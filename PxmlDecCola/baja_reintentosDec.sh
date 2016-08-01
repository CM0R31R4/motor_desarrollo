#!/bin/bash

echo "Baja Reintentos actoVentaXml"
/usr/bin/psql -At -F';' -c "update tx_actoventaxml set reintentos=2 where reintentos>=3 " dmotor

# Limpia las tablas.
/usr/bin/psql -At -F';' -c "vacuum full tx_actoventaxml"
/usr/bin/psql -At -F';' -c "analyze tx_actoventaxml"

