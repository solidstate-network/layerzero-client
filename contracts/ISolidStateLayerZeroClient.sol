// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ISafeOwnable } from '@solidstate/contracts/access/ownable/ISafeOwnable.sol';

import { ILayerZeroClientBase } from './base/ILayerZeroClientBase.sol';
import { ILayerZeroClientConfig } from './config/ILayerZeroClientConfig.sol';
import { ILayerZeroClientReceiver } from './receiver/ILayerZeroClientReceiver.sol';

interface ISolidStateLayerZeroClient is
    ISafeOwnable,
    ILayerZeroClientBase,
    ILayerZeroClientConfig,
    ILayerZeroClientReceiver
{}
