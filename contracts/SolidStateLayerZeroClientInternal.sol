// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { SafeOwnableInternal } from '@solidstate/contracts/access/ownable/SafeOwnableInternal.sol';
import { OwnableInternal } from '@solidstate/contracts/access/ownable/OwnableInternal.sol';

import { ISolidStateLayerZeroClientInternal } from './ISolidStateLayerZeroClientInternal.sol';
import { LayerZeroClientBaseInternal } from './base/LayerZeroClientBaseInternal.sol';
import { LayerZeroClientConfigInternal } from './config/LayerZeroClientConfigInternal.sol';
import { LayerZeroClientReceiverInternal } from './receiver/LayerZeroClientReceiverInternal.sol';

/**
 * @title SolidState LayerZero client implementation
 */
abstract contract SolidStateLayerZeroClientInternal is
    ISolidStateLayerZeroClientInternal,
    LayerZeroClientBaseInternal,
    LayerZeroClientConfigInternal,
    LayerZeroClientReceiverInternal,
    SafeOwnableInternal
{
    function _transferOwnership(
        address account
    ) internal virtual override(SafeOwnableInternal, OwnableInternal) {
        super._transferOwnership(account);
    }
}
