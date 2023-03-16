// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { LayerZeroClientReceiverInternal } from '../receiver/LayerZeroClientReceiverInternal.sol';
import { ILayerZeroClientRelayer } from './ILayerZeroClientRelayer.sol';
import { ILayerZeroClientRelayerInternal } from './ILayerZeroClientRelayerInternal.sol';

/**
 * @title LayerZero Client Relayer internal functions
 * @dev derived from https://github.com/LayerZero-Labs/solidity-examples/ (MIT License)
 */
abstract contract LayerZeroClientRelayerInternal is
    ILayerZeroClientRelayerInternal,
    LayerZeroClientReceiverInternal
{
    /**
     * @inheritdoc LayerZeroClientReceiverInternal
     * @notice forward received LayerZero cross-chain message to encoded target address
     * @dev TODO describe how to format relayable calls
     */
    function _handleLayerZeroMessage(
        uint16,
        bytes calldata,
        uint64,
        bytes calldata data
    ) internal virtual override {
        uint256 length = data.length;

        unchecked {
            address target = address(bytes20(data[length - 20:]));

            (bool success, ) = target.call(data[:length - 20]);

            if (!success) revert('TODO: return revert message');
        }
    }
}
