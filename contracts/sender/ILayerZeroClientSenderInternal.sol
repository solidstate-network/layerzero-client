// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroClientBaseInternal } from '../base/ILayerZeroClientBaseInternal.sol';

/**
 * @title Partial LayerZero Client sender interface needed by internal functions
 */
interface ILayerZeroClientSenderInternal is ILayerZeroClientBaseInternal {
    event MessageSent(
        uint16 destinationChainId,
        bytes payload,
        address refundAddress,
        address zroPaymentAddress,
        bytes adapterParams,
        uint256 nativeFee
    );
}
