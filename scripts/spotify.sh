#!/bin/bash

url="https://accounts.spotify.com/api/token"
grant_type="refresh_token"
refresh_token="AQBUVW-T4gD31lasKXHC8mBv8clizdmLpkjf1TZGzqaD5_je6R-RJhyRXhgj_BBLUCM2N3KnXxUEwMijq84HCxji5oFmDzKea2Okl0YodB3Azc6ipMcwJMwWuNHqwciw35w"
clientId="9426af28a1b44e1b985fbe5450660fbb"
clientSecret="38e54b55a26e4dc0a82c1da5ae4faa2f"
client64="OTQyNmFmMjhhMWI0NGUxYjk4NWZiZTU0NTA2NjBmYmI6MzhlNTRiNTVhMjZlNGRjMGE4MmMxZGE1YWU0ZmFhMmY="

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
