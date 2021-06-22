#!/bin/bash

url="https://accounts.spotify.com/api/token"
grant_type="refresh_token"
refresh_token=$SPOTIFY_REFRESH_TOKEN
client64=$SPOTIFY_CLIENT_64

body='{
   "grant_type":"'$grant_type'",
   "refresh_token":"'$refresh_token'"
}'
response=$(curl -XPOST -d grant_type=$grant_type -d refresh_token=$refresh_token -H "Authorization: Basic $client64" $url)
token=$(echo $response | sed "s/{.*\"access_token\":\"\([^\"]*\).*}/\1/g")
echo $token

url="https://api.spotify.com/v1/me/top/tracks?limit=1&offset=0&time_range=short_term"
response=$(curl -H "Authorization: Bearer $token" $url | jq '{name: .items[0].name, artist: .items[0].artists[0].name, album: .items[0].album.images[1].url}')
url=$(echo $response | jq '.album' | sed -e 's/^"//' -e 's/"$//')
name=$(echo $response | jq '.name' | sed -e 's/^"//' -e 's/"$//')
artist=$(echo $response | jq '.artist' | sed -e 's/^"//' -e 's/"$//')
rm README.md
cp README_TEMPLATE.md README.md
sed -i -e "s,{{MUSIC_IMAGE_URL}},$url,g" README.md
sed -i -e "s/{{MUSIC_NAME}}/$name/g" README.md
sed -i -e "s/{{MUSIC_ARTIST}}/$artist/g" README.md
