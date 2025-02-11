# **Tema 9: Tablas en HTML - Organización de datos**

## **1. Introducción**
Las tablas en HTML permiten organizar y mostrar datos en filas y columnas. Son útiles para mostrar información estructurada de manera clara y comprensible.

---

## **2. Creación de tablas con `<table>`, `<tr>`, `<td>`, `<th>`**
Una tabla en HTML se construye utilizando diferentes etiquetas:
- `<table>`: Define el inicio y fin de la tabla.
- `<tr>` (Table Row): Representa una fila en la tabla.
- `<td>` (Table Data): Define una celda de datos dentro de una fila.
- `<th>` (Table Header): Define una celda de encabezado dentro de una fila.

### **Ejemplo básico de una tabla:**
```html
<table border="1">
    <tr>
        <th>Nombre</th>
        <th>Edad</th>
        <th>País</th>
    </tr>
    <tr>
        <td>María</td>
        <td>30</td>
        <td>España</td>
    </tr>
    <tr>
        <td>Carlos</td>
        <td>25</td>
        <td>Argentina</td>
    </tr>
</table>
```

---

## **3. Uso de `colspan` y `rowspan` para fusionar celdas**
En algunas ocasiones, es necesario fusionar celdas en una tabla. Para ello, utilizamos:
- **`colspan`**: Extiende una celda en varias columnas.
- **`rowspan`**: Extiende una celda en varias filas.

### **Ejemplo de uso de `colspan`:**
```html
<table border="1">
    <tr>
        <th colspan="2">Encabezado combinado</th>
    </tr>
    <tr>
        <td>Celda 1</td>
        <td>Celda 2</td>
    </tr>
</table>
```

### **Ejemplo de uso de `rowspan`:**
```html
<table border="1">
    <tr>
        <th rowspan="2">Encabezado fusionado</th>
        <td>Celda 1</td>
    </tr>
    <tr>
        <td>Celda 2</td>
    </tr>
</table>
```

---

## **4. Aplicación de estilos básicos a tablas**
Las tablas pueden personalizarse con CSS para mejorar su apariencia.

### **Ejemplo de estilos básicos con CSS:**
```html
<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid black;
        padding: 8px;
        text-align: center;
    }
    th {
        background-color: lightgray;
    }
</style>
```

---

## **5. Buenas prácticas en el uso de tablas en HTML**
- Utilizar **encabezados `<th>`** para mejorar la accesibilidad.
- Emplear **`colspan` y `rowspan`** solo cuando sea necesario.
- Evitar tablas demasiado complejas para facilitar su lectura.
- Aplicar **CSS** para mejorar la visualización de la tabla.

---

En el próximo tema, exploraremos **los formularios en HTML**, su estructura y cómo capturar datos del usuario de manera efectiva.

