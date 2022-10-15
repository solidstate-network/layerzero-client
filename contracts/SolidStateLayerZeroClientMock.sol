// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { SolidStateLayerZeroClient } from './SolidStateLayerZeroClient.sol';

contract SolidStateLayerZeroClientMock is SolidStateLayerZeroClient {
    function _handleLayerZeroMessage(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) internal override {
        // TODO: ...
    }
}
