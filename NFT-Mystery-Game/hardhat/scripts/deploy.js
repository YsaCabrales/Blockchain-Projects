const { ethers } = require("hardhat");
require("dotenv").config();

async function main(){
  const LootboxContract = await ethers.deployContract("Lootbox");

  await LootboxContract.waitForDeployment();

  console.log(`Contract deployed to: ${LootboxContract.target}`);

  //0x7077c15ad14A8A55213B743c1D5b5b8D8c61B1ab
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });