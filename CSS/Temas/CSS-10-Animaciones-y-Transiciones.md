# **Tema 10: Animaciones y Transiciones en CSS**

## **1. Introducción a las animaciones y transiciones en CSS**
Las animaciones y transiciones permiten agregar dinamismo y mejorar la experiencia de usuario en una página web. CSS ofrece propiedades específicas para crear efectos visuales sin necesidad de JavaScript.

---

## **2. Transiciones en CSS**
Las transiciones permiten cambiar suavemente el valor de una propiedad CSS durante un período de tiempo.

### **Propiedades principales:**
- `transition-property`: Define qué propiedad será animada.
- `transition-duration`: Especifica la duración de la transición.
- `transition-timing-function`: Controla la aceleración de la transición.
- `transition-delay`: Define un retraso antes de iniciar la transición.

### **Ejemplo básico:**
```css
.button {
    background-color: blue;
    color: white;
    padding: 10px 20px;
    transition: background-color 0.3s ease;
}

.button:hover {
    background-color: red;
}
```

En este ejemplo, el fondo del botón cambia suavemente de azul a rojo cuando se pasa el cursor por encima.

>Nota: Con `transition: all` se pueden afectar a todas las propiedades a la vez.

---

## **3. Funciones de temporización (`transition-timing-function`)**
Controlan la velocidad de la transición durante su ejecución.

- `linear`: Velocidad constante.
- `ease` (por defecto): Inicio y fin lentos con velocidad media.
- `ease-in`: Comienza lentamente.
- `ease-out`: Termina lentamente.
- `ease-in-out`: Inicio y fin lentos.
- `cubic-bezier(n,n,n,n)`: Define una curva de Bézier personalizada.

### **Ejemplo:**
```css
.box {
    width: 100px;
    height: 100px;
    background-color: green;
    transition: transform 0.5s ease-in-out;
}

.box:hover {
    transform: scale(1.2);
}
```

---

## **4. Animaciones en CSS**
Las animaciones permiten crear secuencias de cambios de estilos más complejas que las transiciones.

### **Propiedades principales:**
- `@keyframes`: Define los pasos de la animación.
- `animation-name`: Nombre de la animación.
- `animation-duration`: Duración de la animación.
- `animation-timing-function`: Controla la aceleración.
- `animation-delay`: Retraso antes de iniciar.
- `animation-iteration-count`: Número de repeticiones.
- `animation-direction`: Dirección de la animación.
- `animation`: Shorthand para el resto de propiedades.

### **Ejemplo básico:**
```css
@keyframes mover {
    0% { transform: translateX(0); }
    100% { transform: translateX(200px); }
}

.box {
    width: 100px;
    height: 100px;
    background-color: orange;
    animation: mover 2s infinite alternate;
}
```

En este ejemplo, el cuadro se moverá de izquierda a derecha de forma infinita.

---

## **5. Control avanzado de animaciones**
### **Propiedad `animation-iteration-count`**
Define cuántas veces se ejecuta la animación.
- `infinite`: La animación se repite indefinidamente.
- Número específico (`1`, `2`, etc.): Número de repeticiones.

### **Propiedad `animation-direction`**
Controla la dirección de la animación.
- `normal`: Ejecución estándar.
- `reverse`: Inicia desde el final.
- `alternate`: Alterna direcciones en cada iteración.
- `alternate-reverse`: Alterna comenzando en reversa.

### **Ejemplo:**
```css
@keyframes girar {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

.spinner {
    width: 50px;
    height: 50px;
    border: 5px solid lightgray;
    border-top: 5px solid blue;
    border-radius: 50%;
    animation: girar 1s linear infinite;
}
```

En este ejemplo, se crea un efecto de cargador giratorio.

También se puede controlar más en detalle la animación especificando más valores porcentuales:

```css
@keyframes mover {
  0% { transform: translateX(0); }
  50% { background-color: green; }
  100% { transform: translateX(200px); }
}
```

En este ejemplo ahora la animación hace que además de lo anterior, cambie de color a verde a mitad de camino.

---

## **6. Combinar transiciones y animaciones**
Es posible combinar ambos efectos para lograr resultados más dinámicos.

### **Ejemplo:**
```css
.button {
    background-color: blue;
    color: white;
    padding: 10px 20px;
    transition: background-color 0.3s;
    animation: pulsar 1.5s infinite alternate;
}

.button:hover {
    background-color: red;
}

@keyframes pulsar {
    from { transform: scale(1); }
    to { transform: scale(1.1); }
}
```

Aquí, el botón crece y se reduce mientras cambia de color al pasar el cursor.

---

## **7. Buenas prácticas con animaciones y transiciones**
- Evitar animar propiedades que afecten el rendimiento, como `width` y `height`.
- Usar `transform` y `opacity` para animaciones más fluidas.
- Mantener duraciones adecuadas para mejorar la experiencia del usuario.
- No abusar de animaciones para no sobrecargar la interfaz.

---

En el próximo tema, exploraremos **media queries y diseño responsivo**, para adaptar tus diseños a diferentes tamaños de pantalla.
