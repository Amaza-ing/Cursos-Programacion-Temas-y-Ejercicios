# **Exercises - Topic 13: Functions in MySQL**

Below you will find 5 practical exercises to create and use **functions** in MySQL, also putting into practice how they compare with stored procedures.

Try to solve them before looking at the solution.

---

### **Exercise 1: Function that doubles a number**

Create a `doble_valor` function that takes a number and returns its value multiplied by 2.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE FUNCTION doble_valor(p_num DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  RETURN p_num * 2;
END $$
DELIMITER ;

SELECT doble_valor(15.50) AS resultado;
```

</details>

---

### **Exercise 2: Function that calculates the discount**

Create a `precio_con_descuento` function that takes the price and a discount percentage, and returns the final price.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE FUNCTION precio_con_descuento(p_precio DECIMAL(10,2), p_descuento DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  RETURN p_precio - (p_precio * p_descuento / 100);
END $$
DELIMITER ;

SELECT precio_con_descuento(200, 15) AS precio_final;
```

</details>

---

### **Exercise 3: Function with text validation**

Create a `formatear_nombre` function that takes a name and returns it in uppercase, with leading and trailing spaces removed.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE FUNCTION formatear_nombre(p_nombre VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
  RETURN UPPER(TRIM(p_nombre));
END $$
DELIMITER ;

SELECT formatear_nombre('  maria lopez  ') AS nombre_formateado;
```

</details>

---

### **Exercise 4: Function that classifies customers by spending**

Create a `clasificar_cliente` function that takes the total spent and returns 'ALTO', 'MEDIO' or 'BAJO' according to:

- `>= 1000` → ALTO
- `>= 500 y < 1000` → MEDIO
- `< 500` → BAJO

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE FUNCTION clasificar_cliente(p_total DECIMAL(12,2))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
  IF p_total >= 1000 THEN
    RETURN 'ALTO';
  ELSEIF p_total >= 500 THEN
    RETURN 'MEDIO';
  ELSE
    RETURN 'BAJO';
  END IF;
END $$
DELIMITER ;

SELECT clasificar_cliente(750) AS categoria;
```

</details>

---

### **Exercise 5: Function combined with a query**

Create an `edad_en_meses` function that takes an age in years and returns the age in months. Use it to display the customers' names and their ages in months.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE FUNCTION edad_en_meses(p_edad INT)
RETURNS INT
DETERMINISTIC
BEGIN
  RETURN p_edad * 12;
END $$
DELIMITER ;

SELECT first_name, edad_en_meses(age) AS meses
FROM customers;
```

</details>
