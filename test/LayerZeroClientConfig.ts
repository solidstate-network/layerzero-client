import { describeBehaviorOfLayerZeroClientConfig } from '../spec/LayerZeroClientConfig.behavior';
import {
  LayerZeroClientConfigMock,
  LayerZeroClientConfigMock__factory,
} from '../typechain-types';
import { ethers } from 'hardhat';

describe('LayerZeroClientConfig', function () {
  let instance: LayerZeroClientConfigMock;

  beforeEach(async function () {
    const [deployer] = await ethers.getSigners();
    instance = await new LayerZeroClientConfigMock__factory(deployer).deploy();
  });

  describeBehaviorOfLayerZeroClientConfig(async () => instance, {});
});
