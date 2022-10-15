import { describeBehaviorOfSolidStateLayerZeroClient } from '../spec/SolidStateLayerZeroClient.behavior';
import {
  SolidStateLayerZeroClientMock,
  SolidStateLayerZeroClientMock__factory,
} from '../typechain-types';
import { ethers } from 'hardhat';

describe('SolidStateLayerZeroClient', function () {
  let instance: SolidStateLayerZeroClientMock;

  beforeEach(async function () {
    const [deployer] = await ethers.getSigners();
    instance = await new SolidStateLayerZeroClientMock__factory(
      deployer,
    ).deploy();
  });

  describeBehaviorOfSolidStateLayerZeroClient(async () => instance, {});
});
