# **Topic 7: Links in HTML and navigation between pages**

## **1. Introduction**

HTML links allow you to connect web pages to each other, facilitating navigation within a website or to other external sites. They are created with the `<a>` tag and can contain different attributes to define their behavior.

---

## **2. Creating links with `<a href="">`**

The `href` attribute within the `<a>` tag defines the URL or address that the link points to.

### **Basic example of an external link:**

```HTML
<a href="https://www.ejemplo.com">Visita Ejemplo</a>
```

In this case, by clicking on the link, the user will be directed to the website indicated in `href`.

---

## **3. Important attributes in links**

### **3.1. `target="_blank"`**

This attribute indicates that the link will open in a new browser tab.

```HTML
<a href="https://www.ejemplo.com" target="_blank">Abrir en nueva pestaña</a>
```

### **3.2. `rel="noopener"` and `rel="noreferrer"`**

When using `target="_blank"`, it is recommended to add `rel="noopener noreferrer"` to improve security and prevent the destination page from accessing the `window.opener` of the source site.

```HTML
<a href="https://www.ejemplo.com" target="_blank" rel="noopener noreferrer">Abrir con seguridad</a>
```

---

## **4. Internal links and navigation within the same page**

On a website, we can link different sections within the same page using identifiers (`id`).

### **Internal navigation example:**

```HTML
<a href="#seccion1">Ir a la sección 1</a>
<a href="#seccion2">Ir a la sección 2</a>

<h2 id="seccion1">Sección 1</h2>
<p>Contenido de la primera sección.</p>

<h2 id="seccion2">Sección 2</h2>
<p>Contenido de la segunda sección.</p>
```

In this case, when you click on the links, the browser will scroll to the corresponding section.

---

## **5. Relative and absolute links**

There are two types of links in HTML:

### **5.1. Absolute link**

An absolute link points to a full URL of another website.

```HTML
<a href="https://www.ejemplo.com">Sitio externo</a>
```

### **5.2. Relative link**

A relative link points to a page within the same website without including the full domain.

```HTML
<a href="/contacto.html">Página de contacto</a>
```

---

[![Links and Attributes](https://img.youtube.com/vi/8foa_ash-Ws/0.jpg)](https://www.youtube.com/watch?v=8foa_ash-Ws&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **6. Email and phone links**

It is also possible to create links that open email applications or call a phone number.

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

- Use `rel="noopener noreferrer"` when using `target="_blank"`.
- Prefer relative links for navigation within the same website.
- Use clear descriptions on links to improve accessibility.
- Avoid excessive use of blank links (`#`), as they can confuse users.

---

In the next topic, we will explore HTML images, their syntax, attributes, and how to optimize their use on a web page.
