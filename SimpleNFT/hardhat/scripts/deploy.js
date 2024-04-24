const { ethers } = require("hardhat"); //hardhat runtime environment
require("dotenv").config();

async function main() {
  const simpleNFTContract = await ethers.deployContract("SimpleNFT");

  await simpleNFTContract.waitForDeployment();

  console.log(`Contract deployed to: ${simpleNFTContract.target}`);

  //0xFC2a7A4e269B2b96d7cB07ed19Ed986C316F957E

  //0xC54350Beb5bA59272b94BdFbbfB048FACB04148F
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });

  //npx hardhat run scripts/deploy.js --network mumbai    
  //npx hardhat verify --network mumbai 0xA04eB0586c87EC7d0C6B9626d750C5f6202098Af

  