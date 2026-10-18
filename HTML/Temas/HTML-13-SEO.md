# **Topic 13: Metadata in HTML and basic SEO**

## **1. Introduction**

Metadata in HTML provides information about a web page to browsers and search engines. Its correct configuration improves the indexing, accessibility and visibility of the site on platforms such as Google and social networks.

---

## **2. Using `<meta>` to improve indexing**

The `<meta>` tag is used in the `<head>` section to define key information about the page.

### **Basic HTML metadata example:**

```html
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="robots" content="index, follow" />
</head>
```

### **Explanation:**

- `charset="UTF-8"`: Defines the character encoding.
- `viewport`: Adjust display on mobile devices.
- `robots`: Indicates whether search engines can index the page and follow links.

---

## **3. Title and description settings**

The title and description of a page influence its presentation in search results.

### **3.1. `<title>` Configuration**

The page title is crucial for SEO and should be short and descriptive.

```html
<title>Guía Completa sobre Metadatos en HTML</title>
```

### **3.2. Meta description (`<meta name="description">`)**

The description influences the CTR (Click-Through Rate) in the search results.

```html
<meta
  name="description"
  content="Aprende cómo usar metadatos en HTML para mejorar el SEO y la visibilidad de tu sitio web."
/>
```

**Good practices:**

- The title must be between 50-60 characters.
- The meta description must be between 150-160 characters.

---

## **4. Open Graph: Improving the preview on social networks**

Open Graph (OG) is a metadata standard used by Facebook, Twitter, and other networks to improve the appearance of previews when a link is shared.

### **Open Graph configuration example:**

```html
<meta property="og:title" content="Guía Completa sobre Metadatos en HTML" />
<meta
  property="og:description"
  content="Descubre cómo optimizar tu web con metadatos y mejorar su indexación en buscadores."
/>
<meta property="og:image" content="https://ejemplo.com/imagen.jpg" />
<meta property="og:url" content="https://ejemplo.com/articulo-metadatos" />
<meta property="og:type" content="website" />
```

### **Explanation:**

- `og:title`: Defines the title that will appear on social networks.
- `og:description`: Summary of content.
- `og:image`: Preview image.
- `og:url`: URL of the shared page.
- `og:type`: Content type (`website`, `article`, `video`, etc.).

---

[![SEO & Open Graph](https://img.youtube.com/vi/mva6yRZxQwc/0.jpg)](https://www.youtube.com/watch?v=mva6yRZxQwc&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **5. Good practices in basic SEO with metadata**

- Use **unique and attractive meta descriptions** for each page.
- Make sure the title includes **relevant keywords**.
- Correctly configure **Open Graph** to improve appearance on social networks.
- Use **meta indexing tags** to control which pages can be crawled by search engines.
- Take advantage of **Google Search Console** to monitor the indexing and optimization of your site.
