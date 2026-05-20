# Ejercicios - Tema 09: Copilot con APIs, Docker, infraestructura y GitHub Actions

A continuación, encontrarás ejercicios prácticos para usar Copilot como apoyo en integración con APIs, creación de contenedores, configuración de infraestructura y automatización con GitHub Actions.

## Ejercicio 1: Crear un prompt para consumir una API REST

Tienes que crear una función JavaScript que consulte una API de productos en esta URL:

```text
https://api.example.com/products
```

La función debe:

- Usar `fetch`.
- Controlar errores HTTP.
- Devolver un array de productos.
- Devolver un array vacío si ocurre un error.

Escribe un prompt adecuado para pedir esta función a Copilot.

<details>
<summary>Mostrar solución</summary>

Un prompt adecuado sería:

```text
Crea una función JavaScript llamada getProducts que consulte la URL https://api.example.com/products usando fetch.
La función debe ser asíncrona.
Debe comprobar response.ok antes de leer el JSON.
Si la respuesta es correcta, debe devolver un array de productos.
Si ocurre un error de red o una respuesta HTTP incorrecta, debe devolver un array vacío.
Incluye comentarios breves en español solo donde aporten claridad.
```

Una posible solución sería:

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

La función controla tanto errores HTTP como errores de red. Además, comprueba que el resultado sea realmente un array antes de devolverlo.

</details>

## Ejercicio 2: Pedir a Copilot un endpoint con Express

Quieres crear un endpoint `GET /products/:id` en Express. El endpoint debe buscar un producto por su `id` en un array local llamado `products`.

Si el producto existe, debe devolverlo con estado `200`. Si no existe, debe devolver un error `404` con un mensaje claro.

Escribe un prompt adecuado para Copilot.

<details>
<summary>Mostrar solución</summary>

Un prompt adecuado sería:

```text
Crea un endpoint GET /products/:id con Express.
Debe buscar el producto en un array local llamado products comparando product.id con el parámetro id de la URL.
Si el producto existe, debe devolverlo con status 200.
Si no existe, debe devolver status 404 con un JSON que contenga el mensaje "Product not found".
No uses base de datos ni librerías adicionales.
```

Una posible solución sería:

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

Es importante convertir `req.params.id` a número si los identificadores del array están guardados como números. Si los identificadores fueran strings, no haría falta `Number()`.

</details>

## Ejercicio 3: Crear un Dockerfile con ayuda de Copilot

Tienes una aplicación Node.js sencilla. El archivo principal es `server.js` y el proyecto se ejecuta con:

```bash
npm start
```

La aplicación escucha en el puerto `3000`.

Escribe un prompt para pedir a Copilot que genere un `Dockerfile` básico.

<details>
<summary>Mostrar solución</summary>

Un prompt adecuado sería:

```text
Genera un Dockerfile básico para una aplicación Node.js.
El archivo principal es server.js.
La aplicación se instala con npm install y se ejecuta con npm start.
Debe exponer el puerto 3000.
Usa una imagen ligera de Node.
No añadas configuraciones avanzadas innecesarias.
```

Una posible solución sería:

```dockerfile
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
```

Este `Dockerfile` crea una imagen sencilla para ejecutar la aplicación. Primero copia los archivos de dependencias, instala los paquetes y después copia el resto del proyecto.

</details>

## Ejercicio 4: Crear un archivo docker-compose.yml

Quieres levantar una API Node.js y una base de datos PostgreSQL con Docker Compose.

La API debe:

- Construirse desde el directorio actual.
- Usar el puerto `3000`.
- Recibir la variable de entorno `DATABASE_URL`.

PostgreSQL debe:

- Usar la imagen `postgres:16`.
- Tener usuario `app_user`.
- Tener contraseña `app_password`.
- Crear una base de datos llamada `app_db`.

Escribe una posible solución de `docker-compose.yml`.

<details>
<summary>Mostrar solución</summary>

Una posible solución sería:

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

Un prompt adecuado para pedirlo a Copilot sería:

```text
Crea un archivo docker-compose.yml para levantar una API Node.js y una base de datos PostgreSQL.
La API debe construirse desde el directorio actual, exponer el puerto 3000 y recibir DATABASE_URL.
La base de datos debe usar postgres:16, usuario app_user, contraseña app_password y base de datos app_db.
Mantén la configuración simple para un entorno de desarrollo.
```

En un proyecto real, las contraseñas no deberían dejarse directamente en el archivo si se va a compartir el repositorio. Sería mejor usar variables de entorno o un archivo `.env` excluido del control de versiones.

</details>

## Ejercicio 5: Crear un workflow de GitHub Actions para ejecutar tests

Tienes un proyecto Node.js. Quieres que GitHub Actions ejecute los tests cada vez que se haga `push` o `pull request` sobre la rama `main`.

El proyecto usa:

```bash
npm install
npm test
```

Escribe un workflow válido.

<details>
<summary>Mostrar solución</summary>

Una posible solución sería:

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

Un prompt adecuado para pedirlo a Copilot sería:

```text
Crea un workflow de GitHub Actions para un proyecto Node.js.
Debe ejecutarse en push y pull request sobre la rama main.
Debe usar ubuntu-latest, instalar dependencias con npm install y ejecutar los tests con npm test.
Usa versiones actuales de las acciones oficiales de checkout y setup-node.
```

Este workflow automatiza la comprobación básica del proyecto antes de integrar cambios en la rama principal.

</details>

## Ejercicio 6: Revisar un workflow generado por Copilot

Copilot ha generado este workflow:

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

Indica qué problemas tiene y cómo lo mejorarías.

<details>
<summary>Mostrar solución</summary>

Problemas principales:

1. El token aparece escrito directamente en el workflow.
2. No se descarga el repositorio con `actions/checkout`.
3. No hay fase de instalación, build o tests antes del despliegue.
4. El despliegue se lanza directamente en cada `push` a `main`.
5. No hay separación clara entre validación y despliegue.

Una versión mejorada podría ser:

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

La mejora principal es que el token se guarda como secreto de GitHub Actions y el despliegue solo se ejecuta si antes han pasado los tests.

</details>

## Ejercicio 7: Pedir ayuda para crear infraestructura como código

Quieres pedir a Copilot una plantilla sencilla de Terraform para crear un recurso, pero no quieres que invente nombres de servicios ni configuraciones avanzadas.

Escribe un prompt que obligue a Copilot a pedir aclaraciones si falta información importante.

<details>
<summary>Mostrar solución</summary>

Un prompt adecuado sería:

```text
Quiero crear una plantilla sencilla de Terraform, pero antes de escribir código necesito que me preguntes cualquier dato imprescindible que falte.
No inventes proveedor cloud, región, nombres de recursos ni credenciales.
Primero dime qué información necesitas para generar una configuración mínima y segura.
Después, cuando tenga esos datos, generaremos el archivo main.tf paso a paso.
```

Este prompt es útil porque evita que Copilot genere infraestructura inventada o demasiado genérica. En infraestructura como código, una configuración incorrecta puede tener consecuencias importantes, por lo que conviene empezar pidiendo aclaraciones.

</details>
