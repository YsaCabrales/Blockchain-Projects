const { ethers } = require("hardhat");
require("dotenv").config();

async function main(){
  const MyTokenContract = await ethers.deployContract("MyToken", ["0xc8097aF5D4f912CD0550727072F4F5f464cc9e8a"]);

  await MyTokenContract.waitForDeployment();

  console.log(`Contract deployed to: ${MyTokenContract.target}`);

  //0x598A87Dd215BD3EF0E310a72e26035d4D09c5520
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });