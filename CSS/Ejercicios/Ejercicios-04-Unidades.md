# **Ejercicios - Tema 4: Unidades de Medida en CSS**

## **Instrucciones:**

A continuación, encontrarás 6 ejercicios prácticos sobre unidades de medida en CSS.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Usar unidades absolutas**

Crea un `div` con un ancho de 500 pixels y una altura de 80 pixels.

<details><summary>Mostrar solución</summary>

```css
.box {
  width: 500px;
  height: 80px;
  background-color: lightgray;
}
```

```html
<div class="box">Caja con unidades absolutas.</div>
```

</details>

---

### **Ejercicio 2: Usar porcentajes para diseño flexible**

Define un contenedor con un ancho del 80% del tamaño del elemento padre.

<details><summary>Mostrar solución</summary>

```css
.container {
  width: 80%;
  background-color: lightblue;
}
```

```html
<div class="container">
  Este contenedor ocupa el 80% del ancho del elemento padre.
</div>
```

</details>

---

### **Ejercicio 3: Comparar `em` y `rem`**

Crea un párrafo donde el tamaño de la fuente sea 2em y otro donde sea 2rem. Define `html` con un `font-size` de 16px y el contenedor padre con `font-size` de 10px y observa la diferencia.

<details><summary>Mostrar solución</summary>

```css
html {
  font-size: 16px;
}
.container {
  font-size: 10px;
}
p.rem-example {
  font-size: 2rem; /* 32px relativo al html */
}
p.em-example {
  font-size: 2em; /* 20px relativo al padre */
}
```

```html
<div class="container">
  <p class="em-example">Este texto usa 2em.</p>
  <p class="rem-example">Este texto usa 2rem.</p>
</div>
```

</details>

---

### **Ejercicio 4: Aplicar `vw` y `vh`**

Crea un `div` que ocupe el 50% del ancho y el 30% del alto de la ventana del navegador.

<details><summary>Mostrar solución</summary>

```css
.full-screen-box {
  width: 50vw;
  height: 30vh;
  background-color: pink;
}
```

```html
<div class="full-screen-box">Este contenedor usa vw y vh.</div>
```

</details>

---

### **Ejercicio 5: Uso de `vmin` y `vmax`**

Crea un `div` donde el tamaño de la fuente sea `5vmin`, y otro donde sea `5vmax`.

<details><summary>Mostrar solución</summary>

```css
.text-vmin {
  font-size: 5vmin; /* Basado en el menor valor entre ancho y alto de la pantalla */
}
.text-vmax {
  font-size: 5vmax; /* Basado en el mayor valor entre ancho y alto de la pantalla */
}
```

```html
<p class="text-vmin">Este texto usa vmin.</p>
<p class="text-vmax">Este texto usa vmax.</p>
```

</details>

---

### **Ejercicio 6: Crear un diseño responsivo combinando unidades**

Define un contenedor flexible con `width: 80%`, `max-width: 600px` y `min-width: 300px`. Usa `rem` para definir el padding.

<details><summary>Mostrar solución</summary>

```css
.responsive-box {
  width: 80%;
  max-width: 600px;
  min-width: 300px;
  padding: 2rem;
  background-color: lightgreen;
}
```

```html
<div class="responsive-box">Este contenedor es flexible.</div>
```

</details>
