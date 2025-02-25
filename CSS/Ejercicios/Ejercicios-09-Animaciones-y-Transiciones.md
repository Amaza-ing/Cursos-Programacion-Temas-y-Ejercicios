# **Ejercicios - Tema 9: Animaciones y Transiciones en CSS**

## **Instrucciones:**
A continuación, encontrarás 5 ejercicios prácticos sobre animaciones y transiciones en CSS.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear una transición de color**

Crea un botón que cambie su color de fondo de azul a rojo al pasar el cursor por encima con una transición suave de 0.5 segundos.

<details><summary>Mostrar solución</summary>

```css
.button {
    background-color: blue;
    color: white;
    padding: 10px 20px;
    border: none;
    cursor: pointer;
    transition: background-color 0.5s ease;
}

.button:hover {
    background-color: red;
}
```
```html
<button class="button">Pasa el cursor</button>
```

</details>

---

### **Ejercicio 2: Animar un cuadro en movimiento**

Crea un cuadro que se desplace de izquierda a derecha utilizando `@keyframes`.

<details><summary>Mostrar solución</summary>

```css
@keyframes move {
    from { transform: translateX(0); }
    to { transform: translateX(200px); }
}

.box {
    width: 100px;
    height: 100px;
    background-color: green;
    animation: move 2s infinite alternate;
}
```
```html
<div class="box"></div>
```

</details>

---

### **Ejercicio 3: Crear un efecto de escala al pasar el cursor**

Haz que un elemento se agrande al 120% de su tamaño original cuando el cursor pase por encima.

<details><summary>Mostrar solución</summary>

```css
.scale-box {
    width: 100px;
    height: 100px;
    background-color: orange;
    transition: transform 0.3s ease;
}

.scale-box:hover {
    transform: scale(1.2);
}
```
```html
<div class="scale-box"></div>
```

</details>

---

### **Ejercicio 4: Crear un efecto de desvanecimiento**

Crea un texto que aparezca gradualmente al cargar la página usando `opacity`.

<details><summary>Mostrar solución</summary>

```css
@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

.text {
    font-size: 24px;
    animation: fadeIn 2s ease;
}
```
```html
<p class="text">Texto que aparece gradualmente</p>
```

</details>

---

### **Ejercicio 5: Crear un spinner animado**

Crea un círculo que gire continuamente simulando un spinner de carga.

<details><summary>Mostrar solución</summary>

```css
@keyframes spin {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

.spinner {
    width: 50px;
    height: 50px;
    border: 5px solid lightgray;
    border-top: 5px solid blue;
    border-radius: 50%;
    animation: spin 1s linear infinite;
}
```
```html
<div class="spinner"></div>
```

</details>
