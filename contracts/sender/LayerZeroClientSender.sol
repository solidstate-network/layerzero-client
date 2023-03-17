// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { LayerZeroClientBase } from '../base/LayerZeroClientBase.sol';
import { ILayerZeroClientSender } from './ILayerZeroClientSender.sol';
import { LayerZeroClientSenderInternal } from './LayerZeroClientSenderInternal.sol';

/**
 * @title LayerZero Client sender implementation, excluding optional extensions
 */
abstract contract LayerZeroClientSender is
    ILayerZeroClientSender,
    LayerZeroClientSenderInternal,
    LayerZeroClientBase
{

}
