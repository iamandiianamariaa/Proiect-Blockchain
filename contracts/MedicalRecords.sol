pragma solidity ^0.5.0;

contract MedicalRecords {
    
    address SmartContractOwner;
    constructor() public{
        SmartContractOwner = msg.sender; 
    }

    modifier onlySmartContractOwner{
        require(SmartContractOwner == msg.sender, "Sender not authorized");
        _;
    }

    uint numDoctors;
    uint numPatients;
    struct Patient {  
        uint patID;         
        string name;
        uint age;
        string contact;
        string homeAddress;
        uint[] treatments;
        uint[] doctors;
        bool registerStatus;
    }


    
    mapping(address => mapping(uint => Patient)) patientDetails;
    mapping(address => mapping(uint => Doctor)) doctorDetails;

    event LogNewPatient (uint index, string name,  uint age, string contact, string homeAddress);

    function addPatient(uint patID,string memory name, uint age, string memory contact, string memory homeAddress) 
    public //onlySmartContractOwner
    {
        require(!patientDetails[msg.sender][patID].registerStatus);
        numPatients++;
        patientDetails[msg.sender][patID]=Patient(patID, name, age, contact, homeAddress, new uint[](0), new uint[](0), true);
        emit LogNewPatient(patID,name,age,contact,homeAddress);
    }
    
    function getPatient(uint patID) public onlySmartContractOwner view returns (string memory _name, uint _age, string memory _contact, string memory _homeAddress) {
        require(patientDetails[msg.sender][patID].registerStatus);
        _name = patientDetails[msg.sender][patID].name;
        _age = patientDetails[msg.sender][patID].age;
        _contact = patientDetails[msg.sender][patID].contact;
        _homeAddress = patientDetails[msg.sender][patID].homeAddress;
    }

    function setPatientName(uint patID, string memory name) public //onlySmartContractOwner
    {
        require(patientDetails[msg.sender][patID].registerStatus);
        patientDetails[msg.sender][patID].name = name;
    }

    function setPatientAge(uint patID, uint age) public onlySmartContractOwner{
        require(patientDetails[msg.sender][patID].registerStatus);
        patientDetails[msg.sender][patID].age = age;
    }
    function setPatientContact(uint patID, string memory contact) public onlySmartContractOwner{
        require(patientDetails[msg.sender][patID].registerStatus);
        patientDetails[msg.sender][patID].contact = contact;
    }
    function setPatientAddress(uint patID, string memory homeAddress) public onlySmartContractOwner{
        require(patientDetails[msg.sender][patID].registerStatus);
        patientDetails[msg.sender][patID].homeAddress = homeAddress;
    }

    function getPatientName(uint patID) public view returns (string memory){
        require(patientDetails[msg.sender][patID].registerStatus);
        return patientDetails[msg.sender][patID].name;
    }
    function getPatientAge(uint patID) public view returns (uint){
        require(patientDetails[msg.sender][patID].registerStatus);
        return patientDetails[msg.sender][patID].age;
    }
    function getPatientContact(uint patID) public view returns (string memory){
        require(patientDetails[msg.sender][patID].registerStatus);
        return patientDetails[msg.sender][patID].contact;
    }
    
    function getPatientAddress(uint patID) public view returns (string memory){
        require(patientDetails[msg.sender][patID].registerStatus);
        return patientDetails[msg.sender][patID].homeAddress;
    }
    function getPatientStatus(uint patID) public view returns (bool){
        return patientDetails[msg.sender][patID].registerStatus;
    }
    function getPatientDoctors(uint patID) public view returns (uint){
        return patientDetails[msg.sender][patID].doctors.length;
    }
    function getPatientTreatments(uint patID) public view returns (uint){
        return patientDetails[msg.sender][patID].treatments.length;
    }
    
    struct Doctor{
        uint docID;
        string name;
        string medicalFacility;
        string medicalSpecialty;
        bool registerStatus;
    }
    
    function addDoctor(uint docID,string memory name, string memory medicalFacility, string memory medicalSpecialty) 
    public //onlySmartContractOwner
    {
        require(doctorDetails[msg.sender][docID].registerStatus==false);
        numDoctors++;
        doctorDetails[msg.sender][docID]=Doctor(docID, name, medicalFacility, medicalSpecialty, true);
    }
    
    function getDoctorDetails(uint docID) public onlySmartContractOwner view returns (string memory _name, string memory _medicalFacility, string memory _medicalSpecialty) {
        require(doctorDetails[msg.sender][docID].registerStatus);
        _name = doctorDetails[msg.sender][docID].name;
        _medicalFacility = doctorDetails[msg.sender][docID].medicalFacility;
        _medicalSpecialty = doctorDetails[msg.sender][docID].medicalSpecialty;
    }
    
    function treatPatient(uint patID, uint docID) public //onlySmartContractOwner 
    {
        require(patientDetails[msg.sender][patID].registerStatus);
        require(doctorDetails[msg.sender][docID].registerStatus);
        patientDetails[msg.sender][patID].doctors.push(doctorDetails[msg.sender][docID].docID);
    }
    
    function setDoctorName(uint docID, string memory name) public //onlySmartContractOwner
    {
        require(doctorDetails[msg.sender][docID].registerStatus);
        doctorDetails[msg.sender][docID].name = name;
    }
    function setDoctorMedicalFacility(uint docID, string memory facility) public onlySmartContractOwner{
        require(doctorDetails[msg.sender][docID].registerStatus);
        doctorDetails[msg.sender][docID].medicalFacility = facility;
    }
    function setDoctorSpecialty(uint docID, string memory specialty) public onlySmartContractOwner{
        require(doctorDetails[msg.sender][docID].registerStatus);
        doctorDetails[msg.sender][docID].medicalSpecialty = specialty;
    }

    function getDoctorName(uint docID) public view returns (string memory){
        require(doctorDetails[msg.sender][docID].registerStatus);
        return doctorDetails[msg.sender][docID].name;
    }

    function getDoctorMedicalFacility(uint docID) public view returns (string memory){
        require(doctorDetails[msg.sender][docID].registerStatus);
        return doctorDetails[msg.sender][docID].medicalFacility;
    }
    function getDoctorSpecialty(uint docID) public view returns (string memory){
        require(doctorDetails[msg.sender][docID].registerStatus);
        return doctorDetails[msg.sender][docID].medicalSpecialty;
    }

    function getDoctorStatus(uint docID) public view returns (bool){
        return doctorDetails[msg.sender][docID].registerStatus;
    }

    function getNumDoctors() public view returns (uint) {
      return numDoctors;
    }

    function getNumPatients() public view returns (uint) {
      return numPatients;
    }
    
    struct Treatment {
        uint patientID;
        uint doctorID;
        string diagnosis;
        string medicine;
        uint date;
        bool registerStatus;
    }
    
    uint lastTreatmentID = 0;
    mapping(uint => Treatment) treatments;
    
    function createTreatment(uint patientID, uint doctorID, string memory diagnosis, string memory medicine) 
    public onlySmartContractOwner returns (uint) {
        require(patientDetails[msg.sender][patientID].registerStatus);
        require(doctorDetails[msg.sender][doctorID].registerStatus);
        uint id=lastTreatmentID;
        treatments[id].patientID = patientID;
        treatments[id].doctorID = doctorID;
        treatments[id].diagnosis = diagnosis;
        treatments[id].medicine = medicine;
        treatments[id].date = now;
        treatments[id].registerStatus = true;
        patientDetails[msg.sender][patientID].treatments.push(id);
        lastTreatmentID++;
        return id;
    }
    
    function getTreatmentDetails(uint treatmentID) public onlySmartContractOwner view returns (uint _patientID, uint _doctorID, string memory _diagnosis, string memory _medicine, uint _date) {
        require(treatments[treatmentID].registerStatus);
        _patientID = treatments[treatmentID].patientID;
        _doctorID = treatments[treatmentID].doctorID;
        _medicine = treatments[treatmentID].medicine;
        _diagnosis = treatments[treatmentID].diagnosis;
        _date = treatments[treatmentID].date;
    }

    function editTreatmentDetails(uint treatmentID, string memory diagnosis, string memory medicine) public onlySmartContractOwner{
        require(treatments[treatmentID].registerStatus);
        treatments[treatmentID].medicine = medicine;
        treatments[treatmentID].diagnosis = diagnosis;
        treatments[treatmentID].date = now;
    }
}