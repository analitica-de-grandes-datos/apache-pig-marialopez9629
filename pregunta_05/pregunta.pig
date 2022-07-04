/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.tsv' AS (letra:chararray, dicc:chararray, lista:chararray);

filtrado = FOREACH datos GENERATE dicc;

letters = FOREACH filtrado GENERATE FLATTEN(TOKENIZE(dicc)) AS letter;

grouped = GROUP letters BY letter;

lettercount = FOREACH grouped GENERATE group, COUNT(letters);

lettercount_limited = LIMIT lettercount 7;

STORE lettercount_limited INTO 'output' USING PigStorage(',');
