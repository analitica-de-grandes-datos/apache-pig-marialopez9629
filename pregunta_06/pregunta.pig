/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

datos = LOAD 'data.tsv' AS (letra:chararray, dicc:chararray, lista:MAP[]);

filtrado = FOREACH datos GENERATE FLATTEN(lista);

grouped = GROUP filtrado BY $0;

sumas = FOREACH grouped GENERATE group, COUNT(filtrado.$0);

STORE sumas INTO 'output' USING PigStorage(',');
