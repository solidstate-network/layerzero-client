// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroClientReceiver } from './ILayerZeroClientReceiver.sol';
import { LayerZeroClientReceiverInternal } from './LayerZeroClientReceiverInternal.sol';

/**
 * @title LayerZero Client extension for support of cross-chain message receipt
 */
abstract contract LayerZeroClientReceiver is
    ILayerZeroClientReceiver,
    LayerZeroClientReceiverInternal
{
    /**
     * @inheritdoc ILayerZeroClientReceiver
     */
    function isBlocking(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) external view returns (bool) {
        return _isBlocking(sourceChainId, path, nonce, data);
    }

    /**
     * @inheritdoc ILayerZeroClientReceiver
     */
    function lzReceive(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) external {
        _lzReceive(sourceChainId, path, nonce, data);
    }

    /**
     * @notice inheritdoc ILayerZeroClientReceiver
     */
    function tryMessage(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) external {
        _tryMessage(sourceChainId, path, nonce, data);
    }

    /**
     * @notice inheritdoc ILayerZeroClientReceiver
     */
    function retryMessage(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) external {
        _retryMessage(sourceChainId, path, nonce, data);
    }
}
