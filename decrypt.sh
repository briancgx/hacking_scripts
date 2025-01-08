#!/bin/bash

# Script para romper contraseñas de un archivo ZIP usando 7z y un diccionario

if [ $# -ne 2 ]; then
    echo "Uso: $0 <archivo_zip> <diccionario>"
    exit 1
fi

archivo_zip=$1
diccionario=$2

# Realiza el ataque de fuerza bruta utilizando el diccionario y 7z
while IFS= read -r password; do
    # Prueba la contraseña usando 7z
    7z t "$archivo_zip" -p"$password" &> /dev/null
    if [ $? -eq 0 ]; then
        echo "¡Contraseña encontrada! La contraseña es: $password"
        exit 0  # Detiene el script una vez que encuentra la contraseña correcta
    fi
done < "$diccionario"

echo "Contraseña no encontrada en el diccionario."
