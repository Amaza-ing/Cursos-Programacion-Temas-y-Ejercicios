# **Tema 4: Encabezados, párrafos y texto en HTML**

## **1. Introducción**

El texto es uno de los elementos más importantes en cualquier página web. HTML proporciona varias etiquetas para estructurar el contenido textual de manera adecuada. En este tema, exploraremos los encabezados, párrafos y otros elementos relacionados con el texto en HTML.

---

## **2. Encabezados en HTML**

Los encabezados (`h1` a `h6`) se utilizan para definir títulos y subtítulos en una página web. Son elementos en bloque y juegan un papel fundamental en la jerarquía del contenido.

### **Ejemplo de uso de encabezados:**

```HTML
<h1>Título Principal</h1>
<h2>Subtítulo Nivel 2</h2>
<h3>Subtítulo Nivel 3</h3>
<h4>Subtítulo Nivel 4</h4>
<h5>Subtítulo Nivel 5</h5>
<h6>Subtítulo Nivel 6</h6>
```

### **Características de los encabezados:**

- `h1` es el título principal de la página y debe utilizarse solo una vez.
- `h2` a `h6` representan subtítulos con menor importancia.
- Mejoran la accesibilidad y el SEO (optimización en motores de búsqueda).

---

## **3. Párrafos y saltos de línea**

El texto dentro de una página web se agrupa en párrafos usando la etiqueta `<p>`. Si se necesita un salto de línea sin iniciar un nuevo párrafo, se usa `<br>`.

### **Ejemplo de párrafos y saltos de línea:**

```HTML
<p>Este es un párrafo de ejemplo. Se usa para organizar el texto en bloques.</p>
<p>Este es otro párrafo. <br> Aquí se usa un salto de línea dentro del mismo párrafo.</p>
```

### **Características:**

- `<p>` genera un nuevo bloque de texto.
- `<br>` no genera un nuevo bloque, solo un salto de línea dentro del mismo texto.

---

## **4. Otros elementos en bloque relacionados con texto**

Además de los encabezados y párrafos, existen otros elementos en bloque útiles para estructurar contenido textual:

### **Bloques de cita (`<blockquote>`)**

Se utiliza para resaltar citas largas de texto.

```HTML
<blockquote>
    "La educación es el arma más poderosa que puedes usar para cambiar el mundo." - Nelson Mandela
</blockquote>
```

### **Preformateado (`<pre>`)**

Muestra texto con formato predefinido, respetando espacios y saltos de línea.

```HTML
<pre>
Texto con espacios y saltos de línea
    exactamente como fue escrito.
</pre>
```

### **Divisiones de contenido (`<div>`)**

Se usa para agrupar contenido en bloques sin un significado semántico específico.

```HTML
<div>
    <h2>Sección de Noticias</h2>
    <p>Últimas actualizaciones sobre tecnología y ciencia.</p>
</div>
```

---

[![Texto y Elementos en Linea y en Bloque](https://img.youtube.com/vi/KBw2fd5BbCU/0.jpg)](https://www.youtube.com/watch?v=KBw2fd5BbCU&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **5. Buenas prácticas al trabajar con texto en HTML**

- Utilizar **encabezados correctamente** para jerarquizar la información.
- No abusar de los **saltos de línea (`<br>`)**, es mejor usar párrafos cuando sea necesario.
- Usar **etiquetas semánticas** como `<blockquote>` y `<pre>` en lugar de `<div>` cuando el contenido lo requiera.
- Mantener una estructura clara y ordenada en el código.

---

En el próximo tema, exploraremos **las listas en HTML**, tanto ordenadas como desordenadas, y su importancia en la organización de la información en una página web.
