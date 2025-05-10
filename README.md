# code-container
Alternative approach using Docker Container for all Dev instead of NixOS VM

Dockerfile is necessary so that we don't build image everytime we start using docker-compose. If you actually want to rebuild the image, run
```
docker compose up -d --build
```
