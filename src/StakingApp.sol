// SPDX-License-Identifier: GPL-3.0

// Version solidity
pragma solidity 0.8.30;

import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";


// Staking FIXED amount
// Staking reward period

contract StakingApp is Ownable {

    // Variables
    address public stakingToken;
    uint256 public stakinkPeriod;
    uint256 public fixedStakingAmount;
    uint256 public rewardPerPeriod;
    mapping(address => uint256) public userBalance;
    mapping(address => uint256) public elapsePeriod;

    event ChangeStakingPeriode(uint256 newStakinkPeriod_);
    event DepositToken(address userAddress, uint256 depositAmout_);
    event WithdrawTokens(address userAddress, uint256 withdrawAmout_);
    event EtherSent(uint256 amount_);
    
    constructor(address stakingToken_, address owner_, uint256 stakinkPeriod_, uint256 fixedStakingAmount_, uint256 rewardPerPeriod_) Ownable(owner_) {
        stakingToken = stakingToken_;
        stakinkPeriod = stakinkPeriod_;
        fixedStakingAmount = fixedStakingAmount_;
        rewardPerPeriod = rewardPerPeriod_;
    }

    // Function  

    // External function
    function depositTokens(uint256 tokenAmount_) external{
        require(tokenAmount_ == fixedStakingAmount, "Incorrect Amount");
        require(userBalance[msg.sender] == 0, "User already deposited");

        IERC20(stakingToken).transferFrom(msg.sender, address(this), tokenAmount_);
        userBalance[msg.sender] += tokenAmount_;
        elapsePeriod[msg.sender] = block.timestamp;
         
        emit DepositToken(msg.sender, tokenAmount_);
    }


    function withdrawTokens() external {
        
        uint256 userBalance_ = userBalance[msg.sender];
        userBalance[msg.sender] = 0; 
        IERC20(stakingToken).transfer(msg.sender, userBalance_);

        emit WithdrawTokens(msg.sender, userBalance_);
        
    }


    function claimRewards() external {
        // Check balance
        require(userBalance[msg.sender] == fixedStakingAmount, "Not staking");
       
        // Calculate reward amount   
        uint256 elapsePeriod_ = block.timestamp - elapsePeriod[msg.sender]; 
        require(elapsePeriod_ >=stakinkPeriod, "Need to wait");

        // Update depositTime
        elapsePeriod[msg.sender] = block.timestamp;

        // Transfer reward
        (bool success,) = msg.sender.call{value: rewardPerPeriod}(""); 
        require(success, "Transer failed");
    }

    receive() external payable onlyOwner {
        emit EtherSent(msg.value); 
    }

    function changeStakingPeriod(uint256 newStakinkPeriod_) external onlyOwner {
        stakinkPeriod = newStakinkPeriod_;
        emit ChangeStakingPeriode(newStakinkPeriod_);

    }



}