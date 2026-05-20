# Tema 09 — Automatización: Copilot con APIs, Docker, infraestructura y GitHub Actions

## 1. Introducción

En este tema vamos a utilizar GitHub Copilot en tareas relacionadas con automatización y entornos reales de desarrollo:

- integración con APIs;
- creación de servicios;
- generación de archivos Docker;
- uso básico de infraestructura como código;
- creación de workflows con GitHub Actions;
- automatización de tests y builds;
- buenas prácticas de seguridad en CI/CD.

Este tema conecta GitHub Copilot con el trabajo que se realiza fuera de una función concreta.  
La IA puede ayudar a escribir archivos de configuración, scripts y workflows, pero estos archivos deben revisarse con especial cuidado porque pueden afectar al despliegue, a los permisos y a la seguridad del proyecto.

---

## 2. Objetivos del tema

Al finalizar este tema deberías ser capaz de:

- Pedir a Copilot ayuda para consumir una API.
- Generar endpoints sencillos con una estructura clara.
- Crear documentación básica de una API.
- Pedir a Copilot un `Dockerfile` y un `docker-compose.yml`.
- Entender qué partes de Docker no deben aceptarse sin revisar.
- Usar Copilot para crear un workflow básico de GitHub Actions.
- Automatizar instalación, tests y build.
- Identificar riesgos de seguridad en workflows.
- Usar prompts claros para infraestructura y CI/CD.

---

# Parte 1. Copilot e integración con APIs

## 3. Qué es una API

Una API permite que una aplicación se comunique con otra.

Por ejemplo:

- una aplicación web consulta productos a un backend;
- un backend consulta datos a un servicio externo;
- una aplicación obtiene información meteorológica;
- una tienda online se conecta con una pasarela de pago;
- una aplicación interna consulta una base de datos a través de un servicio.

En desarrollo web es muy habitual trabajar con APIs REST.

---

## 4. Qué puede hacer Copilot con APIs

Copilot puede ayudar a:

- crear endpoints;
- generar controladores;
- escribir servicios;
- consumir APIs externas;
- crear ejemplos de petición;
- documentar rutas;
- validar datos de entrada;
- manejar errores;
- generar tests de endpoints;
- crear clientes HTTP.

Ejemplos de tareas:

```text
Crea un endpoint GET /products que devuelva una lista de productos en memoria.
```

```text
Genera una función que consuma esta API usando fetch y gestione errores HTTP.
```

```text
Documenta estos endpoints en formato Markdown con método, ruta, descripción, parámetros y respuesta de ejemplo.
```

---

## 5. Guía paso a paso: pedir un endpoint a Copilot

Imagina una API con Express.

### Paso 1. Describir el contexto

```text
Estoy trabajando en una API REST con Node.js y Express.
El proyecto separa rutas, controladores y servicios.
Los datos se almacenarán en memoria para este ejemplo.
```

### Paso 2. Pedir una ruta concreta

```text
Crea una ruta GET /products.
Debe devolver un array de productos con id, name, price y stock.
Separa la ruta, el controlador y el servicio.
No añadas base de datos.
```

### Paso 3. Pedir los archivos por separado

En lugar de pedir todo de golpe, puedes dividir:

```text
Crea primero el archivo src/services/productService.js con una función getProducts().
```

Después:

```text
Ahora crea src/controllers/productController.js usando el servicio anterior.
```

Después:

```text
Ahora crea src/routes/productRoutes.js y registra la ruta GET /products.
```

### Paso 4. Revisar el código

Comprueba:

- si los nombres de archivos encajan con el proyecto;
- si los exports/imports son correctos;
- si no se ha añadido una dependencia innecesaria;
- si el manejo de errores es suficiente;
- si el endpoint se registra correctamente en `app.js`.

---

## 6. Ejemplo de servicio

```js
const products = [
  { id: 1, name: "Keyboard", price: 49.99, stock: 12 },
  { id: 2, name: "Mouse", price: 19.99, stock: 30 },
  { id: 3, name: "Monitor", price: 199.99, stock: 5 },
];

function getProducts() {
  return products;
}

module.exports = { getProducts };
```

