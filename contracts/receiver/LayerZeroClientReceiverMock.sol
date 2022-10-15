// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { LayerZeroClientReceiver } from './LayerZeroClientReceiver.sol';

contract LayerZeroClientReceiverMock is LayerZeroClientReceiver {
    function _handleLayerZeroMessage(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) internal override {
        // TODO: ...
    }
}
