FROM nominatim/nominatim:4.4

# Set environment variables
ENV NOMINATIM_PASSWORD=very-secure-password
ENV NOMINATIM_PBF_URL=https://download.geofabrik.de/asia/cambodia-latest.osm.pbf
ENV NOMINATIM_REPLICATION_URL=https://download.geofabrik.de/asia/cambodia-updates/

# Install additional packages
USER root
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

USER nominatim

# Create necessary directories
RUN mkdir -p /nominatim/data

# Download Cambodia OSM data
RUN wget -O /nominatim/data/cambodia-latest.osm.pbf \
    https://download.geofabrik.de/asia/cambodia-latest.osm.pbf

# Create import script
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
# Wait for PostgreSQL to be ready\n\
until pg_isready -h db -U nominatim; do\n\
  echo "Waiting for PostgreSQL..."\n\
  sleep 5\n\
done\n\
\n\
# Check if database is already initialized\n\
if psql -h db -U nominatim -d nominatim -c "SELECT 1" 2>/dev/null; then\n\
  echo "Database already exists, skipping import"\n\
else\n\
  echo "Importing Cambodia data..."\n\
  nominatim import --osm-file /nominatim/data/cambodia-latest.osm.pbf\n\
  echo "Import completed"\n\
fi\n\
\n\
# Start Apache\n\
exec /usr/sbin/apache2ctl -DFOREGROUND' > /nominatim/import-and-serve.sh

RUN chmod +x /nominatim/import-and-serve.sh

# Expose port
EXPOSE 8080

# Start the import and serve process
CMD ["/nominatim/import-and-serve.sh"]