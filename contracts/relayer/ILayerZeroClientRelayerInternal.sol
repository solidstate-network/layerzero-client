// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroClientReceiverInternal } from '../receiver/ILayerZeroClientReceiverInternal.sol';

/**
 * @title Partial LayerZero Client Relayer interface needed by internal functions
 */
interface ILayerZeroClientRelayerInternal is ILayerZeroClientReceiverInternal {

}
