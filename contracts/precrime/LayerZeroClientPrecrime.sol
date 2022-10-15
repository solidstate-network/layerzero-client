// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroClientPrecrime } from './ILayerZeroClientPrecrime.sol';
import { LayerZeroClientPrecrimeInternal } from './LayerZeroClientPrecrimeInternal.sol';

abstract contract LayerZeroClientPrecrime is
    ILayerZeroClientPrecrime,
    LayerZeroClientPrecrimeInternal
{
    function precrime() external view returns (address) {
        return _precrime();
    }

    function setPrecrime(address precrime) external {
        return _setPrecrime(precrime);
    }
}
