echo "Beginning build out of a 3 node Elasticsearch cluster with a Kibana front end."
docker-compose -f create-certs.yml run --rm create_certs
docker-compose -f elastic-docker-tls.yml up -d
echo "Waiting for Elastic cluster to come online to perform API calls."
#TODO Start-Sleep -s 30
docker exec es01 /bin/bash -c "bin/elasticsearch-setup-passwords auto --batch --url https://es01:9200" >> .\passwords.txt
echo 'Please update the value for "ELASTICSEARCH_PASSWORD" in elastic-docker-tls.yml with the "Kibana" password in the newly created "passwords.txt" file.'
#TODO Read-Host "Please press enter when that value is updated"
docker-compose -f elastic-docker-tls.yml stop
docker-compose -f elastic-docker-tls.yml up -d
