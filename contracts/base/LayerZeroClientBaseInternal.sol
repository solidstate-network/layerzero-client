// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroEndpoint } from '../interfaces/ILayerZeroEndpoint.sol';
import { ILayerZeroClientBaseInternal } from './ILayerZeroClientBaseInternal.sol';
import { LayerZeroClientBaseStorage } from './LayerZeroClientBaseStorage.sol';

/**
 * @title Base LayerZero Client internal functions, excluding optional extensions
 * @dev derived from https://github.com/LayerZero-Labs/solidity-examples/ (MIT License)
 */
abstract contract LayerZeroClientBaseInternal is ILayerZeroClientBaseInternal {
    modifier onlyLayerZeroEndpoint() {
        if (msg.sender != _getLayerZeroEndpoint())
            revert LayerZeroClientBase__NotLayerZeroEndpoint();
        _;
    }

    /**
     * @notice query the LayerZero endpoint address
     * @return layerZeroEndpoint LayerZero endpoint address
     */
    function _getLayerZeroEndpoint()
        internal
        view
        virtual
        returns (address layerZeroEndpoint)
    {
        return LayerZeroClientBaseStorage.layout().layerZeroEndpoint;
    }

    /**
     * @notice query the trusted remote for given chain id
     * @param remoteChainId LayerZero remote chain id
     * @return path formatted LayerZero trusted remote path
     */
    function _getTrustedRemote(uint16 remoteChainId)
        internal
        view
        virtual
        returns (bytes memory path)
    {
        path = _formatTrustedRemote(_getTrustedRemoteAddress(remoteChainId));
    }

    /**
     * @notice query the trusted remote address for given chain id
     * @param remoteChainId LayerZero remote chain id
     * @return remoteAddress trusted remote address formatted as bytes
     */
    function _getTrustedRemoteAddress(uint16 remoteChainId)
        internal
        view
        virtual
        returns (bytes memory remoteAddress)
    {
        remoteAddress = LayerZeroClientBaseStorage.layout().trustedRemotes[
            remoteChainId
        ];

        if (remoteAddress.length == 0)
            revert LayerZeroClientBase__InvalidTrustedRemote();
    }

    /**
     * @notice query whether LayerZero remote path is trusted for given chain id
     * @param remoteChainId LayerZero remote chain id
     * @param path formatted LayerZero remote path
     * @return whether LayerZero remote path is trusted
     */
    function _isTrustedRemote(uint16 remoteChainId, bytes calldata path)
        internal
        view
        virtual
        returns (bool)
    {
        return
            _isTrustedRemoteAddress(remoteChainId, _parseTrustedRemote(path));
    }

    /**
     * @notice query whether address is trusted remote for given chain id
     * @param remoteChainId LayerZero remote chain id
     * @param remoteAddress trusted remote address formatted as bytes
     * @return whether remote address is trusted
     */
    function _isTrustedRemoteAddress(
        uint16 remoteChainId,
        bytes memory remoteAddress
    ) internal view virtual returns (bool) {
        return
            keccak256(remoteAddress) ==
            keccak256(_getTrustedRemoteAddress(remoteChainId));
    }

    /**
     * @notice set the LayerZero endpoint address
     * @param layerZeroEndpoint LayerZero endpoint address
     */
    function _setLayerZeroEndpoint(address layerZeroEndpoint) internal virtual {
        LayerZeroClientBaseStorage
            .layout()
            .layerZeroEndpoint = layerZeroEndpoint;
    }

    /**
     * @notice set LayerZero trusted remote for given chain id
     * @param remoteChainId LayerZero remote chain id
     * @param path formatted LayerZero trusted remote path
     */
    function _setTrustedRemote(uint16 remoteChainId, bytes calldata path)
        internal
        virtual
    {
        _setTrustedRemoteAddress(remoteChainId, _parseTrustedRemote(path));

        // TODO: SetTrustedRemoteAddress is also emitted via internal call
        emit SetTrustedRemote(remoteChainId, path);
    }

    /**
     * @notice set LayerZero trusted remote address for given chain id
     * @param remoteChainId LayerZero remote chain id
     * @param remoteAddress trusted remote address formatted as bytes
     */
    function _setTrustedRemoteAddress(
        uint16 remoteChainId,
        bytes memory remoteAddress
    ) internal virtual {
        LayerZeroClientBaseStorage.layout().trustedRemotes[
            remoteChainId
        ] = remoteAddress;

        emit SetTrustedRemoteAddress(remoteChainId, remoteAddress);
    }

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
    }

    /**
     * @notice format LayerZero trusted remote by appending local address to remote address
     * @param remoteAddress trusted remote address formatted as bytes
     * @return path formatted LayerZero remote path
     */
    function _formatTrustedRemote(bytes memory remoteAddress)
        private
        view
        returns (bytes memory path)
    {
        if (remoteAddress.length == 0)
            revert LayerZeroClientBase__InvalidTrustedRemote();

        path = bytes.concat(remoteAddress, bytes20(address(this)));
    }

    /**
     * @notice parse remtoe address from formatted LayerZero trusted remote path
     * @param path formatted LayerZero remote path
     * @return remoteAddress trusted remote address formatted as bytes
     */
    function _parseTrustedRemote(bytes calldata path)
        private
        view
        returns (bytes memory remoteAddress)
    {
        uint256 length = path.length;
        if (length < 20) revert LayerZeroClientBase__InvalidTrustedRemote();

        unchecked {
            if (address(bytes20(path[length - 20:])) != address(this))
                revert LayerZeroClientBase__InvalidTrustedRemote();

            remoteAddress = path[:length - 20];
        }
    }
}
