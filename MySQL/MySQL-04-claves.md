# **Tema 4: Claves Primarias y Foráneas en MySQL**

En este tema aprenderemos a:

- Definir claves primarias (`PRIMARY KEY`).
- Crear claves foráneas (`FOREIGN KEY`) para relacionar tablas.
- Aplicar restricciones de integridad referencial.

---

## **1. ¿Qué es una clave primaria?**

Una **clave primaria** es una columna (o combinación de columnas) que identifica de forma única cada fila en una tabla.

### **Características:**

- No puede contener valores duplicados.
- No puede ser nula.

### **Ejemplo:**

```sql
CREATE TABLE customers (
  id INT PRIMARY KEY,
  name VARCHAR(50)
);
```

También puede definirse al final:

```sql
CREATE TABLE customers (
  id INT,
  name VARCHAR(50),
  PRIMARY KEY (id)
);
```

---

## **2. ¿Qué es una clave foránea?**

Una **clave foránea** es una columna que apunta a una clave primaria en otra tabla. Sirve para establecer una relación entre tablas.

### **Ejemplo:**

```sql
CREATE TABLE orders (
  id INT PRIMARY KEY,
  customer_id INT,
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);
```

Esto indica que `customer_id` en `orders` debe coincidir con un `id` existente en `customers`.

---

## **3. Crear varias claves**

Una tabla puede tener una clave primaria y varias claves foráneas.

```sql
CREATE TABLE order_details (
  order_id INT,
  product_id INT,
  quantity INT,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);
```

> En este caso, la clave primaria es compuesta: cada combinación de `order_id` y `product_id` debe ser única.

---

## **4. Restricciones adicionales**

Puedes definir qué ocurre cuando se elimina o actualiza un valor referenciado.

### **ON DELETE y ON UPDATE**

```sql
FOREIGN KEY (customer_id) REFERENCES customers(id)
ON DELETE CASCADE
ON UPDATE CASCADE
```

### **Opciones comunes:**

- `CASCADE`: aplica el cambio a las filas relacionadas.
- `SET NULL`: pone el valor a `NULL` si se elimina el registro referenciado.
- `RESTRICT`: impide eliminar/actualizar si hay filas relacionadas.

---

## **5. Ver claves y relaciones en una tabla existente**

Consulta la estructura de una tabla para ver claves definidas:

```sql
SHOW CREATE TABLE orders;
```

---

## **6. Ventajas de usar claves correctamente**

- Garantizan la integridad de los datos.
- Evitan registros huérfanos o inconsistentes.
- Permiten trabajar con `JOIN` de forma segura.

---

## **7. Conclusión**

- Las claves primarias identifican registros de forma única.
- Las claves foráneas permiten relacionar tablas.
- Las restricciones `ON DELETE` y `ON UPDATE` controlan el comportamiento de las relaciones.

---

En el siguiente tema aprenderemos a **Normalizar tablas antes de trabajar con ellas**.
