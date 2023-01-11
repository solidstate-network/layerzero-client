// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroClientPrecrimeInternal } from './ILayerZeroClientPrecrimeInternal.sol';

interface ILayerZeroClientPrecrime is ILayerZeroClientPrecrimeInternal {
    function precrime() external view returns (address);

    function setPrecrime(address precrime) external;
}
