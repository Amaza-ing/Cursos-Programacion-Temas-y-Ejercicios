# Exercises - Topic 09: Copilot with APIs, Docker, infrastructure and GitHub Actions

Below, you'll find hands-on exercises on using Copilot to help with API integration, container creation, infrastructure configuration and automation with GitHub Actions.

## Exercise 1: Create a prompt to consume a REST API

You have to create a JavaScript function that queries a products API at this URL:

```text
https://api.example.com/products
```


The function must:

- Use `fetch`.
- Handle HTTP errors.
- Return an array of products.
- Return an empty array if an error occurs.

Write a suitable prompt to ask Copilot for this function.

<details>
<summary>Show solution</summary>

A suitable prompt would be:

```text
Crea una función JavaScript llamada getProducts que consulte la URL https://api.example.com/products usando fetch.
La función debe ser asíncrona.
Debe comprobar response.ok antes de leer el JSON.
Si la respuesta es correcta, debe devolver un array de productos.
Si ocurre un error de red o una respuesta HTTP incorrecta, debe devolver un array vacío.
Incluye comentarios breves en español solo donde aporten claridad.
```


A possible solution would be:

```javascript
async function getProducts() {
  try {
    const response = await fetch("https://api.example.com/products");

    if (!response.ok) {
      return [];
    }

    const products = await response.json();
    return Array.isArray(products) ? products : [];
  } catch (error) {
    return [];
  }
}
```


The function handles both HTTP errors and network errors. It also checks that the result is actually an array before returning it.

</details>

## Exercise 2: Ask Copilot for an endpoint with Express

You want to create a `GET /products/:id` endpoint in Express. The endpoint must search for a product by its `id` in a local array called `products`.

If the product exists, it must return it with status `200`. If it doesn't exist, it must return a `404` error with a clear message.

Write a suitable prompt for Copilot.

<details>
<summary>Show solution</summary>

A suitable prompt would be:

```text
Crea un endpoint GET /products/:id con Express.
Debe buscar el producto en un array local llamado products comparando product.id con el parámetro id de la URL.
Si el producto existe, debe devolverlo con status 200.
Si no existe, debe devolver status 404 con un JSON que contenga el mensaje "Product not found".
No uses base de datos ni librerías adicionales.
```


A possible solution would be:

```javascript
app.get("/products/:id", (req, res) => {
  const productId = Number(req.params.id);
  const product = products.find((item) => item.id === productId);

  if (!product) {
    return res.status(404).json({ message: "Product not found" });
  }

  return res.status(200).json(product);
});
```


It's important to convert `req.params.id` to a number if the IDs in the array are stored as numbers. If the IDs were strings, `Number()` wouldn't be needed.

</details>

## Exercise 3: Create a Dockerfile with the help of Copilot

You have a simple Node.js application. The main file is `server.js` and the project is run with:

```bash
npm start
```


The application listens on port `3000`.

Write a prompt to ask Copilot to generate a basic `Dockerfile`.

<details>
<summary>Show solution</summary>

A suitable prompt would be:

```text
Genera un Dockerfile básico para una aplicación Node.js.
El archivo principal es server.js.
La aplicación se instala con npm install y se ejecuta con npm start.
Debe exponer el puerto 3000.
Usa una imagen ligera de Node.
No añadas configuraciones avanzadas innecesarias.
```


A possible solution would be:

```dockerfile
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
```


This `Dockerfile` creates a simple image to run the application. It first copies the dependency files, installs the packages and then copies the rest of the project.

</details>

## Exercise 4: Create a docker-compose.yml file

You want to spin up a Node.js API and a PostgreSQL database with Docker Compose.

The API must:

- Be built from the current directory.
- Use port `3000`.
- Receive the `DATABASE_URL` environment variable.

PostgreSQL must:

- Use the `postgres:16` image.
- Have the user `app_user`.
- Have the password `app_password`.
- Create a database called `app_db`.

Write a possible solution for `docker-compose.yml`.

<details>
<summary>Show solution</summary>

A possible solution would be:

```yaml
services:
  api:
    build: .
    ports:
      - "3000:3000"
    environment:
      DATABASE_URL: postgres://app_user:app_password@database:5432/app_db
    depends_on:
      - database

  database:
    image: postgres:16
    environment:
      POSTGRES_USER: app_user
      POSTGRES_PASSWORD: app_password
      POSTGRES_DB: app_db
    ports:
      - "5432:5432"
```


A suitable prompt to ask Copilot for it would be:

```text
Crea un archivo docker-compose.yml para levantar una API Node.js y una base de datos PostgreSQL.
La API debe construirse desde el directorio actual, exponer el puerto 3000 y recibir DATABASE_URL.
La base de datos debe usar postgres:16, usuario app_user, contraseña app_password y base de datos app_db.
Mantén la configuración simple para un entorno de desarrollo.
```

In a real project, passwords shouldn't be left directly in the file if the repository is going to be shared. It would be better to use environment variables or a `.env` file excluded from version control.

</details>

## Exercise 5: Create a GitHub Actions workflow to run tests

You have a Node.js project. You want GitHub Actions to run the tests every time there's a `push` or a `pull request` on the `main` branch.

The project uses:

```bash
npm install
npm test
```


Write a valid workflow.

<details>
<summary>Show solution</summary>

A possible solution would be:

```yaml
name: Run tests

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 20

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```


A suitable prompt to ask Copilot for it would be:

```text
Crea un workflow de GitHub Actions para un proyecto Node.js.
Debe ejecutarse en push y pull request sobre la rama main.
Debe usar ubuntu-latest, instalar dependencias con npm install y ejecutar los tests con npm test.
Usa versiones actuales de las acciones oficiales de checkout y setup-node.
```


This workflow automates the project's basic checks before changes are merged into the main branch.

</details>

## Exercise 6: Review a workflow generated by Copilot

Copilot has generated this workflow:

```yaml
name: Deploy app

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Deploy
        run: curl -X POST https://deploy.example.com?token=123456
```


Point out what problems it has and how you would improve it.

<details>
<summary>Show solution</summary>

Main problems:

1. The token is written directly in the workflow.
2. The repository isn't checked out with `actions/checkout`.
3. There is no install, build or test phase before deployment.
4. The deployment is triggered directly on every `push` to `main`.
5. There is no clear separation between validation and deployment.

An improved version could be:

```yaml
name: Test and deploy app

on:
  push:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 20

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test

  deploy:
    runs-on: ubuntu-latest
    needs: test

    steps:
      - name: Trigger deployment
        run: curl -X POST "https://deploy.example.com?token=${{ secrets.DEPLOY_TOKEN }}"
```


The main improvement is that the token is stored as a GitHub Actions secret and the deployment only runs if the tests have passed first.

</details>

## Exercise 7: Ask for help creating infrastructure as code

You want to ask Copilot for a simple Terraform template to create a resource, but you don't want it to make up service names or advanced settings.

Write a prompt that forces Copilot to ask for clarification if important information is missing.

<details>
<summary>Show solution</summary>

A suitable prompt would be:

```text
Quiero crear una plantilla sencilla de Terraform, pero antes de escribir código necesito que me preguntes cualquier dato imprescindible que falte.
No inventes proveedor cloud, región, nombres de recursos ni credenciales.
Primero dime qué información necesitas para generar una configuración mínima y segura.
Después, cuando tenga esos datos, generaremos el archivo main.tf paso a paso.
```


This prompt is useful because it keeps Copilot from generating made-up or overly generic infrastructure. In infrastructure as code, a wrong configuration can have serious consequences, so it's a good idea to start by asking for clarification.

</details>
