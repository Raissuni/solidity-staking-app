# 🧱 Solidity Staking App (Fixed Amount)

A **fixed-amount staking smart contract** built with **Solidity**, where users stake ERC20 tokens and earn **ETH rewards** after a predefined staking period.

The project is fully tested using **Foundry**, covering both successful flows and failure scenarios.

---

## 📌 Overview

This staking system allows users to:

- Stake a **fixed amount of ERC20 tokens**
- Earn **ETH rewards** after a minimum staking period
- Withdraw their tokens at any time
- Prevent multiple deposits per user
- Claim rewards only when conditions are met

The contract owner controls the staking period and funds the reward pool with ETH.

---

## ⚙️ How It Works

1. The user deposits a **fixed amount of staking tokens**
2. The contract records the deposit timestamp
3. The user must wait for the **staking period** to elapse
4. Once the period is completed, the user can **claim ETH rewards**
5. Tokens can be withdrawn at any time

---

## 🚀 Features

- Fixed staking amount per user
- ERC20 token staking
- Time-based reward mechanism
- ETH rewards paid by the contract
- Owner-controlled staking period
- Protection against multiple deposits
- Fully tested with Foundry
- CI with GitHub Actions

---

## 🧪 Test Coverage

All critical behaviors are covered with unit tests:

- Contract deployment validation
- Owner-only functions (`changeStakingPeriod`)
- Correct ETH funding of the contract
- Reverts for invalid staking amounts
- Single-deposit restriction per user
- Token withdrawal logic
- Reward claiming logic
- Time manipulation using `vm.warp`
- Revert testing using `vm.expectRevert`
- User simulation with `vm.prank`

Run the test suite with:

```bash
forge test
🛠️ Tech Stack
Solidity (0.8.30)

Foundry

OpenZeppelin

GitHub Actions (CI)

🔐 Security Considerations
Uses Solidity 0.8.x built-in overflow checks

Fixed staking amount prevents manipulation

Rewards can only be claimed after the staking period

Only the owner can update staking parameters

ETH transfers are validated with success checks

📚 What I Learned
Designing staking mechanisms with fixed constraints

Handling time-based logic in Solidity

Writing comprehensive unit tests with Foundry

Using cheatcodes like vm.warp, vm.prank, and vm.expectRevert

Managing ETH transfers safely in smart contracts

Setting up CI for Solidity projects

