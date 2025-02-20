# **Tema 1: Introducción a Angular y Configuración del Entorno**

## **1. ¿Qué es Angular?**

Angular es un framework de desarrollo web creado por Google, basado en TypeScript. Permite construir aplicaciones web escalables, modulares y mantenibles.

### **Características clave de Angular:**

- Basado en **TypeScript**, un superset de JavaScript.
- Utiliza un sistema de **componentes** para construir interfaces.
- Ofrece **vinculación de datos bidireccional**.
- Soporta **enrutamiento** y **gestión de estado**.
- Cuenta con una arquitectura modular basada en **módulos y servicios**.

---

## **2. Instalación de Angular CLI**

Angular CLI (Command Line Interface) es la herramienta oficial para gestionar proyectos en Angular.

### **Paso 1: Instalar Angular CLI**

Para instalar Angular CLI globalmente en tu sistema, ejecuta el siguiente comando en la terminal:

```sh
npm install -g @angular/cli
```

> Nota: Se requiere tener instalado Node.js y npm. Puedes descargarlo desde [nodejs.org](https://nodejs.org/).

## **3. Verificación de la instalación**

Una vez instalado Angular CLI, verifica que la instalación se haya realizado correctamente ejecutando el siguiente comando en la terminal:

```sh
ng version
```

Este comando mostrará la versión instalada de Angular CLI, junto con otras dependencias del sistema.

---

## **4. Creación de un nuevo proyecto Angular**

Para crear un nuevo proyecto en Angular, usa el siguiente comando:

```sh
ng new my-project
```

### **Opciones del comando:**

- `my-project`: Nombre del proyecto (puedes cambiarlo por el que prefieras).
- Durante la creación, se te preguntará:
  - El tipo de estilos a usar (**CSS, SCSS, SASS, LESS**), puedes seleccionar `CSS` para comenzar.
  - Si deseas incluir **SSR** (elige `No` a no ser que quieras Server Side Rendering).

Este comando generará la estructura base de un proyecto Angular en la carpeta `my-project`.

---

## **5. Levantar el servidor de desarrollo**

Una vez creado el proyecto, navega dentro de la carpeta del proyecto y ejecuta:

```sh
cd my-project
ng serve
```

Esto iniciará un servidor local y podrás acceder a la aplicación en tu navegador en la siguiente dirección:

```
http://localhost:4200/
```

Cada cambio que realices en el código se reflejará automáticamente en el navegador.

---

[![Cómo empezar con Angular](https://img.youtube.com/vi/K8BqmCUqrME/0.jpg)](https://www.youtube.com/watch?v=K8BqmCUqrME&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **6. Estructura de archivos y carpetas en un proyecto Angular**

Un proyecto Angular generado con `ng new` tiene la siguiente estructura de archivos:

```
my-project/
│── node_modules/        # Dependencias del proyecto
│── public/              # Assets del proyecto
│── src/                 # Código fuente del proyecto
│   ├── app/             # Componentes y módulos principales
│   ├── index.html       # Archivo HTML principal
│   ├── main.ts          # Punto de entrada de la aplicación
│   ├── styles.css       # Archivo global de estilos
│── angular.json         # Configuración global de Angular
│── package.json         # Dependencias y scripts del proyecto
│── tsconfig.json        # Configuración de TypeScript
│── Otros ficheros       # Otros ficheros de configuración
```

### **Explicación breve de los archivos clave:**

- **`src/app/`**: Contiene los componentes, módulos y servicios de la aplicación.
- **`main.ts`**: Archivo de arranque de la aplicación.
- **`index.html`**: Página principal donde se monta la aplicación Angular.
- **`styles.css`**: Archivo global de estilos.
- **`angular.json`**: Archivo de configuración del proyecto Angular.

---

[![Estructura de Ficheros y Carpetas](https://img.youtube.com/vi/jwCiqmOKKKo/0.jpg)](https://www.youtube.com/watch?v=jwCiqmOKKKo&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **7. Extensión Angular Language Service**

Añade la extensión Angular Language Service en Visual Studio Code para desarrollar aplicaciones en Angular con más facilidad.

---

[![Extensión Angular Language Service](https://img.youtube.com/vi/llHGjwLP7-4/0.jpg)](https://www.youtube.com/watch?v=llHGjwLP7-4&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## Comandos importantes

Instalar Angular

```sh
npm install -g @angular/cli
```

Creación de nuevo proyecto

```sh
ng new my-project
```

Levantar el proyecto

```sh
ng serve
```

---

En el próximo tema, exploraremos en profundidad los **componentes en Angular** y cómo estructurar nuestra aplicación correctamente.
