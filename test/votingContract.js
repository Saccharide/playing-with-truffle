const VotingContract = artifacts.require('VotingContract');

contract('VotingContract', () => {
    it('Vote for candidate 1', async () => {
        const votingContract = await VotingContract.deployed();
        await votingContract.vote("candidate 1");
        await votingContract.closeVote();

        const winner = await votingContract.getWinner(); 
        assert(("candidate 1", 1) !== 0);
    });
});
