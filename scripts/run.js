const main = async () => {

    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther("1")
    });
    await waveContract.deployed();
    console.log("contract deployed to :", waveContract.address);

    let contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract Balance after deploy is ", hre.ethers.utils.formatEther(contractBalance));

    let waveTxn = await waveContract.wave("Hi! This is my first wave");
    await waveTxn.wait();

    await new Promise(r => setTimeout(r, 16000));

    waveTxn = await waveContract.wave("Hi! This is second wave");
    await waveTxn.wait();

    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract Balance after wave is ", hre.ethers.utils.formatEther(contractBalance));





}

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
}

runMain();