Ejemplo de prompt para mejorarlo:

```text
Revisa este servicio.
Añade una función getProductById(id).
No cambies la estructura de datos.
Controla el caso en el que no exista ningún producto con ese id.
```

---

## 7. Consumo de una API externa

También podemos pedir a Copilot funciones que consuman APIs.

Ejemplo:

```text
Crea una función async llamada getUserById que reciba un id y consulte https://jsonplaceholder.typicode.com/users/{id}.
Usa fetch.
Si la respuesta HTTP no es correcta, lanza un error claro.
Devuelve solo id, name, email y city.
```

Posible resultado:

```js
async function getUserById(id) {
  const response = await fetch(
    `https://jsonplaceholder.typicode.com/users/${id}`,
  );

  if (!response.ok) {
    throw new Error(`Error fetching user with id ${id}`);
  }

  const user = await response.json();

  return {
    id: user.id,
    name: user.name,
    email: user.email,
    city: user.address.city,
  };
}

module.exports = { getUserById };
```

### Qué revisar

- ¿La URL es correcta?
- ¿Se controla `response.ok`?
- ¿Qué pasa si `user.address` no existe?
- ¿La función devuelve demasiados datos?
- ¿Se están exponiendo datos sensibles?
- ¿Hace falta timeout?
- ¿Hace falta retry?
- ¿Hay tests?

---

## 8. Prompt para documentar una API

```text
Documenta estos endpoints en Markdown.
Para cada endpoint incluye:
- método HTTP;
- ruta;
- descripción;
- parámetros;
- body esperado;
- respuesta correcta;
- posibles errores;
- ejemplo de petición;
- ejemplo de respuesta.
```

Ejemplo de documentación:

````md
## GET /products

Devuelve la lista de productos disponibles.

### Respuesta 200

```json
[
  {
    "id": 1,
    "name": "Keyboard",
    "price": 49.99,
    "stock": 12
  }
]
```
````

### Errores posibles

- `500 Internal Server Error`: error inesperado en el servidor.

````

---

# Parte 2. Copilot y Docker

## 9. Qué es Docker

Docker permite empaquetar una aplicación con sus dependencias para ejecutarla de forma más consistente en distintos entornos.

Con Docker podemos definir:

- qué imagen base usar;
- qué dependencias instalar;
- qué archivos copiar;
- qué comando ejecutar;
- qué puerto exponer;
- qué variables de entorno utilizar.

El archivo principal suele llamarse:

```text
Dockerfile
````

---

## 10. Qué puede hacer Copilot con Docker

Copilot puede ayudar a:

- crear un `Dockerfile`;
- crear un `.dockerignore`;
- generar un `docker-compose.yml`;
- explicar errores de construcción;
- optimizar capas;
- revisar problemas de seguridad;
- crear comandos para construir y ejecutar imágenes.

Ejemplo de prompt:

```text
Crea un Dockerfile para una aplicación Node.js con Express.
Usa una imagen oficial de Node.
Instala dependencias con npm ci.
Copia solo lo necesario.
Expón el puerto 3000.
Ejecuta npm start.
Incluye comentarios breves.
```

---

## 11. Ejemplo de Dockerfile para Node.js

```dockerfile
FROM node:22-alpine

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev

COPY src ./src

EXPOSE 3000

CMD ["npm", "start"]
```

Este archivo indica:

- usar Node 22 sobre Alpine;
- trabajar dentro de `/app`;
- copiar los archivos de dependencias;
- instalar dependencias de producción;
- copiar el código fuente;
- exponer el puerto 3000;
- ejecutar `npm start`.

---

## 12. Archivo `.dockerignore`

Copilot también puede generar un `.dockerignore`.

Prompt:

```text
Genera un archivo .dockerignore para una aplicación Node.js.
Debe excluir node_modules, logs, archivos de entorno, carpeta de coverage y archivos temporales.
```

Ejemplo:

```text
node_modules
npm-debug.log
.env
.env.*
coverage
dist
.git
.gitignore
.DS_Store
```

