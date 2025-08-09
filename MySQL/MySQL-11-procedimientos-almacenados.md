# **Tema 11: Procedimientos Almacenados en MySQL**

En este tema aprenderemos a:

- Comprender qué es un procedimiento almacenado.
- Crear y ejecutar procedimientos almacenados.
- Usar parámetros de entrada y salida.
- Modificar y eliminar procedimientos.

---

## **1. ¿Qué es un procedimiento almacenado?**

Un **procedimiento almacenado** es un conjunto de instrucciones SQL que se guarda en la base de datos y que puede ejecutarse posteriormente.

### **Ventajas:**

- Reutilización de código.
- Mejora de rendimiento al reducir el tráfico entre la aplicación y la base de datos.
- Mayor seguridad, ya que la lógica se mantiene en el servidor.

---

## **2. Crear un procedimiento almacenado**

### **Sintaxis básica:**

```sql
DELIMITER $$
CREATE PROCEDURE nombre_procedimiento()
BEGIN
  -- instrucciones SQL
END $$
DELIMITER ;
```

### **Ejemplo:**

```sql
DELIMITER $$
CREATE PROCEDURE obtener_clientes()
BEGIN
  SELECT * FROM customers;
END $$
DELIMITER ;
```

Este procedimiento, al ejecutarse, devuelve todos los clientes.

---

## **3. Ejecutar un procedimiento almacenado**

```sql
CALL obtener_clientes();
```

---

## **4. Procedimientos con parámetros**

### **Parámetros de entrada (IN)**

```sql
DELIMITER $$
CREATE PROCEDURE obtener_pedidos_cliente(IN cliente_id INT)
BEGIN
  SELECT * FROM orders WHERE customer_id = cliente_id;
END $$
DELIMITER ;
```

Llamada:

```sql
CALL obtener_pedidos_cliente(3);
```

### **Parámetros de salida (OUT)**

```sql
DELIMITER $$
CREATE PROCEDURE contar_pedidos_cliente(IN cliente_id INT, OUT total_pedidos INT)
BEGIN
  SELECT COUNT(*) INTO total_pedidos FROM orders WHERE customer_id = cliente_id;
END $$
DELIMITER ;
```

Llamada:

```sql
CALL contar_pedidos_cliente(3, @total);
SELECT @total;
```

### **Parámetros de entrada/salida (INOUT)**

Permiten modificar el valor de un parámetro y devolverlo modificado.

---

## **5. Eliminar un procedimiento**

```sql
DROP PROCEDURE obtener_clientes;
```

---

## **6. Modificar un procedimiento**

En MySQL no existe `ALTER PROCEDURE` para cambiar la lógica directamente. Se debe eliminar y volver a crear:

```sql
DROP PROCEDURE IF EXISTS obtener_clientes;
CREATE PROCEDURE obtener_clientes() ...
```

MySQL "puro" (hasta la versión 8.0 incluida) no soporta

```sql
CREATE OR REPLACE PROCEDURE obtener_clientes;
```

Esa sintaxis sí existe en otros motores como PostgreSQL y Oracle.

---

## **7. Ver procedimientos existentes**

```sql
SHOW PROCEDURE STATUS WHERE Db = 'nombre_base_datos';
```

---

## **8. Conclusión**

- Los procedimientos almacenados permiten encapsular lógica SQL dentro de la base de datos.
- Pueden recibir parámetros de entrada, salida o ambos.
- Se ejecutan con `CALL` y se gestionan con `DROP` para eliminarlos.

---

En el próximo tema aprenderemos a **crear y usar triggers (disparadores) para automatizar acciones en la base de datos.**
