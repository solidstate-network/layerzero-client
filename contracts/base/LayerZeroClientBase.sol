// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroClientBase } from './ILayerZeroClientBase.sol';
import { LayerZeroClientBaseInternal } from './LayerZeroClientBaseInternal.sol';

/**
 * @title Base LayerZero Client implementation, excluding optional extensions
 */
abstract contract LayerZeroClientBase is
    ILayerZeroClientBase,
    LayerZeroClientBaseInternal
{

}
