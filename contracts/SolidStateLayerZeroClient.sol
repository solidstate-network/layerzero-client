// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { SafeOwnable } from '@solidstate/contracts/access/ownable/SafeOwnable.sol';
import { OwnableInternal } from '@solidstate/contracts/access/ownable/OwnableInternal.sol';

import { ISolidStateLayerZeroClient } from './ISolidStateLayerZeroClient.sol';
import { SolidStateLayerZeroClientInternal } from './SolidStateLayerZeroClientInternal.sol';
import { LayerZeroClientBase } from './base/LayerZeroClientBase.sol';
import { LayerZeroClientConfig } from './config/LayerZeroClientConfig.sol';
import { LayerZeroClientReceiver } from './receiver/LayerZeroClientReceiver.sol';

/**
 * @title SolidState LayerZero client implementation
 */
abstract contract SolidStateLayerZeroClient is
    ISolidStateLayerZeroClient,
    SolidStateLayerZeroClientInternal,
    LayerZeroClientBase,
    LayerZeroClientConfig,
    LayerZeroClientReceiver,
    SafeOwnable
{
    function _transferOwnership(
        address account
    )
        internal
        virtual
        override(
            SolidStateLayerZeroClientInternal,
            SafeOwnable,
            OwnableInternal
        )
    {
        super._transferOwnership(account);
    }
}
