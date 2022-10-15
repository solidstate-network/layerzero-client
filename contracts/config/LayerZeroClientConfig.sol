// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroClientConfig } from './ILayerZeroClientConfig.sol';
import { LayerZeroClientConfigInternal } from './LayerZeroClientConfigInternal.sol';

contract LayerZeroClientConfig is
    ILayerZeroClientConfig,
    LayerZeroClientConfigInternal
{
    /**
     * @inheritdoc ILayerZeroClientConfig
     */
    function getConfig(
        uint16 version,
        uint16 chainId,
        uint256 configType
    ) external view returns (bytes memory) {
        return _getConfig(version, chainId, configType);
    }

    /**
     * @inheritdoc ILayerZeroClientConfig
     */
    function setConfig(
        uint16 version,
        uint16 chainId,
        uint256 configType,
        bytes calldata config
    ) external {
        _setConfig(version, chainId, configType, config);
    }

    /**
     * @inheritdoc ILayerZeroClientConfig
     */
    function setReceiveVersion(uint16 version) external {
        _setReceiveVersion(version);
    }

    /**
     * @inheritdoc ILayerZeroClientConfig
     */
    function setSendVersion(uint16 version) external {
        _setSendVersion(version);
    }

    /**
     * @inheritdoc ILayerZeroClientConfig
     */
    function forceResumeReceive(uint16 srcChainId, bytes calldata srcAddress)
        external
    {
        _forceResumeReceive(srcChainId, srcAddress);
    }
}
