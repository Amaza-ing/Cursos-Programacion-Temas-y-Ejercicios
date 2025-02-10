# **Tema 2: Estructura básica de un documento HTML**

## **1. Introducción**
Un documento HTML tiene una estructura fundamental que todos los archivos deben seguir. Esta estructura está compuesta por diversas etiquetas que organizan el contenido y definen su comportamiento dentro de un navegador web.

### **Importancia de una estructura ordenada:**
- Facilita la comprensión del documento.
- Mejora la accesibilidad y la usabilidad.
- Permite una mejor interpretación por los navegadores y motores de búsqueda.

---

## **2. Componentes principales de un documento HTML**
Todo documento HTML está compuesto por las siguientes secciones:

1. **Declaración del tipo de documento (`DOCTYPE`)**
2. **Elemento `<html>`** (Contenedor principal de la página)
3. **Sección `<head>`** (Metadatos e importaciones)
4. **Sección `<body>`** (Contenido visible en la página)

### **Ejemplo de estructura básica:**
```
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi primer documento HTML</title>
</head>
<body>
    <h1>Bienvenido a mi página</h1>
    <p>Este es un párrafo de ejemplo.</p>
</body>
</html>
```

---

## **3. Explicación de las etiquetas principales**

### **1. `<!DOCTYPE html>`**
- Indica al navegador que el documento está escrito en HTML5.
- No es una etiqueta propiamente dicha, sino una instrucción para el navegador.

### **2. `<html>`**
- Contiene todo el código HTML de la página.
- Es la etiqueta raíz de cualquier documento HTML.

### **3. `<head>`**
- Contiene información sobre el documento.
- Puede incluir:
  - Metadatos (`<meta>`)
  - Título de la página (`<title>`)
  - Enlaces a hojas de estilo (`<link>`)
  - Scripts (`<script>`)

### **4. `<body>`**
- Contiene todo el contenido visible en la página.
- Puede incluir:
  - Encabezados (`<h1>` a `<h6>`)
  - Párrafos (`<p>`)
  - Imágenes (`<img>`)
  - Enlaces (`<a>`)
  - Listas (`<ul>`, `<ol>`, `<li>`)
  - Tablas (`<table>`)
  - Formularios (`<form>`)

---

## **4. Importancia de los metadatos en el `<head>`**
Los metadatos ayudan a mejorar el rendimiento, la accesibilidad y el posicionamiento en buscadores (**SEO**).

### **Metadatos comunes:**
- `<meta charset="UTF-8">` → Define la codificación de caracteres.
- `<meta name="viewport" content="width=device-width, initial-scale=1.0">` → Optimiza la página para dispositivos móviles.
- `<meta name="description" content="Descripción de la página">` → Mejora el posicionamiento en buscadores.

---

## **5. Buenas prácticas en la estructuración HTML**
- **Usar una estructura clara y semántica.**
- **Cerrar correctamente todas las etiquetas.**
- **Evitar el uso excesivo de `<div>` cuando hay etiquetas semánticas disponibles.**
- **Incluir metadatos básicos para compatibilidad y SEO.**
- **Mantener el código limpio y comentado cuando sea necesario.**

---

## **6. Creación de un archivo HTML**
Para crear un archivo HTML en tu computadora:
1. Abre un editor de texto (Visual Studio Code, Notepad++, Sublime Text).
2. Guarda el archivo con la extensión `.html` (Ejemplo: `index.html`).
3. Escribe la estructura básica de HTML.
4. Abre el archivo en un navegador web para visualizarlo.

---

En el próximo tema, aprenderemos sobre **Elementos, etiquetas y atributos en HTML**, fundamentales para el desarrollo web.

