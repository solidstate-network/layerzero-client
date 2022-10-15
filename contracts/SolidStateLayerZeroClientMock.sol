// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { OwnableStorage } from '@solidstate/contracts/access/ownable/OwnableStorage.sol';

import { SolidStateLayerZeroClient } from './SolidStateLayerZeroClient.sol';

contract SolidStateLayerZeroClientMock is SolidStateLayerZeroClient {
    constructor() {
        OwnableStorage.layout().owner = msg.sender;
    }

    function _handleLayerZeroMessage(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) internal override {
        // TODO: ...
    }
}
