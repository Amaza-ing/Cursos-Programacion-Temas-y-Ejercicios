# **Topic 9: Tables in HTML - Data Organization**

## **1. Introduction**

HTML tables allow you to organize and display data in rows and columns. They are useful for displaying structured information in a clear and understandable way.

---

## **2. Creating tables with `<table>`, `<tr>`, `<td>`, `<th>`**

A table in HTML is built using different tags:

- `<table>`: Defines the start and end of the table.
- `<tr>` (Table Row): Represents a row in the table.
- `<td>` (Table Data): Defines a data cell within a row.
- `<th>` (Table Header): Defines a header cell within a row.

### **Basic example of a table:**

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

## **3. Using `colspan` and `rowspan` to merge cells**

Sometimes it is necessary to merge cells in a table. To do this, we use:

- **`colspan`**: Extends a cell into multiple columns.
- **`rowspan`**: Extends a cell into multiple rows.

### **Example of use of `colspan`:**

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

### **Example of use of `rowspan`:**

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

## **4. Applying basic styles to tables**

Tables can be customized with CSS to improve their appearance.

### **Example of basic styles with CSS:**

```html
<style>
  table {
    width: 100%;
    border-collapse: collapse;
  }
  th,
  td {
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

[![Tables in HTML](https://img.youtube.com/vi/mgop_khNu8A/0.jpg)](https://www.youtube.com/watch?v=mgop_khNu8A&list=PLzA2VyZwsq_9NPG0g7N4fo6lw50rWnWPc)

---

## **5. Good practices in using tables in HTML**

- Use **`<th>` headers** to improve accessibility.
- Use **`colspan` and `rowspan`** only when necessary.
- Avoid tables that are too complex to make them easier to read.
- Apply **CSS** to improve the table display.

---

In the next topic, we will explore **HTML forms**, their structure, and how to capture user data effectively.
