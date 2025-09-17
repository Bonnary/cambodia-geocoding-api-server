# Cambodia Geocoding API Server
# Based on Nominatim with Cambodia OSM data

FROM mediagis/nominatim:5.1

# Set the default PBF URL for Cambodia
ENV PBF_URL=https://download.geofabrik.de/asia/cambodia-latest.osm.pbf

# Set default Nominatim configuration
ENV NOMINATIM_PASSWORD=nominatim
ENV NOMINATIM_UPDATE_MODE=none
ENV POSTGRES_USER=nominatim
ENV POSTGRES_DB=nominatim

# Expose the port
EXPOSE 8080

# Set the default entrypoint and command
# The base image already handles the download and import of OSM data
CMD ["/app/start.sh"]