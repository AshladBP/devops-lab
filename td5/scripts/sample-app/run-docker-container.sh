#!/usr/bin/env bash
set -e

name=$(npm pkg get name | tr -d '"')
version=$(npm pkg get version | tr -d '"')

# Déterminer l'architecture actuelle et la mapper aux tags Docker
architecture=$(docker system info --format '{{.Architecture}}')
case $architecture in
    "x86_64")
        docker_arch="amd64"
        ;;
    "aarch64"|"arm64")
        docker_arch="arm64"
        ;;
    *)
        docker_arch="$architecture"
        ;;
esac

image_name="$name:$version-$docker_arch"
container_name="$name-app"

echo "Architecture détectée: $architecture -> Docker tag: $docker_arch"
echo "Starting Docker container from image: $image_name"

# Vérifier si l'image existe
if ! docker image inspect "$image_name" > /dev/null 2>&1; then
    echo "Erreur: L'image $image_name n'existe pas."
    echo "Images disponibles:"
    docker images | grep "$name" || echo "Aucune image trouvée pour $name"
    echo "Veuillez d'abord exécuter: npm run dockerize"
    exit 1
fi

# Stop and remove existing container if it exists
docker stop "$container_name" 2>/dev/null || true
docker rm "$container_name" 2>/dev/null || true

# Run the container
docker run -d \
  --name "$container_name" \
  -p 8080:8080 \
  --restart unless-stopped \
  "$image_name"

echo "Container '$container_name' est en cours d'exécution!"
echo "Application disponible à: http://localhost:8080"
echo "Pour voir les logs: docker logs -f $container_name"
echo "Pour arrêter: docker stop $container_name"
echo "Pour supprimer: docker rm $container_name"
