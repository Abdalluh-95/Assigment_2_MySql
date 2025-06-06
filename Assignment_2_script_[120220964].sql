-- ______________method using______________
-- SUBSTRING_INDEX , LEFT , RIGHT , TRIM , LOCATE , ROUND


-- Question 1 - Problem 1
SELECT title, author
FROM data_science_books
ORDER BY title
LIMIT 10;

-- Question 1 - Problem 2
SELECT *
FROM data_science_books
WHERE language = 'English'
AND price BETWEEN 30 AND 50;
-- if you need just name book replase * -> title


-- Question 1 - Problem 3
SELECT 
  TRIM(LEFT(publisher, LOCATE('(', publisher) - 1)) AS publisher_name,
  AVG(pages) AS avg_pages
FROM 
  data_science_books
WHERE 
  publisher IS NOT NULL
  AND publisher != ''
GROUP BY 
  publisher_name
HAVING 
  COUNT(title) > 5;
-- LOCATE: returns the position of the first "(" in the publisher string and -1 So you don't count ")"
-- LEFT: takes the text from the start up to just before the "("
-- TRIM: removes extra spaces from the start and end of the string


-- Question 1 - Problem 4
SELECT title, avg_reviews
FROM data_science_books
WHERE title LIKE '%Python%'
ORDER BY avg_reviews DESC
LIMIT 5;

-- Question 1 - Problem 5
SELECT language,
ROUND(SUM(star5) / SUM(n_reviews) * 100, 2) AS rate_star5
FROM data_science_books
WHERE LANGUAGE IS NOT null and LANGUAGE != ''
GROUP BY language
HAVING COUNT(*) >= 20;

-- Question 1 - Problem 6
SELECT 
  TRIM(SUBSTRING_INDEX(publisher, ';', 1)) AS A_publisher,
  COUNT(*) AS total_books,
  SUM(n_reviews) AS total_reviews,
  ROUND(SUM(star5) / SUM(n_reviews) * 100, 2) AS rate_avg_star5
FROM 
  data_science_books
WHERE 
  publisher IS NOT NULL AND publisher != ''
GROUP BY 
  A_publisher
HAVING 
  COUNT(*) >= 10 
  AND rate_avg_star5 >= 30
ORDER BY 
  rate_avg_star5 DESC;



-- Question 1 - Problem 7
SELECT language,
       AVG(price / pages) AS avg_price_page
FROM data_science_books
WHERE pages IS NOT NULL AND pages > 0
GROUP BY language
ORDER BY avg_price_page DESC
LIMIT 3;

-- Question 1 - Problem 8
SELECT 
  RIGHT(SUBSTRING_INDEX(SUBSTRING_INDEX(publisher, '(', -1), ')', 1), 4) AS pub_year,
  AVG(price) AS avg_price
FROM 
  data_science_books
WHERE 
  price IS NOT NULL AND publisher LIKE '%(%'
GROUP BY 
  pub_year
ORDER BY 
  avg_price DESC
  LIMIT 1;
-- RIGHT(str , n) take (n) of leater from (str) From the end of the text  
-- The SUBSTRING_INDEX  Take a specific part of the text according to the condition
-- SUBSTRING_INDEX(str, delim, count) 
-- str: name Column 
-- dilim: The separator we want to use for the division
-- count: How many words
-- -1: means that we want the part after the last occurrence of the separator from the right.


-- Question 1 - Problem 9
SELECT 
    ds.publisher,
    AVG(ds.avg_reviews) AS avg_rating,
    AVG(ds.avg_reviews) - overall.overall_avg AS difference
FROM 
    data_science_books ds,
    (SELECT AVG(avg_reviews) AS overall_avg FROM data_science_books) AS overall
GROUP BY 
    ds.publisher
HAVING 
    difference >= 0.5
ORDER BY 
    difference DESC;


-- Question 3 - Problem 1
SELECT title FROM data_science_books WHERE language LIKE 'English';

-- Question 3 - Problem 2
SELECT * FROM data_science_books WHERE NOT price < 100 ORDER BY price DESC;

-- Question 3 - Problem 3
SELECT publisher, COUNT(publisher) AS books 
FROM data_science_books 
GROUP BY publisher;

-- Question 3 - Problem 4
SELECT title, pages 
FROM data_science_books 
WHERE IFNULL(pages, 0) = 0;
-- I'm use IFNULL methoed to check if value null replase ( null -> 0 )


-- Question 3 - Problem 5
SELECT language, SUM(price) / COUNT(price) AS avg_price
FROM data_science_books
GROUP BY language
ORDER BY avg_price ASC;
