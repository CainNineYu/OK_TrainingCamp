const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Counter", function () {
  it("Should return the new counter once it's changed", async function () {
    const Counter = await ethers.getContractFactory("Counter");
    const counter = await Counter.deploy();
    // await counter.deploy();
    // let c = await counter.count();
    // console.log(c);


    await counter.count();
    let c = await counter.counter();
    console.log("----->"+c.toString());
    expect(c.toString()).to.equal("1");
  });
  
});
