#!/usr/bin/env sh
# echo 'The following command terminates the "maven clean install" process using its PID'
# echo '(written to ".pidfile"), all of which were conducted when "deliver.sh"'
# echo 'was executed.'
# set -x
# kill $(cat .pidfile)
pid=$(pgrep -f "java -jar my-app.jar")
kill $pid
echo 'was executed. terminate jar'
