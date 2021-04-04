--1. Crear base de datos llamada películas
CREATE DATABASE peliculas;

--2. Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes, determinando la relación entre ambas tablas.
 CREATE TABLE peliculas(id SERIAL, pelicula VARCHAR(200), año_de_estreno SMALLINT, director VARCHAR(100), PRIMARY KEY(id));

 CREATE TABLE reparto(peliculas_id SMALLINT, nombre_actor VARCHAR(200), FOREIGN KEY(peliculas_id) REFERENCES peliculas(id));

 --3. Cargar ambos archivos a su tabla correspondiente
 \COPY peliculas FROM './peliculas.csv' csv header;
 \COPY reparto FROM './reparto.csv' csv;

 --4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película, año de estreno, director y todo el reparto.
SELECT pelicula, año_de_estreno, director, nombre_actor FROM peliculas INNER JOIN reparto ON peliculas_id=peliculas.id WHERE pelicula='Titanic';

--5. Listar los titulos de las películas donde actúe Harrison Ford.
SELECT pelicula, nombre_actor FROM peliculas INNER JOIN reparto ON peliculas_id=peliculas.id WHERE nombre_actor='Harrison Ford';

--6. Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el top 100.
 SELECT director, count(director) AS cantidad_peliculas FROM peliculas GROUP BY director  ORDER BY cantidad_peliculas DESC LIMIT(10); 

--7. Indicar cuantos actores distintos hay
SELECT COUNT(DISTINCT nombre_actor) FROM reparto;

--8 Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por título de manera ascendente
SELECT pelicula, año_de_estreno FROM peliculas WHERE año_de_estreno >= 1990 AND año_de_estreno <= 1999 ORDER BY pelicula ASC;

--9 Listar el reparto de las películas lanzadas el año 2001
SELECT nombre_actor, pelicula FROM peliculas INNER JOIN reparto ON peliculas_id=peliculas.id WHERE año_de_estreno=2001;

--10. Listar los actores de la película más nueva
SELECT nombre_actor, año_de_estreno FROM peliculas INNER JOIN reparto ON peliculas.id=peliculas_id WHERE año_de_estreno = (SELECT MAX (año_de_estreno) FROM peliculas);