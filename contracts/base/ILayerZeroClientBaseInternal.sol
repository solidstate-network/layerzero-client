// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title Partial LayerZero Client base interface needed by internal functions
 */
interface ILayerZeroClientBaseInternal {
    error LayerZeroClientBase__InvalidTrustedRemote();

    event SetTrustedRemote(uint16 remoteChainId, bytes path);
    event MessageSent(
        uint16 destinationChainId,
        bytes payload,
        address refundAddress,
        address zroPaymentAddress,
        bytes adapterParams,
        uint256 nativeFee
    );
}
