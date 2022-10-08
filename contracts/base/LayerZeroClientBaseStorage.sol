// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library LayerZeroClientBaseStorage {
    struct Layout {
        address layerZeroEndpoint;
        mapping(uint16 => bytes) trustedRemotes;
    }

    bytes32 internal constant STORAGE_SLOT =
        keccak256('solidstate.contracts.storage.LayerZeroClientBase');

    function layout() internal pure returns (Layout storage l) {
        bytes32 slot = STORAGE_SLOT;
        assembly {
            l.slot := slot
        }
    }
}
