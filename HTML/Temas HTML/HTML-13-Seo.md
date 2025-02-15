# **Tema 13: Metadatos en HTML y SEO básico**

## **1. Introducción**
Los metadatos en HTML proporcionan información sobre una página web a los navegadores y motores de búsqueda. Su correcta configuración mejora la indexación, accesibilidad y visibilidad del sitio en plataformas como Google y redes sociales.

---

## **2. Uso de `<meta>` para mejorar la indexación**
La etiqueta `<meta>` se usa en la sección `<head>` para definir información clave sobre la página.

### **Ejemplo básico de metadatos en HTML:**
```html
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="robots" content="index, follow">
</head>
```

### **Explicación:**
- `charset="UTF-8"`: Define la codificación de caracteres.
- `viewport`: Ajusta la visualización en dispositivos móviles.
- `robots`: Indica si los motores de búsqueda pueden indexar la página y seguir enlaces.

---

## **3. Configuración del título y descripción**
El título y la descripción de una página influyen en la presentación en los resultados de búsqueda.

### **3.1. Configuración del `<title>`**
El título de la página es crucial para el SEO y debe ser breve y descriptivo.
```html
<title>Guía Completa sobre Metadatos en HTML</title>
```

### **3.2. Meta descripción (`<meta name="description">`)**
La descripción influye en el CTR (Click-Through Rate) en los resultados de búsqueda.
```html
<meta name="description" content="Aprende cómo usar metadatos en HTML para mejorar el SEO y la visibilidad de tu sitio web." />
```

**Buenas prácticas:**
- El título debe tener entre 50-60 caracteres.
- La meta descripción debe estar entre 150-160 caracteres.

---

## **4. Open Graph: Mejorando la vista previa en redes sociales**
Open Graph (OG) es un estándar de metadatos usado por Facebook, Twitter y otras redes para mejorar la apariencia de las vistas previas cuando se comparte un enlace.

### **Ejemplo de configuración de Open Graph:**
```html
<meta property="og:title" content="Guía Completa sobre Metadatos en HTML" />
<meta property="og:description" content="Descubre cómo optimizar tu web con metadatos y mejorar su indexación en buscadores." />
<meta property="og:image" content="https://ejemplo.com/imagen.jpg" />
<meta property="og:url" content="https://ejemplo.com/articulo-metadatos" />
<meta property="og:type" content="website" />
```

### **Explicación:**
- `og:title`: Define el título que aparecerá en redes sociales.
- `og:description`: Resumen del contenido.
- `og:image`: Imagen de vista previa.
- `og:url`: URL de la página compartida.
- `og:type`: Tipo de contenido (`website`, `article`, `video`, etc.).

---

## **5. Buenas prácticas en SEO básico con metadatos**
- Usa **meta descripciones únicas y atractivas** para cada página.
- Asegúrate de que el título incluya **palabras clave relevantes**.
- Configura correctamente **Open Graph** para mejorar la apariencia en redes sociales.
- Utiliza **meta etiquetas de indexación** para controlar qué páginas pueden ser rastreadas por los motores de búsqueda.
- Aprovecha **Google Search Console** para monitorear la indexación y optimización de tu sitio.
