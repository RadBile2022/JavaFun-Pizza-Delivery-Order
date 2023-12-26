#!/usr/bin/env sh
# echo 'The following command terminates the "maven clean install" process using its PID'
# echo '(written to ".pidfile"), all of which were conducted when "deliver.sh"'
# echo 'was executed.'
# set -x
# kill $(cat .pidfile)
JAR_NAME=$(ls target/*.jar | xargs -n 1 basename)

echo "Nama file jar: $JAR_NAME"
pid=$(pgrep -f $JAR_NAME)
kill $pid
echo 'was executed. terminate jar'
