pragma solidity ^0.5.0;

contract Buzzcoin {

    mapping (address => bool) private p1;
    mapping (address => bool) private p2;
    mapping (address => bool) private p3;
    mapping (address => bool) private p4;
    mapping (address => bool) private p5;
    mapping (address => bool) private p6;
    mapping (address => bool) private p7;

    mapping (address => bool) private perm;
    address[40] private users;
    address owner;

    function () external payable {}
    function donate() external payable {}


    //constructor
    constructor() public{
        owner = msg.sender;
        users = [0x71caC84e88D4C5E4cdAEBfe21C178Ac467B4f77d, 0x2d9be36890a99C80F252E696194189D2F9c5f160, 0x53cAee6a3f6c528A419367108766d1Fc1A5a21B7, 0xCb1aFDC8ed80FE28E6295BABa027d49C45FcE465, 0x3E6f6f38B3AB719A8749Ce77c1481FE77C5d9123, 0x9F99754746cb869E57a1b50868d6c684feee7A09, 0xbC8f2E33B23536Ee7F327bB1F62C8990E894679d, 0x8C56907Fd9a8289D05222d67b31bCF9BeE4c3322, 0x62971627e947E3b4403f489e864BC47a445EAa9b, 0xF1276e9CE3A58B2292248e184945B818f84C3D33, 0x6D4C70a768B4f6947387179A69F27d9509794793, 0x04481C7EeFc711610E8C8b7f5C633fE0e3f90b3b, 0x087c164777E66E696262E8802aDe75E00060E7C3, 0x80E8FDA0558340522741af206d272Cc3bBD1896F, 0xB308bfa0aF2e107EB160a501CfA3c0CF1d0Ebb86, 0x3727197874eECe1ba6D754CDCC2E387016A213A0, 0xAD883DF7Ed09c3ADFF080db06671fa219411F1f1, 0x639543a00D691719c05be1E973FCa02083c0d711, 0x0208079Cd52b866040b89Ab5635984Ad131316A3, 0x02aF6680e6eb75b6044dAE89a62bc2a24761d5B6, 0xBaF0d1E75F00787143008fd8aAc63004cE427a7f, 0xA2750D199dd264AEBa9E7806a0b877e4516e2c8F, 0xdf49Eb4D5323a02803D1B3e50B6B0fa1fE72141F, 0xda329c9E5C216CAB3284F810C8cb4d9823aDEA9a, 0xe04Ab27880Ae69835065Da476C3e0C7A0B237868, 0x500B55D22CDa3cAD0274790Eaf4ae0597973cEA5, 0x19aa426cB6861d6c6DE596212c7F3E29C950BDd4, 0x8c35947aC87780e8C0E5095AD352c1f57d47F3C9, 0xfdC5413A7CC1b4F72a783F20E1985672b3A53076, 0x9C11002AaEb94147a4844C1A3ad36D59aC0625dd, 0x73Daa1eF3EF50D935c0850456879cbdeAC7314da, 0x73Daa1eF3EF50D935c0850456879cbdeAC7314da, 0xa7177777f7563Fab5C8E4c98a4fB7A21416be12d, 0x3EaEAfdea4e2c3A47f6d44aD2aB86CfC426A5402, 0xF867F9396081CF367e6CE70E69C4eCC3F067bc83, 0x1a8dA1e8A09A79052221346759BF0a94f02607E5, 0xa30e162D0108B1699f5Ba60C1Bd98557e96E66b3, 0xf6F53Aca1A2C0B017BEb7Bd80DAB169D8CDd5e5B, 0x82a8723CE3FcdDE148e266BE83ff02b5B087E1Fd, 0x2C3cDe3d87272C8ba94135C73f334377BC6e66e1];
        for(uint i = 0; i < 40; i++){
            perm[users[i]] = true;
        }

        //problem 7 initialization
        richest = msg.sender;
        mostSent = 0;
    }

    function problem1() external payable {
        assert(!p1[msg.sender]);
        assert(perm[msg.sender]);
        msg.sender.transfer(1 ether);
        p1[msg.sender] = true;

    }
    uint mask = 2;
    function problem2(uint nonce) external payable {
        assert(!p2[msg.sender]);
        assert(perm[msg.sender]);
        uint hash = uint(sha256(abi.encode(nonce, msg.sender)));
        mask *= 2;
        if (hash % mask == 0){
            p2[msg.sender] = true;
            msg.sender.transfer(5 ether);
        }
    }

    function problem3() external payable {
        assert(!p3[msg.sender]);
        assert(perm[msg.sender]);
        uint dice = uint(keccak256(abi.encode(msg.sender, block.number, now))) % 6;
        if(dice == 0) {
            p3[msg.sender] = true;
            msg.sender.transfer(1 ether);
        }
    }

    function problem4() external payable {
        assert(!p4[msg.sender]);
        assert(perm[msg.sender]);
        assert(msg.value == 1 ether);
        p4[msg.sender] = true;
    }

    uint256 doggy = 43169883051092453190094141851069219482566562937660943787317544241827140791188;
    function problem5(string memory preimage) public payable {
        assert(!p5[msg.sender]);
        assert(perm[msg.sender]);
        uint hash = uint(sha256(abi.encode(preimage)));
        assert(hash == doggy);
        msg.sender.transfer(3 ether);
        p5[msg.sender] = true;
    }


    //mayor

    uint256 private plays = 0;
    uint256 private total = 0;
    uint256[101] private counter;
    address payable[101] private identity;
    address payable[5] private already_played;

    function problem6() external payable {
        if(msg.value % (1 ether) != 0 || msg.value == 0 || msg.value > (100 ether)){
            revert();
        }

        uint256 val_in_eth = msg.value / (1 ether);

        // if already played - revert
        for (uint i=0; i<5; i++) {
            if (already_played[i] == msg.sender) {
                revert();
            }
        }
        already_played[plays] = msg.sender;

        plays++;
        counter[val_in_eth]++;
        identity[val_in_eth] = msg.sender;
        total += msg.value;

        if (plays == 5) {
            bool payed = false;
            for (uint i = 0; i < 101; i++) {
                if (counter[i] == 1 && !payed) {
                    identity[i].transfer(total + (2 ether));
                    payed = true;
                }
                delete counter[i];
                delete identity[i];
            }
            plays = 0;
            total = 0;

            for (uint i=0; i<5; i++)
                delete already_played[i];
        }

        p6[msg.sender] = true;
    }

    //king of the hill


    // The goal is to send the most money to the contract in order to become the
    // “richest”, inspired by King of the Ether. In the following contract, if
    // you are usurped as the richest, you will receive the funds of the person
    // who has gone on to become the new richest.
    // https://solidity.readthedocs.io/en/v0.4.24/common-patterns.html
    address public richest;
    uint public mostSent;

    mapping (address => uint) pendingWithdrawals;

    function problem7becomeRichest() public payable returns (bool) {
        if (msg.value > mostSent) {
            pendingWithdrawals[richest] += msg.value;
            richest = msg.sender;
            mostSent = msg.value;
            return true;
        } else {
            return false;
        }
        p7[msg.sender] = true;
    }

    function problem7withdraw() public {
        uint amount = pendingWithdrawals[msg.sender];
        // Remember to zero the pending refund before
        // sending to prevent re-entrancy attacks
        pendingWithdrawals[msg.sender] = 0;
        msg.sender.transfer(amount);
        p7[msg.sender] = true;
    }
}
