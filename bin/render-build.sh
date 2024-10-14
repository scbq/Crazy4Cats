#!/usr/bin/env bash
# exit on error
set -o errexit

# Instalar dependencias de gemas del proyecto
bundle install

# Utilizar Node.js como entorno de ejecución JavaScript para ExecJS
# exportando NODE_PATH para que lo detecte correctamente
export NODE_PATH=$(npm root -g)

# Precompilar activos
bundle exec rails assets:precompile

# Limpiar activos antiguos
bundle exec rails assets:clean

# Ejecutar migraciones
bundle exec rails db:migrate
