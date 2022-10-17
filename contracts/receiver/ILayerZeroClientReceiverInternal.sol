// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroClientBaseInternal } from '../base/ILayerZeroClientBaseInternal.sol';

/**
 * @title Partial LayerZero Client Receiver interface needed by internal functions
 */
interface ILayerZeroClientReceiverInternal is ILayerZeroClientBaseInternal {
    event MessageSucceeded(
        uint16 sourceChainId,
        bytes path,
        uint64 nonce,
        bytes data
    );

    event MessageFailed(
        uint16 sourceChainId,
        bytes path,
        uint64 nonce,
        bytes data,
        bytes reason
    );

    error LayerZeroClientReceiverNonBlocking__NotSelf();
    error LayerZeroClientReceiverNonBlocking__InvalidPayload();
}