El `.dockerignore` evita copiar archivos innecesarios o sensibles dentro de la imagen.

---

## 13. Guía paso a paso: pedir y revisar un Dockerfile

### Paso 1. Explicar el proyecto

```text
Tengo una API REST con Node.js y Express.
El punto de entrada es src/app.js.
El script de inicio es npm start.
La aplicación escucha en el puerto 3000.
```

### Paso 2. Pedir Dockerfile

```text
Crea un Dockerfile para este proyecto.
Usa buenas prácticas básicas.
No incluyas secretos ni variables de entorno reales.
Explica cada línea.
```

### Paso 3. Pedir `.dockerignore`

```text
Crea un .dockerignore adecuado para este proyecto Node.js.
```

### Paso 4. Construir la imagen

```bash
docker build -t copilot-api .
```

### Paso 5. Ejecutar el contenedor

```bash
docker run -p 3000:3000 copilot-api
```

### Paso 6. Revisar errores

Si falla, copia el error y pregunta:

```text
Explícame este error de Docker.
Dime la causa más probable y cómo comprobarla.
No propongas todavía una solución definitiva.
```

---

## 14. Docker Compose

`docker-compose.yml` permite definir varios servicios.

Por ejemplo:

- aplicación web;
- base de datos;
- servicio de cache;
- cola de mensajes.

Prompt:

```text
Crea un docker-compose.yml para una API Node.js y una base de datos MySQL.
La API debe depender de MySQL.
No incluyas contraseñas reales.
Usa variables de entorno.
Añade comentarios para explicar cada bloque.
```

Ejemplo simplificado:

```yaml
services:
  api:
    build: .
    ports:
      - "3000:3000"
    environment:
      DB_HOST: db
      DB_USER: ${DB_USER}
      DB_PASSWORD: ${DB_PASSWORD}
      DB_NAME: ${DB_NAME}
    depends_on:
      - db

  db:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${DB_NAME}
    volumes:
      - db_data:/var/lib/mysql

volumes:
  db_data:
```

---

## 15. Qué revisar en archivos Docker generados por Copilot

Antes de aceptar un `Dockerfile` o `docker-compose.yml`, comprueba:

- si la imagen base es adecuada;
- si la versión está fijada o es demasiado genérica;
- si copia archivos sensibles;
- si instala dependencias innecesarias;
- si expone puertos correctos;
- si usa variables de entorno;
- si evita incluir contraseñas reales;
- si ejecuta comandos peligrosos;
- si el contenedor corre como root cuando no debería;
- si el archivo es comprensible para el equipo.

---

# Parte 3. Infraestructura como código

## 16. Qué es infraestructura como código

La infraestructura como código, o IaC, consiste en definir recursos de infraestructura mediante archivos de configuración.

Ejemplos de herramientas:

- Terraform;
- Bicep;
- CloudFormation;
- Pulumi.

Con IaC se pueden describir recursos como:

- redes;
- servidores;
- bases de datos;
- almacenamiento;
- permisos;
- servicios cloud.

---

## 17. Copilot e IaC

Copilot puede ayudar a escribir plantillas de infraestructura, pero aquí hay que ser especialmente cuidadoso.

Un error en infraestructura puede provocar:

- costes innecesarios;
- recursos expuestos públicamente;
- permisos excesivos;
- pérdida de datos;
- problemas de cumplimiento normativo.

Por eso, en IaC se recomienda usar Copilot para:

- generar borradores;
- explicar bloques existentes;
- detectar configuraciones sospechosas;
- documentar recursos;
- crear ejemplos educativos.

No se recomienda aceptar infraestructura generada sin revisión experta.

---

## 18. Prompt seguro para Terraform

```text
Genera un ejemplo educativo de Terraform para crear un recurso sencillo.
No uses credenciales reales.
No configures acceso público salvo que lo expliques.
Incluye comentarios y explica cada bloque.
```

Prompt para revisión:

