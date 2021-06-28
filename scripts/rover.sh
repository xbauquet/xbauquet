#!/bin/bash

url=$ROVER_URL
response=$(curl $url)

opacity=$(echo $response | jq '.atmoOpacity' | sed -e 's/^"//' -e 's/"$//')
date=$(echo $response | jq '.terrestrialDate' | sed -e 's/^"//' -e 's/"$//')
date=$(($date/1000))
date=$(date +'%Y-%m-%d' -d @$date)
sol=$(echo $response | jq '.sol' | sed -e 's/^"//' -e 's/"$//')
minTemp=$(echo $response | jq '.minTemp' | sed -e 's/^"//' -e 's/"$//')
maxTemp=$(echo $response | jq '.maxTemp' | sed -e 's/^"//' -e 's/"$//')
minGtsTemp=$(echo $response | jq '.minGtsTemp' | sed -e 's/^"//' -e 's/"$//')
maxGtsTemp=$(echo $response | jq '.maxGtsTemp' | sed -e 's/^"//' -e 's/"$//')
pressure=$(echo $response | jq '.pressure' | sed -e 's/^"//' -e 's/"$//')
sunrise=$(echo $response | jq '.sunrise' | sed -e 's/^"//' -e 's/"$//')
sunset=$(echo $response | jq '.sunset' | sed -e 's/^"//' -e 's/"$//')

sed -i -e "s,{{MARS_ATMO_OPACITY}},$opacity,g" README_NEW.md
sed -i -e "s/{{MARS_DATE}}/$date/g" README_NEW.md
sed -i -e "s/{{MARS_SOL}}/$sol/g" README_NEW.md
sed -i -e "s/{{MARS_MIN_TEMP}}/$minTemp/g" README_NEW.md
sed -i -e "s/{{MARS_MAX_TEMP}}/$maxTemp/g" README_NEW.md
sed -i -e "s/{{MARS_MIN_GROUND_TEMP}}/$minGtsTemp/g" README_NEW.md
sed -i -e "s/{{MARS_MAX_GROUND_TEMP}}/$maxGtsTemp/g" README_NEW.md
sed -i -e "s/{{MARS_PRESSURE}}/$pressure/g" README_NEW.md
sed -i -e "s/{{MARS_SUNRISE}}/$sunrise/g" README_NEW.md
sed -i -e "s/{{MARS_SUNSET}}/$sunset/g" README_NEW.md
