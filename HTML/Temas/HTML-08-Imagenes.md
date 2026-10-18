# **Topic 8: Images in HTML and optimization for the web**

## **1. Introduction**

Images are an essential part of web content, as they enrich the user experience and improve the visual presentation of a page. HTML provides the `<img>` tag for inserting images, along with several attributes to improve their accessibility and performance.

---

## **2. Insert images with `<img>`**

The `<img>` tag allows images to be displayed on a web page. It is an element of type **empty**, which means it does not need a closing tag.

### **Basic example:**

```html
<img src="imagen.jpg" alt="Descripción de la imagen" />
```

### **Explanation of attributes:**

- `src`: Defines the path or URL of the image.
- `alt`: Provides an alternative description in case the image does not load or for accessibility.

---

## **3. Important attributes of `<img>`**

### **3.1. Size attributes: `width` and `height`**

These attributes allow you to define the width and height of an image in pixels or percentages.

**Example:**

```html
<img
  src="imagen.jpg"
  width="300"
  height="200"
  alt="Imagen con tamaño definido"
/>
```

> **Note:** It is preferable to control the size with CSS for greater flexibility.

### **3.2. `loading="lazy"` (Lazy Loading)**

The `loading="lazy"` attribute allows images to load only when the user scrolls to them, improving page performance.

**Example:**

```html
<img src="imagen.jpg" alt="Imagen optimizada" loading="lazy" />
```

---

## **4. Use of images in different formats**

Depending on the need, we can use different image formats on the web:

### **4.1. `.jpg` (JPEG)**

- Format commonly used for photographs.
- Good compression, but with loss of quality.

### **4.2. `.png`**

- Supports transparency.
- Ideal for graphics with transparent backgrounds.
- Files larger than JPEG.

### **4.3. `.webp`**

- Modern format that offers better compression and quality.
- Compatible with most modern browsers.

### **4.4. `.svg`**

- Vector format, scalable without loss of quality.
- Ideal for logos and icons.

**Example of using an SVG file:**

```html
<img src="logo.svg" alt="Logotipo en formato SVG" />
```

---

[![Images in HTML](https://img.youtube.com/vi/09vAXmbiD_4/0.jpg)](https://www.youtube.com/watch?v=09vAXmbiD_4&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **5. Good practices for image optimization**

- **Reduce the size of the images** before uploading them to the website.
- Use **optimized formats** such as WebP when possible.
- Apply **lossless compression** with tools like TinyPNG or Squoosh.
- Implement `loading="lazy"` to improve performance on image-heavy pages.
- Correctly define the `alt` to improve accessibility and SEO.

---

In the next topic, we will explore HTML tables, their structure, and how to use them to organize information on the web.