```text
Revisa este archivo Terraform.
Busca:
- permisos excesivos;
- recursos públicos;
- valores hardcodeados;
- secretos;
- costes potencialmente altos;
- configuraciones peligrosas.
No modifiques el archivo todavía.
```

---

## 19. Prompt seguro para Bicep

```text
Explica este archivo Bicep paso a paso.
Indica qué recursos crea, qué parámetros usa y qué riesgos de seguridad habría que revisar.
No propongas cambios todavía.
```

---

# Parte 4. GitHub Actions y CI/CD

## 20. Qué es GitHub Actions

GitHub Actions permite automatizar flujos de trabajo dentro de un repositorio.

Se puede usar para:

- instalar dependencias;
- ejecutar tests;
- analizar código;
- construir una aplicación;
- generar artefactos;
- desplegar;
- publicar paquetes;
- ejecutar tareas programadas.

Un workflow de GitHub Actions se define normalmente en archivos YAML dentro de:

```text
.github/workflows/
```

---

## 21. Qué es CI/CD

CI significa **Continuous Integration** o integración continua.  
Consiste en comprobar automáticamente que el código funciona cuando se suben cambios.

CD puede significar **Continuous Delivery** o **Continuous Deployment**.  
Consiste en preparar o realizar despliegues automatizados.

Ejemplo de flujo CI básico:

1. Un desarrollador sube código.
2. GitHub Actions detecta el cambio.
3. Se instala el proyecto.
4. Se ejecutan los tests.
5. Se genera el build.
6. Si algo falla, el workflow marca error.

---

## 22. Qué puede hacer Copilot con GitHub Actions

Copilot puede ayudar a:

- crear workflows;
- explicar archivos YAML;
- corregir errores de indentación;
- añadir jobs;
- configurar versiones de Node, Java, Python, etc.;
- añadir caché de dependencias;
- ejecutar tests;
- crear builds;
- revisar problemas de seguridad;
- documentar el pipeline.

Prompt inicial:

```text
Crea un workflow de GitHub Actions para un proyecto Node.js.
Debe ejecutarse en push y pull_request hacia la rama main.
Debe instalar dependencias con npm ci, ejecutar tests y ejecutar npm run build.
Usa Node 22.
Explica cada parte del YAML.
```

---

## 23. Ejemplo de workflow para Node.js

Archivo:

```text
.github/workflows/ci.yml
```

Contenido:

```yaml
name: CI

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  test-and-build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v6

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: "22"
          cache: "npm"

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Build project
        run: npm run build
```

Este workflow:

- se llama `CI`;
- se ejecuta al hacer push a `main`;
- se ejecuta al abrir o actualizar una pull request hacia `main`;
- usa Ubuntu como entorno;
- descarga el repositorio;
- configura Node.js;
- instala dependencias;
- ejecuta tests;
- genera el build.

---

## 24. Guía paso a paso: crear un workflow con Copilot

### Paso 1. Explicar el proyecto

```text
Tengo un proyecto Node.js.
Uso npm.
Los tests se ejecutan con npm test.
El build se ejecuta con npm run build.
Quiero un workflow de CI para GitHub Actions.
```

### Paso 2. Pedir el workflow

```text
Crea un archivo .github/workflows/ci.yml.
Debe ejecutarse en push y pull_request hacia main.
Debe usar Node 22.
Debe instalar dependencias, ejecutar tests y hacer build.
Incluye nombres claros para cada step.
```

### Paso 3. Revisar el YAML

Comprueba:

- indentación;
- eventos (`push`, `pull_request`);
- rama correcta;
- versión de Node;
- comandos reales del proyecto;
- si existe el script `build`;
- si existe el script `test`.

### Paso 4. Crear el archivo

Crea la carpeta:

```text
.github/workflows
```

Dentro, crea:

```text
ci.yml
```

### Paso 5. Subir los cambios

```bash
git add .github/workflows/ci.yml
git commit -m "Add CI workflow"
git push
```

### Paso 6. Revisar la pestaña Actions

En GitHub, entra en el repositorio y abre la pestaña:

```text
Actions
```

Ahí podrás ver si el workflow se ha ejecutado correctamente.

