# **Topic 13: Functions in MySQL and How They Differ from Stored Procedures**

In this topic we will learn how to:

- Understand what a function is in MySQL.
- Create and run custom functions.
- Know the key differences between functions and stored procedures.
- Follow good practices when using them.

---

## **1. What is a function in MySQL?**

A **function** is a block of SQL code stored in the database that takes parameters, performs operations and returns **a single value**.

### **Characteristics:**

- It always returns a value using `RETURN`.
- It can take one or more parameters.
- It can be used directly in `SELECT` queries.

---

## **2. Syntax for creating a function**

```sql
DELIMITER $$
CREATE FUNCTION nombre_funcion(parametros)
RETURNS tipo_dato
DETERMINISTIC
BEGIN
  -- lógica de la función
  RETURN valor;
END $$
DELIMITER ;
```

> `DETERMINISTIC` indicates that the function always returns the same result for the same parameters.

---

## **3. Basic example**

A function that calculates the price with VAT (21%).

```sql
DELIMITER $$
CREATE FUNCTION precio_con_iva(p_precio DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  RETURN p_precio * 1.21;
END $$
DELIMITER ;
```

Usage:

```sql
SELECT name, precio_con_iva(price) AS precio_final FROM products;
```

---

## **4. Function with conditional logic**

```sql
DELIMITER $$
CREATE FUNCTION es_mayor_de_edad(p_edad INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
  IF p_edad >= 18 THEN
    RETURN 'SI';
  ELSE
    RETURN 'NO';
  END IF;
END $$
DELIMITER ;
```

Usage:

```sql
SELECT first_name, es_mayor_de_edad(age) AS mayor FROM customers;
```

---

## **5. Differences between functions and stored procedures**

| Characteristic | Function | Procedure |
| ---------------- | --------------------------------- | -------------------------------------------------------- |
| Returns a value | Yes, just one | Not necessarily (it may return zero or more results) |
| Use in queries | Yes | Not directly |
| How it is called | Inside `SELECT`, `WHERE`, etc. | With `CALL nombre_procedimiento()` |
| Parameters | Only `IN` | `IN`, `OUT` and `INOUT` |

---

## **6. Viewing existing functions**

```sql
SHOW FUNCTION STATUS WHERE Db = 'nombre_base_datos';
```

---

## **7. Deleting a function**

```sql
DROP FUNCTION IF EXISTS precio_con_iva;
```

---

## **8. Good practices**

- Use functions for calculations and transformations that return a single value.
- Keep the logic simple and avoid operations that modify data.
- Document the purpose of each function.

---

## **9. Conclusion**

- Functions let you encapsulate calculations and reuse them in queries.
- They differ from procedures in that they always return a value and can be used inside SQL statements.
- Using them properly makes SQL code clearer and more reusable.

---

In the next topic we will learn how to **work with Boolean and date variables**.
