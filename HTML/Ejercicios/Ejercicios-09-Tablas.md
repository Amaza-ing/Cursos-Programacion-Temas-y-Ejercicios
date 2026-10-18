# **Exercises - Topic 9: Tables in HTML**

## **Instructions:**

Below you will find 5 practical exercises on tables in HTML.

Try to solve them before consulting the solution.

---

### **Exercise 1: Create a simple table**

Create a table with 3 columns: "Name", "Age" and "City". Add at least two rows of data.

<details><summary>Show solution</summary>

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

### **Exercise 2: Add headers to a table**

Modify the following table so that the titles "Product", "Price", and "Quantity" are headings (`<th>` in the first row).

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

<details><summary>Show solution</summary>

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

### **Exercise 3: Merge cells with `colspan`**

Create a table with one header row and three columns. Then, in the second row, use `colspan="2"` to merge two cells.

<details><summary>Show solution</summary>

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

### **Exercise 4: Merge cells with `rowspan`**

Create a table where one cell occupies two rows using `rowspan="2"`.

<details><summary>Show solution</summary>

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

### **Exercise 5: Create a table with multiple rows and columns**

Design a table that has at least 3 rows and 4 columns with fictitious customer information.

<details><summary>Show solution</summary>

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
