# **Tema 7: Enlaces en HTML y navegación entre páginas**

## **1. Introducción**
Los enlaces en HTML permiten conectar páginas web entre sí, facilitando la navegación dentro de un sitio web o hacia otros sitios externos. Se crean con la etiqueta `<a>` y pueden contener distintos atributos para definir su comportamiento.

---

## **2. Creación de enlaces con `<a href="">`**
El atributo `href` dentro de la etiqueta `<a>` define la URL o dirección a la que apunta el enlace.

### **Ejemplo básico de un enlace externo:**
```HTML
<a href="https://www.ejemplo.com">Visita Ejemplo</a>
```
En este caso, al hacer clic en el enlace, el usuario será dirigido al sitio web indicado en `href`.

---

## **3. Atributos importantes en enlaces**

### **3.1. `target="_blank"`**
Este atributo indica que el enlace se abrirá en una nueva pestaña del navegador.
```HTML
<a href="https://www.ejemplo.com" target="_blank">Abrir en nueva pestaña</a>
```

### **3.2. `rel="noopener"` y `rel="noreferrer"`**
Cuando se usa `target="_blank"`, es recomendable agregar `rel="noopener noreferrer"` para mejorar la seguridad y evitar que la página de destino acceda al `window.opener` del sitio de origen.
```HTML
<a href="https://www.ejemplo.com" target="_blank" rel="noopener noreferrer">Abrir con seguridad</a>
```

---

## **4. Enlaces internos y navegación dentro de una misma página**
En un sitio web, podemos enlazar diferentes secciones dentro de la misma página utilizando identificadores (`id`).

### **Ejemplo de navegación interna:**
```HTML
<a href="#seccion1">Ir a la sección 1</a>
<a href="#seccion2">Ir a la sección 2</a>

<h2 id="seccion1">Sección 1</h2>
<p>Contenido de la primera sección.</p>

<h2 id="seccion2">Sección 2</h2>
<p>Contenido de la segunda sección.</p>
```
En este caso, al hacer clic en los enlaces, el navegador desplazará la vista hasta la sección correspondiente.

---

## **5. Enlaces relativos y absolutos**
Existen dos tipos de enlaces en HTML:

### **5.1. Enlace absoluto**
Un enlace absoluto apunta a una URL completa de otro sitio web.
```HTML
<a href="https://www.ejemplo.com">Sitio externo</a>
```

### **5.2. Enlace relativo**
Un enlace relativo apunta a una página dentro del mismo sitio web sin necesidad de incluir el dominio completo.
```HTML
<a href="/contacto.html">Página de contacto</a>
```

---

## **6. Enlaces de correo electrónico y teléfono**
También es posible crear enlaces que abran aplicaciones de correo o llamen a un número de teléfono.

### **6.1. Enlace para enviar un correo electrónico**
```HTML
<a href="mailto:correo@ejemplo.com">Enviar correo</a>
```

### **6.2. Enlace para realizar una llamada**
```HTML
<a href="tel:+123456789">Llamar al 123456789</a>
```

---

## **7. Buenas prácticas al usar enlaces en HTML**
- Utilizar `rel="noopener noreferrer"` cuando se usa `target="_blank"`.
- Preferir enlaces relativos para la navegación dentro del mismo sitio web.
- Usar descripciones claras en los enlaces para mejorar la accesibilidad.
- Evitar el uso excesivo de enlaces en blanco (`#`), ya que pueden confundir a los usuarios.

---

En el próximo tema, exploraremos **las imágenes en HTML**, su sintaxis, atributos y cómo optimizar su uso en una página web.

