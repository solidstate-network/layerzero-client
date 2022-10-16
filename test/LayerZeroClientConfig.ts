import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { describeBehaviorOfLayerZeroClientConfig } from '../spec/LayerZeroClientConfig.behavior';
import {
  LayerZeroClientConfigMock,
  LayerZeroClientConfigMock__factory,
} from '../typechain-types';
import { ethers } from 'hardhat';

describe('LayerZeroClientConfig', function () {
  let owner: SignerWithAddress;
  let nonOwner: SignerWithAddress;
  let instance: LayerZeroClientConfigMock;

  before(async () => {
    [owner, nonOwner] = await ethers.getSigners();
  });

  beforeEach(async function () {
    instance = await new LayerZeroClientConfigMock__factory(owner).deploy();
  });

  describeBehaviorOfLayerZeroClientConfig(async () => instance, {
    getNonOwner: async () => nonOwner,
  });
});
