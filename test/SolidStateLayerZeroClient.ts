import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { describeBehaviorOfSolidStateLayerZeroClient } from '../spec/SolidStateLayerZeroClient.behavior';
import {
  SolidStateLayerZeroClientMock,
  SolidStateLayerZeroClientMock__factory,
} from '../typechain-types';
import { ethers } from 'hardhat';

describe('SolidStateLayerZeroClient', function () {
  let owner: SignerWithAddress;
  let nonOwner: SignerWithAddress;
  let nomineeOwner: SignerWithAddress;

  let instance: SolidStateLayerZeroClientMock;

  before(async () => {
    [owner, nonOwner, nomineeOwner] = await ethers.getSigners();
  });

  beforeEach(async () => {
    instance = await new SolidStateLayerZeroClientMock__factory(owner).deploy();
  });

  describeBehaviorOfSolidStateLayerZeroClient(async () => instance, {
    getOwner: async () => owner,
    getNonOwner: async () => nonOwner,
    getNomineeOwner: async () => nomineeOwner,
  });
});
