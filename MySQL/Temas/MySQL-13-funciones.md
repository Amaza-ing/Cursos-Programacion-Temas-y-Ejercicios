# **Tema 13: Funciones en MySQL y Diferencias con Procedimientos Almacenados**

En este tema aprenderemos a:

- Entender qué es una función en MySQL.
- Crear y ejecutar funciones personalizadas.
- Conocer las diferencias clave entre funciones y procedimientos almacenados.
- Aplicar buenas prácticas en su uso.

---

## **1. ¿Qué es una función en MySQL?**

Una **función** es un bloque de código SQL almacenado en la base de datos que recibe parámetros, realiza operaciones y devuelve **un único valor**.

### **Características:**

- Siempre devuelve un valor mediante `RETURN`.
- Puede recibir uno o más parámetros.
- Puede usarse directamente en consultas `SELECT`.

---

## **2. Sintaxis para crear una función**

```sql
DELIMITER $$
CREATE FUNCTION nombre_funcion(parametros)
RETURNS tipo_dato
DETERMINISTIC
BEGIN
  -- lógica de la función
  RETURN valor;
END $$
DELIMITER ;
```

> `DETERMINISTIC` indica que la función devuelve siempre el mismo resultado para los mismos parámetros.

---

## **3. Ejemplo básico**

Función para calcular el precio con IVA (21%).

```sql
DELIMITER $$
CREATE FUNCTION precio_con_iva(p_precio DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  RETURN p_precio * 1.21;
END $$
DELIMITER ;
```

Uso:

```sql
SELECT name, precio_con_iva(price) AS precio_final FROM products;
```

---

## **4. Función con lógica condicional**

```sql
DELIMITER $$
CREATE FUNCTION es_mayor_de_edad(p_edad INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
  IF p_edad >= 18 THEN
    RETURN 'SI';
  ELSE
    RETURN 'NO';
  END IF;
END $$
DELIMITER ;
```

Uso:

```sql
SELECT first_name, es_mayor_de_edad(age) AS mayor FROM customers;
```

---

## **5. Diferencias entre funciones y procedimientos almacenados**

| Característica   | Función                           | Procedimiento                                            |
| ---------------- | --------------------------------- | -------------------------------------------------------- |
| Devuelve valor   | Sí, uno solo                      | No necesariamente (puede devolver cero o más resultados) |
| Uso en consultas | Sí                                | No directamente                                          |
| Llamada          | Dentro de `SELECT`, `WHERE`, etc. | Con `CALL nombre_procedimiento()`                        |
| Parámetros       | Solo `IN`                         | `IN`, `OUT` e `INOUT`                                    |

---

## **6. Ver funciones existentes**

```sql
SHOW FUNCTION STATUS WHERE Db = 'nombre_base_datos';
```

---

## **7. Eliminar una función**

```sql
DROP FUNCTION IF EXISTS precio_con_iva;
```

---

## **8. Buenas prácticas**

- Usar funciones para cálculos y transformaciones que devuelvan un solo valor.
- Mantener la lógica sencilla y evitar operaciones que modifiquen datos.
- Documentar el propósito de cada función.

---

## **9. Conclusión**

- Las funciones permiten encapsular cálculos y reutilizarlos en consultas.
- Se diferencian de los procedimientos en que siempre devuelven un valor y pueden usarse dentro de sentencias SQL.
- Un uso adecuado mejora la claridad y reutilización del código SQL.

---

En el siguiente tema aprenderemos a **trabajar con variables booleanas y de tipo fecha**.
