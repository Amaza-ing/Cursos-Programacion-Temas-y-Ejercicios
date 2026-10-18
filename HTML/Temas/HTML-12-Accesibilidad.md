# **Topic 12: Applying accessibility in HTML**

## **1. Introduction**

Accessibility in HTML is essential to ensure that everyone, including people with visual, hearing or cognitive disabilities, can interact with websites effectively. Using semantic tags and specific attributes improves usability and the user experience.

---

## **2. Why accessibility matters on the web**

- It lets people with disabilities use assistive technologies such as screen readers.
- It improves the user experience for all visitors.
- It complies with web accessibility regulations and standards such as WCAG.
- It benefits SEO ranking and code structure.

---

## **3. Accessibility attributes in HTML**

### **3.1. Using `aria-label`**

The `aria-label` attribute provides an accessible description of an element when there is no suitable visible text.

**Example:**

```html
<button aria-label="Enviar formulario">📩</button>
```

In this case, a screen reader will read "Enviar formulario" ("Submit form"), even though the button only displays an icon.

---

### **3.2. Using `aria-labelledby`**

This attribute links an element to another one that acts as its label.

**Example:**

```html
<label for="username" id="label-name">Nombre:</label>
<input type="text" id="username" aria-labelledby="label-name" />
```

---

### **3.3. Using `aria-describedby`**

Provides additional information about an element by linking it to a description.

**Example:**

```html
<input type="text" id="user" aria-describedby="user-help" />
<p id="user-help">Debe contener al menos 6 caracteres.</p>
```

---

## **4. Good practices to improve accessibility**

### **4.1. Using semantic tags correctly**

Using tags such as `<header>`, `<nav>`, `<main>`, `<article>` and `<footer>` helps structure the content and makes it easier to understand.

### **4.2. Using `alt` on images**

The `alt` attribute is essential for describing the content of images.

**Example:**

```html
<img src="paisaje.jpg" alt="Imagen de un paisaje montañoso al atardecer" />
```

### **4.3. Accessible navigation with `tabindex`**

Lets you define the keyboard navigation order.

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

- **Don't rely on color alone** to convey information.
- **Ensure sufficient contrast** between text and background.
- **Test accessibility** with tools like Lighthouse or the W3C validator.

---

In the next topic, we'll explore **how to optimize SEO and use metadata correctly**.
