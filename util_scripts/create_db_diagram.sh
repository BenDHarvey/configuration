#!/usr/bin/env bash
set -euo pipefail

cat <<EOT >> /tmp/schemaspy.properties
schemaspy.t=pgsql
schemaspy.host=localhost
schemaspy.port=5432
schemaspy.db=<db_name>
schemaspy.u=<db_username>
schemaspy.p=<db_password>
schemaspy.schemas=public
EOT

# Create the output directory so that we know it will always be there
mkdir -p /tmp/output

docker run --network=host -v "/tmp/output:/output" -v "/tmp:/config"  schemaspy/schemaspy:latest -configFile /config/schemaspy.properties  -noimplied -nopages -l

