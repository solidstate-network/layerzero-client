// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { LayerZeroClientBaseInternal } from '../base/LayerZeroClientBaseInternal.sol';
import { ILayerZeroClientReceiverInternal } from './ILayerZeroClientReceiverInternal.sol';
import { LayerZeroClientReceiverStorage } from './LayerZeroClientReceiverStorage.sol';

/**
 * @title LayerZero Client Receiver internal functions
 * @dev derived from https://github.com/LayerZero-Labs/solidity-examples/ (MIT License)
 */
abstract contract LayerZeroClientReceiverInternal is
    ILayerZeroClientReceiverInternal,
    LayerZeroClientBaseInternal
{
    /**
     * @notice query whether given cross-chain message data should be treated as blocking
     * @dev LayerZero messaging is blocking by default, but non-blocking behavior can be introduced by overriding this function
     *    see ILayerZeroClientReceiver for parameter descriptions
     * @return whether message should be handled in a blocking fashion
     */
    function _isBlocking(
        uint16,
        bytes calldata,
        uint64,
        bytes calldata
    ) internal view virtual returns (bool) {
        return true;
    }

    /**
     * @notice route received LayerZero cross-chain message to internal handler function
     * @dev only callable by LayerZero endpoint
     * @param sourceChainId LayerZero chain id of message source
     * @param path encoded LayerZero trusted remote path
     * @param nonce ordered message nonce
     * @param data cross-chain message payload
     */
    function _lzReceive(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) internal virtual onlyLayerZeroEndpoint {
        if (!_isTrustedRemote(sourceChainId, path))
            revert LayerZeroClientBase__InvalidTrustedRemote();

        if (_isBlocking(sourceChainId, path, nonce, data)) {
            _handleLayerZeroMessage(sourceChainId, path, nonce, data);

            // TODO: success event
        } else {
            // TODO: encode call to tryMessage

            bool success;

            if (!success) {
                bytes32 key = keccak256(
                    abi.encodePacked(sourceChainId, path, nonce, data)
                );

                LayerZeroClientReceiverStorage.layout().failedMessages[
                    key
                ] = block.timestamp;

                // TODO: failure event
            }
        }
    }

    /**
     * @notice attempt message processing in non-blocking fashion
     * @param sourceChainId LayerZero chain id of message source
     * @param path encoded LayerZero trusted remote path
     * @param nonce ordered message nonce
     * @param data cross-chain message payload
     */
    function _tryMessage(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) internal virtual {
        if (msg.sender != address(this)) {
            revert LayerZeroClientReceiverNonBlocking__NotSelf();
        }

        _handleLayerZeroMessage(sourceChainId, path, nonce, data);

        // TODO: success event
    }

    /**
     * @notice retry processing of failed non-blocking message
     * @param sourceChainId LayerZero chain id of message source
     * @param path encoded LayerZero trusted remote path
     * @param nonce ordered message nonce
     * @param data cross-chain message payload
     */
    function _retryMessage(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) internal virtual {
        LayerZeroClientReceiverStorage.Layout
            storage l = LayerZeroClientReceiverStorage.layout();

        bytes32 key = keccak256(
            abi.encodePacked(sourceChainId, path, nonce, data)
        );

        if (l.failedMessages[key] == 0) {
            revert LayerZeroClientReceiverNonBlocking__InvalidPayload();
        }

        delete l.failedMessages[key];

        _handleLayerZeroMessage(sourceChainId, path, nonce, data);

        // TODO: success event
    }

    /**
     * @notice handle received LayerZero cross-chain message
     * @param sourceChainId LayerZero chain id of message source
     * @param path encoded LayerZero trusted remote path
     * @param nonce ordered message nonce
     * @param data cross-chain message payload
     */
    function _handleLayerZeroMessage(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) internal virtual;
}
