// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroClientPrecrimeInternal } from './ILayerZeroClientPrecrimeInternal.sol';
import { LayerZeroClientPrecrimeStorage } from './LayerZeroClientPrecrimeStorage.sol';

abstract contract LayerZeroClientPrecrimeInternal is
    ILayerZeroClientPrecrimeInternal
{
    function _precrime() internal view virtual returns (address) {
        return LayerZeroClientPrecrimeStorage.layout().precrime;
    }

    function _setPrecrime(address precrime) internal virtual {
        // TODO: onlyOwner
        LayerZeroClientPrecrimeStorage.layout().precrime = precrime;
        emit SetPrecrime(precrime);
    }
}