---

## 25. Errores habituales en workflows generados con Copilot

### Error 1. Usar comandos que no existen

Copilot puede generar:

```yaml
- name: Build project
  run: npm run build
```

Pero tu `package.json` quizá no tenga script `build`.

Comprueba siempre `package.json`.

### Error 2. Indentación incorrecta

YAML depende mucho de la indentación.  
Un espacio incorrecto puede romper el workflow.

### Error 3. Usar versiones obsoletas de actions

Revisa que las actions usadas sean actuales y oficiales.

### Error 4. Incluir secretos directamente

Nunca aceptes esto:

```yaml
password: "my-real-password"
```

Usa secretos del repositorio:

```yaml
password: ${{ secrets.DB_PASSWORD }}
```

### Error 5. Dar permisos excesivos

Si el workflow no necesita escribir en el repositorio, no le des permisos de escritura.

---

## 26. Seguridad en GitHub Actions

La seguridad es especialmente importante en CI/CD.

Buenas prácticas:

- no guardar secretos en el código;
- usar `secrets`;
- limitar permisos;
- revisar acciones de terceros;
- fijar versiones;
- no ejecutar scripts desconocidos;
- tener cuidado con workflows que se ejecutan en pull requests externas;
- revisar qué comandos propone Copilot;
- evitar publicar artefactos sensibles.

Prompt de revisión de seguridad:

```text
Revisa este workflow de GitHub Actions desde el punto de vista de seguridad.
Busca:
- secretos expuestos;
- permisos excesivos;
- actions de terceros sospechosas;
- comandos peligrosos;
- problemas con pull_request;
- riesgos de publicación accidental de artefactos.
No modifiques todavía el archivo.
```

---

## 27. Añadir permisos mínimos

En algunos workflows puede ser recomendable declarar permisos explícitos.

Ejemplo:

```yaml
permissions:
  contents: read
```

Esto indica que el workflow solo necesita leer el contenido del repositorio.

Si el workflow necesita publicar paquetes, crear releases o comentar pull requests, los permisos serían diferentes.  
No conviene dar permisos amplios “por si acaso”.

---

## 28. Copilot para diagnosticar errores de GitHub Actions

Cuando falla un workflow, Copilot puede ayudar.

### Paso 1. Copiar el error

Incluye:

- nombre del job;
- step que falla;
- mensaje de error;
- fragmento del YAML;
- comando que se ejecutó.

### Paso 2. Preguntar por la causa

```text
Este workflow de GitHub Actions falla en el step "Run tests".
Te paso el log y el archivo YAML.
Explícame la causa más probable y cómo comprobarla.
No propongas cambios todavía.
```

### Paso 3. Pedir corrección mínima

```text
Propón la corrección mínima para arreglar este workflow.
No cambies la estructura general.
Explica por qué el cambio soluciona el problema.
```

---

# Parte 5. Flujo integrador con Copilot

## 29. Caso guiado: API + Docker + CI

Supongamos que tenemos una API Node.js con Express.

Queremos:

1. Crear endpoints de productos.
2. Añadir tests.
3. Crear un Dockerfile.
4. Crear un workflow de CI.
5. Documentar cómo ejecutar el proyecto.

---

## 30. Paso 1. Pedir endpoints

```text
Tengo una API Node.js con Express.
Crea una funcionalidad de productos con:
- GET /products
- GET /products/:id
Usa datos en memoria.
Separa rutas, controladores y servicios.
No añadas base de datos.
```

---

## 31. Paso 2. Pedir tests

```text
Genera tests para los endpoints de productos.
Usa Jest y Supertest.
Incluye:
- listado de productos;
- búsqueda por id existente;
- búsqueda por id inexistente.
```

---

## 32. Paso 3. Pedir Dockerfile

```text
Crea un Dockerfile para esta API.
Usa Node 22.
Instala dependencias con npm ci.
Expón el puerto 3000.
Ejecuta npm start.
Incluye también un .dockerignore.
```

---

## 33. Paso 4. Pedir workflow

