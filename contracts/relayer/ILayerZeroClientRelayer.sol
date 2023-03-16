// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroClientReceiver } from '../receiver/ILayerZeroClientReceiver.sol';
import { ILayerZeroClientRelayerInternal } from './ILayerZeroClientRelayerInternal.sol';

/**
 * @title LayerZero Client Relayer interface
 */
interface ILayerZeroClientRelayer is
    ILayerZeroClientReceiver,
    ILayerZeroClientRelayerInternal
{

}
