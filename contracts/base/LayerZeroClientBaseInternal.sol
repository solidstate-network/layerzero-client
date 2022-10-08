// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ILayerZeroEndpoint } from '../interfaces/ILayerZeroEndpoint.sol';
import { ILayerZeroClientBaseInternal } from './ILayerZeroClientBaseInternal.sol';
import { LayerZeroClientBaseStorage } from './LayerZeroClientBaseStorage.sol';

abstract contract LayerZeroClientBaseInternal is ILayerZeroClientBaseInternal {
    modifier onlyLayerZeroEndpoint() {
        if (msg.sender != _getLayerZeroEndpoint())
            revert LayerZeroClientBase__NotLayerZeroEndpoint();
        _;
    }

    function _getLayerZeroEndpoint() internal view virtual returns (address) {
        return LayerZeroClientBaseStorage.layout().layerZeroEndpoint;
    }

    function _getTrustedRemote(uint16 remoteChainId)
        internal
        view
        virtual
        returns (bytes memory path)
    {
        path = _addressToPath(_getTrustedRemoteAddress(remoteChainId));
    }

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

    function _isTrustedRemote(uint16 remoteChainId, bytes calldata path)
        internal
        view
        virtual
        returns (bool)
    {
        return _isTrustedRemoteAddress(remoteChainId, _pathToAddress(path));
    }

    function _isTrustedRemoteAddress(
        uint16 remoteChainId,
        bytes memory remoteAddress
    ) internal view virtual returns (bool) {
        return
            keccak256(remoteAddress) ==
            keccak256(_getTrustedRemoteAddress(remoteChainId));
    }

    function _setLayerZeroEndpoint(address layerZeroEndpoint) internal virtual {
        LayerZeroClientBaseStorage
            .layout()
            .layerZeroEndpoint = layerZeroEndpoint;
    }

    function _setTrustedRemote(uint16 remoteChainId, bytes calldata path)
        internal
        virtual
    {
        _setTrustedRemoteAddress(remoteChainId, _pathToAddress(path));

        // TODO: SetTrustedRemoteAddress is also emitted via internal call
        emit SetTrustedRemote(remoteChainId, path);
    }

    function _setTrustedRemoteAddress(
        uint16 remoteChainId,
        bytes memory remoteAddress
    ) internal virtual {
        LayerZeroClientBaseStorage.layout().trustedRemotes[
            remoteChainId
        ] = remoteAddress;

        emit SetTrustedRemoteAddress(remoteChainId, remoteAddress);
    }

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

    function _pathToAddress(bytes calldata path)
        private
        pure
        returns (bytes memory remoteAddress)
    {
        uint256 length = path.length;
        if (length < 20) revert LayerZeroClientBase__InvalidTrustedRemote();

        unchecked {
            remoteAddress = path[0:length - 20];
        }
    }

    function _addressToPath(bytes memory remoteAddress)
        private
        view
        returns (bytes memory path)
    {
        path = bytes.concat(remoteAddress, bytes20(address(this)));
    }
}
