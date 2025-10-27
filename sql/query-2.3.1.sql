WITH MatchesInMadrid AS (
    SELECT m.matchID
    FROM Team t
    JOIN Match m ON t.teamID = m.Team1ID
    WHERE t.City = 'Madrid'
)
SELECT p.playerID, p.Name, p.Surname
FROM Player p
JOIN Goal g ON p.playerID = g.PlayerID
JOIN MatchesInMadrid mm ON g.MatchID = mm.matchID;
