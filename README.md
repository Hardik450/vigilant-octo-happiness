# CommunityNFT Creator

## Project Description

CommunityNFT Creator is a collaborative NFT creation platform where communities vote on traits and collectively own generated art. This innovative platform democratizes the NFT creation process by allowing community members to propose, vote on, and collectively decide the characteristics of unique digital assets.

The platform operates on a decentralized governance model where community members stake their tokens to gain voting power, propose artistic traits, and participate in the collective creation of NFTs that represent the community's shared vision and creativity.

## Project Vision

Our vision is to revolutionize digital art creation by making it a truly collaborative and democratic process. We believe that the most meaningful and valuable digital assets are those created through collective creativity and shared ownership. 

CommunityNFT Creator aims to:

- **Democratize Art Creation**: Remove barriers between artists and communities by making everyone a participant in the creative process
- **Foster Community Engagement**: Create meaningful connections between community members through shared artistic endeavors
- **Establish Fair Ownership**: Ensure that those who contribute to the creative process have a stake in the final artwork
- **Promote Creative Diversity**: Encourage diverse perspectives and ideas through inclusive voting mechanisms
- **Build Sustainable Communities**: Create economic incentives that reward active participation and long-term community building

## Future Scope

The CommunityNFT Creator platform has extensive potential for growth and enhancement:

### Phase 1 - Core Enhancement
- **Advanced Voting Mechanisms**: Implement quadratic voting, time-weighted voting, and reputation-based voting systems
- **Dynamic Trait Generation**: Integrate AI-powered trait suggestion and automatic art generation based on voted traits
- **Revenue Sharing**: Implement automatic royalty distribution among community members based on their contribution levels
- **Multi-Chain Support**: Expand beyond Stacks to support Ethereum, Polygon, and other major blockchains

### Phase 2 - Advanced Features
- **Governance Token Integration**: Launch native governance tokens that provide additional voting power and platform benefits
- **Creator Rewards Program**: Establish incentive mechanisms for active trait proposers and voters
- **Marketplace Integration**: Built-in marketplace for trading community-created NFTs with special features for fractional ownership
- **Cross-Community Collaborations**: Enable multiple communities to collaborate on shared NFT projects

### Phase 3 - Platform Expansion
- **Mobile Application**: Develop native mobile apps for iOS and Android with full platform functionality
- **Social Features**: Add community chat, member profiles, creation galleries, and social networking features
- **Educational Hub**: Create tutorials, workshops, and resources to help communities maximize their creative potential
- **API Ecosystem**: Provide comprehensive APIs for third-party developers to build additional tools and integrations

### Phase 4 - Innovation & Growth
- **Metaverse Integration**: Enable community NFTs to be used as avatars, assets, and decorations in virtual worlds
- **Real-World Utilities**: Bridge digital and physical worlds through merchandise, events, and physical art creation
- **DAO Infrastructure**: Evolution into a fully decentralized autonomous organization with automated governance
- **Global Community Network**: Establish partnerships with art institutions, educational organizations, and cultural groups worldwide

## Tech Stack

### Blockchain & Smart Contracts
- **Blockchain**: Stacks Blockchain
- **Smart Contract Language**: Clarity 2.0
- **Development Framework**: Clarinet CLI
- **Network**: Stacks Testnet/Mainnet

### Development Tools
- **Package Manager**: npm/yarn
- **Testing Framework**: Vitest
- **TypeScript**: For testing and scripts
- **Git**: Version control
- **VS Code**: Recommended IDE with Clarity extensions

### Frontend (Future Implementation)
- **Framework**: React/Next.js
- **Web3 Integration**: Stacks.js
- **Wallet Integration**: Hiro Web Wallet
- **Styling**: Tailwind CSS
- **State Management**: Zustand/Redux

### Infrastructure
- **Deployment**: Clarinet deployments
- **API**: Stacks Blockchain API
- **Storage**: On-chain metadata storage
- **Hosting**: Vercel/Netlify (for frontend)

## Technical Architecture

### Smart Contract Functions

#### 1. `create-trait-proposal`
Creates a new proposal for an NFT trait that the community can vote on.

**Parameters:**
- `trait-name`: Name of the trait (e.g., "Background", "Eyes", "Hat")
- `trait-value`: Value of the trait (e.g., "Sunset Sky", "Blue Eyes", "Red Cap")
- `description`: Detailed description of the proposed trait
- `voting-duration`: Number of blocks for which voting will remain open

**Features:**
- Requires community stake to create proposals
- Automatic proposal ID generation
- Configurable voting duration
- Event emission for transparency

