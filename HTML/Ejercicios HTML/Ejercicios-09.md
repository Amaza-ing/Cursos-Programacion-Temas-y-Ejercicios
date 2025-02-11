# **Ejercicios - Tema 9: Tablas en HTML**

## **Instrucciones:**
A continuación, encontrarás 5 ejercicios prácticos sobre tablas en HTML. Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear una tabla simple**
Crea una tabla con 3 columnas: "Nombre", "Edad" y "Ciudad". Agrega al menos dos filas de datos.

<details><summary>Mostrar solución</summary>

```html
<table>
    <tr>
        <th>Nombre</th>
        <th>Edad</th>
        <th>Ciudad</th>
    </tr>
    <tr>
        <td>Ana</td>
        <td>28</td>
        <td>Madrid</td>
    </tr>
    <tr>
        <td>Pedro</td>
        <td>35</td>
        <td>Buenos Aires</td>
    </tr>
</table>
```

</details>

---

### **Ejercicio 2: Agregar encabezados a una tabla**
Modifica la siguiente tabla para que los títulos "Producto", "Precio" y "Cantidad" sean encabezados (`<th>` en la primera fila).

```html
<table border="1">
    <tr>
        <td>Manzana</td>
        <td>1.50€</td>
        <td>10</td>
    </tr>
    <tr>
        <td>Pan</td>
        <td>0.80€</td>
        <td>5</td>
    </tr>
</table>
```

<details><summary>Mostrar solución</summary>

```html
<table border="1">
    <tr>
        <th>Producto</th>
        <th>Precio</th>
        <th>Cantidad</th>
    </tr>
    <tr>
        <td>Manzana</td>
        <td>1.50€</td>
        <td>10</td>
    </tr>
    <tr>
        <td>Pan</td>
        <td>0.80€</td>
        <td>5</td>
    </tr>
</table>
```

</details>

---

### **Ejercicio 3: Fusionar celdas con `colspan`**
Crea una tabla con una fila de encabezado y tres columnas. Luego, en la segunda fila, usa `colspan="2"` para fusionar dos celdas.

<details><summary>Mostrar solución</summary>

```html
<table border="1">
    <tr>
        <th>Nombre</th>
        <th>Apellidos</th>
        <th>Ciudad</th>
    </tr>
    <tr>
        <td colspan="2">Juan Gómez</td>
        <td>Barcelona</td>
    </tr>
</table>
```

</details>

---

### **Ejercicio 4: Fusionar celdas con `rowspan`**
Crea una tabla donde una celda ocupe dos filas usando `rowspan="2"`.

<details><summary>Mostrar solución</summary>

```html
<table border="1">
    <tr>
        <th>Departamento</th>
        <th>Empleado</th>
    </tr>
    <tr>
        <td rowspan="2">Ventas</td>
        <td>Ana</td>
    </tr>
    <tr>
        <td>Marcos</td>
    </tr>
</table>
```

</details>

---

### **Ejercicio 5: Crear una tabla con múltiples filas y columnas**
Diseña una tabla que tenga al menos 3 filas y 4 columnas con información ficticia de clientes.

<details><summary>Mostrar solución</summary>

```html
<table border="1">
    <tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Email</th>
        <th>País</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Laura</td>
        <td>laura@email.com</td>
        <td>España</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Roberto</td>
        <td>roberto@email.com</td>
        <td>Chile</td>
    </tr>
    <tr>
        <td>3</td>
        <td>Elena</td>
        <td>elena@email.com</td>
        <td>México</td>
    </tr>
</table>
```

</details>

