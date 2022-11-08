const { expect } = require("chai");
const { ethers } = require("hardhat");
const hre = require("hardhat");

describe("MinterHubExtender", function () {
  it("Should deploy", async function () {
    const MinterHubExtender = await hre.ethers.getContractFactory("MinterHubExtender");
    const extender = await MinterHubExtender.deploy();
    await extender.deployed();
  });
});
