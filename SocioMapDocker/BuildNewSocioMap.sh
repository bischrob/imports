# script to build SocioMap from prior dump

docker build -t sociomap SocioMapDocker

docker run \
    --name=sociomap \
    -d \
    --publish=7474:7474 --publish=7687:7687\
    --volume=$HOME/neo4j/data:/var/lib/neo4j/data \
    --volume=$HOME/neo4j/logs:/var/lib/neo4j/logs \
    --volume=$HOME/neo4j/conf:/var/lib/neo4j/conf \
    --volume=$HOME/neo4j/import:/var/lib/neo4j/import \
    --volume=$HOME/neo4j/plugins:/var/lib/neo4j/plugins \
    --restart unless-stopped \
    sociomap

docker exec -u neo4j -i -t sociomap \
  cypher-shell -d system "stop database neo4j;"

docker exec -u neo4j -i -t sociomap \
  neo4j-admin load \
  --database=neo4j \
  --from=import/sociomap.dump \
  --force

docker exec -u neo4j -i -t sociomap \
  cypher-shell -d system "start database neo4j;"

docker exec -u neo4j -i -t sociomap \
  cypher-shell -d system "create database sociomap;"

docker exec -u neo4j -i -t sociomap \
  cypher-shell -d system "start database sociomap;"

# create constraints and add group labels

docker exec -u neo4j -i -t sociomap \
  cypher-shell -d neo4j "CREATE CONSTRAINT IF NOT EXISTS ON (n:CATEGORY) ASSERT (n.SocioMapID) IS NODE KEY;";

docker exec -u neo4j -i -t sociomap \
  cypher-shell -d neo4j "CREATE CONSTRAINT IF NOT EXISTS ON (n:USER) ASSERT (n.UserID) IS NODE KEY;";

docker exec -u neo4j -i -t sociomap \
  cypher-shell -d neo4j "CREATE CONSTRAINT IF NOT EXISTS ON (n:DATASET) ASSERT (n.DatasetID) IS NODE KEY;";

docker exec -u neo4j -i -t sociomap \
  cypher-shell -d neo4j "CREATE CONSTRAINT IF NOT EXISTS ON (n:DATASET) ASSERT (n.CategorySet) IS NODE KEY;";

docker exec -u neo4j -i -t sociomap \
  cypher-shell -d neo4j "CREATE CONSTRAINT IF NOT EXISTS ON ()-[r:USES]-() ASSERT exists(r.Key);";

docker exec -u neo4j -i -t sociomap \
  cypher-shell -d neo4j "CREATE INDEX names FOR (n:CATEGORY) ON (n.Names);";