#### 2. `generate-community-nft`
Generates a new NFT based on approved trait proposals from the community.

**Parameters:**
- `approved-proposal-ids`: List of proposal IDs that have been approved through voting

**Features:**
- Validates all proposals are properly approved
- Combines traits into cohesive NFT metadata
- Establishes community ownership
- Tracks voting participation and engagement

### Key Data Structures

- **Proposals Map**: Stores all trait proposals with voting data and status
- **NFT Metadata Map**: Contains generated NFT information, traits, and ownership details
- **Community Stakes Map**: Tracks member voting power based on their platform stake
- **Proposal Votes Map**: Records individual voting history to prevent double-voting

## Setup Instructions

## Quick Start Guide

### For Developers
```bash
# 1. Clone and setup
git clone https://github.com/Hardik450/CommunityNFTCreator.git
cd CommunityNFTCreator
npm install

# 2. Test locally
clarinet check
npm test

# 3. Deploy to testnet
clarinet deployment apply --testnet
```

### For Community Members
1. **Install Hiro Wallet** browser extension
2. **Switch to Testnet** in wallet settings
3. **Get test STX** from the faucet
4. **Visit deployed contract** on Stacks Explorer
5. **Start creating proposals** and voting!

## Prerequisites
- **Node.js**: Version 16.x or higher
- **Git**: Latest version
- **Clarinet CLI**: Latest version
- **Hiro Web Wallet**: Browser extension
- **Code Editor**: VS Code with Clarity extension (recommended)

### Step 1: Install Development Tools

#### Install Node.js and npm
```bash
# Check if Node.js is installed
node --version
npm --version

# If not installed, download from: https://nodejs.org/
```

#### Install Clarinet CLI
```bash
# Using npm
npm install -g @hirosystems/clarinet

# Using Homebrew (macOS)
brew install clarinet

# Verify installation
clarinet --version
```

#### Install VS Code Extensions
1. **Clarity**: Syntax highlighting and language support
2. **Stacks**: Additional Stacks blockchain tools
3. **GitLens**: Enhanced Git integration

### Step 2: Clone and Setup Repository

```bash
# Clone the repository
git clone https://github.com/Hardik450/CommunityNFTCreator.git
cd CommunityNFTCreator

# Install dependencies
npm install

# Verify project structure
ls -la
```

### Step 3: Local Development Setup

#### Initialize Clarinet Project (if not done)
```bash
# Check Clarinet configuration
clarinet check

# Start local development network
clarinet integrate

# Run in another terminal - Interactive console
clarinet console
```

#### Setup Environment Variables
Create a `.env` file in the project root:
```env
STACKS_NETWORK=testnet
PRIVATE_KEY=your-private-key-here
CONTRACT_ADDRESS=ST297CWAT94DT6EPHRC8W16X1ZV8MT0EX2SEMRBK.CommunityNFTCreator
```

### Step 4: Testing

#### Run Unit Tests
```bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Run specific test file
npm test CommunityNFTCreator.test.ts
```

#### Manual Testing in Console
```bash
# Start Clarinet console
clarinet console

# Test contract functions
>> (contract-call? .CommunityNFTCreator set-community-stake tx-sender u100)
>> (contract-call? .CommunityNFTCreator create-trait-proposal "Background" "Stars" "Beautiful starry background" u1440)
```

### Step 5: Wallet Setup

