const { ethers } = require("hardhat"); //hardhat runtime environment

async function main() {
  const calculatorContract = await ethers.deployContract("Calculator");

  await calculatorContract.waitForDeployment();

  console.log(`Contract deployed to: ${calculatorContract.target}`);

  //0x3adC9Cf222dccF56D999B71B3bdC34D685f985FD

  const calculatorV2Contract = await ethers.deployContract("CalculatorV2");

  await calculatorV2Contract.waitForDeployment();

  console.log(`Contract deployed to: ${calculatorV2Contract.target}`);

  //0x5b22C1016Bf42C6bFa8c565e471700fcb8D171aa
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });

  //Contract Address: 0xA04eB0586c87EC7d0C6B9626d750C5f6202098Af
  //npx hardhat run scripts/deploy.js --network mumbai    
  //npx hardhat verify --network mumbai 0xA04eB0586c87EC7d0C6B9626d750C5f6202098Af

  