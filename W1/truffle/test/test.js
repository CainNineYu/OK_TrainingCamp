var Counter = artifacts.require("Counter");

contract("Counter", function(accounts) {
  var counterInstance;
  // it定义一个测试用例
  it("Counter", function() {  
    //部署之后读取count值，判断值是否等于1
    return Counter.deployed()
      .then(function(instance) {
        counterInstance = instance;
        return counterInstance.count();
      }).then(function() {
        return counterInstance.counter();
      }).then(function(count) {
        // 满足断言则测试用例通过
        assert.equal(count, 1);  
    });
  });
});