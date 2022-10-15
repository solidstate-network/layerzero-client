import {
  describeBehaviorOfSafeOwnable,
  SafeOwnableBehaviorArgs,
} from '@solidstate/spec';
import {
  describeBehaviorOfLayerZeroClientBase,
  LayerZeroClientBaseBehaviorArgs,
} from './LayerZeroClientBase.behavior';
import {
  describeBehaviorOfLayerZeroClientConfig,
  LayerZeroClientConfigBehaviorArgs,
} from './LayerZeroClientConfig.behavior';
import {
  describeBehaviorOfLayerZeroClientReceiver,
  LayerZeroClientReceiverBehaviorArgs,
} from './LayerZeroClientReceiver.behavior';
import { describeFilter } from '@solidstate/library';
import { ISolidStateLayerZeroClient } from '@solidstate/typechain-types';
import { BigNumber, BigNumberish, ContractTransaction } from 'ethers';

export interface SolidStateLayerZeroClientBehaviorArgs
  extends SafeOwnableBehaviorArgs,
    LayerZeroClientBaseBehaviorArgs,
    LayerZeroClientConfigBehaviorArgs,
    LayerZeroClientReceiverBehaviorArgs {}

export function describeBehaviorOfSolidStateLayerZeroClient(
  deploy: () => Promise<ISolidStateLayerZeroClient>,
  args: SolidStateLayerZeroClientBehaviorArgs,
  skips?: string[],
) {
  const describe = describeFilter(skips);

  describe('::SolidStateLayerZeroClient', function () {
    describeBehaviorOfSafeOwnable(deploy, args, skips);

    describeBehaviorOfLayerZeroClientBase(deploy, args, skips);

    describeBehaviorOfLayerZeroClientConfig(deploy, args, skips);

    describeBehaviorOfLayerZeroClientReceiver(deploy, args, skips);
  });
}