```text
Crea un workflow de GitHub Actions para esta API.
Debe ejecutarse en push y pull_request hacia main.
Debe instalar dependencias, ejecutar tests y construir la imagen Docker.
No debe publicar la imagen.
```

---

## 34. Paso 5. Pedir documentación

```text
Actualiza el README con:
- instalación local;
- ejecución en desarrollo;
- ejecución de tests;
- construcción de imagen Docker;
- endpoints disponibles.
```

---

## 35. Paso 6. Pedir revisión completa

```text
Revisa los cambios propuestos.
Busca:
- problemas de seguridad;
- errores en imports/exports;
- tests insuficientes;
- comandos que no coinciden con package.json;
- documentación incompleta.
No añadas nuevas funcionalidades.
```

---

# Parte 6. Checklist final

## 36. Antes de aceptar código de APIs

Comprueba:

- rutas correctas;
- métodos HTTP correctos;
- validación de parámetros;
- manejo de errores;
- respuestas claras;
- estructura coherente;
- tests suficientes;
- documentación actualizada.

## 37. Antes de aceptar Dockerfile

Comprueba:

- imagen base adecuada;
- versión razonable;
- dependencias correctas;
- `.dockerignore`;
- ausencia de secretos;
- puerto correcto;
- comando de inicio correcto;
- tamaño de imagen razonable.

## 38. Antes de aceptar workflows

Comprueba:

- eventos correctos;
- rama correcta;
- versión de runtime;
- comandos existentes;
- permisos mínimos;
- secrets bien usados;
- actions confiables;
- logs comprensibles;
- ausencia de despliegues accidentales.

---

## 39. Prompts recopilatorios del tema

### API

```text
Crea un endpoint para [recurso].
Usa [framework].
Separa rutas, controladores y servicios.
Incluye manejo básico de errores.
No añadas base de datos.
```

### Cliente HTTP

```text
Crea una función async que consuma esta API.
Usa fetch.
Controla errores HTTP.
Devuelve solo los campos necesarios.
Incluye un ejemplo de uso.
```

### Docker

```text
Crea un Dockerfile para este proyecto.
Usa buenas prácticas básicas.
No incluyas secretos.
Explica cada línea.
```

### Docker Compose

```text
Crea un docker-compose.yml para este proyecto.
Usa variables de entorno para credenciales.
No escribas contraseñas reales.
Explica cada servicio.
```

### Terraform o Bicep

```text
Revisa este archivo de infraestructura como código.
Busca permisos excesivos, recursos públicos, secretos, costes altos y configuraciones peligrosas.
No modifiques todavía el archivo.
```

### GitHub Actions

```text
Crea un workflow de GitHub Actions para este proyecto.
Debe ejecutarse en push y pull_request hacia main.
Debe instalar dependencias, ejecutar tests y hacer build.
Usa permisos mínimos.
```

### Seguridad en CI/CD

```text
Revisa este workflow desde el punto de vista de seguridad.
Busca secretos expuestos, permisos excesivos, actions no confiables y comandos peligrosos.
```

---

## 40. Resumen

En este tema hemos visto cómo utilizar Copilot en tareas más cercanas a un entorno profesional:

- APIs;
- integración con servicios externos;
- Docker;
- Docker Compose;
- infraestructura como código;
- GitHub Actions;
- CI/CD;
- revisión de seguridad.

Copilot puede acelerar mucho la creación de archivos técnicos, pero estos archivos suelen tener impacto directo en ejecución, despliegue y seguridad.  
Por eso, deben revisarse siempre con especial atención.

La regla general es:

> Usa Copilot para generar borradores, explicaciones y propuestas; usa tu criterio técnico para decidir qué se integra en el proyecto.

---

## 41. Documentación recomendada

- GitHub Docs — GitHub Actions.
- GitHub Docs — Workflow syntax for GitHub Actions.
- GitHub Docs — Secure use of GitHub Actions.
- Docker Docs — Dockerfile reference.
- Docker Docs — Docker Compose.
- Terraform Docs.
- Microsoft Learn — Bicep.
