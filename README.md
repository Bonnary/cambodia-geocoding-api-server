# Cambodia Geocoding API Server

This repository contains the necessary files to build and run a local Nominatim server for geocoding addresses in Cambodia. It uses data from OpenStreetMap.

## Prerequisites

- [Docker](https://www.docker.com/get-started) must be installed on your machine.

## How to Use

You can either build the Docker image yourself or use a platform like Coolify to build and deploy it from this repository.

### Building the Docker Image

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Bonnary/cambodia-geocoding-api-server.git
    cd cambodia-geocoding-api-server
    ```

2.  **Build the image:**
    From the root of the repository, run the following command:
    ```bash
    docker build -t cambodia-nominatim .
    ```
    This will create a Docker image named `cambodia-nominatim` on your local machine.

### Running the Docker Container

1.  **Start the container:**
    ```bash
    docker run -p 8080:8080 --name nominatim cambodia-nominatim
    ```
    This command starts a container named `nominatim` and maps port 8080 on your host to port 8080 in the container.

2.  **Wait for Nominatim to initialize:**
    The first time you run the container, Nominatim needs to import and process the OpenStreetMap data for Cambodia. This process can take a significant amount of time (30 minutes to a few hours depending on your machine's performance). You can monitor the progress by viewing the container's logs:
    ```bash
    docker logs -f nominatim
    ```
    Wait until you see messages indicating that the server is ready to accept connections.

### Using the Geocoding API

Once the server is running, you can send requests to it.

**Example: Forward Geocoding (Search for a place)**

To search for "Phnom Penh", you can use `curl` or your web browser:

```bash
curl "http://localhost:8080/search?q=Phnom+Penh&format=json"
```

**Example: Reverse Geocoding (Find address for coordinates)**

To find the address for latitude `11.5475456` and longitude `104.8171284`:

```bash
curl "http://localhost:8080/reverse?format=json&lat=11.5475456&lon=104.8171284"
```

Example output:

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

## Deployment to Coolify

If you are using Coolify:

1.  Connect your Coolify instance to your GitHub account.
2.  Create a new "Application" in Coolify.
3.  Select this repository.
4.  Coolify will automatically detect the `Dockerfile` and build and deploy the application for you.
5.  Coolify will assign a public URL to your running application.
