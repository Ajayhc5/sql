CREATE TABLE Numbers_Miss (id INT);
INSERT INTO Numbers_Miss VALUES (1),(2),(3),(5),(6),(8);

-- Create a tally table (1 to 100)
WITH Tally AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS num FROM sys.objects)
SELECT num AS MissingNumber FROM Tally WHERE 
num BETWEEN (SELECT MIN(id) FROM Numbers_Miss) AND (SELECT MAX(id) FROM Numbers_Miss)
  AND num NOT IN (SELECT id FROM Numbers_Miss);

WITH Tally AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS num FROM sys.objects)
SELECT t.num AS MissingNumber FROM Tally t
LEFT JOIN Numbers_Miss n ON t.num = n.id
WHERE n.id IS NULL AND t.num BETWEEN (SELECT MIN(id) FROM Numbers_Miss) AND (SELECT MAX(id) FROM Numbers_Miss);



