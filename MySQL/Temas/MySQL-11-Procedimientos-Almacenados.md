# **Topic 11: Stored Procedures in MySQL**

In this topic we will learn to:

- Understand what a stored procedure is.
- Create and execute stored procedures.
- Use input and output parameters.
- Modify and eliminate procedures.

---

## **1. What is a stored procedure?**

A **stored procedure** is a set of SQL statements that is stored in the database and can be executed later.

### **Advantages:**

- Code reuse.
- Performance improvement by reducing traffic between the application and the database.
- Greater security, since the logic is maintained on the server.

---

## **2. Create a stored procedure**

### **Basic syntax:**

```sql
DELIMITER $$
CREATE PROCEDURE nombre_procedimiento()
BEGIN
  -- instrucciones SQL
END $$
DELIMITER ;
```

### **Example:**

```sql
DELIMITER $$
CREATE PROCEDURE obtener_clientes()
BEGIN
  SELECT * FROM customers;
END $$
DELIMITER ;
```

This procedure, when executed, returns all clients.

---

## **3. Run a stored procedure**

```sql
CALL obtener_clientes();
```

---

## **4. Procedures with parameters**

### **Input parameters (IN)**

```sql
DELIMITER $$
CREATE PROCEDURE obtener_pedidos_cliente(IN cliente_id INT)
BEGIN
  SELECT * FROM orders WHERE customer_id = cliente_id;
END $$
DELIMITER ;
```

Call:

```sql
CALL obtener_pedidos_cliente(3);
```

### **Output parameters (OUT)**

```sql
DELIMITER $$
CREATE PROCEDURE contar_pedidos_cliente(IN cliente_id INT, OUT total_pedidos INT)
BEGIN
  SELECT COUNT(*) INTO total_pedidos FROM orders WHERE customer_id = cliente_id;
END $$
DELIMITER ;
```

Call:

```sql
CALL contar_pedidos_cliente(3, @total);
SELECT @total;
```

### **Input/output parameters (INOUT)**

They allow you to modify the value of a parameter and return it modified.

---

## **5. Delete a procedure**

```sql
DROP PROCEDURE obtener_clientes;
```

---

## **6. Modify a procedure**

In MySQL there is no `ALTER PROCEDURE` to change the logic directly. It must be deleted and recreated:

```sql
DROP PROCEDURE IF EXISTS obtener_clientes;
CREATE PROCEDURE obtener_clientes() ...
```

"Pure" MySQL (up to and including version 8.0) does not support

```sql
CREATE OR REPLACE PROCEDURE obtener_clientes;
```

This syntax does exist in other engines such as PostgreSQL and Oracle.

---

## **7. See existing procedures**

```sql
SHOW PROCEDURE STATUS WHERE Db = 'nombre_base_datos';
```

---

[![Stored Procedures](https://img.youtube.com/vi/4qnZDc2yWYc/0.jpg)](https://www.youtube.com/watch?v=4qnZDc2yWYc&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **8. Conclusion**

- Stored procedures allow you to encapsulate SQL logic within the database.
- They can receive input, output parameters or both.
- They are executed with `CALL` and managed with `DROP` to remove them.

---

In the next topic we will learn to **create and use triggers to automate actions in the database.**
