// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ISafeOwnableInternal } from '@solidstate/contracts/access/ownable/ISafeOwnableInternal.sol';

import { ILayerZeroClientBaseInternal } from './base/ILayerZeroClientBaseInternal.sol';
import { ILayerZeroClientConfigInternal } from './config/ILayerZeroClientConfigInternal.sol';
import { ILayerZeroClientReceiverInternal } from './receiver/ILayerZeroClientReceiverInternal.sol';

interface ISolidStateLayerZeroClientInternal is
    ILayerZeroClientBaseInternal,
    ILayerZeroClientConfigInternal,
    ILayerZeroClientReceiverInternal,
    ISafeOwnableInternal
{}
