# **Tema 4: Normalización de Tablas en MySQL**

En este tema aprenderemos:

- Qué es la normalización de bases de datos.
- Cuáles son las formas normales más importantes.
- Cómo aplicar normalización a nuestras tablas para evitar redundancias y mejorar la integridad de los datos.

---

## **1. ¿Qué es la normalización?**

La **normalización** es un proceso que se aplica al diseño de bases de datos para:

- Reducir la **redundancia de datos**.
- Evitar **anomalías** en las operaciones de inserción, actualización y eliminación.
- Mejorar la **integridad de los datos**.

Normalizar una base de datos significa **dividir los datos en varias tablas relacionadas** correctamente.

---

## **2. Formas Normales**

Las formas normales son reglas o niveles que nos ayudan a decidir si una base de datos está bien estructurada. A continuación veremos las tres más utilizadas:

### **1ª Forma Normal (1NF)**

- Cada celda debe contener un único valor (no listas o arrays).
- Cada fila debe ser única.
- Las columnas deben tener el mismo tipo de datos en todas las filas.

**Ejemplo incorrecto (no está en 1NF):**

| id  | nombre | teléfonos         |
| --- | ------ | ----------------- |
| 1   | Laura  | 123456, 789101112 |

**Solución (en 1NF):**

| id  | nombre | teléfono  |
| --- | ------ | --------- |
| 1   | Laura  | 123456    |
| 1   | Laura  | 789101112 |

---

### **2ª Forma Normal (2NF)**

- Debe cumplir la 1NF.
- Todos los atributos no clave deben depender de **toda** la clave primaria (no sólo de una parte).

**Ejemplo incorrecto:**

| curso_id | estudiante_id | estudiante_nombre |
| -------- | ------------- | ----------------- |
| 1        | 10            | Ana Fernández     |

`estudiante_nombre` depende solo de `estudiante_id`, no del conjunto `(curso_id, estudiante_id)`.

**Solución:**
Separar en dos tablas:

**Tabla `enrollments`:**
| curso_id | estudiante_id |
|----------|----------------|
| 1 | 10 |

**Tabla `students`:**
| estudiante_id | estudiante_nombre |
|----------------|-------------------|
| 10 | Ana Fernández |

---

### **3ª Forma Normal (3NF)**

- Debe cumplir la 2NF.
- No debe haber **dependencias transitivas**, es decir, los atributos no clave no deben depender entre sí.

**Ejemplo incorrecto:**

| id  | nombre_cliente | ciudad  | código_postal |
| --- | -------------- | ------- | ------------- |
| 1   | Raúl Pérez     | Sevilla | 41001         |

`código_postal` depende de `ciudad`, no directamente de `id`.

**Solución:** Separar en dos tablas:

**Tabla `customers`:**
| id | nombre_cliente | ciudad_id |
|----|----------------|-----------|
| 1 | Raúl Pérez | 3 |

**Tabla `cities`:**
| ciudad_id | ciudad | código_postal |
|-----------|---------|----------------|
| 3 | Sevilla | 41001 |

---

## **3. Ejemplo de Normalización paso a paso**

Supongamos que tenemos esta tabla inicial:

| pedido_id | cliente_nombre | producto | cantidad | precio_total |
| --------- | -------------- | -------- | -------- | ------------ |
| 1         | Ana Gómez      | Lápiz    | 2        | 1.00         |
| 2         | Ana Gómez      | Cuaderno | 1        | 2.00         |

Esta tabla mezcla información de clientes, pedidos y productos.

### **Paso 1: separar productos**

**Tabla `products`:**
| id | nombre | precio_unitario |
|----|-----------|-----------------|
| 1 | Lápiz | 0.50 |
| 2 | Cuaderno | 2.00 |

### **Paso 2: separar clientes**

**Tabla `customers`:**
| id | nombre |
|----|-------------|
| 1 | Ana Gómez |

### **Paso 3: registrar pedidos y detalles**

**Tabla `orders`:**
| id | customer_id |
|----|-------------|
| 1 | 1 |
| 2 | 1 |

**Tabla `order_details`:**
| order_id | product_id | cantidad |
|----------|------------|----------|
| 1 | 1 | 2 |
| 2 | 2 | 1 |

---

[![Normalización de Tablas](https://img.youtube.com/vi/w0olqd2CxJI/0.jpg)](https://www.youtube.com/watch?v=w0olqd2CxJI&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **4. Ventajas de la normalización**

- Evita la repetición innecesaria de datos.
- Reduce el tamaño de la base de datos.
- Facilita la modificación y actualización.
- Mejora la consistencia de los datos.

---

## **5. Cuándo no normalizar en exceso**

Aunque la normalización es útil, **una base de datos demasiado fragmentada puede afectar al rendimiento**.

En sistemas con muchas consultas de lectura, a veces se opta por una **desnormalización controlada** para reducir la cantidad de `JOIN` necesarios.

Existen hasta una cuarta y quinta formas normales, pero no suelen ser necesarias salvo en casos muy concretos.

---

## **6. Conclusión**

- La normalización organiza la información en varias tablas bien estructuradas.
- Las tres primeras formas normales (1NF, 2NF y 3NF) cubren la mayoría de los casos prácticos.
- Un buen diseño de base de datos comienza con una buena normalización.

---

En el próximo tema aprenderemos a realizar **consultas avanzadas con SELECT y condiciones usando WHERE, ORDER BY, LIMIT y operadores lógicos.**
