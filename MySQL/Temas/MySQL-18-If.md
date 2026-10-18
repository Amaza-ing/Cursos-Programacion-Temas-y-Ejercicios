# **Topic 18: Using IF in Queries and Stored Procedures in MySQL**

In this topic we will learn how to:

- Use `IF()` in queries to make conditional decisions.
- Use `IF ... THEN ... ELSE` structures inside stored procedures.
- Tell the difference between `IF()` as a function and `IF` as a control structure.

---

## **1. IF() in queries**

In MySQL, `IF()` is a **function** that lets you evaluate a condition and return one value if it is true and another if it is false.

### **Syntax:**

```sql
IF(condición, valor_si_verdadero, valor_si_falso)
```

### **Example:**

Show a customer's status based on the `is_active` field:

```sql
SELECT first_name,
       IF(is_active = 1, 'ACTIVO', 'INACTIVO') AS estado
FROM customers;
```

---

## **2. Using CASE as an alternative**

Although it is not part of the main topic, it is useful to know that `CASE` also handles conditionals and is more flexible:

```sql
SELECT first_name,
       CASE
         WHEN is_active = 1 THEN 'ACTIVO'
         ELSE 'INACTIVO'
       END AS estado
FROM customers;
```

---

## **3. IF in stored procedures**

Inside stored procedures, `IF` is used as a **control structure**.

### **Syntax:**

```sql
IF condición THEN
   -- instrucciones
ELSEIF otra_condición THEN
   -- instrucciones
ELSE
   -- instrucciones
END IF;
```

### **Example:**

```sql
DELIMITER $$
CREATE PROCEDURE evaluar_cliente(IN p_id INT)
BEGIN
  DECLARE v_total DECIMAL(10,2);
  SELECT SUM(total_amount) INTO v_total
  FROM orders
  WHERE customer_id = p_id;

  IF v_total >= 1000 THEN
    SELECT 'Cliente Premium' AS categoria;
  ELSEIF v_total >= 500 THEN
    SELECT 'Cliente Frecuente' AS categoria;
  ELSE
    SELECT 'Cliente Ocasional' AS categoria;
  END IF;
END $$
DELIMITER ;
```

---

## **4. IF inside SET or SELECT in procedures**

We can use `IF()` as a function in procedures:

```sql
DELIMITER $$
CREATE PROCEDURE estado_cliente(IN p_id INT)
BEGIN
  DECLARE v_estado VARCHAR(20);
  SELECT IF(is_active = 1, 'ACTIVO', 'INACTIVO') INTO v_estado
  FROM customers
  WHERE id = p_id;
  SELECT v_estado AS estado;
END $$
DELIMITER ;
```

---

[![IF ELSE conditionals](https://img.youtube.com/vi/DFZmMB7DO_E/0.jpg)](https://www.youtube.com/watch?v=DFZmMB7DO_E&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **5. Good practices**

- Use `IF()` for simple conditions in queries.
- Use `IF ... THEN ... END IF` in procedures for more complex logic.
- When there are multiple conditions, `CASE` is usually more readable.

---

## **6. Conclusion**

- `IF()` in queries returns conditional values without modifying the structure of the rows.
- `IF ... THEN` in procedures lets you run different statements depending on conditions.
- They are key tools for applying conditional logic in SQL.

---

In the next topic we will see **how to create iterations using `while`**.
