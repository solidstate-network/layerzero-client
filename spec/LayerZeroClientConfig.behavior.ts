import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { describeFilter } from '@solidstate/library';
import { ILayerZeroClientConfig } from '@solidstate/typechain-types';
import { expect } from 'chai';
import { BigNumber, ContractTransaction } from 'ethers';
import { ethers } from 'hardhat';

export interface LayerZeroClientConfigBehaviorArgs {}

export function describeBehaviorOfLayerZeroClientConfig(
  deploy: () => Promise<ILayerZeroClientConfig>,
  args: LayerZeroClientConfigBehaviorArgs,
  skips?: string[],
) {
  const describe = describeFilter(skips);

  describe('::LayerZeroClientConfig', function () {
    let instance: ILayerZeroClientConfig;

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
