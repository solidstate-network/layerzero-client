// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @dev derived from https://github.com/nomad-xyz/ExcessivelySafeCall (MIT License)
 */
library ExcessivelySafeCall {
    /**
     * TODO: adapt NatSpec comments from source library
     */
    function excessivelySafeCall(
        address target,
        uint256 gasAmount,
        uint256 value,
        uint16 maxCopy,
        bytes memory data
    ) internal returns (bool, bytes memory) {
        uint256 toCopy;
        bool success;
        bytes memory returnData = new bytes(maxCopy);

        assembly {
            // execute external call via assembly to avoid automatic copying of return data
            success := call(
                gasAmount,
                target,
                value,
                add(data, 0x20),
                mload(data),
                0,
                0
            )

            // determine whether to limit amount of data to copy
            toCopy := returndatasize()

            if gt(toCopy, maxCopy) {
                toCopy := maxCopy
            }

            // store the length of the copied bytes
            mstore(returnData, toCopy)

            // copy the bytes from returndata[0:toCopy]
            returndatacopy(add(returnData, 0x20), 0, toCopy)
        }

        return (success, returnData);
    }
}
