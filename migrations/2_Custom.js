const myContract = artifacts.require("MedicalRecords");

module.exports = function (deployer) {
  deployer.deploy(myContract);
};