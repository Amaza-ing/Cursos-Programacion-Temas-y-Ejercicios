# Topic 09 — Automation: Copilot with APIs, Docker, infrastructure and GitHub Actions

## 1. Introduction

In this topic we are going to use GitHub Copilot in tasks related to automation and real development environments:

- integration with APIs;
- creation of services;
- Docker file generation;
- basic use of infrastructure as code;
- creation of workflows with GitHub Actions;
- automation of tests and builds;
- good security practices in CI/CD.

This topic connects GitHub Copilot to work done outside of a specific feature.  
AI can help write configuration files, scripts, and workflows, but these files should be reviewed especially carefully because they can affect project deployment, permissions, and security.

---

## 2. Objectives of the topic

By the end of this topic you should be able to:

- Ask Copilot for help consuming an API.
- Generate simple endpoints with a clear structure.
- Create basic documentation of an API.
- Ask Copilot for an `Dockerfile` and an `docker-compose.yml`.
- Understand which parts of Docker should not be accepted without review.
- Use Copilot to create a basic GitHub Actions workflow.
- Automate installation, tests and build.
- Identify security risks in workflows.
- Use clear prompts for infrastructure and CI/CD.

---

# Part 1. Copilot and integration with APIs

## 3. What is an API

An API allows one application to communicate with another.

For example:

- a web application queries products to a backend;
- a backend queries data to an external service;
- an application obtains weather information;
- an online store connects with a payment gateway;
- an internal application queries a database through a service.

In web development it is very common to work with REST APIs.

---

## 4. What Copilot can do with APIs

Copilot can help:

- create endpoints;
- generate drivers;
- write services;
- consume external APIs;
- create request examples;
- document routes;
- validate input data;
- handle errors;
- generate endpoint tests;
- create HTTP clients.

Examples of tasks:

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

## 5. Step-by-step guide: request an endpoint from Copilot

Imagine an API with Express.

### Step 1. Describe the context

```text
Estoy trabajando en una API REST con Node.js y Express.
El proyecto separa rutas, controladores y servicios.
Los datos se almacenarán en memoria para este ejemplo.
```

### Step 2. Request a specific route

```text
Crea una ruta GET /products.
Debe devolver un array de productos con id, name, price y stock.
Separa la ruta, el controlador y el servicio.
No añadas base de datos.
```

### Step 3. Order files separately

Instead of ordering everything at once, you can divide:

```text
Crea primero el archivo src/services/productService.js con una función getProducts().
```

After:

```text
Ahora crea src/controllers/productController.js usando el servicio anterior.
```

After:

```text
Ahora crea src/routes/productRoutes.js y registra la ruta GET /products.
```

### Step 4. Review the code

Check:

- whether the file names fit the project;
- if the exports/imports are correct;
- if no unnecessary dependency has been added;
- whether error handling is sufficient;
- if the endpoint registers successfully in `app.js`.

---

## 6. Service example

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

Example of a prompt to improve it:

```text
Revisa este servicio.
Añade una función getProductById(id).
No cambies la estructura de datos.
Controla el caso en el que no exista ningún producto con ese id.
```

---

## 7. Consumption of an external API

We can also ask Copilot for functions that consume APIs.

Example:

```text
Crea una función async llamada getUserById que reciba un id y consulte https://jsonplaceholder.typicode.com/users/{id}.
Usa fetch.
Si la respuesta HTTP no es correcta, lanza un error claro.
Devuelve solo id, name, email y city.
```

Possible result:

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

### What to check

- Is the URL correct?
- Is `response.ok` controlled?
- What if `user.address` does not exist?
- Does the function return too much data?
- Is sensitive data being exposed?
- Is there a need for a timeout?
- Is retry necessary?
- Are there tests?

---

## 8. Prompt to document an API

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

Documentation example:

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

### Possible errors

- `500 Internal Server Error`: unexpected server error.

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

## 10. What Copilot can do with Docker

Copilot can help:

- create an `Dockerfile`;
- create an `.dockerignore`;
- generate an `docker-compose.yml`;
- explain construction errors;
- optimize layers;
- review security issues;
- create commands to build and run images.

Prompt example:

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

## 11. Dockerfile example for Node.js

