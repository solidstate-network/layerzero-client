// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroClientConfigInternal } from './ILayerZeroClientConfigInternal.sol';

interface ILayerZeroClientConfig is ILayerZeroClientConfigInternal {
    /**
     * @notice query the stored application config from the LayerZero endpoint
     * @param version LayerZero messaging library version
     * @param chainId LayerZero chain id TODO: is config synced across chains, or is chainId always local chain id?
     * @param configType configuration type corresponding to LayerZero message library in use
     * @return config encoded configuration
     */
    function getConfig(
        uint16 version,
        uint16 chainId,
        uint256 configType
    ) external view returns (bytes memory config);

    /**
     * @notice update the stored application config in the LayerZero endpoint
     * @param version LayerZero messaging library version
     * @param chainId LayerZero chain id TODO: is config synced across chains, or is chainId always local chain id?
     * @param configType configuration type corresponding to LayerZero message library in use
     * @param config encoded configuration
     */
    function setConfig(
        uint16 version,
        uint16 chainId,
        uint256 configType,
        bytes calldata config
    ) external;

    /**
     * @notice set the LayerZero messaging library version to use for outgoing messages
     * @param version new messaging library version
     */
    function setSendVersion(uint16 version) external;

    /**
     * @notice set the LayerZero messaging library version to use for incoming messages
     * @param version new messaging library version
     */
    function setReceiveVersion(uint16 version) external;

    /**
     * @notice clear pending payload stored in the LayerZero endpoint to force resume message flow
     * @param sourceChainId LayerZero source chain id
     * @param sourceAddress TODO: is this an address, or an encoded trusted remote?
     */
    function forceResumeReceive(
        uint16 sourceChainId,
        bytes calldata sourceAddress
    ) external;
}
