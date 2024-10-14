#!/usr/bin/env bash
# exit on error
set -o errexit

# Instalación de las dependencias del proyecto
bundle install

# Precompilar activos y limpiar anteriores
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Migrar la base de datos, necesario para preparar las tablas
bundle exec rails db:migrate
