@echo off


REM ## TASSEL home directory
set "TASSEL=c:\tassel-5.2.58"

REM ## Initial and maximum memory size
set XMS=-Xms512m
set XMX=-Xmx2g

REM ## XML configuration file
set CONFIG=glm-P.xml




REM !!! DO NOT MODIFY !!!

set "CP=%TASSEL%\sTASSEL.jar"
for %%i in ("%TASSEL%\lib\*.jar") do call set "CP=%%CP%%;%%i"

java -classpath "%CP%" %XMS% %XMX% net.maizegenetics.pipeline.TasselPipeline -configFile %CONFIG%

pause
