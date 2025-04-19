# **Ejercicios - Tema 5: Normalización de Tablas en MySQL**

A continuación, encontrarás 4 ejercicios prácticos sobre normalización de bases de datos. Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Detectar violaciones de 1NF**

Analiza la siguiente tabla y explica por qué no está en Primera Forma Normal (1NF). Luego, propón una versión normalizada.

| id  | nombre | correos                 |
| --- | ------ | ----------------------- |
| 1   | Elena  | elena@mail.com; e@x.com |

<details><summary>Mostrar Solución</summary>

La columna `correos` contiene múltiples valores en una sola celda, lo cual viola la 1NF.

**Solución (normalizada):**

| id  | nombre | correo         |
| --- | ------ | -------------- |
| 1   | Elena  | elena@mail.com |
| 1   | Elena  | e@x.com        |

</details>

---

### **Ejercicio 2: Separar datos según 2NF**

Observa la siguiente tabla:

| profesor_id | curso_id | profesor_nombre |
| ----------- | -------- | --------------- |
| 1           | 101      | Juan Ortega     |
| 1           | 102      | Juan Ortega     |

¿Viola la Segunda Forma Normal? Si es así, normaliza la estructura.

<details><summary>Mostrar Solución</summary>

Sí. `profesor_nombre` depende solo de `profesor_id`, no del conjunto `(profesor_id, curso_id)`.

**Solución:**

**Tabla `teachers`:**
| profesor_id | profesor_nombre |
|-------------|------------------|
| 1 | Juan Ortega |

**Tabla `teaching`:**
| profesor_id | curso_id |
|-------------|-----------|
| 1 | 101 |
| 1 | 102 |

</details>

---

### **Ejercicio 3: Eliminar dependencia transitiva (3NF)**

Analiza esta tabla:

| cliente_id | nombre_cliente | ciudad    | país   |
| ---------- | -------------- | --------- | ------ |
| 1          | Ana Rivas      | Madrid    | España |
| 2          | Laura Vázquez  | Barcelona | España |

¿Qué problema de 3NF puedes identificar? Propón la normalización.

<details><summary>Mostrar Solución</summary>

`país` depende de `ciudad`, no directamente de `cliente_id`. Esto es una dependencia transitiva.

**Solución:**

**Tabla `cities`:**
| ciudad_id | ciudad | país |
|-----------|-----------|---------|
| 1 | Madrid | España |
| 2 | Barcelona | España |

**Tabla `customers`:**
| cliente_id | nombre_cliente | ciudad_id |
|------------|----------------|-----------|
| 1 | Ana Rivas | 1 |
| 2 | Laura Vázquez | 2 |

</details>

---

### **Ejercicio 4: Normalizar una tabla de pedidos**

Dada la siguiente tabla:

| pedido_id | cliente     | producto   | cantidad | precio_unitario |
| --------- | ----------- | ---------- | -------- | --------------- |
| 1         | Pedro Núñez | Bolígrafo  | 3        | 0.75            |
| 2         | Pedro Núñez | Carpeta A4 | 2        | 1.50            |

Diseña un modelo normalizado en al menos tres tablas.

<details><summary>Mostrar Solución</summary>

**Tabla `customers`:**
| id | nombre |
|----|--------------|
| 1 | Pedro Núñez |

**Tabla `products`:**
| id | nombre | precio_unitario |
|----|--------------|------------------|
| 1 | Bolígrafo | 0.75 |
| 2 | Carpeta A4 | 1.50 |

**Tabla `orders`:**
| id | customer_id |
|----|-------------|
| 1 | 1 |
| 2 | 1 |

**Tabla `order_details`:**
| order_id | product_id | cantidad |
|----------|------------|----------|
| 1 | 1 | 3 |
| 2 | 2 | 2 |

</details>
