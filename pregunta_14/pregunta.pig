/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       color 
   FROM 
       u 
   WHERE 
       color NOT LIKE 'b%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/

datos = LOAD 'data.csv' USING PigStorage(',')
   AS (
        id:int,
        name:chararray,
        lastname:chararray,
        date:chararray,
        color:chararray,
        value:int
   );

resultado = FOREACH datos GENERATE color;

selection = FILTER resultado BY NOT ($0 matches '.*b.*');

STORE selection INTO 'output' USING PigStorage(',');
