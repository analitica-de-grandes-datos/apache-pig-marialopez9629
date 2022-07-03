/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

datos = LOAD 'data.tsv' AS (letra:chararray, dicc:BAG{}, lista:MAP[]);

datos2 = FOREACH datos GENERATE letra, FLATTEN(dicc),FLATTEN(lista);

datos3 = FOREACH datos2 GENERATE $1, $2;

grouped = GROUP datos3 BY ($0,$1);

resultado = FOREACH grouped GENERATE group, COUNT(datos3);

STORE resultado INTO 'output' USING PigStorage(',');
