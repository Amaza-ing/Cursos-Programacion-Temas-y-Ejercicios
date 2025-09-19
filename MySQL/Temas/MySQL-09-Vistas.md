# **Tema 9: Crear y Gestionar Vistas (VIEW) en MySQL**

En este tema aprenderemos a:

- Entender qué es una vista (`VIEW`).
- Crear vistas para simplificar consultas complejas.
- Actualizar, eliminar y usar vistas como tablas virtuales.

---

## **1. ¿Qué es una vista (VIEW)?**

Una **vista** es una consulta guardada que se comporta como una tabla virtual. No almacena datos por sí misma, sino que muestra el resultado de una consulta cada vez que se accede.

### **Ventajas:**

- Oculta la complejidad de consultas largas.
- Mejora la legibilidad y mantenimiento del código.
- Puede limitar el acceso a ciertos datos.

---

## **2. Crear una vista**

### **Sintaxis básica:**

```sql
CREATE VIEW nombre_vista AS
SELECT columnas
FROM tabla(s)
WHERE condición;
```

### **Ejemplo:**

Vista que muestra los pedidos con información del cliente:

```sql
CREATE VIEW pedidos_con_clientes AS
SELECT o.id AS order_id, c.first_name, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.id;
```

---

## **3. Consultar una vista**

Una vez creada, puedes consultar la vista como si fuera una tabla:

```sql
SELECT * FROM pedidos_con_clientes;
```

También puedes aplicar filtros adicionales:

```sql
SELECT * FROM pedidos_con_clientes
WHERE total_amount > 100;
```

---

## **4. Actualizar una vista**

Puedes modificar una vista con `CREATE OR REPLACE VIEW`:

```sql
CREATE OR REPLACE VIEW pedidos_con_clientes AS
SELECT o.id, c.first_name, c.last_name, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.id;
```

> Ten en cuenta que solo algunas vistas pueden ser actualizadas directamente (cuando no contienen funciones de agregación, `GROUP BY`, `DISTINCT`, etc.).

---

## **5. Eliminar una vista**

Para eliminar una vista:

```sql
DROP VIEW pedidos_con_clientes;
```

---

## **6. Comprobar vistas existentes**

Para ver todas las vistas definidas en la base de datos:

```sql
SHOW FULL TABLES WHERE Table_type = 'VIEW';
```

---

## **7. Cuándo usar vistas**

Usa vistas cuando:

- Necesites reutilizar una consulta larga o compleja.
- Quieras presentar datos combinados de varias tablas.
- Quieras restringir el acceso a columnas específicas.

---

[![Vistas](https://img.youtube.com/vi/7T5ZYN78JaM/0.jpg)](https://www.youtube.com/watch?v=7T5ZYN78JaM&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **8. Conclusión**

- Las vistas simplifican el acceso a datos complejos.
- Son útiles para estructurar mejor las consultas y reutilizarlas.
- Aunque parecen tablas, no almacenan datos directamente.

---

En el siguiente tema aprenderemos a **crear y utilizar índices.**
