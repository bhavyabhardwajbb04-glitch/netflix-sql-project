create database netflix;
use netflix;
create table netflix_titles(
show_id varchar(10),
type varchar(15),
title varchar (150), 
director varchar(208),
casts varchar(1000),
country	varchar(150),
date_added	datetime,
release_year int,
rating	varchar(10),
duration varchar (15),	
listed_in varchar(100),
description varchar (250)
);
select * from netflix_titles;
select count(*) as total_content from  netflix_titles;
select distinct type from  netflix_titles;
-- 15 Business Problems & Solutions
-- 1. Count the number of Movies vs TV Shows
select count(*) as total_content from  netflix_titles 
group by type;

-- 2. Find the most common rating for movies and TV shows
select type , rating,count(*),max(rating) 
from  netflix_titles group by 1,2, 

-- 3. List all movies released in a specific year (e.g., 2020)
select * from  netflix_titles 
where type ='Movie' and release_year=2020;

-- 4. Find the top 5 countries with the most content on Netflix
select country ,count(*) as table_content
from  netflix_titles
where country is not null
group by country
order by table_content desc
limit 5;

-- 5. Identify the longest movie
select * from  netflix_titles
where type='Movie'and duration= (select max(duration) from netflix_titles)

-- 6. Find content added in the last 5 years
select * from netflix_titles
where date_added>=current_date -interval 5 year
order by date_added desc;

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select * from netflix_titles 
where director LIKE %Rajiv Chilaka% ;

-- 8. List all TV shows with more than 5 seasons
SELECT *
FROM netflix_titles
WHERE type = 'TV Show'
  AND duration = '5 Seasons';
-- 9. Count the number of content items in each genre
select listed_in, count(*) as table_content 
from netflix_titles group by listed_in 
order by table_content desc;

-- 10.Find each year and the average numbers of content release in India on netflix. 
 -- return top 5 year with highest avg content release!
 SELECT release_year,COUNT(*) AS total_content,
AVG(COUNT(*)) OVER () AS avg_content
FROM netflix_titles
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY total_content DESC
LIMIT 5;
-- 11. List all movies that are documentaries
select * from netflix_titles
where listed_in='documentaries';
-- 12. Find all content without a director
select * from netflix_titles
where director IS NULL;
-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT COUNT(*) AS total_movies
FROM netflix_titles
WHERE type = 'Movie'
AND cast LIKE '%Salman Khan%'
AND release_year BETWEEN 2016 AND 2025;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
WITH RECURSIVE actor_split AS (
    SELECT
        show_id,
        TRIM(SUBSTRING_INDEX(cast, ',', 1)) AS actor,
        SUBSTRING(cast, LENGTH(SUBSTRING_INDEX(cast, ',', 1)) + 2) AS remaining
    FROM netflix_titles
    WHERE country LIKE '%India%'
      AND type = 'Movie'
      AND cast IS NOT NULL
      
-- 15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.

select case when description LIKE '%kill%'
or description like '%violence%'
then 'Bad'
else 'Good'
end as content_category,
COUNT(*) as total_content
from netflix_titles
group by content_category;
