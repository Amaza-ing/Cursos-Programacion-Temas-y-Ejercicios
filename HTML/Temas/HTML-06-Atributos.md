# **Tema 6: Elementos, etiquetas y atributos en HTML**

## **1. Introducción**

En HTML, la estructura de una página web está compuesta por **elementos**, que se definen mediante **etiquetas** y pueden contener atributos que añaden información o funcionalidad. Comprender estas diferencias es fundamental para escribir código HTML limpio y estructurado.

---

## **2. Diferencia entre elementos y etiquetas**

### **¿Qué es una etiqueta en HTML?**

Una **etiqueta** en HTML es un identificador que define el inicio y/o final de un elemento. Se escriben entre `< >` y pueden ser de apertura, cierre o autoconclusivas.

**Ejemplo:**

```HTML
<p>Este es un párrafo.</p>
```

- `<p>` es una etiqueta de apertura.
- `</p>` es una etiqueta de cierre.
- Todo el contenido dentro de `<p>...</p>` es un **elemento**.

### **¿Qué es un elemento en HTML?**

Un **elemento** en HTML es la combinación de una etiqueta de apertura, su contenido y, en algunos casos, una etiqueta de cierre.

**Ejemplo:**

```HTML
<h1>Título principal</h1>
```

En este caso, `<h1>` y `</h1>` forman un **elemento de encabezado**.

---

## **3. ¿Qué son los atributos en HTML?**

Los atributos proporcionan información adicional sobre un elemento. Se incluyen en la etiqueta de apertura y siguen la sintaxis `nombre="valor"`.

### **Ejemplo de atributos en una imagen:**

```HTML
<img src="imagen.jpg" alt="Descripción de la imagen">
```

En este caso:

- `src` define la fuente de la imagen.
- `alt` proporciona un texto alternativo en caso de que la imagen no se cargue.

---

## **4. Atributos comunes en HTML**

- **lang**: Define el idioma del contenido.

  ```HTML
  <html lang="es">
  ```

- **id**: Asigna un identificador único a un elemento.
  ```HTML
  <p id="intro">Este es un párrafo con un ID.</p>
  ```
- **class**: Permite agrupar varios elementos bajo una misma categoría.
  ```HTML
  <p class="destacado">Texto destacado.</p>
  ```
- **data-\***: Permite almacenar información personalizada.
  ```HTML
  <div data-usuario="123">Perfil del usuario</div>
  ```
- **src**: Especifica la URL de una imagen, video o script.
  ```HTML
  <img src="logo.png" alt="Logo del sitio">
  ```
- **alt**: Texto alternativo para imágenes.
  ```HTML
  <img src="foto.jpg" alt="Fotografía de un paisaje">
  ```
- **href**: Define la URL de un enlace.

  ```HTML
  <a href="https://www.ejemplo.com">Visitar sitio</a>
  ```

- **title**: Muestra un texto emergente al pasar el cursor.
  ```HTML
  <p title="Información adicional">Coloca el cursor aquí.</p>
  ```

---

[![Enlaces y Atributos](https://img.youtube.com/vi/8foa_ash-Ws/0.jpg)](https://www.youtube.com/watch?v=8foa_ash-Ws&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **5. Otros atributos importantes**

### **Atributos en formularios**

- **placeholder**: Texto de referencia en un campo de entrada.
  ```HTML
  <input type="text" placeholder="Escribe tu nombre">
  ```
- **disabled**: Desactiva un campo.
  ```HTML
  <input type="text" disabled>
  ```
- **required**: Hace obligatorio un campo.
  ```HTML
  <input type="email" required>
  ```

### **Atributos en multimedia**

- **controls**: Agrega controles a un audio o video.
  ```HTML
  <video src="video.mp4" controls></video>
  ```
- **autoplay**: Reproduce un contenido automáticamente.
  ```HTML
  <audio src="musica.mp3" autoplay></audio>
  ```

---

## **6. Buenas prácticas al usar atributos en HTML**

- Usa **nombres descriptivos** en los atributos `id` y `class`.
- No repitas **valores de `id`**, ya que deben ser únicos.
- Usa **`alt` en imágenes** para mejorar la accesibilidad.
- Evita **atributos innecesarios** si no aportan valor al código.

---

En el próximo tema, exploraremos **los enlaces en HTML**, su sintaxis, atributos y cómo crear vínculos dentro y fuera de una página web.
