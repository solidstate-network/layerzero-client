// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroClientReceiverInternal } from './ILayerZeroClientReceiverInternal.sol';

/**
 * @title LayerZero Client Receiver interface
 */
interface ILayerZeroClientReceiver is ILayerZeroClientReceiverInternal {
    /**
     * @notice query whether given cross-chain message data should be treated as blocking
     * @param sourceChainId LayerZero source chain id
     * @param path encoded LayerZero trusted remote path
     * @param nonce ordered message nonce
     * @param data cross-chain message payload
     * @return whether message should be handled in a blocking fashion
     */
    function isBlocking(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) external view returns (bool);

    /**
     * @notice entrypoint for LayerZero to deliver a cross-chain message
     * @param sourceChainId LayerZero source chain id
     * @param path encoded LayerZero trusted remote path
     * @param nonce ordered message nonce
     * @param data cross-chain message payload
     */
    function lzReceive(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) external;

    /**
     * @notice attempt message processing in non-blocking fashion
     * @dev calls to this function should only be made from the contract itself
     * @param sourceChainId LayerZero source chain id
     * @param path encoded LayerZero trusted remote path
     * @param nonce ordered message nonce
     * @param data cross-chain message payload
     */
    function tryMessage(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) external;

    /**
     * @notice retry processing of failed non-blocking message
     * @param sourceChainId LayerZero source chain id
     * @param path encoded LayerZero trusted remote path
     * @param nonce ordered message nonce
     * @param data cross-chain message payload
     */
    function retryMessage(
        uint16 sourceChainId,
        bytes calldata path,
        uint64 nonce,
        bytes calldata data
    ) external;
}
