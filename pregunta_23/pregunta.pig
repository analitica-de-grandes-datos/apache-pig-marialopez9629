/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname,
       color 
   FROM 
       u 
   WHERE 
       color REGEXP '[aeiou]$';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
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

resultado = FOREACH datos GENERATE name,color;

selection = FILTER resultado BY ($1 matches '.*a' or $1 matches '.*e' or $1 matches '.*i' or $1 matc>

STORE selection INTO 'output' USING PigStorage(',');

