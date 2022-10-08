// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ILayerZeroClientBaseInternal {
    error LayerZeroClientBase__InvalidTrustedRemote();
    error LayerZeroClientBase__NotLayerZeroEndpoint();

    event SetTrustedRemote(uint16 remoteChainId, bytes path);
    event SetTrustedRemoteAddress(uint16 remoteChainId, bytes remoteAddress);
}
