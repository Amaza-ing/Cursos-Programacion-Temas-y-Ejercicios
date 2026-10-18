# **Topic 12: Use of accessibility in HTML**

## **1. Introduction**

Accessibility in HTML is essential to ensure that all people, including those with visual, hearing or cognitive disabilities, can interact with websites effectively. The use of semantic tags and specific attributes improves usability and user experience.

---

## **2. Importance of accessibility on the web**

- Allows people with disabilities to use assistive technologies such as screen readers.
- Improve the user experience for all visitors.
- Complies with web accessibility regulations and standards such as WCAG.
- Benefits SEO positioning and code structure.

---

## **3. Accessibility attributes in HTML**

### **3.1. Using `aria-label`**

The `aria-label` attribute provides an accessible description of an element when there is no suitable visible text.

**Example:**

```html
<button aria-label="Enviar formulario">📩</button>
```

In this case, a screen reader will read "Submit Form," even though the button only displays an icon.

---

### **3.2. Using `aria-labelledby`**

This attribute links one element to another that acts as its tag.

**Example:**

```html
<label for="username" id="label-name">Nombre:</label>
<input type="text" id="username" aria-labelledby="label-name" />
```

---

### **3.3. Using `aria-describedby`**

Provides additional information about an item by linking it to a description.

**Example:**

```html
<input type="text" id="user" aria-describedby="user-help" />
<p id="user-help">Debe contener al menos 6 caracteres.</p>
```

---

## **4. Good practices to improve accessibility**

### **4.1. Correct use of semantic tags**

Using tags such as `<header>`, `<nav>`, `<main>`, `<article>` and `<footer>` helps with the structure and understanding of the content.

### **4.2. Using `alt` in images**

The `alt` attribute is essential to describe the content of images.

**Example:**

```html
<img src="paisaje.jpg" alt="Imagen de un paisaje montañoso al atardecer" />
```

### **4.3. Accessible navigation with `tabindex`**

Allows you to define the order of navigation with the keyboard.

**Example:**

```html
<a href="#" tabindex="1">Inicio</a>
<a href="#" tabindex="2">Servicios</a>
<a href="#" tabindex="3">Contacto</a>
```

### **4.4. Using `role` to define elements**

The `role` attribute provides additional information about the purpose of an element.

**Example:**

```html
<nav role="navigation">
  <ul>
    <li><a href="#">Inicio</a></li>
    <li><a href="#">Blog</a></li>
  </ul>
</nav>
```

---

[![Accessibility & Lighthouse](https://img.youtube.com/vi/z8KEdAktCQQ/0.jpg)](https://www.youtube.com/watch?v=z8KEdAktCQQ&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **5. Final considerations**

- **Avoid the exclusive use of colors** to transmit information.
- **Ensure sufficient contrast** between text and background.
- **Test accessibility** with tools like Lighthouse or the W3C validator.

---

In the next topic, we will explore **how to optimize SEO and correct use of metadata**.
