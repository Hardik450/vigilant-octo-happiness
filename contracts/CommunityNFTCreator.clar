;; CommunityNFT Creator Contract
;; Collaborative NFT creation platform where communities vote on traits and collectively own generated art

;; Define the NFT
(define-non-fungible-token community-nft uint)

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-authorized (err u101))
(define-constant err-invalid-proposal (err u102))
(define-constant err-proposal-not-found (err u103))
(define-constant err-voting-ended (err u104))
(define-constant err-insufficient-votes (err u105))
(define-constant err-nft-not-found (err u106))
(define-constant err-already-voted (err u107))
(define-constant err-invalid-amount (err u108))

;; Data variables
(define-data-var next-proposal-id uint u1)
(define-data-var next-nft-id uint u1)
(define-data-var min-votes-required uint u5)

;; Data structures for proposals
(define-map proposals 
  uint 
  {
    creator: principal,
    trait-name: (string-ascii 50),
    trait-value: (string-ascii 100),
    description: (string-ascii 200),
    votes-for: uint,
    votes-against: uint,
    voting-end-height: uint,
    is-active: bool,
    is-executed: bool
  })

;; Track votes by user for each proposal
(define-map proposal-votes {proposal-id: uint, voter: principal} bool)

;; NFT metadata and ownership
(define-map nft-metadata 
  uint 
  {
    traits: (list 10 {trait-name: (string-ascii 50), trait-value: (string-ascii 100)}),
    community-owners: (list 20 principal),
    creation-height: uint,
    total-votes: uint
  })

;; Community member stakes (determines voting power)
(define-map community-stakes principal uint)

;; Function 1: Create and vote on trait proposals
(define-public (create-trait-proposal 
  (trait-name (string-ascii 50)) 
  (trait-value (string-ascii 100)) 
  (description (string-ascii 200))
  (voting-duration uint))
  (let 
    (
      (proposal-id (var-get next-proposal-id))
      (voting-end (+ stacks-block-height voting-duration))
    )
    (begin
      ;; Validate inputs
      (asserts! (> (len trait-name) u0) err-invalid-proposal)
      (asserts! (> (len trait-value) u0) err-invalid-proposal)
      (asserts! (> (len description) u0) err-invalid-proposal)
      (asserts! (and (> voting-duration u0) (< voting-duration u10080)) err-invalid-proposal) ;; Max 1 week
      
      ;; Ensure caller has community stake (voting power)
      (asserts! (> (default-to u0 (map-get? community-stakes tx-sender)) u0) err-not-authorized)
      
      ;; Create the proposal
      (map-set proposals proposal-id 
        {
          creator: tx-sender,
          trait-name: trait-name,
          trait-value: trait-value,
          description: description,
          votes-for: u0,
          votes-against: u0,
          voting-end-height: voting-end,
          is-active: true,
          is-executed: false
        })
      
      ;; Increment proposal counter
      (var-set next-proposal-id (+ proposal-id u1))
      
      ;; Emit event
      (print {
        event: "proposal-created",
        proposal-id: proposal-id,
        creator: tx-sender,
        trait-name: trait-name,
        trait-value: trait-value,
        voting-end: voting-end
      })
      
      (ok proposal-id))))

;; Vote on trait proposal
(define-public (vote-on-proposal (proposal-id uint) (vote-for bool))
  (let 
    (
      (proposal (unwrap! (map-get? proposals proposal-id) err-proposal-not-found))
      (voter-stake (default-to u0 (map-get? community-stakes tx-sender)))
      (vote-key {proposal-id: proposal-id, voter: tx-sender})
    )
    (begin
      ;; Ensure voter has stake
      (asserts! (> voter-stake u0) err-not-authorized)
      
      ;; Ensure proposal is still active
      (asserts! (get is-active proposal) err-invalid-proposal)
      (asserts! (< stacks-block-height (get voting-end-height proposal)) err-voting-ended)
      
      ;; Ensure voter hasn't already voted
      (asserts! (is-none (map-get? proposal-votes vote-key)) err-already-voted)
      
      ;; Record the vote
      (map-set proposal-votes vote-key true)
      
      ;; Update proposal vote counts based on voter's stake
      (if vote-for
        (map-set proposals proposal-id 
          (merge proposal {votes-for: (+ (get votes-for proposal) voter-stake)}))
        (map-set proposals proposal-id 
          (merge proposal {votes-against: (+ (get votes-against proposal) voter-stake)})))
      
      ;; Emit vote event
      (print {
        event: "vote-cast",
        proposal-id: proposal-id,
        voter: tx-sender,
        vote-for: vote-for,
        stake: voter-stake
      })
      
      (ok true))))

