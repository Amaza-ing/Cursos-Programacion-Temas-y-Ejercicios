# **Tema 12: Uso de accesibilidad en HTML**

## **1. Introducción**

La accesibilidad en HTML es fundamental para garantizar que todas las personas, incluidas aquellas con discapacidades visuales, auditivas o cognitivas, puedan interactuar con los sitios web de manera efectiva. El uso de etiquetas semánticas y atributos específicos mejora la usabilidad y la experiencia del usuario.

---

## **2. Importancia de la accesibilidad en la web**

- Permite que las personas con discapacidades utilicen tecnologías asistivas como lectores de pantalla.
- Mejora la experiencia de usuario para todos los visitantes.
- Cumple con normativas y estándares de accesibilidad web como WCAG.
- Beneficia el posicionamiento SEO y la estructura del código.

---

## **3. Atributos de accesibilidad en HTML**

### **3.1. Uso de `aria-label`**

El atributo `aria-label` proporciona una descripción accesible de un elemento cuando no hay un texto visible adecuado.

**Ejemplo:**

```html
<button aria-label="Enviar formulario">📩</button>
```

En este caso, un lector de pantalla leerá "Enviar formulario", aunque el botón solo muestra un ícono.

---

### **3.2. Uso de `aria-labelledby`**

Este atributo enlaza un elemento con otro que actúa como su etiqueta.

**Ejemplo:**

```html
<label for="username" id="label-name">Nombre:</label>
<input type="text" id="username" aria-labelledby="label-name" />
```

---

### **3.3. Uso de `aria-describedby`**

Proporciona información adicional sobre un elemento enlazándolo con una descripción.

**Ejemplo:**

```html
<input type="text" id="user" aria-describedby="user-help" />
<p id="user-help">Debe contener al menos 6 caracteres.</p>
```

---

## **4. Buenas prácticas para mejorar la accesibilidad**

### **4.1. Uso correcto de etiquetas semánticas**

Emplear etiquetas como `<header>`, `<nav>`, `<main>`, `<article>` y `<footer>` ayuda a la estructura y comprensión del contenido.

### **4.2. Uso de `alt` en imágenes**

El atributo `alt` es esencial para describir el contenido de las imágenes.

**Ejemplo:**

```html
<img src="paisaje.jpg" alt="Imagen de un paisaje montañoso al atardecer" />
```

### **4.3. Navegación accesible con `tabindex`**

Permite definir el orden de navegación con el teclado.

**Ejemplo:**

```html
<a href="#" tabindex="1">Inicio</a>
<a href="#" tabindex="2">Servicios</a>
<a href="#" tabindex="3">Contacto</a>
```

### **4.4. Uso de `role` para definir elementos**

El atributo `role` proporciona información adicional sobre el propósito de un elemento.

**Ejemplo:**

```html
<nav role="navigation">
  <ul>
    <li><a href="#">Inicio</a></li>
    <li><a href="#">Blog</a></li>
  </ul>
</nav>
```

---

## **5. Consideraciones finales**

- **Evitar el uso exclusivo de colores** para transmitir información.
- **Garantizar suficiente contraste** entre texto y fondo.
- **Probar accesibilidad** con herramientas como Lighthouse o el validador de W3C.

---

En el próximo tema, exploraremos **cómo optimizar el seo y uso correcto de los metadatos**.
