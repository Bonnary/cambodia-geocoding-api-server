# Use the official Nominatim image as base
FROM mediagis/nominatim:5.1

# Set the PBF URL environment variable
ENV PBF_URL=https://download.geofabrik.de/asia/cambodia-latest.osm.pbf

# Expose port 8080 (the internal port used by the container)
EXPOSE 8080

# The base image already has the appropriate CMD/ENTRYPOINT
# so we don't need to specify it again