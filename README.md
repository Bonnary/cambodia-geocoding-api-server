# Cambodia Geocoding API Server

A containerized Nominatim-based geocoding API server specifically configured for Cambodia using OpenStreetMap data.

## Overview

This project provides a ready-to-deploy geocoding API server for Cambodia using:
- **Nominatim**: Open-source geocoding engine
- **Cambodia OSM Data**: Latest OpenStreetMap data from Geofabrik
- **Docker**: Containerized for easy deployment
- **Coolify Compatible**: Ready for deployment on Coolify servers

## Features

- 🇰🇭 **Cambodia-specific**: Pre-configured with Cambodia OSM data
- 🚀 **Easy deployment**: One-command setup with Docker
- 🔄 **Auto-updates**: Configurable data update modes
- 🏥 **Health checks**: Built-in monitoring endpoints
- 📍 **Full geocoding**: Forward and reverse geocoding support
- 🔍 **Search capabilities**: Address search and place lookup

## Quick Start

### Option 1: Docker Compose (Recommended)

```bash
# Clone the repository
git clone <your-repo-url>
cd cambodia-geocoding-api-server

# Start the service
docker-compose up -d
```

### Option 2: Docker Build & Run

```bash
# Build the image
docker build -t cambodia-geocoding .

# Run the container
docker run -d -p 8080:8080 --name cambodia-geocoding cambodia-geocoding
```

### Option 3: Original Docker Command

```bash
docker run -it -e PBF_URL=https://download.geofabrik.de/asia/cambodia-latest.osm.pbf -p 8080:8080 --name nominatim mediagis/nominatim:5.1
```

## Deployment on Coolify

### Method 1: Docker Compose Deployment

1. **Create a new project** in Coolify
2. **Add a new application** → Choose "Docker Compose"
3. **Connect your Git repository** containing this code
4. **Set the compose file path** to `docker-compose.yml`
5. **Deploy** the application

### Method 2: Dockerfile Deployment

1. **Create a new project** in Coolify
2. **Add a new application** → Choose "Dockerfile"
3. **Connect your Git repository**
4. **Set these environment variables**:
   - `PBF_URL=https://download.geofabrik.de/asia/cambodia-latest.osm.pbf`
5. **Set port mapping**: `8080:8080`
6. **Deploy** the application

## API Usage

Once deployed, the API will be available at `http://your-server:8080`

### Health Check
```bash
curl http://localhost:8080/status
```

### Forward Geocoding (Address → Coordinates)
```bash
# Search for a place in Cambodia
curl "http://localhost:8080/search?q=Phnom+Penh&format=json&limit=1"

# Search with more specific parameters
curl "http://localhost:8080/search?q=Royal+Palace+Phnom+Penh&format=json&countrycodes=kh"
```

### Reverse Geocoding (Coordinates → Address)
```bash
# Get address from coordinates 
curl "http://localhost:8080/reverse?format=json&lat=11.5475456&lon=104.8171284"
```

### Example Response
```json
{
    "place_id": 216238,
    "licence": "Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright",
    "osm_type": "way",
    "osm_id": 183100847,
    "lat": "11.547530077798418",
    "lon": "104.81706073005701",
    "class": "highway",
    "type": "residential",
    "place_rank": 26,
    "importance": 0.0533433333333333,
    "addresstype": "road",
    "name": "",
    "display_name": "ភូមិចាក់ជ្រូក, ខណ្ឌពោធិ៍សែនជ័យ, រាជធានីភ្នំពេញ, 122911, ព្រះរាជាណាចក្រ​កម្ពុជា",
    "address": {
        "hamlet": "ភូមិចាក់ជ្រូក",
        "town": "ខណ្ឌពោធិ៍សែនជ័យ",
        "state": "រាជធានីភ្នំពេញ",
        "ISO3166-2-lvl4": "KH-12",
        "postcode": "122911",
        "country": "ព្រះរាជាណាចក្រ​កម្ពុជា",
        "country_code": "kh"
    },
    "boundingbox": [
        "11.5469857",
        "11.5476174",
        "104.8170407",
        "104.8171856"
    ]
}
```

## Configuration

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `PBF_URL` | Cambodia OSM data | URL to OSM PBF file |
| `NOMINATIM_PASSWORD` | `nominatim` | Database password |
| `NOMINATIM_UPDATE_MODE` | `none` | Update mode (none/once/continuous) |
| `POSTGRES_USER` | `nominatim` | PostgreSQL username |
| `POSTGRES_DB` | `nominatim` | PostgreSQL database name |

### Custom OSM Data

To use different OSM data, set the `PBF_URL` environment variable:

```bash
# For a different region
docker run -e PBF_URL=https://download.geofabrik.de/asia/thailand-latest.osm.pbf ...

# For a smaller area (Phnom Penh only)
docker run -e PBF_URL=https://download.geofabrik.de/asia/cambodia/phnom-penh-latest.osm.pbf ...
```

## Data Import Process

⚠️ **Important**: The first startup will take a significant amount of time (30-60 minutes) as it:

1. Downloads the Cambodia OSM data (~50MB)
2. Imports the data into PostgreSQL
3. Builds search indexes
4. Starts the Nominatim API server

**Monitor the progress:**
```bash
# Check container logs
docker logs -f cambodia-geocoding-api

# Or with docker-compose
docker-compose logs -f
```

## Performance & Resources

### System Requirements
- **RAM**: Minimum 2GB, recommended 4GB+
- **Storage**: ~2GB for Cambodia data + indexes
- **CPU**: 2+ cores recommended for initial import

## Troubleshooting

### Container Won't Start
```bash
# Check logs
docker logs cambodia-geocoding-api

# Common issues:
# - Insufficient memory
# - Network issues downloading OSM data
# - Port 8080 already in use
```

### API Returns No Results
- Ensure data import completed successfully
- Check if searching within Cambodia boundaries
- Verify coordinates are in correct format (decimal degrees)

### Performance Issues
- Increase container memory allocation
- Use SSD storage for better I/O performance
- Consider using smaller regional extracts

## API Documentation

For complete API documentation, visit:
- **Nominatim API docs**: https://nominatim.org/release-docs/latest/api/Overview/
- **Search parameters**: https://nominatim.org/release-docs/latest/api/Search/
- **Reverse parameters**: https://nominatim.org/release-docs/latest/api/Reverse/

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project uses:
- **Nominatim**: Licensed under GPL v2
- **OSM Data**: © OpenStreetMap contributors, ODbL license
- **mediagis/nominatim**: MIT License

## Support

- **Issues**: Create an issue in this repository
- **OSM Data**: Check [Geofabrik](https://download.geofabrik.de/asia/cambodia.html) for data updates
- **Nominatim**: See [official documentation](https://nominatim.org/)

---

**Note**: This server is configured specifically for Cambodia. For other countries or regions, modify the `PBF_URL` environment variable to point to the appropriate OSM extract.