import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { describeFilter } from '@solidstate/library';
import { ILayerZeroClientConfig } from '@solidstate/typechain-types';
import { expect } from 'chai';
import { BigNumber, ContractTransaction } from 'ethers';
import { ethers } from 'hardhat';

export interface LayerZeroClientConfigBehaviorArgs {
  getNonOwner: () => Promise<SignerWithAddress>;
}

export function describeBehaviorOfLayerZeroClientConfig(
  deploy: () => Promise<ILayerZeroClientConfig>,
  args: LayerZeroClientConfigBehaviorArgs,
  skips?: string[],
) {
  const describe = describeFilter(skips);

  describe('::LayerZeroClientConfig', function () {
    let nonOwner;
    let instance: ILayerZeroClientConfig;

    beforeEach(async function () {
      nonOwner = await args.getNonOwner();
      instance = await deploy();
    });

    describe('#getConfig(uint16,uint16,uint256)', function () {
      it('returns the stored application config from the LayerZero endpoint');
    });

    describe('#setConfig(uint16,uint16,uint256,bytes)', function () {
      describe('reverts if', () => {
        it('sender is not owner', async () => {
          await expect(
            instance
              .connect(nonOwner)
              ['setConfig(uint16,uint16,uint256,bytes)'](0, 0, 0, '0x'),
          ).to.be.revertedWithCustomError(instance, 'Ownable__NotOwner');
        });
      });
    });

    describe('#setReceiveVersion(uint16)', function () {
      describe('reverts if', () => {
        it('sender is not owner', async () => {
          await expect(
            instance.connect(nonOwner)['setReceiveVersion(uint16)'](0),
          ).to.be.revertedWithCustomError(instance, 'Ownable__NotOwner');
        });
      });
    });

    describe('#setSendVersion(uint16)', function () {
      describe('reverts if', () => {
        it('sender is not owner', async () => {
          await expect(
            instance.connect(nonOwner)['setSendVersion(uint16)'](0),
          ).to.be.revertedWithCustomError(instance, 'Ownable__NotOwner');
        });
      });
    });

    describe('#forceResumeReceive(uint16,bytes)', function () {
      describe('reverts if', () => {
        it('sender is not owner', async () => {
          await expect(
            instance
              .connect(nonOwner)
              ['forceResumeReceive(uint16,bytes)'](0, '0x'),
          ).to.be.revertedWithCustomError(instance, 'Ownable__NotOwner');
        });
      });
    });
  });
}
