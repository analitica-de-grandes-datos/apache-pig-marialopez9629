/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' AS (letra:CHARARRAY, date:CHARARRAY, value:INT);

valores = FOREACH lines GENERATE value;

sorted = ORDER valores BY value;

limitado = LIMIT sorted 5;

STORE limitado INTO 'output' USING PigStorage(',');
