// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.9.0;

import "./Roles.sol";

contract Patient {
  using Roles for Roles.Role;

  event PatientAdded(address indexed _account);
  event PatientRemoved(address indexed _account);

  Roles.Role private patientsList;

  constructor() public {
    patientsList.addRole(msg.sender);
    emit PatientAdded(msg.sender);
  }

  ///@dev Modifiers for Patient.
  modifier onlyPatient() {
    require(isPatient(msg.sender));
    _;
  }
  /*-----------------------------*/

  ///@dev Patient Utility functions.
  function isPatient(address _account) public view returns (bool) {
    return patientsList.hasRole(_account);
  }

  function addPatient(address _account) public onlyPatient {
    patientsList.addRole(_account);
    emit PatientAdded(_account);
  }

  function removePatient() public {
    patientsList.removeRole(msg.sender);
    emit PatientRemoved(msg.sender);
  }
  /*-----------------------------*/

}
