// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IOwnableInternal } from '@solidstate/contracts/access/ownable/IOwnableInternal.sol';

import { ILayerZeroClientBaseInternal } from '../base/ILayerZeroClientBaseInternal.sol';

interface ILayerZeroClientConfigInternal is
    ILayerZeroClientBaseInternal,
    IOwnableInternal
{}
