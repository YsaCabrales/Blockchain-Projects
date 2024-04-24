const { ethers } = require("hardhat");
// const fs = require("fs");
const ipfsClient = require("ipfs-http-client");

async function main() {
  const [deployer] = await ethers.getSigners();
  const ipfs = ipfsClient({ host: "api.pinata.cloud", port: 5001, protocol: "https" });
  const tokenId = 1;

  // Upload your NFT metadata to IPFS
  const metadata = "https://beige-electrical-llama-367.mypinata.cloud/ipfs/QmTwE1d7iNVtz8YTkFR2kqg1cHaagvatXicESeThEqxTZH/1.json"

  const ipfsResponse = await ipfs.add(metadata);
  const ipfsCid = ipfsResponse.path;

  // Mint the NFT
  const contractAddress = "0xa3D8A2926a4ED7C08F6890b6637a9f170216d8f1"; // Replace with your deployed contract address
  const NFTContract = await ethers.getContractFactory("NFTCollection");
  const nft = await NFTContract.attach(contractAddress);
  await nft.mint(deployer.address, tokenId, ipfsCid);

  console.log(`Minted NFT with token ID ${tokenId}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
