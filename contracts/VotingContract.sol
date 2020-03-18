pragma solidity ^0.5.0;

contract VotingContract{
    
    address public creator;

    // Record keeping variables
    mapping(address => bool) private votingRecords;
    mapping(bytes32 => string) private candidates;
    mapping(string => uint) private scoreboard;
    
    struct Candidate {
        string name;
    }
    // list of candidates
    Candidate[] Candidate_list;

    bool private voteEnded;

    // Winner variables
    uint private max_vote;
    string private winner;

    // Converting bytes32 to string
    function bytes32ToString(bytes32 str) pure public returns (string memory) {
        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
        for (uint i = 0; i < 32; i++) {
            byte char = byte(bytes32(uint(str) * 2 ** (8 * i)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }   
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (uint j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        return string(bytesStringTrimmed);
    }

    // Converting from string to bytes32: bytes32(str)

    // Creating a new instance of voting from a list of names, since solidity does not support an array of string (because they are not treated as primitive types), we will get a list of bytes32 values as input, and then convert it manually.
    constructor(bytes32[] memory _candidateList) public {
        creator = msg.sender;

        for(uint i = 0; i < _candidateList.length; i++) {
            // Convert the byte32 value to string
           	string memory candidate = bytes32ToString(_candidateList[i]);

           	// Initialize voting scorebard for each candidate 
           	scoreboard[candidate] = 0;
			
		    // Initialize mapping
			candidates[_candidateList[i]] = candidate;
			
			Candidate_list.push(Candidate({name:candidate}));
			
        }
    }


    // Voting function, each user can only vote once. This allows user to vote using candidate's bytes32 value
    function vote(bytes32 _candidate) public {
        // Requiring that vote is not ended
        require(!voteEnded);
        // Requiring that user has not yet voted
        require(!votingRecords[msg.sender]);
        
        // Set user's voting status to voted
        votingRecords[msg.sender] = true;

        string memory candidate = bytes32ToString(_candidate);

        // Increament the score for that candidate
        scoreboard[candidate]++;

        // Check if it is the one with highest vote
        if (scoreboard[candidate] > max_vote) {
            max_vote = scoreboard[candidate];
            winner = candidate;
        } 
    }

    // Give user the option of voting with their string name
    function vote(string memory _candidate) public {
        // Requiring that vote is not ended
        require(!voteEnded);
        // Requiring that user has not yet voted
        require(!votingRecords[msg.sender]);
        
        // Set user's voting status to voted
        votingRecords[msg.sender] = true;

        // Increament the score for that candidate
        scoreboard[_candidate]++;

        // Check if it is the one with highest vote
        if (scoreboard[_candidate] > max_vote) {
            max_vote = scoreboard[_candidate];
            winner = _candidate;
        } 
    }

    // Close the voting, only can be called with the creator
    modifier isOwner() {
        require(msg.sender == creator, "Caller is not creator");
        _;
    }
    function closeVote() public isOwner {
        voteEnded = true;
    }

    // Reopen vote just in case close by mistake
    function reopenVote() public isOwner {
        voteEnded = false;
    }

    // See Winner and number of votes
    function getWinner() view public returns(string memory, uint) {
        // Check if voting has ended
        require(voteEnded, "Voting is still happing");
        return (winner, max_vote);
    }
    
    // See current candidates
    function viewCandidates() view public returns(string memory) {
        
        string memory result = "";
        for (uint i = 0; i < Candidate_list.length; i++){
            string memory temp = append(Candidate_list[i].name,"\n");
            result = append(result, temp);
        }
        return result;
        
    }
    
    // Concatenate strings
    function append(string memory a, string memory b) internal pure returns (string memory) {

        return string(abi.encodePacked(a, b));

    }

}

