rm logback.log
cp config121MSProd.conf config.conf
java -jar dbAssist.jar -scriptRun
rm config.conf
