// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

interface tokenRecipient {
    function receiveApproval(address _from, uint256 _value, address _token, bytes calldata _extraData) external;

    // make receievTransfer compatible
    function receiveTransfer(uint256 value) external;
}
