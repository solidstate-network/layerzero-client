import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { describeFilter } from '@solidstate/library';
import { ILayerZeroClientReceiver } from '@solidstate/typechain-types';
import { expect } from 'chai';
import { BigNumber, ContractTransaction } from 'ethers';
import { ethers } from 'hardhat';

export interface LayerZeroClientReceiverBehaviorArgs {}

export function describeBehaviorOfLayerZeroClientReceiver(
  deploy: () => Promise<ILayerZeroClientReceiver>,
  args: LayerZeroClientReceiverBehaviorArgs,
  skips?: string[],
) {
  const describe = describeFilter(skips);

  describe('::LayerZeroClientReceiver', function () {
    let instance: ILayerZeroClientReceiver;

    beforeEach(async function () {
      instance = await deploy();
    });

    describe('#todo()', function () {
      it('todo', async () => {
        console.log('okay');
      });
    });
  });
}
