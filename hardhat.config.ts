import '@nomicfoundation/hardhat-chai-matchers';
import '@nomiclabs/hardhat-ethers';
import '@typechain/hardhat';
import 'hardhat-contract-sizer';
import 'hardhat-docgen';
import 'hardhat-gas-reporter';
import 'hardhat-spdx-license-identifier';
import 'solidity-coverage';

export default {
  solidity: {
    version: '0.8.17',
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },

  contractSizer: {
    runOnCompile: true,
  },

  docgen: {
    clear: true,
    runOnCompile: false,
  },

  gasReporter: {
    enabled: true,
  },

  spdxLicenseIdentifier: {
    overwrite: false,
    runOnCompile: true,
  },

  typechain: {
    alwaysGenerateOverloads: true,
  },
};
