--1. Retrieve the names of all artists along with the number of artworks they have in the gallery, andlist them in descending order of the number of artworks.
SELECT 
    A.Name AS ArtistName, 
    COUNT(Art.ArtworkID) AS ArtworkCount
FROM 
    Artists A
    LEFT JOIN Artworks Art ON A.ArtistID = Art.ArtistID
GROUP BY 
    A.Name
ORDER BY 
    ArtworkCount DESC;

--2. List the titles of artworks created by artists from 'Spanish' and 'Dutch' nationalities, and orderthem by the year in ascending order.
SELECT 
    Art.Title, 
    A.Name AS ArtistName, 
    A.Nationality, 
    Art.Year
FROM 
    Artworks Art
    JOIN Artists A ON Art.ArtistID = A.ArtistID
WHERE 
    A.Nationality IN ('Spanish', 'Dutch')
ORDER BY 
    Art.Year ASC;

--3. Find the names of all artists who have artworks in the 'Painting' category, and the number ofartworks they have in this category.
SELECT 
    A.Name AS ArtistName, 
    COUNT(Art.ArtworkID) AS ArtworkCount
FROM 
    Artists A
    JOIN Artworks Art ON A.ArtistID = Art.ArtistID
    JOIN Ctegories C ON Art.CategoryID = C.CategoryID
WHERE 
    C.Name = 'Painting'
GROUP BY 
    A.Name;

--4. List the names of artworks from the 'Modern Art Masterpieces' exhibition, along with theirartists and categories.
SELECT 
    Art.Title AS ArtworkTitle, 
    A.Name AS ArtistName, 
    C.Name AS CategoryName
FROM 
    ExhibitionArtworks EA
    JOIN Exhibitions E ON EA.ExhibitionID = E.ExhibitionID
    JOIN Artworks Art ON EA.ArtworkID = Art.ArtworkID
    JOIN Artists A ON Art.ArtistID = A.ArtistID
    JOIN Ctegories C ON Art.CategoryID = C.CategoryID
WHERE 
    E.Title = 'Modern Art Masterpieces';

--5. Find the artists who have more than two artworks in the gallery.
SELECT 
    A.Name AS ArtistName, 
    COUNT(Art.ArtworkID) AS ArtworkCount
FROM 
    Artists A
    JOIN Artworks Art ON A.ArtistID = Art.ArtistID
GROUP BY 
    A.Name
HAVING 
    COUNT(Art.ArtworkID) > 2;

--6. Find the titles of artworks that were exhibited in both 'Modern Art Masterpieces' and'Renaissance Art' exhibitions
SELECT 
    Art.Title AS ArtworkTitle
FROM 
    ExhibitionArtworks EA1
    JOIN Exhibitions E1 ON EA1.ExhibitionID = E1.ExhibitionID
    JOIN Artworks Art ON EA1.ArtworkID = Art.ArtworkID
WHERE 
    E1.Title = 'Modern Art Masterpieces'
    AND Art.ArtworkID IN (
        SELECT EA2.ArtworkID
        FROM ExhibitionArtworks EA2
        JOIN Exhibitions E2 ON EA2.ExhibitionID = E2.ExhibitionID
        WHERE E2.Title = 'Renaissance Art'
    );

--7. Find the total number of artworks in each category
SELECT 
    C.Name AS CategoryName, 
    COUNT(Art.ArtworkID) AS ArtworkCount
FROM 
    Ctegories C
    LEFT JOIN Artworks Art ON C.CategoryID = Art.CategoryID
GROUP BY 
    C.Name;


--8. List artists who have more than 3 artworks in the gallery.
SELECT 
    A.Name AS ArtistName, 
    COUNT(Art.ArtworkID) AS ArtworkCount
FROM 
    Artists A
    JOIN Artworks Art ON A.ArtistID = Art.ArtistID
GROUP BY 
    A.Name
HAVING 
    COUNT(Art.ArtworkID) > 3;

--9. Find the artworks created by artists from a specific nationality (e.g., Spanish).
SELECT 
    Art.Title AS ArtworkTitle, 
    A.Name AS ArtistName
FROM 
    Artworks Art
    JOIN Artists A ON Art.ArtistID = A.ArtistID
WHERE 
    A.Nationality = 'Spanish';


--10. List exhibitions that feature artwork by both Vincent van Gogh and Leonardo da Vinci.
SELECT DISTINCT 
    E.Title AS ExhibitionTitle
