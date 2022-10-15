// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { OwnableInternal } from '@solidstate/contracts/access/ownable/OwnableInternal.sol';

import { ILayerZeroEndpoint } from '../interfaces/ILayerZeroEndpoint.sol';
import { LayerZeroClientBaseInternal } from '../base/LayerZeroClientBaseInternal.sol';
import { ILayerZeroClientConfigInternal } from './ILayerZeroClientConfigInternal.sol';

contract LayerZeroClientConfigInternal is
    ILayerZeroClientConfigInternal,
    LayerZeroClientBaseInternal,
    OwnableInternal
{
    function _getConfig(
        uint16 version,
        uint16 chainId,
        uint256 configType
    ) internal view returns (bytes memory) {
        return
            ILayerZeroEndpoint(_getLayerZeroEndpoint()).getConfig(
                version,
                chainId,
                address(this),
                configType
            );
    }

    // generic config for LayerZero user Application
    function _setConfig(
        uint16 version,
        uint16 chainId,
        uint256 configType,
        bytes calldata config
    ) internal onlyOwner {
        ILayerZeroEndpoint(_getLayerZeroEndpoint()).setConfig(
            version,
            chainId,
            configType,
            config
        );
    }

    function _setSendVersion(uint16 version) internal onlyOwner {
        ILayerZeroEndpoint(_getLayerZeroEndpoint()).setSendVersion(version);
    }

    function _setReceiveVersion(uint16 version) internal onlyOwner {
        ILayerZeroEndpoint(_getLayerZeroEndpoint()).setReceiveVersion(version);
    }

    function _forceResumeReceive(uint16 srcChainId, bytes calldata srcAddress)
        internal
        onlyOwner
    {
        ILayerZeroEndpoint(_getLayerZeroEndpoint()).forceResumeReceive(
            srcChainId,
            srcAddress
        );
    }
}
