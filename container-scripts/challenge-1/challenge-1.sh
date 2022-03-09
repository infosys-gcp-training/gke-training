#!/bin/bash
echo $1
upperLimit=5000
sleepInterval=0.01

breeds=("Poodle" "Pug" "Terrier" "Hound Dog" "Dachshund" "Golden Retriever" "German Shepherd" "Labrador" "Pit Bull" "Shiba Ken" "Chihuahua" "Bernese Mountain Dog" "Bichon Frise" "Cocker Spaniel" "Bull Dog" "Rottweiler" "Husky" "Beagle" "Sheepdog" "Blood Hound" "Boxer" "Corgi" "Greyhound")
owners=("Micheal Jackson" "Mariah Carey" "Frank Sinatra" "Elvis Presley" "Eric Clapton" "Madonna" "Johnny Cash" "Miles Davis" "Ray Charles" "Naomi Watanabe" "Whitney Houston" "Lady Gaga" "Hiroshi Abe" "Hayao Miyazaki" "Ichiro Suzuki" "Haruki Murakami" )
dogTags=("Fluffy" "Foo Foo" "Frank" "Rover" "Beethoveen" "Princess" "Blue" "Ratty" "Micky" "Ran" "Max" "Kyanna" "Fido" "Wiggles" "Milo" "Buster" "Lucky" "Ollie" "Blaze" "Axel")

#for owner in "${owners[@]}"
for i in $(seq 0 $upperLimit); do
	echo '{"severity":"INFO","message":"hot dog", "labels":{"type":"food"}, "logging.googleapis.com/labels":{"type":"food"}}'
	if [ $i -eq 1368 ]; then
		for j in "${!owners[@]}"; do
			#for j in $(seq 0 2); do
				echo '{"severity":"INFO","message":"dog", "logging.googleapis.com/labels":{"type":"animal", "breed":"'${breeds[$j]}'", "name_tag":"'${dogTags[$j]}'"}}'
			#done
		done
	fi
	if [ $i -eq 2345 ]; then
		for j in "${!owners[@]}"; do
			#for j in $(seq 0 2); do
				echo '{"severity":"INFO","message":"dog owner", "logging.googleapis.com/labels":{"type":"animal", "name":"'${dogTags[$j]}'", "owner":"'${owners[$j]}'"}}'
			#done
		done
	fi
	if [ $i -eq 345 ]; then
		echo '{"severity":"WARNING","message":"dog tag missing", "logging.googleapis.com/labels":{"type":"animal", "owner":"unknown", "breed":"'${breeds[9]}'"}}'
	fi
	if [ $i -gt 110 ] && [ $i -lt 198 ]; then
		echo '{"severity":"WARNING","message":"hot dog is cold", "labels":{"type":"food"}, "logging.googleapis.com/labels":{"type":"food"}}'
	fi

	sleep $sleepInterval
done


exit 0
