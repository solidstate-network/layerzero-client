// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroClientBase } from './ILayerZeroClientBase.sol';
import { LayerZeroClientBaseInternal } from './LayerZeroClientBaseInternal.sol';

abstract contract LayerZeroClientBase is
    ILayerZeroClientBase,
    LayerZeroClientBaseInternal
{}
