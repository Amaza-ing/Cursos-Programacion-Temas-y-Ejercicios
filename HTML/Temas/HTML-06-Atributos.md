# **Topic 6: Elements, tags and attributes in HTML**

## **1. Introduction**

In HTML, the structure of a web page is made up of **elements**, which are defined by **tags** and may contain attributes that add information or functionality. Understanding these differences is essential for writing clean and structured HTML code.

---

## **2. Difference between elements and labels**

### **What is a tag in HTML?**

A **tag** in HTML is an identifier that defines the start and/or end of an element. They are written between `< >` and can be opening, closing or self-concluding.

**Example:**

```HTML
<p>Este es un párrafo.</p>
```


- `<p>` is an opening tag.
- `</p>` is a closing tag.
- All content within `<p>...</p>` is an **item**.

### **What is an element in HTML?**

An **element** in HTML is the combination of an opening tag, its content, and, in some cases, a closing tag.

**Example:**

```HTML
<h1>Título principal</h1>
```


In this case, `<h1>` and `</h1>` form a **header element**.

---

## **3. What are attributes in HTML?**

Attributes provide additional information about an element. They are included in the opening tag and follow the `nombre="valor"` syntax.

### **Example of attributes in an image:**

```HTML
<img src="imagen.jpg" alt="Descripción de la imagen">
```


In this case:

- `src` defines the source of the image.
- `alt` provides alternative text in case the image fails to load.

---

## **4. Common attributes in HTML**

- **lang**: Defines the language of the content.

  ```HTML
  <html lang="es">
  ```


- **id**: Assigns a unique identifier to an element.
  ```HTML
  <p id="intro">Este es un párrafo con un ID.</p>
  ```

- **class**: Allows you to group several elements under the same category.
  ```HTML
  <p class="destacado">Texto destacado.</p>
  ```

- **data-\***: Allows you to store personalized information.
  ```HTML
  <div data-usuario="123">Perfil del usuario</div>
  ```

- **src**: Specifies the URL of an image, video or script.
  ```HTML
  <img src="logo.png" alt="Logo del sitio">
  ```

- **alt**: Alternative text for images.
  ```HTML
  <img src="foto.jpg" alt="Fotografía de un paisaje">
  ```

- **href**: Defines the URL of a link.

  ```HTML
  <a href="https://www.ejemplo.com">Visitar sitio</a>
  ```


- **title**: Shows a pop-up text on hover.
  ```HTML
  <p title="Información adicional">Coloca el cursor aquí.</p>
  ```


---

[![Links and Attributes](https://img.youtube.com/vi/8foa_ash-Ws/0.jpg)](https://www.youtube.com/watch?v=8foa_ash-Ws&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **5. Other important attributes**

### **Attributes in forms**

- **placeholder**: Reference text in an input field.
  ```HTML
  <input type="text" placeholder="Escribe tu nombre">
  ```

- **disabled**: Disables a field.
  ```HTML
  <input type="text" disabled>
  ```

- **required**: Makes a field mandatory.
  ```HTML
  <input type="email" required>
  ```


### **Attributes in multimedia**

- **controls**: Add controls to an audio or video.
  ```HTML
  <video src="video.mp4" controls></video>
  ```

- **autoplay**: Play content automatically.
  ```HTML
  <audio src="musica.mp3" autoplay></audio>
  ```


---

## **6. Good practices when using attributes in HTML**

- Use **friendly names** on the `id` and `class` attributes.
- Do not repeat **`id` values**, as they must be unique.
- Use **`alt` on images** to improve accessibility.
- Avoid **unnecessary attributes** if they do not add value to the code.

---

In the next topic, we will explore **links in HTML**, their syntax, attributes, and how to create links inside and outside of a web page.
