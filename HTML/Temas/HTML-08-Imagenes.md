# **Topic 8: Images in HTML and optimization for the web**

## **1. Introduction**

Images are an essential part of web content, as they enrich the user experience and improve the visual presentation of a page. HTML provides the `<img>` tag for inserting images, along with several attributes to improve their accessibility and performance.

---

## **2. Inserting images with `<img>`**

The `<img>` tag lets you display images on a web page. It is an **empty** element, which means it doesn't need a closing tag.

### **Basic example:**

```html
<img src="imagen.jpg" alt="Descripción de la imagen" />
```

### **The attributes explained:**

- `src`: Defines the path or URL of the image.
- `alt`: Provides an alternative description, for accessibility or in case the image doesn't load.

---

## **3. Important attributes of `<img>`**

### **3.1. Size attributes: `width` and `height`**

These attributes let you define the width and height of an image in pixels or percentages.

**Example:**

```html
<img
  src="imagen.jpg"
  width="300"
  height="200"
  alt="Imagen con tamaño definido"
/>
```

> **Note:** It's better to control the size with CSS, for greater flexibility.

### **3.2. `loading="lazy"` (lazy loading)**

The `loading="lazy"` attribute makes images load only when the user scrolls to them, which improves page performance.

**Example:**

```html
<img src="imagen.jpg" alt="Imagen optimizada" loading="lazy" />
```

---

## **4. Using images in different formats**

Depending on what we need, we can use different image formats on the web:

### **4.1. `.jpg` (JPEG)**

- A format commonly used for photographs.
- Good compression, but with some loss of quality.

### **4.2. `.png`**

- Supports transparency.
- Ideal for graphics with transparent backgrounds.
- Larger files than JPEG.

### **4.3. `.webp`**

- A modern format that offers better compression and quality.
- Supported by most modern browsers.

### **4.4. `.svg`**

- A vector format that scales without losing quality.
- Ideal for logos and icons.

**Example of using an SVG file:**

```html
<img src="logo.svg" alt="Logotipo en formato SVG" />
```

---

[![Images in HTML](https://img.youtube.com/vi/09vAXmbiD_4/0.jpg)](https://www.youtube.com/watch?v=09vAXmbiD_4&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **5. Good practices for image optimization**

- **Reduce the size of your images** before uploading them to the website.
- Use **optimized formats** such as WebP when possible.
- Apply **compression** with tools like TinyPNG (lossy) or Squoosh (lossy or lossless).
- Use `loading="lazy"` to improve performance on image-heavy pages.
- Write a proper `alt` text to improve accessibility and SEO.

---

In the next topic, we'll explore **tables in HTML**, their structure and how to use them to organize information on the web.
