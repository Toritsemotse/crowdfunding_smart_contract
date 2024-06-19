//SPDX-License-Identifier:MIT

pragma solidity^0.8.22;

contract crowdfunding {
    address public  owner;

    enum State{
        IN_PROGRESS,
        ENDED
    }

    State public currentState;
    
    constructor() {
        owner = payable (msg.sender);
    }

    modifier stillInProgress() {
        require(currentState == State.IN_PROGRESS, "donation phase is no longer in progress");
        _;
    }

    function donate() external payable stillInProgress() {}

    function checkAmountCollected() public view stillInProgress() returns(uint256) {
        return address(this).balance;
    }

    function withdraw() external {
        require(msg.sender == owner, "only the owner can withdraw");
        payable(owner).transfer(address(this).balance);
        currentState = State.ENDED;
    }

}