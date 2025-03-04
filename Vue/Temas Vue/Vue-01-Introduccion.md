# **Tema 1: Introducción a Vue.js y Configuración del Entorno con Vite**

## **1. ¿Qué es Vue.js?**

Vue.js es un **framework progresivo** para la construcción de interfaces de usuario. Fue creado por **Evan You** y destaca por su:

- **Simplicidad y curva de aprendizaje suave**.
- **Enfoque basado en componentes reutilizables**.
- **Reactividad declarativa** que actualiza la interfaz automáticamente.
- **Flexibilidad** para integrarse en proyectos nuevos o existentes.
- **Ligereza** en tamaño y rapidez en ejecución.

---

## **2. Instalación de Node.js**

Vue requiere Node.js para gestionar dependencias y ejecutar scripts. Descarga Node.js desde [nodejs.org](https://nodejs.org/).

Para verificar la instalación:

```sh
node -v
npm -v
```

---

## **3. Crear un nuevo proyecto Vue con Vite**

**Vite** es un gestor de proyectos. Vue recomienda utilizar **Vite** como herramienta de desarrollo por su rapidez y configuración sencilla.

Para crear un nuevo proyecto Vue con Vite, ejecuta:

```sh
npm create vue@latest
```

### Proceso de Creación

1. El asistente te preguntará el nombre del proyecto. Por ejemplo:

```
Project name: my-vue-project
```

2. Selecciona las funcionalidades opcionales (pinia, router, testing, etc.) o deja las opciones por defecto para comenzar.

3. Accede al directorio del proyecto:

- Mediante terminal:

```sh
cd my-vue-project
```

- O moviéndote diréctamente a la carpeta: file -> open folder -> my-vue-project

4. Instala las dependencias:

```sh
npm install
```

---

## **4. Estructura de carpetas de un proyecto Vue con Vite**

Un proyecto Vue creado con Vite tendrá esta estructura:

```
my-vue-project/
│── node_modules/        # Dependencias
│── public/              # Recursos estáticos
│── src/                 # Código fuente
│   ├── assets/          # Imágenes y otros assets
│   ├── components/      # Componentes reutilizables
│   ├── App.vue          # Componente principal
│   └── main.js          # Punto de entrada
│── git.ignore           # Ignora ficheros en el repositorio
│── index.html           # HTML del proyecto
│── package.json         # Configuración del proyecto
│── README.md            # Documentación inicial
│── vite.config.js       # Configuración de Vite
```

---

## **5. Levantar el servidor de desarrollo**

Para iniciar el servidor de desarrollo, ejecuta:

```sh
npm run dev
```

La aplicación estará disponible en:

```
http://localhost:5173/
```

---

## **6. Composición básica de un componente en Vue**

Vue utiliza un formato llamado **Single File Component (SFC)**, que combina lógica (JavaScript), template (HTML) y estilos (CSS) en un solo archivo `.vue`.

Ejemplo:

```vue
<script setup>
let message = "Hola desde Vue!";
</script>

<template>
  <p>{{ message }}</p>
</template>

<style scoped>
p {
  color: green;
}
</style>
```

---

## **7. Extensiones recomendadas para Visual Studio Code**

Para mejorar la experiencia de desarrollo, instala las siguientes extensiones:

- **Vue - Official**: Extensión oficial para Vue 3.
- **ESLint**: Para validar la calidad del código.
- **Prettier**: Formateador de código.

> Nota: La extensión Vue - Official es especialmente importante para que los ficheros .vue se visualicen correctamente.

---

[![Cómo empezar con Vue.js](https://img.youtube.com/vi/PqJeA7p2R-Y/0.jpg)](https://www.youtube.com/watch?v=PqJeA7p2R-Y&list=PLzA2VyZwsq_92Fnb4JEUnXUhSYfNHtcKx)

---

## Comandos importantes

Crear proyecto Vue con Vite:

```sh
npm create vue@latest
```

Acceder al proyecto e instalar dependencias:

```sh
cd my-vue-project
npm install
```

Levantar servidor de desarrollo:

```sh
npm run dev
```

---

En el siguiente tema exploraremos **los componentes en Vue.js**.
