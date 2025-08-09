# **Ejercicios - Tema 10: Índices en MySQL**

A continuación, encontrarás 5 ejercicios prácticos para crear, gestionar y eliminar índices en MySQL.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear un índice simple en una columna de búsqueda frecuente**

Crea un índice llamado `idx_city` en la columna `city` de la tabla `customers`.

<details><summary>Mostrar Solución</summary>

```sql
CREATE INDEX idx_city ON customers(city);
```

</details>

---

### **Ejercicio 2: Crear un índice único para asegurar datos sin duplicados**

En la tabla `suppliers`, crea un índice único en la columna `tax_id` para que no se repita.

<details><summary>Mostrar Solución</summary>

```sql
CREATE UNIQUE INDEX idx_tax_id ON suppliers(tax_id);
```

</details>

---

### **Ejercicio 3: Crear un índice compuesto**

En la tabla `orders`, crea un índice llamado `idx_customer_date` que incluya las columnas `customer_id` y `created_at`.

<details><summary>Mostrar Solución</summary>

```sql
CREATE INDEX idx_customer_date ON orders(customer_id, created_at);
```

</details>

---

### **Ejercicio 4: Ver los índices existentes en una tabla**

Consulta todos los índices creados en la tabla `products`.

<details><summary>Mostrar Solución</summary>

```sql
SHOW INDEX FROM products;
```

</details>

---

### **Ejercicio 5: Eliminar un índice existente**

Elimina el índice `idx_city` de la tabla `customers`.

<details><summary>Mostrar Solución</summary>

```sql
DROP INDEX idx_city ON customers;
```

</details>
