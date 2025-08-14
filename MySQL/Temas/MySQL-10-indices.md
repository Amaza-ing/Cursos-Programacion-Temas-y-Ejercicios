# **Tema 10: Índices en MySQL**

En este tema aprenderemos a:

- Entender qué es un índice y para qué sirve.
- Crear índices para optimizar consultas.
- Conocer los diferentes tipos de índices en MySQL.
- Gestionar y eliminar índices.

---

## **1. ¿Qué es un índice?**

Un **índice** es una estructura de datos especial que MySQL utiliza para localizar rápidamente las filas de una tabla sin tener que escanearla completamente.

### **Ventajas:**

- Acelera las consultas `SELECT`.
- Mejora el rendimiento en búsquedas y ordenaciones.

### **Desventajas:**

- Ocupa espacio adicional en disco.
- Puede ralentizar operaciones `INSERT`, `UPDATE` y `DELETE` debido a la actualización del índice.

---

## **2. Tipos de índices en MySQL**

### **Índice normal (INDEX)**

Se utiliza para acelerar búsquedas en columnas específicas.

```sql
CREATE INDEX idx_nombre ON customers(first_name);
```

### **Índice único (UNIQUE)**

Garantiza que todos los valores en una columna sean únicos.

```sql
CREATE UNIQUE INDEX idx_email ON customers(email);
```

### **Índice de clave primaria (PRIMARY KEY)**

Se crea automáticamente cuando definimos una `PRIMARY KEY`.

### **Índice de texto completo (FULLTEXT)**

Especial para búsquedas de texto en columnas grandes (`TEXT`, `VARCHAR`).

```sql
CREATE FULLTEXT INDEX idx_texto ON articles(content);
```

### **Índice compuesto**

Cubre múltiples columnas para optimizar búsquedas que involucren varias condiciones.

```sql
CREATE INDEX idx_nombre_apellido ON customers(first_name, last_name);
```

---

## **3. Crear índices al momento de crear la tabla**

Podemos definir índices directamente en la creación de una tabla:

```sql
CREATE TABLE products (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  price DECIMAL(10,2),
  INDEX idx_price (price)
);
```

---

## **4. Ver índices existentes**

Para ver los índices de una tabla:

```sql
SHOW INDEX FROM customers;
```

---

## **5. Eliminar índices**

Podemos borrar un índice con:

```sql
DROP INDEX idx_nombre ON customers;
```

> No se pueden eliminar índices creados automáticamente por una clave primaria sin eliminar primero la clave primaria.

---

## **6. Buenas prácticas con índices**

- Indexar columnas utilizadas frecuentemente en `WHERE`, `JOIN` u `ORDER BY`.
- Evitar crear demasiados índices innecesarios.
- Revisar periódicamente el rendimiento con `EXPLAIN`.

---

## **7. Conclusión**

- Los índices mejoran la velocidad de lectura de datos.
- Existen varios tipos: normales, únicos, compuestos y de texto completo.
- Deben usarse estratégicamente para equilibrar rendimiento y consumo de recursos.

---

En el próximo tema aprenderemos a **crear y utlizar procedimientos almacenados para reutilizar el código**
