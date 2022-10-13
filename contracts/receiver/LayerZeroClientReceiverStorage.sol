// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library LayerZeroClientReceiverStorage {
    struct Layout {
        mapping(bytes32 => uint256) failedMessages;
    }

    bytes32 internal constant STORAGE_SLOT =
        keccak256('solidstate.contracts.storage.LayerZeroClientReceiver');

    function layout() internal pure returns (Layout storage l) {
        bytes32 slot = STORAGE_SLOT;
        assembly {
            l.slot := slot
        }
    }
}
