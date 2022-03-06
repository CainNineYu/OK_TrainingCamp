// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Score {

    mapping(address => uint256) public student;
    mapping(address => bool) public teacherAddr;

    event StudentScore(
        address indexed teacherAddr,
        address indexed studentAddr,
        uint256 score
    );

    modifier onlyTeacher() {
        require(teacherAddr[tx.origin], "No Root");
        _;
    }

    constructor() {
        teacherAddr[msg.sender] = true;
    }

    function modifyScore(address _addr, uint256 _score) public onlyTeacher {
        require(_score <= 100, "Score Not More Than 100 !!");
        student[_addr] = _score;
        emit StudentScore(msg.sender, _addr, _score);
    }

}