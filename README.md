# SolidState LayerZero Client

SolidState integration with the LayerZero cross-chain messaging protocol.

This project is built with [SolidState](https://github.com/solidstate-network). See the [solidstate-solidity](https://github.com/solidstate-network/solidstate-solidity) documentation for information about contract integration and testing.

## Installation

```bash
npm install --save-dev @solidstate/layerzero-client
# or
yarn add --dev @solidstate/layerzero-client
```

## Development

Install dependencies via Yarn:

```bash
yarn install
```

Setup Husky to format code on commit:

```bash
yarn prepare
```

Compile contracts via Hardhat:

```bash
yarn run hardhat compile
```

### Testing

Test contracts with Hardhat and generate gas report using `hardhat-gas-reporter`:

```bash
yarn run hardhat test
```

Generate a code coverage report using `solidity-coverage`:

```bash
yarn run hardhat coverage
```

### Documentation

A static documentation site can be generated using `hardhat-docgen`:

```bash
yarn run hardhat docgen
```
