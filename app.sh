#!/bin/bash
# simple curl script to get weather in Nome Alaska
# using jq to parse json return object to output temperature and conditions
export json_obj=`curl -s 'https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys'`

export city_details=`echo $json_obj|jq '.query.results.channel'`
echo 'The weather for '`echo $city_details|jq '.location.city'|tr -d '"'`
echo 'Wind Chill: '`echo $city_details|jq '.wind.chill'|tr -d '"'`
echo 'Temperature Farenheit: '`echo $city_details|jq '.item.condition.temp'|tr -d '"'`
echo 'Conditions: '`echo $city_details|jq '.item.condition.text'|tr -d '"'`