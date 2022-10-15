// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library LayerZeroClientPrecrimeStorage {
    struct Layout {
        address precrime;
    }

    bytes32 internal constant STORAGE_SLOT =
        keccak256('solidstate.contracts.storage.LayerZeroClientPrecrime');

    function layout() internal pure returns (Layout storage l) {
        bytes32 slot = STORAGE_SLOT;
        assembly {
            l.slot := slot
        }
    }
}