```dockerfile
FROM node:22-alpine

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev

COPY src ./src

EXPOSE 3000

CMD ["npm", "start"]
```

This file indicates:

- use Node 22 on Alpine;
- work within `/app`;
- copy the dependencies files;
- install production dependencies;
- copy the source code;
- expose port 3000;
- run `npm start`.

---

## 12. `.dockerignore` file

Copilot can also generate an `.dockerignore`.

Prompt:

```text
Genera un archivo .dockerignore para una aplicación Node.js.
Debe excluir node_modules, logs, archivos de entorno, carpeta de coverage y archivos temporales.
```

Example:

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

The `.dockerignore` avoids copying unnecessary or sensitive files into the image.

---

## 13. Step-by-step guide: request and review a Dockerfile

### Step 1. Explain the project

```text
Tengo una API REST con Node.js y Express.
El punto de entrada es src/app.js.
El script de inicio es npm start.
La aplicación escucha en el puerto 3000.
```

### Step 2. Request Dockerfile

```text
Crea un Dockerfile para este proyecto.
Usa buenas prácticas básicas.
No incluyas secretos ni variables de entorno reales.
Explica cada línea.
```

### Step 3. Order `.dockerignore`

```text
Crea un .dockerignore adecuado para este proyecto Node.js.
```

### Step 4. Build the image

```bash
docker build -t copilot-api .
```

### Step 5. Run the container

```bash
docker run -p 3000:3000 copilot-api
```

### Step 6. Check for errors

If it fails, copy the error and ask:

```text
Explícame este error de Docker.
Dime la causa más probable y cómo comprobarla.
No propongas todavía una solución definitiva.
```

---

## 14. Docker Compose

`docker-compose.yml` allows you to define several services.

For example:

- web application;
- database;
- cache service;
- message queue.

Prompt:

```text
Crea un docker-compose.yml para una API Node.js y una base de datos MySQL.
La API debe depender de MySQL.
No incluyas contraseñas reales.
Usa variables de entorno.
Añade comentarios para explicar cada bloque.
```

Simplified example:

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

## 15. What to check in Docker files generated by Copilot

Before accepting an `Dockerfile` or `docker-compose.yml`, check:

- whether the base image is suitable;
- if the version is fixed or too generic;
- if you copy sensitive files;
- if you install unnecessary dependencies;
- if you expose correct ports;
- if you use environment variables;
- if you avoid including real passwords;
- if you execute dangerous commands;
- if the container runs as root when it shouldn't;
- whether the file is understandable by the computer.

---

# Part 3. Infrastructure as code

## 16. What is infrastructure as code

Infrastructure as code, or IaC, involves defining infrastructure resources using configuration files.

Examples of tools:

-Terraform;
- Bicep;
- CloudFormation;
- Pulumi.

With IaC you can describe resources such as:

- networks;
- servers;
- databases;
- storage;
- permissions;
- cloud services.

---

## 17. Copilot and IaC

Copilot can help you write infrastructure templates, but you have to be especially careful here.

An infrastructure error can cause:

- unnecessary costs;
- publicly displayed resources;
- excessive permissions;
- data loss;
- regulatory compliance issues.

Therefore, in IaC it is recommended to use Copilot to:

- generate drafts;
- explain existing blocks;
- detect suspicious configurations;
- document resources;
- create educational examples.

It is not recommended to accept infrastructure generated without expert review.

---

## 18. Secure Prompt for Terraform

```text
Genera un ejemplo educativo de Terraform para crear un recurso sencillo.
No uses credenciales reales.
No configures acceso público salvo que lo expliques.
Incluye comentarios y explica cada bloque.
```

Prompt for review:

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

## 19. Safe Prompt for Bicep

```text
Explica este archivo Bicep paso a paso.
Indica qué recursos crea, qué parámetros usa y qué riesgos de seguridad habría que revisar.
No propongas cambios todavía.
```

---

# Part 4. GitHub Actions and CI/CD

## 20. What is GitHub Actions

GitHub Actions allows you to automate workflows within a repository.

Can be used for:

- install dependencies;
- run tests;
- analyze code;
- build an application;
- generate artifacts;
- deploy;
- publish packages;
- execute scheduled tasks.

