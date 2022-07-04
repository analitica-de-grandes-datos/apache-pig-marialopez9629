/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

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

resultado2 = FOREACH resultado GENERATE $0,$3,REGEX_EXTRACT($3,'0*(\\d+)?', 1),ToString(ToDate($0,'yyyy-MM-dd'),'EEE'),ToString(ToDate($0,'yyyy-MM-dd'),'EEE');

resultado3= FOREACH resultado2 GENERATE $0,$1,$2,REPLACE($3,'Thu','jue'), REPLACE($4,'Thu','jueves');

resultado4= FOREACH resultado3 GENERATE $0,$1,$2,REPLACE($3,'Wed','mie'), REPLACE($4,'Wed','miercoles');

resultado5= FOREACH resultado4 GENERATE $0,$1,$2,REPLACE($3,'Sun','dom'), REPLACE($4,'Sun','domingo');

resultado6= FOREACH resultado5 GENERATE $0,$1,$2,REPLACE($3,'Fri','vie'), REPLACE($4,'Fri','viernes');

resultado7= FOREACH resultado6 GENERATE $0,$1,$2,REPLACE($3,'Mon','lun'), REPLACE($4,'Mon','lunes');

resultado8= FOREACH resultado7 GENERATE $0,$1,$2,REPLACE($3,'Tue','mar'), REPLACE($4,'Tue','martes');


STORE resultado8 INTO 'output' USING PigStorage(',');

