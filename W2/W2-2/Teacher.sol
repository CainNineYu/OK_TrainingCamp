// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IScore {
    function modifyScore(address _addr, uint256 _score) external;
}

contract Teacher {

    IScore public score;

    constructor(IScore _scoreAddr) {
        score = _scoreAddr;
    }

    function teacherModifyScore(address _addr, uint256 _score) public {
        score.modifyScore(_addr, _score);
    }
}