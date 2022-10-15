import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { describeFilter } from '@solidstate/library';
import { ILayerZeroClientBase } from '@solidstate/typechain-types';
import { expect } from 'chai';
import { BigNumber, ContractTransaction } from 'ethers';
import { ethers } from 'hardhat';

export interface LayerZeroClientBaseBehaviorArgs {}

export function describeBehaviorOfLayerZeroClientBase(
  deploy: () => Promise<ILayerZeroClientBase>,
  args: LayerZeroClientBaseBehaviorArgs,
  skips?: string[],
) {
  const describe = describeFilter(skips);

  describe('::LayerZeroClientBase', function () {
    let instance: ILayerZeroClientBase;

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
