import { describeBehaviorOfLayerZeroClientReceiver } from '../spec/LayerZeroClientReceiver.behavior';
import {
  LayerZeroClientReceiverMock,
  LayerZeroClientReceiverMock__factory,
} from '../typechain-types';
import { ethers } from 'hardhat';

describe('LayerZeroClientReceiver', function () {
  let instance: LayerZeroClientReceiverMock;

  beforeEach(async function () {
    const [deployer] = await ethers.getSigners();
    instance = await new LayerZeroClientReceiverMock__factory(
      deployer,
    ).deploy();
  });

  describeBehaviorOfLayerZeroClientReceiver(async () => instance, {});
});
