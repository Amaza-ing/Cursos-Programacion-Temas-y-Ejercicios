# **Ejercicios - Tema 7: Posicionamiento en CSS**

## **Instrucciones:**

A continuación, encontrarás 5 ejercicios prácticos sobre el posicionamiento en CSS.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear un elemento con `position: relative`**

Crea un `div` con un ancho de 150px, un alto de 100px y color de fondo verde. Luego, desplázalo 30px hacia abajo y 40px hacia la derecha usando `position: relative`.

<details><summary>Mostrar solución</summary>

```css
.box {
  width: 150px;
  height: 100px;
  background-color: green;
  position: relative;
  top: 30px;
  left: 40px;
}
```

```html
<div class="box"></div>
```

</details>

---

### **Ejercicio 2: Crear un contenedor con un elemento `absolute`**

Define un `div` padre con `position: relative` y dentro de él coloca otro `div` con `position: absolute`, que se posicione en la esquina inferior derecha del contenedor.

<details><summary>Mostrar solución</summary>

```css
.container {
  width: 300px;
  height: 200px;
  background-color: lightgray;
  position: relative;
}

.child {
  width: 80px;
  height: 50px;
  background-color: red;
  position: absolute;
  bottom: 0;
  right: 0;
}
```

```html
<div class="container">
  <div class="child"></div>
</div>
```

</details>

---

### **Ejercicio 3: Crear un menú de navegación fijo (`fixed`)**

Crea una barra de navegación de 100% de ancho con color de fondo azul y posición fija en la parte superior de la página.

<details><summary>Mostrar solución</summary>

```css
.navbar {
  width: 100%;
  height: 50px;
  background-color: blue;
  position: fixed;
  top: 0;
  left: 0;
  color: white;
  text-align: center;
  line-height: 50px;
}
```

```html
<div class="navbar">Menú de navegación</div>
```

</details>

---

### **Ejercicio 4: Crear un elemento con `sticky`**

Crea un encabezado `<h2>` que permanezca pegado en la parte superior de la página cuando el usuario haga scroll.

<details><summary>Mostrar solución</summary>

```css
.header {
  background-color: yellow;
  padding: 10px;
  position: sticky;
  top: 0;
}
```

```html
<h2 class="header">Encabezado adhesivo</h2>
<p>Texto de prueba para hacer scroll...</p>
```

</details>

---

### **Ejercicio 5: Centrar un elemento con `absolute` y `transform`**

Crea un `div` de 100x100px con fondo naranja y posiciónalo en el centro exacto de la pantalla usando `position: absolute` y `transform`.

<details><summary>Mostrar solución</summary>

```css
.center-box {
  width: 100px;
  height: 100px;
  background-color: orange;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
```

```html
<div class="center-box"></div>
```

</details>
