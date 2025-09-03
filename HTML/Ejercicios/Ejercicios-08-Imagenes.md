# **Ejercicios - Tema 8: Imágenes en HTML y optimización para la web**

## **Instrucciones:**

A continuación, encontrarás 5 ejercicios prácticos sobre imágenes en HTML.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Insertar una imagen básica**

Crea un documento HTML que muestre una imagen ubicada en la misma carpeta que el archivo HTML.

<details><summary>Mostrar solución</summary>

```html
<img src="imagen.jpg" alt="Descripción de la imagen" />
```

</details>

---

### **Ejercicio 2: Definir tamaño de una imagen**

Modifica el código del ejercicio anterior para que la imagen tenga un ancho de 400 píxeles y una altura de 300 píxeles.

<details><summary>Mostrar solución</summary>

```html
<img
  src="imagen.jpg"
  width="400"
  height="300"
  alt="Imagen con tamaño definido"
/>
```

</details>

---

### **Ejercicio 3: Aplicar carga diferida (`loading="lazy"`)**

Añade el atributo `loading="lazy"` a la imagen para que solo se cargue cuando el usuario la vea en pantalla.

<details><summary>Mostrar solución</summary>

```html
<img src="imagen.jpg" alt="Imagen con carga diferida" loading="lazy" />
```

</details>

---

### **Ejercicio 4: Usar diferentes formatos de imagen**

Crea un documento HTML que muestre una imagen en formato `.webp` y otra en formato `.svg`.

<details><summary>Mostrar solución</summary>

```html
<img src="imagen.webp" alt="Imagen en formato WebP" />
<img src="logo.svg" alt="Logotipo en formato SVG" />
```

</details>

---

### **Ejercicio 5: Imagen con enlace**

Haz que una imagen actúe como un enlace a otra página web.

<details><summary>Mostrar solución</summary>

```html
<a href="https://www.ejemplo.com">
  <img src="imagen.jpg" alt="Imagen con enlace" />
</a>
```

</details>
