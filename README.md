# Decentralized Stablecoin (DSC)

**[Developed following the cyfrin updraft course by Patrick Collins]**

A minimal, over‑collateralized, algorithmic stablecoin system built with Foundry. DSC (“Decentralized Stable Coin”) is an ERC‑20 token pegged to the US dollar, backed exclusively by WETH and WBTC. It features:

- **Exogenous Collateralization**: Users deposit WETH or WBTC as collateral.
- **Algorithmic Minting/Burning**: Peg stability maintained via health‑factor checks.
- **Over‑Collateralization**: Always ≥ 200% collateral coverage.
- **No Governance, No Fees**: Simple, permissionless, on‑chain stability.

---

## Table of Contents

- Architecture  
- Getting Started  
- Sepolia Deployment
- Usage    
- License  

---

# Architecture

## Contracts

| Path                            | Description                                    |
|---------------------------------|------------------------------------------------|
| `src/DecentralizedStableCoin.sol` | ERC20 burnable stablecoin implementation.      |
| `src/DSCEngine.sol`             | Protocol engine: collateral, minting, liquidation. |
| `script/HelperConfig.s.sol`     | Network‑specific configuration & mocks.        |
| `src/libraries/OracleLib.sol`   | Staleness‑checked wrapper for Chainlink feeds. |

---

## Scripts

- **DeployDSC.s.sol** (`script/DeployDSC.s.sol`)  
  Deploys `DecentralizedStableCoin` & `DSCEngine` in one broadcast.  
  - Reads network config (Sepolia or Anvil) via `HelperConfig`.  
  - Transfers DSC ownership to the engine.

---

## Testing

```bash
forge test --match-path test/unit
```

# Getting Started

## Requirements

- Rust (for Foundry)
- Foundry

## Installation

1.	Install Foundry

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

2.	Clone this repo

```bash
git clone https://github.com/jeddiyoussefepfl/foundry-fund-me
cd foundry-defi-stablecoin-f23
```

## Configuration

# Sepolia Deployment

**NOT RECOMMENDED BUT OK FOR TESTING PURPOSES**

Set PRIVATE_KEY env var to your deployer key for Sepolia:

```bash
export PRIVATE_KEY=<your_sepolia_key>
```

# Usage

- Build 
```bash
forge build
```
- Test
```bash
forge test
```

- Deploy to Sepolia
```bash
forge script script/DeployDSC.s.sol:DeployDSC \
  --rpc-url https://sepolia.infura.io/v3/<INFURA_KEY> \
  --private-key $PRIVATE_KEY \
  --broadcast
```

## License

This project is licensed under the MIT License.