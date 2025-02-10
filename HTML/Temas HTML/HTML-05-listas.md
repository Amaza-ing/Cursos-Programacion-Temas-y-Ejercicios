# **Tema 5: Listas en HTML**

## **1. Introducción**
Las listas en HTML permiten organizar información en una estructura ordenada o desordenada. Son muy utilizadas para menús de navegación, listas de tareas, categorías y otros elementos organizativos en una página web.

En HTML existen tres tipos de listas:
- **Listas desordenadas (`<ul>`)**
- **Listas ordenadas (`<ol>`)**
- **Listas de descripción (`<dl>`)**

---

## **2. Listas desordenadas (`<ul>`)**
Las listas desordenadas presentan los elementos sin un orden específico, utilizando viñetas o marcadores por defecto.

### **Ejemplo de lista desordenada:**
```HTML
<ul>
    <li>Manzana</li>
    <li>Banana</li>
    <li>Naranja</li>
</ul>
```

### **Características:**
- Se define con `<ul>` (unordered list).
- Cada elemento de la lista se define con `<li>` (list item).
- El estilo de los marcadores puede cambiarse con CSS.

---

## **3. Listas ordenadas (`<ol>`)**
Las listas ordenadas muestran los elementos siguiendo un orden numérico o alfabético.

### **Ejemplo de lista ordenada:**
```HTML
<ol>
    <li>Primer paso</li>
    <li>Segundo paso</li>
    <li>Tercer paso</li>
</ol>
```

### **Características:**
- Se define con `<ol>` (ordered list).
- Cada elemento se representa con `<li>`.
- El tipo de numeración puede cambiarse con el atributo `type` (`1`, `A`, `a`, `I`, `i`).

### **Ejemplo con diferentes tipos de numeración:**
```HTML
<ol type="A">
    <li>Opción A</li>
    <li>Opción B</li>
    <li>Opción C</li>
</ol>
```

---

## **4. Listas anidadas**
Las listas pueden contener otras listas dentro de sus elementos, permitiendo crear estructuras más complejas.

### **Ejemplo de lista anidada:**
```HTML
<ul>
    <li>Frutas
        <ul>
            <li>Manzana</li>
            <li>Banana</li>
            <li>Naranja</li>
        </ul>
    </li>
    <li>Verduras
        <ul>
            <li>Zanahoria</li>
            <li>Lechuga</li>
        </ul>
    </li>
</ul>
```

### **Características:**
- Se pueden anidar listas dentro de `<li>`.
- Puede combinarse `<ul>` con `<ol>` según sea necesario.

---

## **5. Listas de descripción (`<dl>`, `<dt>`, `<dd>`)**
Las listas de descripción se utilizan para definir términos y sus respectivas descripciones.

### **Ejemplo de lista de descripción:**
```HTML
<dl>
    <dt>HTML</dt>
    <dd>Lenguaje de marcado para la creación de páginas web.</dd>
    
    <dt>CSS</dt>
    <dd>Lenguaje de estilos utilizado para diseñar páginas web.</dd>
</dl>
```

### **Características:**
- Se define con `<dl>` (description list).
- `<dt>` representa el término.
- `<dd>` es la descripción asociada al término.

---

## **6. Buenas prácticas al trabajar con listas**
- Utilizar **listas ordenadas** cuando el orden de los elementos es importante.
- Utilizar **listas desordenadas** para agrupar elementos sin jerarquía específica.
- Aplicar **listas de descripción** cuando se necesiten definir términos.
- Evitar listas demasiado profundas o anidadas para mejorar la legibilidad.
- Utilizar **CSS** para personalizar la apariencia de las listas.

---

En el próximo tema, aprenderemos sobre **Elementos, etiquetas y atributos en HTML**.

