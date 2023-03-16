// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { LayerZeroClientReceiver } from '../receiver/LayerZeroClientReceiver.sol';
import { ILayerZeroClientRelayer } from './ILayerZeroClientRelayer.sol';
import { LayerZeroClientRelayerInternal } from './LayerZeroClientRelayerInternal.sol';

/**
 * @title LayerZero Client extension for support of cross-chain message receipt
 */
abstract contract LayerZeroClientRelayer is
    ILayerZeroClientRelayer,
    LayerZeroClientRelayerInternal,
    LayerZeroClientReceiver
{

}
