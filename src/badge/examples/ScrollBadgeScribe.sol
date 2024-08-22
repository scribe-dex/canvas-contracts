// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Attestation} from "@eas/contracts/IEAS.sol";

import {ScrollBadgeAccessControl} from "../extensions/ScrollBadgeAccessControl.sol";
import {ScrollBadgeSingleton} from "../extensions/ScrollBadgeSingleton.sol";
import {ScrollBadge} from "../ScrollBadge.sol";

/// @title ScrollBadgeScribe
contract ScrollBadgeScribe is ScrollBadgeAccessControl, ScrollBadgeSingleton {
    string public sharedTokenURI;

    constructor(address resolver_, string memory tokenUri_) ScrollBadge(resolver_) {
        sharedTokenURI = tokenUri_;
    }

    /// @notice Update the token URI.
    /// @param tokenUri_ The new  token URI.
    function updateTokenURI(string memory tokenUri_) external onlyOwner {
        sharedTokenURI = tokenUri_;
    }

    /// @inheritdoc ScrollBadge
    function onIssueBadge(Attestation calldata attestation)
        internal
        override (ScrollBadgeAccessControl, ScrollBadgeSingleton)
        returns (bool)
    {
        return super.onIssueBadge(attestation);
    }

    /// @inheritdoc ScrollBadge
    function onRevokeBadge(Attestation calldata attestation)
        internal
        override (ScrollBadgeAccessControl, ScrollBadgeSingleton)
        returns (bool)
    {
        return super.onRevokeBadge(attestation);
    }

    /// @inheritdoc ScrollBadge
    function badgeTokenURI(bytes32 /*uid*/ ) public view override returns (string memory) {
        return sharedTokenURI;
    }
}
