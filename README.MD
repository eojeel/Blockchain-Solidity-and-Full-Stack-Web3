**Default**

Runtime BUNJS: https://bun.sh/

Compile code run

../node_modules/.bin/solcjs --bin --abi --include-path ../node_modules/ --base-path . -o . SimpleStorage.sol

Run blockchain (locally)
https://trufflesuite.com/ganache/

## Lesson 6

bun hardhat run **SCRIPTS** --netwokork **NETWORK**

**Start Local Node**

bun hardhat node
bun hardhat run scripts/deploy.js --network localhost

**Testing**

bun hardhat test
bun coverage (solidiy coverage report)
