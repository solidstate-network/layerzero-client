// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title Partial LayerZero Client base interface needed by internal functions
 */
interface ILayerZeroClientBaseInternal {
    error LayerZeroClientBase__InvalidTrustedRemote();
    error LayerZeroClientBase__NotLayerZeroEndpoint();

    event SetTrustedRemote(uint16 remoteChainId, bytes path);
}
