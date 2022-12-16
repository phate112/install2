#!/bin/bash

echo "Scanning $(date +"%Y-%m-%d")"

mkdir -p $(date +"%Y-%m-%d")/commonports

cd $(date +"%Y-%m-%d")
curl https://raw.githubusercontent.com/montysecurity/C2-Tracker/main/data/all.txt | sort -u | uniq >> all.txt
$(rustscan -a all.txt --scripts None -b 65535 --ulimit 1000000 -r 1-65000 --accessible | grep Open | awk '{print $2}' >> rustscan_shodan_ports_all.txt; cat rustscan_shodan_ports_all.txt | httpx -t 1000 -rl 2000 -rlm 200000 -silent -fc 404,403,400 -title -favicon -td -timeout 30 -hash mm3 -server -json -o all_http_servers.json;cat all_http_servers.json| grep -i 'Directory listing for\|Index of' | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u | uniq | aquatone -silent -http-timeout 50000 -out aquatone-screenshots -scan-timeout 10000 -resolution "1600x1200" -screenshot-timeout 100000) &


cd commonports
$(rustscan -a ../all.txt --scripts None -b 65535 --ulimit 1000000 -p 1234,1337,55555,1389,23205,4848,666,6770,80,8000,8001,8443,8446,8889,9000,1234,12344,1338,1339,1389,23205,443,444,4721,4848,6080,6081,666,6770,80,8000,8001,8080,8090,8443,8446,86,8887,8889,9000,1234,1338,1339,1389,23205,443,444,4721,4848,5000,58888,6080,6081,666,6770,80,8000,8001,8080,8085,8443,8446,8887,8889,9000,9090,1234,1338,1339,1389,23205,443,4848,6080,6081,666,6770,8000,8001,8443,8446,8889,9000,80,81,300,443,591,593,832,981,1010,1311,2082,2087,2095,2096,2480,3000,3128,3333,4243,4567,4711,4712,4993,5000,5104,5108,5800,6543,7000,7396,7474,8000,8001,8008,8014,8042,8069,8080,8081,8088,8090,8091,8118,8123,8172,8222,8243,8280,8281,8333,8443,8500,8834,8880,8888,8983,9000,9043,9060,9080,9090,9091,9200,9443,9800,9981,12443,16080,18091,18092,20720,28017 --accessible | grep Open | awk '{print $2}' >> rustscan_shodan_ports_all_common.txt; cat rustscan_shodan_ports_all_common.txt | httpx -t 1000 -rl 2000 -rlm 200000 -silent -fc 404,403,400 -title -favicon -td -timeout 30 -hash mm3 -server -json -o all_http_servers_common.json | grep -i 'Directory listing for\|Index of' | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u | uniq | aquatone -silent -http-timeout 300000 -out aquatone-screenshots -scan-timeout 10000 -resolution "1600x1200" -screenshot-timeout 100000) &
