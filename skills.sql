-- Note: Please consult the directions for this assignment 
-- for the most explanatory version of each question.
-- SCHEMAS FYI: 
CREATE TABLE Brands (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    founded INT(4),
    headquarters VARCHAR(50),
    discontinued INT(4)
);

CREATE TABLE Models (
    id INTEGER PRIMARY KEY,
    year INT(4) NOT NULL,
    brand_name VARCHAR(50) NULL,
    name VARCHAR(50) NOT NULL
);

-- 1. Select all columns for all brands in the Brands table.
    SELECT * FROM Brands;

-- 2. Select all columns for all car models made by Pontiac in the Models table.
    SELECT * FROM Models 
        WHERE branch_name = 'Pontiac';

-- 3. Select the brand name and model 
--    name for all models made in 1964 from the Models table.
    SELECT brand_name, name FROM Models
        WHERE year = 1964;

-- 4. Select the model name, brand name, and headquarters for the Ford Mustang 
--    from the Models and Brands tables.
    SELECT Models.name, Models.brand_name, Brands.headquarters 
        FROM Models JOIN Brands ON (Models.brand_name = Brands.name)
            WHERE Models.name = 'Mustang';

-- 5. Select all rows for the three oldest brands 
--    from the Brands table (Hint: you can use LIMIT and ORDER BY).
    SELECT * FROM Brands
        ORDER BY founded LIMIT 3;

-- 6. Count the Ford models in the database (output should be a number).
    SELECT COUNT(*) FROM Models
        WHERE brand_name = 'Ford';

-- 7. Select the name of any and all car brands that are not discontinued.
    SELECT name FROM Brands
        WHERE discontinued IS NULL;

-- 8. Select rows 15-25 of the DB in alphabetical order by model name.
    SELECT Models.id AS 'Model ID', Models.year, Models.brand_name AS 'Brand Name', Models.name AS 'Model Name', Brands.id AS 'Brand ID', Brands.founded, Brands.headquarters, Brands.discontinued 
        FROM Models LEFT JOIN Brands ON (Models.brand_name = Brands.name)
            ORDER BY Models.name LIMIT 14, 10;            #OFFSET by 14, get 10
###ROO: wasn't sure if we wanted row 25 or just up to 25, went with exclusive

-- 9. Select the brand, name, and year the model's brand was 
--    founded for all of the models from 1960. Include row(s)
--    for model(s) even if its brand is not in the Brands table.
--    (The year the brand was founded should be NULL if 
--    the brand is not in the Brands table.)
    SELECT Models.brand_name, Models.year, Brands.founded
        FROM Models LEFT JOIN Brands ON (Models.brand_name = Brands.name)
            WHERE Models.year = 1960;


-- Part 2: Change the following queries according to the specifications. 
-- Include the answers to the follow up questions in a comment below your
-- query.

-- 1. Modify this query so it shows all brands that are not discontinued
-- regardless of whether they have any models in the models table.
-- before:
    -- SELECT b.name,
    --        b.founded,
    --        m.name
    -- FROM Model AS m
    --   LEFT JOIN brands AS b
    --     ON b.name = m.brand_name
    -- WHERE b.discontinued IS NULL;
    SELECT DISTINCT B.name AS 'Brand Name', B.founded AS 'Year Founded', M.name AS 'Model Name'
        FROM Brands AS B LEFT JOIN Models as M ON (B.name = M.brand_name)
        WHERE B.discontinued IS NULL;
###ROO: Used distinct because the query asks for all brands (not all models)


-- 2. Modify this left join so it only selects models that have brands in the Brands table.
-- before: 
    -- SELECT m.name,
    --        b.name,
    --        b.founded
    -- FROM Models AS m
    --   LEFT JOIN Brands AS b
    --     ON b.name = m.brand_name;
        SElECT  M.name,
                B.name,
                B.founded
        FROM Brands AS B
            LEFT JOIN Models as M ON (B.name = M.brand_name)
        ORDER BY B.name;                              #HAVE TESLA, NOT FILMORE


-- followup question: In your own words, describe the difference between 
-- left joins and inner joins.
###ROO: 
### Inner joins show info for fields that both tables have in common.  
#If you inner join tables on a field where some rows have NULL values, those rows won't show
### Left joins show all info for the left table regardless of whether it's NULL in right table,
# and corresponding info from right table.  
#If you Left Join tables on a field where some rows in the left table have NULL values, those rows will still show


-- 3. Modify the query so that it only selects brands that don't have any models in the models table. 
-- (Hint: it should only show Tesla's row.)
-- before: 
    -- SELECT name,
    --        founded
    -- FROM Brands
    --   LEFT JOIN Models
    --     ON brands.name = Models.brand_name
    -- WHERE Models.year > 1940;
    SELECT  B.name,
            B.founded
    FROM Brands AS B
        LEFT JOIN Models AS M ON (B.name = M.brand_name)
    WHERE M.brand_name IS NULL;


-- 4. Modify the query to add another column to the results to show 
-- the number of years from the year of the model until the brand becomes discontinued
-- Display this column with the name years_until_brand_discontinued.
-- before: 
    -- SELECT b.name,
    --        m.name,
    --        m.year,
    --        b.discontinued
    -- FROM Models AS m
    --   LEFT JOIN brands AS b
    --     ON m.brand_name = b.name
    -- WHERE b.discontinued NOT NULL;
    SELECT  B.name,
            M.name,
            M.year,
            B.discontinued,
            (B.discontinued - M.year)  AS 'years_until_brand_discontinued'
    FROM Models AS M
        LEFT JOIN Brands AS B
            ON (M.brand_name = B.name)
        WHERE B.discontinued NOT NULL
        ORDER BY M.name;




-- Part 3: Further Study

-- 1. Select the name of any brand with more than 5 models in the database.

-- 2. Add the following rows to the Models table.

-- year    name       brand_name
-- ----    ----       ----------
-- 2015    Chevrolet  Malibu
-- 2015    Subaru     Outback

-- 3. Write a SQL statement to crate a table called `Awards`
--    with columns `name`, `year`, and `winner`. Choose
--    an appropriate datatype and nullability for each column
--   (no need to do subqueries here).

-- 4. Write a SQL statement that adds the following rows to the Awards table:

--   name                 year      winner_model_id
--   ----                 ----      ---------------
--   IIHS Safety Award    2015      the id for the 2015 Chevrolet Malibu
--   IIHS Safety Award    2015      the id for the 2015 Subaru Outback

-- 5. Using a subquery, select only the *name* of any model whose 
-- year is the same year that *any* brand was founded.





