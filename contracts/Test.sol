pragma solidity ^0.5.0;

contract Test{


    uint mask = 2;
    
    function problem2(uint nonce) public returns (bool){
        bool result = false;
        //address _address = parseAddr("0xa7177777f7563fab5c8e4c98a4fb7a21416be12d");
        address _address = 0xa7177777f7563Fab5C8E4c98a4fB7A21416be12d;

        uint hash = uint(sha256(abi.encode(nonce, _address)));
        
        mask *= 2;
        if (hash % 4 == 0){
            result = true;
        }
        return result;
    }
    
    function testp2() public returns (uint) {
        uint ans = 0;
        for(uint i = 700; i < 900; i++) {
            if (problem2(i)) {
                ans = i;
                break;
            }
        }
        return ans;
    }

}