A GitHub Actions workflow is typically defined in YAML files within:

```text
.github/workflows/
```

---

## 21. What is CI/CD

CI stands for **Continuous Integration** or continuous integration.  
It consists of automatically checking that the code works when changes are uploaded.

CD can mean **Continuous Delivery** or **Continuous Deployment**.  
It consists of preparing or carrying out automated deployments.

Basic CI flow example:

1. A developer uploads code.
2. GitHub Actions detects the change.
3. The project is installed.
4. The tests are executed.
5. The build is generated.
6. If something fails, the workflow flags an error.

---

## 22. What Copilot can do with GitHub Actions

Copilot can help:

- create workflows;
- explain YAML files;
- correct indentation errors;
- add jobs;
- configure versions of Node, Java, Python, etc.;
- add dependency cache;
- run tests;
- create builds;
- review security issues;
- document the pipeline.

Initial prompt:

```text
Crea un workflow de GitHub Actions para un proyecto Node.js.
Debe ejecutarse en push y pull_request hacia la rama main.
Debe instalar dependencias con npm ci, ejecutar tests y ejecutar npm run build.
Usa Node 22.
Explica cada parte del YAML.
```

---

## 23. Workflow example for Node.js

File:

```text
.github/workflows/ci.yml
```

Content:

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

This workflow:

- it is called `CI`;
- is executed when pushing `main`;
- is executed when opening or updating a pull request towards `main`;
- uses Ubuntu as an environment;
- download the repository;
- configure Node.js;
- install dependencies;
- run tests;
- generates the build.

---

## 24. Step-by-step guide: create a workflow with Copilot

### Step 1. Explain the project

```text
Tengo un proyecto Node.js.
Uso npm.
Los tests se ejecutan con npm test.
El build se ejecuta con npm run build.
Quiero un workflow de CI para GitHub Actions.
```

### Step 2. Request the workflow

```text
Crea un archivo .github/workflows/ci.yml.
Debe ejecutarse en push y pull_request hacia main.
Debe usar Node 22.
Debe instalar dependencias, ejecutar tests y hacer build.
Incluye nombres claros para cada step.
```

### Step 3. Review the YAML

Check:

- indentation;
- events (`push`, `pull_request`);
- correct branch;
- Node version;
- actual project commands;
- if the script `build` exists;
- if the `test` script exists.

### Step 4. Create the file

Create the folder:

```text
.github/workflows
```

Inside, create:

```text
ci.yml
```

### Step 5. Upload changes

```bash
git add .github/workflows/ci.yml
git commit -m "Add CI workflow"
git push
```

### Step 6. Review the Actions tab

On GitHub, go to the repository and open the tab:

```text
Actions
```

There you can see if the workflow has been executed correctly.

---

## 25. Common errors in workflows generated with Copilot

### Error 1. Using commands that do not exist

Copilot can generate:

```yaml
- name: Build project
  run: npm run build
```

But your `package.json` may not have `build` script.

Always check `package.json`.

### Error 2. Incorrect indentation

YAML relies heavily on indentation.  
An incorrect space can break the workflow.
### Error 3. Using outdated versions of actions

Check that the actions used are current and official.

### Error 4. Including secrets directly

Never accept this:

```yaml
password: "my-real-password"
```

Use repository secrets:

```yaml
password: ${{ secrets.DB_PASSWORD }}
```

### Error 5. Giving excessive permissions

If the workflow does not need to write to the repository, do not give it write permissions.

---

## 26. Security in GitHub Actions

Security is especially important in CI/CD.

Good practices:

- do not keep secrets in the code;
- use `secrets`;
- limit permissions;
- review actions of third parties;
- fix versions;
- do not run unknown scripts;
- be careful with workflows that are executed on external pull requests;
- review what commands Copilot proposes;
- avoid publishing sensitive artifacts.

Security Review Prompt:

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

## 27. Add minimum permissions

In some workflows it may be advisable to declare explicit permissions.

Example:

```yaml
permissions:
  contents: read
```

This indicates that the workflow only needs to read the contents of the repository.

If the workflow needs to publish packages, create releases, or comment on pull requests, the permissions would be different.  
It is not advisable to give broad permissions “just in case.”

---

