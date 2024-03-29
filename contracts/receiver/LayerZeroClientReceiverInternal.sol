// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { AddressUtils } from '@solidstate/contracts/utils/AddressUtils.sol';

import { LayerZeroClientBaseInternal } from '../base/LayerZeroClientBaseInternal.sol';
import { ILayerZeroClientReceiver } from './ILayerZeroClientReceiver.sol';
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
    using AddressUtils for address;

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

            emit MessageSucceeded(sourceChainId, path, nonce, data);
        } else {
            (bool success, bytes memory reason) = address(this)
                .excessivelySafeCall(
                    gasleft(),
                    150,
                    0,
                    abi.encodeWithSelector(
                        ILayerZeroClientReceiver.tryMessage.selector,
                        sourceChainId,
                        path,
                        nonce,
                        data
                    )
                );

            if (!success) {
                bytes32 key = keccak256(
                    abi.encodePacked(sourceChainId, path, nonce, data)
                );

                LayerZeroClientReceiverStorage.layout().failedMessages[
                    key
                ] = block.timestamp;

                emit MessageFailed(sourceChainId, path, nonce, data, reason);
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
            revert LayerZeroClientReceiver__NotSelf();
        }

        _handleLayerZeroMessage(sourceChainId, path, nonce, data);

        emit MessageSucceeded(sourceChainId, path, nonce, data);
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
            revert LayerZeroClientReceiver__InvalidPayload();
        }

        delete l.failedMessages[key];

        _handleLayerZeroMessage(sourceChainId, path, nonce, data);

        emit MessageSucceeded(sourceChainId, path, nonce, data);
    }

    /**
     * @notice handle received LayerZero cross-chain message
     * @dev must be overridden with domain-specific logic
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
