# Informe — Dockerización Flask Realworld Example App

## Análisis de la app
- Lenguaje: Python
- Dependencias: requirements/prod.txt
- Puerto: 5000
- Cómo arranca: flask run --with-threads
- Base de datos: PostgreSQL

## Decisiones que tomé
- Imagen base: python:3.9-slim por compatibilidad con dependencias antiguas
- docker-compose con dos servicios: app + PostgreSQL
- Variable de entorno FLASK_APP=autoapp.py para indicar el archivo principal
- psycopg2-binary en lugar de psycopg2 porque la imagen slim no tiene librerías de PostgreSQL

## Problemas encontrados

### Error 1 — Python 3.13 incompatible
SQLAlchemy 1.1.9 usa collections.MutableMapping que fue removido en Python 3.10.
Solución: cambié a python:3.9-slim.

### Error 2 — psycopg2 no compila
La imagen slim no tiene pg_config necesario para compilar psycopg2.
Solución: reemplacé por psycopg2-binary en prod.txt.

### Error 3 — Flask_SQLAlchemy incompatible
Flask_SQLAlchemy==2.2 no es compatible con versiones modernas de Flask.
Intenté fijar Flask==1.1.4 pero generó nuevas incompatibilidades en cascada.

## Conclusión
La app tiene dependencias demasiado antiguas e incompatibles entre sí.
Dockerizarla requeriría actualizar el código fuente, lo cual excede
el alcance de una tarea de containerización.
Esta situación es común en apps legacy y requiere intervención del equipo
de desarrollo antes de continuar.

Esta app se clono de una repo de github para realizar pruebas y practicas. https://github.com/gothinkster/flask-realworld-example-app