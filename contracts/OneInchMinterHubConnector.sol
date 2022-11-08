//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "1inch-v2-contracts/contracts/OneInchExchange.sol";

interface Hub {
    function transferToChain(
        address _tokenContract,
        bytes32 _destinationChain,
        bytes32 _destination,
        uint256 _amount,
        uint256 _fee
    ) external;
}

contract OneInchMinterHubConnector {
    OneInchExchange public exchange = OneInchExchange(0x1111111254fb6c44bAC0beD2854e76F90643097d);
    Hub public hub = Hub(0xF5b0ed82a0b3e11567081694cC66c3df133f7C8F);

    function swapAndTransferToChain(
        IOneInchCaller caller,
        OneInchExchange.SwapDescription calldata desc,
        IOneInchCaller.CallDescription[] calldata calls,
        bytes32 destinationChain,
        bytes32 destination,
        uint256 fee
    ) public {
        require(desc.srcReceiver == address(this), "desc.srcReceiver must be this contract");
        require(desc.dstReceiver == address(this), "desc.dstReceiver must be this contract");

        uint256 amount = exchange.swap(caller, desc, calls);
        hub.transferToChain(address(desc.dstToken), destinationChain, destination, amount, fee);
    }
}