## 28. Copilot to diagnose GitHub Actions errors

When a workflow fails, Copilot can help.

### Step 1. Copy the error

Includes:

- job name;
- step that fails;
- error message;
- YAML fragment;
- command that was executed.

### Step 2. Ask about the cause

```text
Este workflow de GitHub Actions falla en el step "Run tests".
Te paso el log y el archivo YAML.
Explícame la causa más probable y cómo comprobarla.
No propongas cambios todavía.
```

### Step 3. Request minimum correction

```text
Propón la corrección mínima para arreglar este workflow.
No cambies la estructura general.
Explica por qué el cambio soluciona el problema.
```

---

# Part 5. Integrative flow with Copilot

## 29. Guided case: API + Docker + CI

Suppose we have a Node.js API with Express.

We want:

1. Create product endpoints.
2. Add tests.
3. Create a Dockerfile.
4. Create a CI workflow.
5. Document how to execute the project.

---

## 30. Step 1. Order endpoints

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

## 31. Step 2. Request tests

```text
Genera tests para los endpoints de productos.
Usa Jest y Supertest.
Incluye:
- listado de productos;
- búsqueda por id existente;
- búsqueda por id inexistente.
```

---

## 32. Step 3. Request Dockerfile

```text
Crea un Dockerfile para esta API.
Usa Node 22.
Instala dependencias con npm ci.
Expón el puerto 3000.
Ejecuta npm start.
Incluye también un .dockerignore.
```

---

## 33. Step 4. Request workflow

```text
Crea un workflow de GitHub Actions para esta API.
Debe ejecutarse en push y pull_request hacia main.
Debe instalar dependencias, ejecutar tests y construir la imagen Docker.
No debe publicar la imagen.
```

---

## 34. Step 5. Request documentation

```text
Actualiza el README con:
- instalación local;
- ejecución en desarrollo;
- ejecución de tests;
- construcción de imagen Docker;
- endpoints disponibles.
```

---

## 35. Step 6. Request full review

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

# Part 6. Final checklist

## 36. Before accepting API code

Check:

- correct routes;
- correct HTTP methods;
- parameter validation;
- error handling;
- clear answers;
- coherent structure;
- sufficient tests;
- updated documentation.

## 37. Before accepting Dockerfile

Check:

- suitable base image;
- reasonable version;
- correct dependencies;
- `.dockerignore`;
- absence of secrets;
- correct port;
- correct start command;
- reasonable image size.

## 38. Before accepting workflows

Check:

- correct events;
- correct branch;
- runtime version;
- existing commands;
- minimum permissions;
- well used secrets;
- reliable actions;
- understandable logs;
- absence of accidental deployments.

---

## 39. Theme compilation prompts

### API

```text
Crea un endpoint para [recurso].
Usa [framework].
Separa rutas, controladores y servicios.
Incluye manejo básico de errores.
No añadas base de datos.
```

### HTTP Client

```text
Crea una función async que consuma esta API.
Usa fetch.
Controla errores HTTP.
Devuelve solo los campos necesarios.
Incluye un ejemplo de uso.
```

###Docker

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

### Terraform or Bicep

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

### Security in CI/CD

```text
Revisa este workflow desde el punto de vista de seguridad.
Busca secretos expuestos, permisos excesivos, actions no confiables y comandos peligrosos.
```

---

## 40. Summary

In this topic we have seen how to use Copilot in tasks closer to a professional environment:

- APIs;
- integration with external services;
- Docker;
- Docker Compose;
- infrastructure as code;
- GitHub Actions;
- CI/CD;
- security review.

Copilot can greatly speed up the creation of technical files, but these files often have a direct impact on execution, deployment, and security.  
Therefore, they should always be reviewed with special attention.

The general rule is:

> Use Copilot to generate drafts, explanations and proposals; Use your technical judgment to decide what goes into the project.

---

## 41. Recommended documentation

- GitHub Docs—GitHub Actions.
- GitHub Docs — Workflow syntax for GitHub Actions.
- GitHub Docs — Secure use of GitHub Actions.
- Docker Docs — Dockerfile reference.
- Docker Docs — Docker Compose.
-Terraform Docs.
- Microsoft Learn — Bicep.
