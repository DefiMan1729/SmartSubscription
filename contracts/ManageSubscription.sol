// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract ManageSubscription {
    uint public nextPlanId;
    address token;

    constructor (address _token){
        token = _token;
    }

    struct Plan{
    address merchant;
    uint amount;
    uint frequency;
    }

    struct Subscription {
    address subscriber;
    uint start;
    uint nextPayment;
  }
    mapping(uint => Plan) public plans;
    mapping(address => mapping(uint => Subscription)) public subscriptions;
    function createPlan(uint amount, uint frequency) public {
    plans[nextPlanId] = Plan(
      msg.sender, 
      amount, 
      frequency
    );
    nextPlanId++;
  }

    function subscribe(uint planId) public {
        IERC20(token).transferFrom(msg.sender, plans[planId].merchant, plans[planId].amount);
        subscriptions[msg.sender][planId]= Subscription(
            msg.sender,
            block.timestamp,
            block.timestamp + plans[planId].frequency
        );
    }

    function payup(address subscriber, uint planId) public {
        require(
        block.timestamp > subscriptions[msg.sender][planId].nextPayment,
        'payment not due'
    );
    IERC20(token).transferFrom(subscriber, plans[planId].merchant, plans[planId].amount);
    subscriptions[msg.sender][planId].nextPayment= block.timestamp + plans[planId].frequency;
    }

    function cancel(address _subscriber, uint _planId) public {
        delete subscriptions[_subscriber][_planId];
    }

}