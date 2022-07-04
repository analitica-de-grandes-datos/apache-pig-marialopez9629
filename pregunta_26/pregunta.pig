/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname 
   FROM 
       u 
   WHERE 
       SUBSTRING(firstname, 0, 1) >= 'm';

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

resultado = FOREACH datos GENERATE name;

selection = FILTER resultado BY ($0 matches '(M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z).*');

STORE selection INTO 'output';

