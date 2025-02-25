# **Ejercicios - Tema 1: Introducción a CSS**

## **Instrucciones:**
A continuación, encontrarás 5 ejercicios prácticos sobre la introducción a CSS. 

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Aplicar un estilo en línea**

Crea un párrafo en HTML que tenga el color de texto rojo utilizando CSS en línea.

<details><summary>Mostrar solución</summary>

```html
<p style="color: red;">Este es un párrafo con CSS en línea.</p>
```

</details>

---

### **Ejercicio 2: Usar CSS interno**

Crea un documento HTML que defina un estilo CSS en la etiqueta `<style>` para que todos los párrafos tengan color azul.

<details><summary>Mostrar solución</summary>

```html
<!DOCTYPE html>
<html>
<head>
    <style>
        p {
            color: blue;
        }
    </style>
</head>
<body>
    <p>Este es un párrafo con CSS interno.</p>
</body>
</html>
```

</details>

---

### **Ejercicio 3: Aplicar un estilo desde un archivo externo**

Crea un archivo CSS externo llamado `styles.css` y aplícalo a un documento HTML para que los títulos `<h1>` tengan color verde.

<details><summary>Mostrar solución</summary>

**Archivo `styles.css`**:
```css
h1 {
    color: green;
}
```

**Archivo `index.html`**:
```html
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Este es un título con CSS externo.</h1>
</body>
</html>
```

</details>

---

### **Ejercicio 4: Modificar el tamaño del texto**

Usa CSS para cambiar el tamaño del texto de un párrafo a 20 píxeles.

<details><summary>Mostrar solución</summary>

```html
<!DOCTYPE html>
<html>
<head>
    <style>
        p {
            font-size: 20px;
        }
    </style>
</head>
<body>
    <p>Este es un párrafo con tamaño de texto de 20px.</p>
</body>
</html>
```

</details>

---

### **Ejercicio 5: Usar múltiples propiedades CSS**

Crea un párrafo con CSS que tenga color de texto rojo, tamaño de fuente de 18px y alineación centrada.

<details><summary>Mostrar solución</summary>

```html
<!DOCTYPE html>
<html>
<head>
    <style>
        p {
            color: red;
            font-size: 18px;
            text-align: center;
        }
    </style>
</head>
<body>
    <p>Este es un párrafo con múltiples propiedades CSS.</p>
</body>
</html>
```

</details>
