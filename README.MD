**Default**

Runtime BUNJS: https://bun.sh/

Compile code run
```
../node_modules/.bin/solcjs --bin --abi --include-path ../node_modules/ --base-path . -o . SimpleStorage.sol
```
Run blockchain (locally)
https://trufflesuite.com/ganache/

## 6 (entry to hardhat and testing)
```
bun hardhat run **SCRIPTS** --netwokork **NETWORK**
```
**Start Local Node**
```
bun hardhat node
bun hardhat run scripts/deploy.js --network localhost
```
**Testing**
```
bun hardhat test
bun coverage (solidiy coverage report)
```

** Compile
```
bun hardhat compile
```
### 7

### Hardhat-deploy

[wighawag/hardhat-deploy](https://github.com/wighawag/hardhat-deploy)
```
npm add hardhat-deploy --dev

bun hardhat deploy

bun hardhard deploy --network rinkeby --tags fundme
```
