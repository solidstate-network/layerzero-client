// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { SafeOwnable } from '@solidstate/contracts/access/ownable/SafeOwnable.sol';
import { OwnableInternal } from '@solidstate/contracts/access/ownable/OwnableInternal.sol';

import { ISolidStateLayerZeroClient } from './ISolidStateLayerZeroClient.sol';
import { LayerZeroClientBase } from './base/LayerZeroClientBase.sol';
import { LayerZeroClientConfig } from './config/LayerZeroClientConfig.sol';
import { LayerZeroClientReceiver } from './receiver/LayerZeroClientReceiver.sol';

/**
 * @title SolidState LayerZero client implementation
 */
abstract contract SolidStateLayerZeroClient is
    ISolidStateLayerZeroClient,
    SafeOwnable,
    LayerZeroClientBase,
    LayerZeroClientConfig,
    LayerZeroClientReceiver
{
    function _transferOwnership(address account)
        internal
        virtual
        override(OwnableInternal, SafeOwnable)
    {
        super._transferOwnership(account);
    }
}
