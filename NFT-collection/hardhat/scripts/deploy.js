const { ethers } = require("hardhat"); //hardhat runtime environment
require("dotenv").config({ path: ".env"});

async function main() {
  const baseURI = "https://beige-electrical-llama-367.mypinata.cloud/ipfs/QmTwE1d7iNVtz8YTkFR2kqg1cHaagvatXicESeThEqxTZH"; // Replace with the correct IPFS URL
  const NFTColl = await ethers.getContractFactory("NFTCollection"); // Get the contract factory
  const NFTcoll = await NFTColl.deploy(baseURI); // Deploy the contract with the baseURI argument
  await NFTcoll.waitForDeployment();
  console.log(`Contract deployed to: ${NFTcoll.target}`);

  //0xa3D8A2926a4ED7C08F6890b6637a9f170216d8f1
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });

  //npx hardhat run scripts/deploy.js --network mumbai    
  //npx hardhat verify --network mumbai 

  