#!/usr/bin/env bash
set -euo pipefail

cat <<EOT >> /tmp/schemaspy.properties
schemaspy.t=pgsql
schemaspy.host=localhost
schemaspy.port=5432
schemaspy.db=docker_switchdin
schemaspy.u=switchdin
schemaspy.p=SuperSecret123!
schemaspy.schemas=public
EOT

# Create the output directory so that we know it will always be there
mkdir -p /tmp/output

docker run --network=host -v "/tmp/output:/output" -v "/tmp:/config"  schemaspy/schemaspy:latest -configFile /config/schemaspy.properties  -noimplied -nopages -l

