# **Ejercicios - Temas 4 y 5: Texto y Listas en HTML**

## **Instrucciones:**

A continuación, encontrarás 10 ejercicios prácticos sobre el uso de encabezados, párrafos y listas en HTML. Realiza cada uno de ellos en un editor de código y visualiza los resultados en tu navegador.

Intenta resolverlos antes de consultar la solución.

---

## **Ejercicios sobre encabezados y párrafos**

### **Ejercicio 1: Estructura de un artículo con encabezados**

Crea un documento HTML con una estructura de artículo que incluya un título principal (`h1`), un subtítulo (`h2`), y tres secciones (`h3`). Agrega contenido en párrafos (`p`).

<details><summary>Mostrar solución</summary>

```html
<h1>Título del Artículo</h1>
<h2>Subtítulo del Artículo</h2>

<h3>Primera Sección</h3>
<p>Contenido de la primera sección.</p>

<h3>Segunda Sección</h3>
<p>Contenido de la segunda sección.</p>

<h3>Tercera Sección</h3>
<p>Contenido de la tercera sección.</p>
```

</details>

---

### **Ejercicio 2: Uso correcto de los encabezados**

Analiza el siguiente código y corrige cualquier mal uso de los encabezados:

```html
<h3>Título principal</h3>
<h1>Subtítulo</h1>
<h4>Sección del contenido</h4>
```

Explica por qué los encabezados deben seguir una jerarquía lógica.

<details><summary>Mostrar solución</summary>

**Corrección:**

```html
<h1>Título principal</h1>
<h2>Subtítulo</h2>
<h3>Sección del contenido</h3>
```

**Explicación:** Los encabezados deben seguir una jerarquía lógica, empezando desde `<h1>`, seguido por `<h2>`, `<h3>`, etc. No se debe usar un `<h3>` como título principal, ni un `<h1>` como subtítulo.

</details>

---

### **Ejercicio 3: Uso del salto de línea**

Crea un párrafo en HTML donde uses la etiqueta `<br>` para separar líneas dentro del mismo párrafo sin crear nuevos bloques.

<details><summary>Mostrar solución</summary>

```html
<p>
  Esta es la primera línea.<br />
  Esta es la segunda línea.<br />
  Y esta es la tercera línea.
</p>
```

</details>

---

### **Ejercicio 4: Cita y texto preformateado**

Escribe un documento HTML que incluya un bloque de cita (`<blockquote>`) con una frase famosa y un bloque de código preformateado (`<pre>`) con un fragmento de texto representando un poema o un mensaje de varias líneas.

<details><summary>Mostrar solución</summary>

```html
<blockquote>
  "La educación es el arma más poderosa que puedes usar para cambiar el mundo."
  - Nelson Mandela
</blockquote>

<pre>
Rosas son rojas,
Violetas son azules,
El código es hermoso,
Y tú también.
</pre>
```

</details>

---

## **Ejercicios sobre listas**

### **Ejercicio 5: Lista desordenada de elementos favoritos**

Crea una lista desordenada (`<ul>`) con al menos cinco elementos que representen tus comidas, películas o libros favoritos.

<details><summary>Mostrar solución</summary>

```html
<ul>
  <li>El Señor de los Anillos</li>
  <li>Star Wars</li>
  <li>Harry Potter</li>
</ul>
```

</details>

---

### **Ejercicio 6: Lista ordenada de pasos en un proceso**

Crea una lista ordenada (`<ol>`) que describa los pasos para hacer una receta sencilla (por ejemplo, preparar un café o una ensalada).

<details><summary>Mostrar solución</summary>

```html
<ol>
  <li>Hervir agua.</li>
  <li>Agregar café molido.</li>
  <li>Esperar 5 minutos.</li>
  <li>Colar el café.</li>
  <li>Servir y disfrutar.</li>
</ol>
```

</details>

---

### **Ejercicio 7: Lista anidada de categorías y subcategorías**

Crea una lista anidada en la que haya categorías principales (`<ul>`) y subcategorías (`<li>` con listas internas).
Ejemplo: Lista de géneros musicales y algunos artistas dentro de cada género.

<details><summary>Mostrar solución</summary>

```html
<ul>
  <li>
    Rock
    <ul>
      <li>Queen</li>
      <li>The Beatles</li>
    </ul>
  </li>
  <li>
    Pop
    <ul>
      <li>Taylor Swift</li>
      <li>Ed Sheeran</li>
    </ul>
  </li>
</ul>
```

</details>

---

### **Ejercicio 8: Corrección de una lista mal estructurada**

Corrige el siguiente código para que la estructura de la lista sea válida:

```html
<ol>
  <li>Paso 1</li>
  <ul>
    <li>Detalle adicional</li>
  </ul>
  <li>Paso 2</li>
</ol>
```

Explica qué estaba mal y cómo lo corregiste.

<details><summary>Mostrar solución</summary>

**Corrección:**

```html
<ol>
  <li>
    Paso 1
    <ul>
      <li>Detalle adicional</li>
    </ul>
  </li>
  <li>Paso 2</li>
</ol>
```

**Explicación:** Las listas deben seguir una estructura adecuada, evitando que una `<ul>` esté directamente dentro de un `<ol>` sin estar dentro de un `<li>`.

</details>

---

### **Ejercicio 9: Lista de descripción con términos y definiciones**

Crea una lista de descripción (`<dl>`) donde definas al menos tres términos y sus respectivas explicaciones.

<details><summary>Mostrar solución</summary>

```html
<dl>
  <dt>HTML</dt>
  <dd>Lenguaje de marcado para la creación de páginas web.</dd>

  <dt>CSS</dt>
  <dd>Lenguaje de estilos para dar formato a las páginas web.</dd>

  <dt>JavaScript</dt>
  <dd>Lenguaje de programación para la interactividad en la web.</dd>
</dl>
```

</details>

---

### **Ejercicio 10: Crear una lista combinada**

Crea una estructura de lista que combine listas ordenadas, desordenadas y de descripción dentro de un mismo documento HTML.

<details><summary>Mostrar solución</summary>

```html
<ul>
  <li>
    Lenguajes de Programación
    <ol>
      <li>Python</li>
      <li>JavaScript</li>
      <li>Java</li>
    </ol>
  </li>
  <li>
    Frameworks y Librerías
    <ul>
      <li>React</li>
      <li>Angular</li>
      <li>Vue</li>
    </ul>
  </li>
  <li>
    Términos Claves
    <dl>
      <dt>API</dt>
      <dd>Interfaz de programación de aplicaciones.</dd>
      <dt>DOM</dt>
      <dd>Modelo de objetos del documento.</dd>
    </dl>
  </li>
</ul>
```

</details>
