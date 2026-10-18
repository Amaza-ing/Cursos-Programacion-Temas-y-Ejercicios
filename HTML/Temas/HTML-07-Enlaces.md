# **Topic 7: Links in HTML and navigation between pages**

## **1. Introduction**

Links in HTML let you connect web pages to each other, making it easy to navigate within a website or to other external sites. They are created with the `<a>` tag and can have different attributes that define their behavior.

---

## **2. Creating links with `<a href="">`**

The `href` attribute within the `<a>` tag defines the URL or address that the link points to.

### **Basic example of an external link:**

```HTML
<a href="https://www.ejemplo.com">Visita Ejemplo</a>
```

In this case, when the user clicks the link, they'll be taken to the website given in `href`.

---

## **3. Important link attributes**

### **3.1. `target="_blank"`**

This attribute indicates that the link will open in a new browser tab.

```HTML
<a href="https://www.ejemplo.com" target="_blank">Abrir en nueva pestaña</a>
```

### **3.2. `rel="noopener"` and `rel="noreferrer"`**

When you use `target="_blank"`, it's recommended to add `rel="noopener noreferrer"` to improve security and prevent the destination page from accessing the source site's `window.opener`.

```HTML
<a href="https://www.ejemplo.com" target="_blank" rel="noopener noreferrer">Abrir con seguridad</a>
```

---

## **4. Internal links and navigation within the same page**

On a website, we can link to different sections within the same page using identifiers (`id`).

### **Example of internal navigation:**

```HTML
<a href="#seccion1">Ir a la sección 1</a>
<a href="#seccion2">Ir a la sección 2</a>

<h2 id="seccion1">Sección 1</h2>
<p>Contenido de la primera sección.</p>

<h2 id="seccion2">Sección 2</h2>
<p>Contenido de la segunda sección.</p>
```

In this case, when you click the links, the browser will scroll to the corresponding section.

---

## **5. Relative and absolute links**

There are two types of links in HTML:

### **5.1. Absolute link**

An absolute link points to the full URL of another website.

```HTML
<a href="https://www.ejemplo.com">Sitio externo</a>
```

### **5.2. Relative link**

A relative link points to a page within the same website without including the full domain.

```HTML
<a href="/contacto.html">Página de contacto</a>
```

---

[![Links and attributes](https://img.youtube.com/vi/8foa_ash-Ws/0.jpg)](https://www.youtube.com/watch?v=8foa_ash-Ws&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **6. Email and phone links**

You can also create links that open an email app or call a phone number.

### **6.1. Link to send an email**

```HTML
<a href="mailto:correo@ejemplo.com">Enviar correo</a>
```

### **6.2. Link to make a call**

```HTML
<a href="tel:+123456789">Llamar al 123456789</a>
```

---

## **7. Good practices when using links in HTML**

- Use `rel="noopener noreferrer"` whenever you use `target="_blank"`.
- Prefer relative links for navigation within the same website.
- Use clear link text to improve accessibility.
- Avoid overusing empty links (`#`), as they can confuse users.

---

In the next topic, we'll explore **images in HTML**: their syntax, their attributes and how to use them efficiently on a web page.
