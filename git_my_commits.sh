#!/bin/bash

# Este script lista los últimos N commits de cualquier autor en Git.

echo "--- Listar Últimos Commits en Git ---"

# 1. Preguntar cuántos commits recientes buscar
read -p "¿Cuántos de los últimos commits quieres listar (ej: 20)? " num_commits

# Validar que el número de commits sea un número positivo
if ! [[ "$num_commits" =~ ^[0-9]+$ ]] || [ "$num_commits" -eq 0 ]; then
    echo "Error: El número de commits debe ser un número positivo."
    exit 1
fi

echo ""
echo "Mostrando los últimos $num_commits commits de cualquier autor..."
echo "----------------------------------------------------"

# git log -n "$num_commits" --pretty=format:"%h - %an, %ar : %s"
#   -n "$num_commits": Limita el número de commits a mostrar.
#   --pretty=format:"...": Personaliza el formato de salida de cada commit.
#     %h: Hash del commit abreviado
#     %an: Nombre del autor
#     %ar: Fecha relativa del autor (ej: 2 days ago)
#     %s: Asunto/mensaje del commit
git log -n "$num_commits" --pretty=format:"%C(yellow)%h%C(reset) - %C(green)%an%C(reset), %C(blue)%ar%C(reset) : %s"

echo ""
echo "----------------------------------------------------"
echo "¡Listado de commits completado!"