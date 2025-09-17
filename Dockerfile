# Use the mediagis/nominatim image as the base
FROM mediagis/nominatim:5.1

# Set the environment variable for the PBF URL for Cambodia
ENV PBF_URL=https://download.geofabrik.de/asia/cambodia-latest.osm.pbf

# Expose the port the Nominatim service runs on
# The original command maps host 8080 to container 8080, 
# but the image actually exposes port 8080 by default.
# We make it explicit here.
EXPOSE 8080
