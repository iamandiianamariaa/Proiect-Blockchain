pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MedicalRecords.sol";

contract TestMedical {

    MedicalRecords medical = MedicalRecords(DeployedAddresses.MedicalRecords());

    function testUserCanAddPacient() public {
        medical.addPatient(1, "Mihai Andrei", 22, "0726357689",  "Bucuresti");
        bool status = medical.getPatientStatus(1);
        Assert.equal(status, true, "Pacient was not added");
    }

    function testNumberOfPatients() public{
        uint number = medical.getNumPatients();
        Assert.equal(number,1,"Number of pacients is not correct");
    }

    function testSetName() public {
        medical.setPatientName(1, "Mihai Ioana");
        string memory name = medical.getPatientName(1);
        Assert.equal(name, "Mihai Ioana", "Name is not correct");
    }

    function testUserCanAddDoctor() public {
        medical.addDoctor(1, "Constantin Bogdan", "Spitalul de urgenta", "Cardiologie");
        bool status = medical.getDoctorStatus(1);
        Assert.equal(status, true, "Doctor was not added");
    }
    function testNumberOfDoctors() public{
        uint number = medical.getNumDoctors();
        Assert.equal(number,1,"Number of doctors is not correct");
    }

    function testSetDoctorName() public {
        medical.setDoctorName(1, "Constantin Andrei");
        string memory name = medical.getDoctorName(1);
        Assert.equal(name, "Constantin Andrei", "Name is not correct");
    }

    function testTreatPacient() public{
        uint numberBefore= medical.getPatientDoctors(1);
        medical.treatPatient(1, 1);
        uint numberAfter = medical.getPatientDoctors(1);
        Assert.equal(numberAfter-numberBefore,1,"Pacient was not added by doctor");
    }
}