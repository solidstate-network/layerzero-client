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

    describe('#isBlocking(uint16,bytes,uint64,bytes)', function () {
      it('returns true by default', async () => {
        expect(
          await instance.callStatic['isBlocking(uint16,bytes,uint64,bytes)'](
            0,
            '0x',
            0,
            '0x',
          ),
        ).to.be.true;
      });
    });

    describe('#lzReceive(uint16,bytes,uint64,bytes)', function () {
      describe('reverts if', () => {
        it('sender is not LayerZero endpoint', async () => {
          await expect(
            instance['lzReceive(uint16,bytes,uint64,bytes)'](0, '0x', 0, '0x'),
          ).to.be.revertedWithCustomError(
            instance,
            'LayerZeroClientBase__NotLayerZeroEndpoint',
          );
        });
      });
    });

    describe('#tryMessage(uint16,bytes,uint64,bytes)', function () {
      describe('reverts if', () => {
        it('sender is not self', async () => {
          await expect(
            instance['tryMessage(uint16,bytes,uint64,bytes)'](0, '0x', 0, '0x'),
          ).to.be.revertedWithCustomError(
            instance,
            'LayerZeroClientReceiver__NotSelf',
          );
        });
      });
    });

    describe('#retryMessage(uint16,bytes,uint64,bytes)', function () {
      describe('reverts if', () => {
        it('payload does not match pending', async () => {
          await expect(
            instance['retryMessage(uint16,bytes,uint64,bytes)'](
              0,
              '0x',
              0,
              '0x',
            ),
          ).to.be.revertedWithCustomError(
            instance,
            'LayerZeroClientReceiver__InvalidPayload',
          );
        });
      });
    });
  });
}
