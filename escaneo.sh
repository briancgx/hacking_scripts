#!/bin/bash

SUBNET="192.168.0"

printf "\nIniciando escaneo de hosts activos en la red %s.0/24...\n\n" "$SUBNET"

# Función para verificar si un host responde al ping
scan_host() {
    local IP="$1"
    ping -c 1 -W 1 "$IP" &> /dev/null && printf "Host activo: %s\n" "$IP"
}

# Exportar la función para ser usada con xargs
export -f scan_host

# Generar direcciones IP y ejecutarlas en paralelo
for i in {1..254}; do
    echo "$SUBNET.$i"
done | xargs -P 20 -I{} bash -c 'scan_host "{}"'

printf "\nEscaneo finalizado.\n"
