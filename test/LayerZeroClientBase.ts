import { describeBehaviorOfLayerZeroClientBase } from '../spec/LayerZeroClientBase.behavior';
import {
  LayerZeroClientBaseMock,
  LayerZeroClientBaseMock__factory,
} from '../typechain-types';
import { ethers } from 'hardhat';

describe('LayerZeroClientBase', function () {
  let instance: LayerZeroClientBaseMock;

  beforeEach(async function () {
    const [deployer] = await ethers.getSigners();
    instance = await new LayerZeroClientBaseMock__factory(deployer).deploy();
  });

  describeBehaviorOfLayerZeroClientBase(async () => instance, {});
});
