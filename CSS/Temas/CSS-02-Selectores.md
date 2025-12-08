# **Tema 2: Selectores y especificidad en CSS**

## **1. Introducción a los selectores en CSS**

Los **selectores** en CSS permiten seleccionar elementos HTML y aplicarles estilos. Existen varios tipos de selectores, cada uno con distintos niveles de especificidad.

### **Ejemplo de un selector básico:**

```css
p {
  color: blue;
}
```

Este selector aplica el color azul a todos los párrafos (`<p>`) de la página.

---

## **2. Tipos de selectores en CSS**

### **1. Selectores básicos**

- **Selector de etiqueta**: selecciona elementos por su etiqueta HTML.
  ```css
  h1 {
    color: red;
  }
  ```
- **Selector de clase (`.`)**: selecciona elementos con una clase específica.
  ```css
  .highlighted {
    font-weight: bold;
  }
  ```
- **Selector de ID (`#`)**: selecciona un elemento con un ID único.
  ```css
  #some-id {
    text-align: center;
  }
  ```

### **2. Selectores combinadores**

- **Selectores unidos**: selecciona elementos que tengan los selectores (etiqueta, cases, id, etc) utilizados a la vez.

  ```css
  div.box.green {
    width: 50px;
    height: 50px;
    color: green;
  }
  ```

  Sólo aplicará a un `<div>` con las clases `box` y `green`.

- **Selector de descendencia (`espacio`)**: selecciona elementos dentro de un contenedor.
  ```css
  div p {
    color: green;
  }
  ```
- **Selector de hijo directo (`>`)**: selecciona solo los hijos directos.
  ```css
  div > p {
    font-size: 18px;
  }
  ```
- **Selector de hermano adyacente (`+`)**: selecciona un elemento inmediatamente después de otro.
  ```css
  h1 + p {
    font-style: italic;
  }
  ```
- **Selector de hermano general (`~`)**: selecciona todos los elementos hermanos.
  ```css
  h1 ~ p {
    color: gray;
  }
  ```

### **3. Selectores de atributos**

Permiten seleccionar elementos en función de sus atributos.

```css
input[type="text"] {
  border: 1px solid black;
}
```

### **4. Selectores pseudo-clases**

Aplican estilos cuando un elemento está en un estado específico.

```css
a:hover {
  color: red;
}
```

### **5. Selectores pseudo-elementos**

Permiten estilizar partes específicas de un elemento.

```css
p::first-letter {
  font-size: 2em;
}
```

### **6. Selector universal**

Se aplicará a todos los elementos. Tiene la especificidad más baja.

```css
* {
  box-sizing: border-box;
}
```

---

## **3. Especificidad en CSS**

La especificidad determina qué regla CSS se aplica cuando hay múltiples reglas en conflicto.

### **Prioridad de los selectores:**

1. Estilos en línea (`style=""`) → **Más alto**.
2. Selectores de ID (`#id`).
3. Selectores de clase (`.clase`), atributos y pseudo-clases (`:hover`).
4. Selectores de etiqueta (`elemento`).
5. Estilos heredados y de navegador → **Menos prioridad**.

### **Ejemplo de especificidad:**

```css
p {
  color: blue; /* Baja especificidad (0, 0, 1) */
}

.highlighted {
  color: green; /* Más específica que una etiqueta (0, 1, 0) */
}

#some-id {
  color: red; /* ID tiene mayor especificidad (1, 0, 0) */
}
```

Si un `<p>` tiene la clase `highlighted` y el ID `some-id`, se aplicará el color **rojo** debido a la mayor especificidad del selector de ID.

### **Prioridad de la cascada:**

Si existen selectores con la misma especificidad se aplicarán los estilos del que se encuentre en último lugar en el código.

```css
.some-class {
  color: red;
}

.some-class {
  color: green;
}

.some-class {
  color: blue;
}
```

Aquí se aplicará el color azul.

---

[![Selectores CSS](https://img.youtube.com/vi/vwAhrcfUmbE/0.jpg)](https://www.youtube.com/watch?v=vwAhrcfUmbE&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **4. Uso de `!important`**

La regla `!important` sobrescribe todas las reglas anteriores, incluso si tienen mayor especificidad.

```css
p {
  color: blue !important;
}
```

⚠ **Usar con moderación**, ya que puede dificultar el mantenimiento del código. Es recomendable no usarlo en absoluto.

---

[![CSS anidado & !important](https://img.youtube.com/vi/9FNDDjs6u7I/0.jpg)](https://www.youtube.com/watch?v=9FNDDjs6u7I&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **5. Buenas prácticas con selectores en CSS**

- Usar clases en lugar de IDs para mayor reutilización.
- Mantener los selectores cortos y específicos.
- Evitar el uso de `!important`.
- Organizar los estilos en un orden lógico.

---

## **Enlaces de Interés.**

- Juego para practicar con los selectores CSS: [flukeout](https://flukeout.github.io/).

---

En el próximo tema, aprenderemos sobre **el modelo de caja en CSS**, un concepto esencial para comprender el diseño y el espaciado de los elementos en una página web.
