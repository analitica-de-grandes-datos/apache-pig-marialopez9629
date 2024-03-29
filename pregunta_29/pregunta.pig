/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código en Pig para manipulación de fechas que genere la siguiente 
salida.

   1971-07-08,jul,07,7
   1974-05-23,may,05,5
   1973-04-22,abr,04,4
   1975-01-29,ene,01,1
   1974-07-03,jul,07,7
   1974-10-18,oct,10,10
   1970-10-05,oct,10,10
   1969-02-24,feb,02,2
   1974-10-17,oct,10,10
   1975-02-28,feb,02,2
   1969-12-07,dic,12,12
   1973-12-24,dic,12,12
   1970-08-27,ago,08,8
   1972-12-12,dic,12,12
   1970-07-01,jul,07,7
   1974-02-11,feb,02,2
   1973-04-01,abr,04,4
   1973-04-29,abr,04,4

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

resultado = FOREACH datos GENERATE date,FLATTEN(STRSPLIT(date,'-',3));

resultado2 = FOREACH resultado GENERATE $0,LOWER(ToString($0,'MMM')),$2,REGEX_EXTRACT($2,'0*(\\d+)?', 1);

resultado3 = FOREACH resultado2 GENERATE $0,REPLACE($1,'apr','abr'),$2,$3;

resultado4 = FOREACH resultado3 GENERATE $0,REPLACE($1,'jan','ene'),$2,$3;

resultado5 = FOREACH resultado4 GENERATE $0,REPLACE($1,'aug','ago'),$2,$3;

resultado6 = FOREACH resultado5 GENERATE $0,REPLACE($1,'dec','dic'),$2,$3;

STORE resultado6 INTO 'output' USING PigStorage(',');




