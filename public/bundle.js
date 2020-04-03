var contractABI = [
    {
      "constant": false,
      "inputs": [
        {
          "internalType": "uint256",
          "name": "nonce",
          "type": "uint256"
        }
      ],
      "name": "problem2",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [],
      "name": "testp2",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    }
];
const contractAddress = '0xc48C09B54AF1bC06A2B7fEC561C8f8ad691B34b5';


const web3 = new Web3('http://localhost:9545');
const smartContract= new web3.eth.Contract(contractABI, contractAddress);


document.addEventListener('DOMContentLoaded', () => {
    const $runButton = document.getElementById("run");
    const $nounce  = document.getElementById('nounce-result');

    // normal works
    console.log("STARTED");
    smartContract.methods.testp2().call().then(_result => {
        $nounce.innerHTML = _result;
        console.log("result = ", _result);
    });
 
    // Prevent default not working.....
    $runButton.addEventListener('submit', e => {
        e.preventDefault();
        console.log("Running test : ");
        smartContract.methods.testp2().call().then(_result => {
            $nounce.innerHTML = _result;
            console.log("result = ", _result);
        });
    });

});
