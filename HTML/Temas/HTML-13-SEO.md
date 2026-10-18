# **Topic 13: Metadata in HTML and basic SEO**

## **1. Introduction**

Metadata in HTML gives browsers and search engines information about a web page. Setting it up correctly improves the site's indexing, accessibility and visibility on platforms such as Google and social networks.

---

## **2. Using `<meta>` to improve indexing**

The `<meta>` tag is used in the `<head>` section to define key information about the page.

### **Basic example of metadata in HTML:**

```html
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="robots" content="index, follow" />
</head>
```

### **Explanation:**

- `charset="UTF-8"`: Defines the character encoding.
- `viewport`: Adjusts how the page is displayed on mobile devices.
- `robots`: Indicates whether search engines can index the page and follow its links.

---

## **3. Setting the title and description**

A page's title and description affect how it appears in search results.

### **3.1. Setting the `<title>`**

The page title is crucial for SEO and should be short and descriptive.

```html
<title>Guía Completa sobre Metadatos en HTML</title>
```

### **3.2. Meta description (`<meta name="description">`)**

The description affects the CTR (click-through rate) in search results.

```html
<meta
  name="description"
  content="Aprende cómo usar metadatos en HTML para mejorar el SEO y la visibilidad de tu sitio web."
/>
```

**Good practices:**

- The title should be 50-60 characters long.
- The meta description should be 150-160 characters long.

---

## **4. Open Graph: Improving previews on social networks**

Open Graph (OG) is a metadata standard used by Facebook, Twitter and other networks to improve how previews look when a link is shared.

### **Example of an Open Graph setup:**

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
- `og:description`: A summary of the content.
- `og:image`: The preview image.
- `og:url`: The URL of the shared page.
- `og:type`: The content type (`website`, `article`, `video`, etc.).

---

[![SEO & Open Graph](https://img.youtube.com/vi/mva6yRZxQwc/0.jpg)](https://www.youtube.com/watch?v=mva6yRZxQwc&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **5. Good practices for basic SEO with metadata**

- Use **unique, compelling meta descriptions** for each page.
- Make sure the title includes **relevant keywords**.
- Set up **Open Graph** correctly to improve how your pages look on social networks.
- Use **indexing meta tags** to control which pages search engines can crawl.
- Take advantage of **Google Search Console** to monitor your site's indexing and optimization.
