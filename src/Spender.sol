// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ManualToken} from "./ManualToken.sol";

contract Spender {
    /** 
     * Errors
     * Spender_FakeReceiveApproval: prevent from fake address
     */
    error Spender_FakeReceiveApproval(address manualToken, address _token);
    error Spender_OnlyOwnerCanTransfer();
    error Spender_BalanceNotEnough();
    error Spender_TransferFailed();

    uint256 private s_balanceAmount;
    address private s_manualToken;
    address private s_owner;
    
    mapping (address => uint256) s_balanceOf;

    constructor(address deployedmanualToken){
        s_manualToken = deployedmanualToken;
        s_owner = msg.sender;
    }


    /**
     * Modifiers
     */
    modifier onlyOwner() {
        if (msg.sender != s_owner) {
            revert Spender_OnlyOwnerCanTransfer();
        }
        _;
    }

    /**
     * Functions
     */
    function transfer(address to, uint256 value) external onlyOwner {
        if (value > s_balanceAmount) revert Spender_BalanceNotEnough();

        // Type contract ManualToken is not implicitly convertible to expected type address. Anyway better?
        bool success = ManualToken(s_manualToken).transfer(to, value);
        if (!success) revert Spender_TransferFailed();
        s_balanceAmount -= value;
    }



    function receiveApproval(address _from, uint256 _value, address _token, bytes calldata /* _extraData */) external {
        if(s_manualToken != _token) revert Spender_FakeReceiveApproval(s_manualToken, _token);
        
        unchecked{
            // overflow is impossible: sum of all <= totalBalance 
            s_balanceOf[_from] += _value;
        }
    }


    /**
     * Getters
     */

    function getBalanceAmount() public view returns(uint256) {
        return s_balanceAmount;
    }

    function getManualToken() public view returns(address) {
        return s_manualToken;
    }

    function getOwner() public view returns(address) {
        return s_owner;
    }

    function getBalanceOf(address whose) public view returns(uint256) {
        return s_balanceOf[whose];
    }

}


/** Something need to be improved:
 * 1. re-entrancy attack
 * 2. apply for spend
 * 3. check apply
 * 4. handle extra_data
 * 5. improve scripts
 * ...
 */