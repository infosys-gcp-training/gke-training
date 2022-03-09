#!/bin/bash
echo $1
upperLimit=6000
sleepInterval=0.01

effiel_tower_function() {
	result='\n
..............() \n
............../\\ \n
.............|==| \n
.............==== \n
..............XX \n
.............xXXx \n
.............XXXX \n
.............XXXX \n
.............XXXX \n
............xXXXXx \n
............XXXXXX \n
............XXXXXX \n
...........xXXXXXXx \n
...........XXXXXXXX \n
..........xXXXXXXXXx \n
..........XXXXXXXXXX \n
.........XXXXX..XXXXX \n
........xXXXX....XXXXx \n
.......XXXXXxxxxxxXXXXX \n
.....xXXXXX........XXXXXx \n
...xXXXXXX..........XXXXXXx \n
xxXXXXXXX............XXXXXXXxx'
	echo $result
}

effiel_tower=$(effiel_tower_function)
effielMessage='{"severity":"INFO","message":"landmark", "name":"???", "data":"'$effiel_tower'", "logging.googleapis.com/labels":{"country":"Canada"}}'

for i in $(seq 0 $upperLimit); do
	echo '{"severity":"INFO","message":"Nice Try!", "result":"No Eiffel Tower here", "logging.googleapis.com/labels":{"landmark_type":"tower"}}'
	if [ $i -eq 568 ]; then
		echo '{"severity":"INFO","message":"landmark", "name":"CN Tower", "logging.googleapis.com/labels":{"country":"Canada"}}'
		echo '{"severity":"INFO","message":"landmark", "name":"Parliament Building", "logging.googleapis.com/labels":{"country":"Canada"}}'
		echo '{"severity":"INFO","message":"landmark", "name":"Hockey Hall of Fame", "logging.googleapis.com/labels":{"country":"Canada"}}'
		echo '{"severity":"INFO","message":"landmark", "name":"Niagara Falls", "logging.googleapis.com/labels":{"country":"Canada"}}'
		echo '{"severity":"INFO","message":"landmark", "name":"Canada Place", "logging.googleapis.com/labels":{"country":"Canada"}}'
		echo '{"severity":"INFO","message":"landmark", "name":"Fairmont Le Chateau Frontenac", "logging.googleapis.com/labels":{"country":"Canada"}}'
		echo '{"severity":"INFO","message":"landmark", "name":"Notre-Dame Basilica", "logging.googleapis.com/labels":{"country":"Canada"}}'
		echo $effielMessage
		echo '{"severity":"INFO","message":"landmark", "name":"West Edmonton Mall", "logging.googleapis.com/labels":{"country":"Canada"}}'
		echo '{"severity":"INFO","message":"landmark", "name":"Rockies", "logging.googleapis.com/labels":{"country":"Canada"}}'
		echo '{"severity":"INFO","message":"landmark", "name":"Lake Louise", "logging.googleapis.com/labels":{"country":"Canada"}}'
		echo '{"severity":"INFO","message":"landmark", "name":"Hotel de Glace", "logging.googleapis.com/labels":{"country":"Canada"}}'
	fi
	if [ $i -gt 1234 ] && [ $i -lt 1287 ]; then
		echo '{"severity":"DEBUG","message":"What country is the Eiffel Tower locate?", "logging.googleapis.com/labels":{"hint":"France"}}'
	fi

	if [ $i -eq 3340 ]; then
		echo '{"severity":"WARNING","message":"Landmark was moved", "source_country":"France", "destination":"Canada","logging.googleapis.com/labels":{"landmark_type":"building"}}'
	fi
	if [ $i -eq 1964 ]; then
		echo '{"severity":"ERROR","message":"Landmark not found", "source_country":"France", "logging.googleapis.com/labels":{"landmark_type":"building", "country":"France"}}'
	fi
	sleep $sleepInterval
done

exit 0