;; Function 2: Generate community NFT from approved proposals
(define-public (generate-community-nft (approved-proposal-ids (list 10 uint)))
  (let 
    (
      (nft-id (var-get next-nft-id))
      (traits (map extract-approved-trait approved-proposal-ids))
      (community-members (get-active-community-members))
    )
    (begin
      ;; Ensure caller has authorization (could be any community member)
      (asserts! (> (default-to u0 (map-get? community-stakes tx-sender)) u0) err-not-authorized)
      
      ;; Validate that all proposals are approved and executed
      (asserts! (fold validate-approved-proposal approved-proposal-ids true) err-invalid-proposal)
      
      ;; Create the NFT metadata
      (map-set nft-metadata nft-id 
        {
          traits: traits,
          community-owners: community-members,
          creation-height: stacks-block-height,
          total-votes: (fold sum-proposal-votes approved-proposal-ids u0)
        })
      
      ;; Mint NFT to the contract (community ownership)
      (try! (nft-mint? community-nft nft-id (as-contract tx-sender)))
      
      ;; Mark proposals as executed
      (map mark-proposal-executed approved-proposal-ids)
      
      ;; Increment NFT counter
      (var-set next-nft-id (+ nft-id u1))
      
      ;; Emit creation event
      (print {
        event: "community-nft-created",
        nft-id: nft-id,
        traits: traits,
        community-owners: community-members,
        creator: tx-sender
      })
      
      (ok nft-id))))

;; Helper functions
(define-private (extract-approved-trait (proposal-id uint))
  (let ((proposal (unwrap-panic (map-get? proposals proposal-id))))
    {trait-name: (get trait-name proposal), trait-value: (get trait-value proposal)}))

(define-private (validate-approved-proposal (proposal-id uint) (acc bool))
  (let ((proposal (unwrap! (map-get? proposals proposal-id) false)))
    (and acc 
         (get is-active proposal)
         (> (get votes-for proposal) (get votes-against proposal))
         (>= (get votes-for proposal) (var-get min-votes-required)))))

(define-private (sum-proposal-votes (proposal-id uint) (acc uint))
  (let ((proposal (unwrap! (map-get? proposals proposal-id) acc)))
    (+ acc (get votes-for proposal) (get votes-against proposal))))

(define-private (mark-proposal-executed (proposal-id uint))
  (let ((proposal (unwrap-panic (map-get? proposals proposal-id))))
    (map-set proposals proposal-id (merge proposal {is-executed: true}))))

(define-private (get-active-community-members)
  ;; This would return a list of active community members
  ;; For now, returning a placeholder list
  (list tx-sender))

;; Read-only functions
(define-read-only (get-proposal (proposal-id uint))
  (ok (map-get? proposals proposal-id)))

(define-read-only (get-nft-metadata (nft-id uint))
  (ok (map-get? nft-metadata nft-id)))

(define-read-only (get-community-stake (member principal))
  (ok (default-to u0 (map-get? community-stakes member))))

(define-read-only (has-voted (proposal-id uint) (voter principal))
  (ok (is-some (map-get? proposal-votes {proposal-id: proposal-id, voter: voter}))))

;; Admin function to set community stakes (for demo purposes)
(define-public (set-community-stake (member principal) (stake uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    ;; Validate inputs
    (asserts! (is-standard member) err-invalid-proposal)
    (asserts! (<= stake u1000000) err-invalid-amount) ;; Max 1M stake
    (map-set community-stakes member stake)
    (ok true)))