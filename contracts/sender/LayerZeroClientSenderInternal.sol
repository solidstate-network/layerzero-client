// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { LayerZeroClientBaseInternal } from '../base/LayerZeroClientBaseInternal.sol';
import { ILayerZeroEndpoint } from '../interfaces/ILayerZeroEndpoint.sol';
import { ILayerZeroClientSenderInternal } from './ILayerZeroClientSenderInternal.sol';

/**
 * @title LayerZero Client sender internal functions, excluding optional extensions
 * @dev derived from https://github.com/LayerZero-Labs/solidity-examples/ (MIT License)
 */
abstract contract LayerZeroClientSenderInternal is
    ILayerZeroClientSenderInternal,
    LayerZeroClientBaseInternal
{
    /**
     * @notice send cross-chain messave via LayerZero endpoint
     * @param destinationChainId LayerZero destination chain id
     * @param payload data payload to send
     * @param refundAddress recipient address of gas fee refund
     * @param zroPaymentAddress address of ZRO fee payer
     * @param adapterParams relayer adapter parameters
     * @param nativeFee amount of local-chain native tokens to send as gas fee
     */
    function _lzSend(
        uint16 destinationChainId,
        bytes memory payload,
        address payable refundAddress,
        address zroPaymentAddress,
        bytes memory adapterParams,
        uint256 nativeFee
    ) internal virtual {
        bytes memory trustedRemote = _getTrustedRemote(destinationChainId);

        ILayerZeroEndpoint(_getLayerZeroEndpoint()).send{ value: nativeFee }(
            destinationChainId,
            trustedRemote,
            payload,
            refundAddress,
            zroPaymentAddress,
            adapterParams
        );

        emit MessageSent(
            destinationChainId,
            payload,
            refundAddress,
            zroPaymentAddress,
            adapterParams,
            nativeFee
        );
    }
}
