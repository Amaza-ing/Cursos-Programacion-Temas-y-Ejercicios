# **Tema 8: Imágenes en HTML y optimización para la web**

## **1. Introducción**
Las imágenes son una parte esencial del contenido web, ya que enriquecen la experiencia del usuario y mejoran la presentación visual de una página. HTML proporciona la etiqueta `<img>` para insertar imágenes, junto con varios atributos para mejorar su accesibilidad y rendimiento.

---

## **2. Insertar imágenes con `<img>`**
La etiqueta `<img>` permite mostrar imágenes en una página web. Es un elemento de tipo **vacío**, lo que significa que no necesita una etiqueta de cierre.

### **Ejemplo básico:**
```html
<img src="imagen.jpg" alt="Descripción de la imagen">
```

### **Explicación de los atributos:**
- `src`: Define la ruta o URL de la imagen.
- `alt`: Proporciona una descripción alternativa en caso de que la imagen no se cargue o para accesibilidad.

---

## **3. Atributos importantes de `<img>`**

### **3.1. Atributos de tamaño: `width` y `height`**
Estos atributos permiten definir el ancho y la altura de una imagen en píxeles o en porcentajes.

**Ejemplo:**
```html
<img src="imagen.jpg" width="300" height="200" alt="Imagen con tamaño definido">
```

> **Nota:** Es preferible controlar el tamaño con CSS para mayor flexibilidad.

### **3.2. `loading="lazy"` (Carga diferida)**
El atributo `loading="lazy"` permite que las imágenes se carguen solo cuando el usuario se desplaza hasta ellas, mejorando el rendimiento de la página.

**Ejemplo:**
```html
<img src="imagen.jpg" alt="Imagen optimizada" loading="lazy">
```

---

## **4. Uso de imágenes en diferentes formatos**
Dependiendo de la necesidad, podemos usar distintos formatos de imagen en la web:

### **4.1. `.jpg` (JPEG)**
- Formato comúnmente utilizado para fotografías.
- Buena compresión, pero con pérdida de calidad.

### **4.2. `.png`**
- Soporta transparencia.
- Ideal para gráficos con fondos transparentes.
- Archivos más pesados que JPEG.

### **4.3. `.webp`**
- Formato moderno que ofrece mejor compresión y calidad.
- Compatible con la mayoría de navegadores modernos.

### **4.4. `.svg`**
- Formato vectorial, escalable sin pérdida de calidad.
- Ideal para logotipos e íconos.

**Ejemplo de uso de un archivo SVG:**
```html
<img src="logo.svg" alt="Logotipo en formato SVG">
```

---

## **5. Buenas prácticas para la optimización de imágenes**
- **Reducir el tamaño de las imágenes** antes de subirlas a la web.
- Usar **formatos optimizados** como WebP cuando sea posible.
- Aplicar **compresión sin pérdida** con herramientas como TinyPNG o Squoosh.
- Implementar `loading="lazy"` para mejorar el rendimiento en páginas con muchas imágenes.
- Definir correctamente el `alt` para mejorar la accesibilidad y SEO.

---

En el próximo tema, exploraremos **las tablas en HTML**, su estructura y cómo utilizarlas para organizar información en la web.

