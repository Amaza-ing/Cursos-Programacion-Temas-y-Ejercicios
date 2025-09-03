# **Tema 1: Introducción a CSS**

## **1. ¿Qué es CSS y para qué sirve?**

CSS (_Cascading Style Sheets_ o Hojas de Estilo en Cascada) es un lenguaje utilizado para definir el diseño y la presentación de documentos HTML. Permite mejorar la apariencia de una página web, separando la estructura del contenido del diseño visual.

### **Características clave de CSS:**

- Permite personalizar el estilo de una página web.
- Separa el contenido (HTML) de la presentación.
- Facilita el mantenimiento y la reutilización de estilos.
- Mejora la accesibilidad y la experiencia del usuario.
- Compatible con todos los navegadores modernos.

---

## **2. ¿Cómo funciona CSS?**

CSS trabaja aplicando reglas de estilo a los elementos HTML. Estas reglas pueden definirse de distintas formas y en diferentes ubicaciones dentro del código.

### **Estructura de una regla CSS:**

```css
selector {
  propiedad: valor;
}
```

### **Ejemplo de una regla CSS:**

```css
p {
  color: blue;
  font-size: 16px;
}
```

En este caso:

- `p` es el **selector**, que indica que se aplicará el estilo a todos los párrafos (`<p>`).
- `color` y `font-size` son **propiedades**.
- `blue` y `16px` son los **valores** de esas propiedades.

---

## **3. Formas de aplicar CSS**

Existen tres maneras principales de incluir CSS en un documento HTML:

### **1. CSS en línea (inline CSS)**

Se aplica directamente en la etiqueta HTML mediante el atributo `style`.

```html
<p style="color: red; font-size: 18px;">
  Este es un párrafo con estilo en línea.
</p>
```

✔ Rápido para pequeños cambios, pero difícil de mantener en proyectos grandes. No está recomendado usarlo si hay alternativa.

### **2. CSS interno (internal CSS)**

Se coloca dentro de la etiqueta `<style>` en el `<head>` del documento HTML.

```html
<!DOCTYPE html>
<html>
  <head>
    <style>
      p {
        color: green;
        font-size: 20px;
      }
    </style>
  </head>
  <body>
    <p>Este es un párrafo con CSS interno.</p>
  </body>
</html>
```

✔ Útil para páginas pequeñas sin necesidad de múltiples archivos CSS.

### **3. CSS externo (external CSS)**

Se guarda en un archivo separado (`.css`) y se enlaza desde el HTML con `<link>`.

**Archivo `styles.css`**:

```css
h1 {
  color: purple;
  text-align: center;
}
```

**Archivo `index.html`**:

```html
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="styles.css" />
  </head>
  <body>
    <h1>Este es un título con CSS externo.</h1>
  </body>
</html>
```

✔ La mejor práctica para proyectos grandes y escalables.

---

## **4. Cascada y especificidad en CSS**

El nombre "Cascading Style Sheets" proviene del concepto de **cascada**, que determina el orden de prioridad de las reglas de estilo.

### **Orden de aplicación de estilos:**

1. Estilos del navegador (por defecto).
2. Estilos externos (`.css`).
3. Estilos internos (`<style>` en HTML).
4. Estilos en línea (`style=""` en la etiqueta HTML).
5. Reglas con `!important` (tienen la mayor prioridad).

### **Ejemplo de prioridad:**

```css
p {
  color: blue !important; /* Se aplicará este color */
}

p {
  color: red;
}
```

📌 **Las reglas con `!important`** sobrescriben cualquier otro estilo, incluso si proviene de un archivo externo. El uso de `!important` está completamente desaconsejado.

---

## **5. Buenas prácticas en CSS**

- Usar archivos CSS externos para mantener el código organizado.
- Evitar el uso excesivo de estilos en línea.
- Mantener una estructura clara con comentarios en el código.
- Reutilizar clases y evitar IDs cuando sea posible.
- Optimizar el código evitando reglas innecesarias.

---

En el próximo tema, exploraremos **selectores y especificidad en CSS**, fundamentales para aplicar estilos de manera efectiva en una página web.