FROM 
    Exhibitions E
    JOIN ExhibitionArtworks EA ON E.ExhibitionID = EA.ExhibitionID
    JOIN Artworks Art ON EA.ArtworkID = Art.ArtworkID
    JOIN Artists A ON Art.ArtistID = A.ArtistID
WHERE 
    A.Name IN ('Vincent van Gogh', 'Leonardo da Vinci')
GROUP BY 
    E.Title
HAVING 
    COUNT(DISTINCT A.Name) = 2;


--11. Find all the artworks that have not been included in any exhibition.
SELECT 
    Art.Title AS ArtworkTitle, 
    A.Name AS ArtistName
FROM 
    Artworks Art
    JOIN Artists A ON Art.ArtistID = A.ArtistID
WHERE 
    Art.ArtworkID NOT IN (SELECT ArtworkID FROM ExhibitionArtworks);


--12. List artists who have created artworks in all available categories.
SELECT 
    A.Name AS ArtistName
FROM 
    Artists A
    JOIN Artworks Art ON A.ArtistID = Art.ArtistID
GROUP BY 
    A.Name
HAVING 
    COUNT(DISTINCT Art.CategoryID) = (SELECT COUNT(CategoryID) FROM Categories);


--13. List the total number of artworks in each category.
SELECT 
    C.Name AS CategoryName, 
    COUNT(Art.ArtworkID) AS ArtworkCount
FROM 
    Ctegories C
    LEFT JOIN Artworks Art ON C.CategoryID = Art.CategoryID
GROUP BY 
    C.Name;


--14. Find the artists who have more than 2 artworks in the gallery.
SELECT 
    A.Name AS ArtistName, 
    COUNT(Art.ArtworkID) AS ArtworkCount
FROM 
    Artists A
    JOIN Artworks Art ON A.ArtistID = Art.ArtistID
GROUP BY 
    A.Name
HAVING 
    COUNT(Art.ArtworkID) > 2;


--15. List the categories with the average year of artworks they contain, only for categories with morethan 1 artwork.
SELECT 
    C.Name AS CategoryName, 
    AVG(Art.Year) AS AvgYear
FROM 
    Ctegories C
    JOIN Artworks Art ON C.CategoryID = Art.CategoryID
GROUP BY 
    C.Name
HAVING 
    COUNT(Art.ArtworkID) > 1;


--16. Find the artworks that were exhibited in the 'Modern Art Masterpieces' exhibition.
SELECT 
    Art.Title AS ArtworkTitle, 
    A.Name AS ArtistName
FROM 
    Artworks Art
    JOIN ExhibitionArtworks EA ON Art.ArtworkID = EA.ArtworkID
    JOIN Exhibitions E ON EA.ExhibitionID = E.ExhibitionID
    JOIN Artists A ON Art.ArtistID = A.ArtistID
WHERE 
    E.Title = 'Modern Art Masterpieces';


--17. Find the categories where the average year of artworks is greater than the average year of allartworks.
SELECT 
    C.Name AS CtegoryName, 
    AVG(Art.Year) AS AvgYear
FROM 
    Ctegories C
    JOIN Artworks Art ON C.CategoryID = Art.CategoryID
GROUP BY 
    C.Name
HAVING 
    AVG(Art.Year) > (SELECT AVG(Year) FROM Artworks);


--18. List the artworks that were not exhibited in any exhibition.
SELECT 
    Art.Title AS ArtworkTitle, 
    A.Name AS ArtistName
FROM 
    Artworks Art
    JOIN Artists A ON Art.ArtistID = A.ArtistID
WHERE 
    Art.ArtworkID NOT IN (SELECT ArtworkID FROM ExhibitionArtworks);


--19. Show artists who have artworks in the same category as "Mona Lisa."
SELECT 
    A.Name AS ArtistName
FROM 
    Artworks Art1
    JOIN Ctegories C ON Art1.CategoryID = C.CategoryID
    JOIN Artworks Art2 ON Art1.CategoryID = Art2.CategoryID
    JOIN Artists A ON Art2.ArtistID = A.ArtistID
WHERE 
    Art1.Title = 'Mona Lisa';

--20. List the names of artists and the number of artworks they have in the gallery.
SELECT 
    A.Name AS ArtistName, 
    COUNT(Art.ArtworkID) AS ArtworkCount
FROM 
    Artists A
    LEFT JOIN Artworks Art ON A.ArtistID = Art.ArtistID
GROUP BY 
    A.Name;
