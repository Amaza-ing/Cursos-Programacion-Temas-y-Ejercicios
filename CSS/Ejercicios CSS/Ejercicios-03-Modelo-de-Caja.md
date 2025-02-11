# **Ejercicios - Tema 3: El Modelo de Caja en CSS**

## **Instrucciones:**
A continuación, encontrarás 5 ejercicios prácticos sobre el modelo de caja en CSS.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Definir márgenes y padding**

Crea un `div` con un fondo gris, un margen de 20 píxeles y un padding de 10 píxeles.

<details><summary>Mostrar solución</summary>

```css
.box {
    background-color: gray;
    margin: 20px;
    padding: 10px;
}
```
```html
<div class="box">Este es un contenedor con margen y padding.</div>
```

</details>

---

### **Ejercicio 2: Usar `box-sizing: border-box`**

Define un `div` con un ancho de 200 píxeles, un borde de 5 píxeles y activa la propiedad `box-sizing: border-box`.

<details><summary>Mostrar solución</summary>

```css
.container {
    width: 200px;
    border: 5px solid black;
    box-sizing: border-box;
}
```
```html
<div class="container">Este contenedor usa box-sizing.</div>
```

</details>

---

### **Ejercicio 3: Aplicar diferentes márgenes**

Crea un `div` con diferentes márgenes: 10 píxeles arriba, 20 píxeles a la derecha, 30 píxeles abajo y 40 píxeles a la izquierda.

<details><summary>Mostrar solución</summary>

```css
.margin-box {
    margin: 10px 20px 30px 40px;
}
```
```html
<div class="margin-box">Este es un contenedor con márgenes diferentes.</div>
```

</details>

---

### **Ejercicio 4: Crear un borde redondeado**

Define un `div` con un borde de 2 píxeles sólido negro y esquinas redondeadas de 15 píxeles.

<details><summary>Mostrar solución</summary>

```css
.rounded-box {
    border: 2px solid black;
    border-radius: 15px;
}
```
```html
<div class="rounded-box">Este es un contenedor con bordes redondeados.</div>
```

</details>

---

### **Ejercicio 5: Crear un efecto de sombra**

Crea un `div` con un fondo azul y una sombra de 5 píxeles de desplazamiento en los ejes X e Y, con una opacidad de 0.5.

<details><summary>Mostrar solución</summary>

```css
.shadow-box {
    background-color: blue;
    box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.5);
}
```
```html
<div class="shadow-box">Este es un contenedor con sombra.</div>
```

</details>