#### Install Hiro Web Wallet
1. Visit [Hiro Wallet](https://wallet.hiro.so/)
2. Install browser extension
3. Create or import wallet
4. Switch to **Testnet** network

#### Get Testnet STX
1. Visit [Stacks Testnet Faucet](https://explorer.hiro.so/sandbox/faucet)
2. Enter your testnet address
3. Request test tokens
4. Wait for confirmation

### Step 6: Deploy to Testnet

#### Generate Deployment Plan
```bash
# Create testnet deployment configuration
clarinet deployment generate --testnet

# Review the generated plan
cat deployments/default.testnet-plan.yaml
```

#### Deploy Contract
```bash
# Deploy to testnet
clarinet deployment apply --testnet

# Verify deployment
clarinet deployment verify --testnet
```

### Step 7: Interact with Deployed Contract

#### Using Stacks Explorer
1. Visit [Stacks Explorer](https://explorer.hiro.so/)
2. Search for your contract address: `ST297CWAT94DT6EPHRC8W16X1ZV8MT0EX2SEMRBK.CommunityNFTCreator`
3. Use the "Call Function" interface to interact

#### Using Clarinet Console
```bash
# Connect to testnet
clarinet console --testnet

# Set community stake
>> (contract-call? 'ST297CWAT94DT6EPHRC8W16X1ZV8MT0EX2SEMRBK.CommunityNFTCreator set-community-stake tx-sender u100)

# Create proposal
>> (contract-call? 'ST297CWAT94DT6EPHRC8W16X1ZV8MT0EX2SEMRBK.CommunityNFTCreator create-trait-proposal "Eyes" "Blue" "Beautiful blue eyes" u1440)
```

## Project Structure

```

├── contracts/
│   └── CommunityNFTCreator.clar       # Main smart contract
├── tests/
│   └── CommunityNFTCreator.test.ts    # Unit tests
├── scripts/
│   └── deploy.js                      # Deployment scripts
├── deployments/
│   ├── default.testnet-plan.yaml      # Testnet deployment config
│   └── default.devnet-plan.yaml      # Devnet deployment config
├── settings/
│   └── Devnet.toml                    # Local development settings
├── .vscode/
│   ├── settings.json                  # VS Code configuration
│   └── tasks.json                     # Build tasks
├── Clarinet.toml                      # Clarinet project configuration
├── package.json                       # Node.js dependencies
├── tsconfig.json                      # TypeScript configuration
├── vitest.config.js                   # Test configuration
├── .gitignore                         # Git ignore rules
└── README.md                          # This file
```

## Common Commands

### Development
```bash
# Check contract syntax
clarinet check

# Run tests
npm test

# Start local blockchain
clarinet integrate

# Interactive console
clarinet console

# Format code
clarinet format
```

### Deployment
```bash
# Generate deployment plan
clarinet deployment generate --testnet

# Deploy to testnet
clarinet deployment apply --testnet

# Check deployment status
clarinet deployment verify --testnet
```

### Debugging
```bash
# Verbose logging
clarinet console --verbose

# Check specific function
clarinet call-read-only .CommunityNFTCreator get-proposal u1

# Trace transaction
clarinet console --trace
```

## Troubleshooting

### Common Issues

#### 1. Clarinet Command Not Found
```bash
# Reinstall Clarinet
npm uninstall -g @hirosystems/clarinet
npm install -g @hirosystems/clarinet
```

#### 2. Contract Deployment Fails
- Check your private key has sufficient STX
- Verify contract syntax with `clarinet check`
- Ensure you're on the correct network

#### 3. Test Failures
```bash
# Clear cache and run tests
rm -rf .clarinet
clarinet check
npm test
```

#### 4. Wallet Connection Issues
- Switch to Testnet in Hiro Wallet
- Clear browser cache
- Re-import wallet with correct seed phrase

### Getting Help
- **Documentation**: [Clarinet Docs](https://docs.hiro.so/stacks/clarinet)
- **Stacks Discord**: [Join Community](https://discord.gg/stacks)
- **GitHub Issues**: Report bugs and feature requests
- **Stacks Forum**: [Ask Questions](https://forum.stacks.org/)

## Getting Started

### Prerequisites
- Stacks blockchain development environment
- Clarity language knowledge
- Community governance understanding

### Installation
1. Clone the repository
2. Deploy the contract to Stacks blockchain
3. Set up initial community stakes
4. Begin creating trait proposals

### Usage Example
```clarity
;; Create a trait proposal
(contract-call? .community-nft-creator create-trait-proposal 
  "Background" 
  "Galaxy Stars" 
  "A beautiful starry galaxy background with nebula effects" 
  u1440) ;; 1440 blocks ≈ 10 days

;; Vote on the proposal
(contract-call? .community-nft-creator vote-on-proposal u1 true)

;; Generate NFT from approved proposals
(contract-call? .community-nft-creator generate-community-nft (list u1 u2 u3))
```

## Contract Address Details

*Contract address details will be added here once deployed to the Stacks blockchain.*

**Testnet Address:** `ST297CWAT94DT6EPHRC8W16X1ZV8MT0EX2SEMRBK.CommunityNFTCreator`
<img width="1883" height="855" alt="Screenshot 2025-08-26 103903" src="https://github.com/user-attachments/assets/fdb9fb58-3828-4a32-8e47-5f23eaa95f75" />

### Deployment Information
- **Network:** Stacks Blockchain
- **Language:** Clarity
- **Version:** 1.0.0
- **Last Updated:** 25-08-2025


## Contributing

We welcome contributions from the community! Please read our contributing guidelines and join our Discord server to participate in discussions and development.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

*CommunityNFT Creator - Where Communities Create, Vote, and Own Together* 🎨✨
