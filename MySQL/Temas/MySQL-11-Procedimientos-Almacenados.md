# **Topic 11: Stored Procedures in MySQL**

In this topic we will learn how to:

- Understand what a stored procedure is.
- Create and run stored procedures.
- Use input and output parameters.
- Modify and delete procedures.

---

## **1. What is a stored procedure?**

A **stored procedure** is a set of SQL statements that is saved in the database and can be run later.

### **Advantages:**

- Code reuse.
- Better performance, by reducing traffic between the application and the database.
- Greater security, since the logic stays on the server.

---

## **2. Creating a stored procedure**

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

When you run this procedure, it returns all the customers.

---

## **3. Running a stored procedure**

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

They let you change the value of a parameter and return it modified.

---

## **5. Deleting a procedure**

```sql
DROP PROCEDURE obtener_clientes;
```

---

## **6. Modifying a procedure**

In MySQL there is no `ALTER PROCEDURE` to change the logic directly. You have to delete the procedure and create it again:

```sql
DROP PROCEDURE IF EXISTS obtener_clientes;
CREATE PROCEDURE obtener_clientes() ...
```

"Pure" MySQL (up to and including version 8.0) does not support

```sql
CREATE OR REPLACE PROCEDURE obtener_clientes;
```

That syntax does exist in other database engines, such as PostgreSQL and Oracle.

---

## **7. Viewing existing procedures**

```sql
SHOW PROCEDURE STATUS WHERE Db = 'nombre_base_datos';
```

---

[![Stored procedures](https://img.youtube.com/vi/4qnZDc2yWYc/0.jpg)](https://www.youtube.com/watch?v=4qnZDc2yWYc&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **8. Conclusion**

- Stored procedures let you encapsulate SQL logic inside the database.
- They can take input parameters, output parameters or both.
- They are run with `CALL`, and `DROP` removes them.

---

In the next topic we will learn how to **create and use triggers to automate actions in the database.**
