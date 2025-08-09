# **Ejercicios - Tema 13: Funciones en MySQL**

A continuación, encontrarás 5 ejercicios prácticos para crear y usar **funciones** en MySQL, aplicando también la comparación con procedimientos almacenados.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Función para calcular el doble de un número**

Crea una función `doble_valor` que reciba un número y devuelva su valor multiplicado por 2.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE FUNCTION doble_valor(p_num DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  RETURN p_num * 2;
END $$
DELIMITER ;

SELECT doble_valor(15.50) AS resultado;
```

</details>

---

### **Ejercicio 2: Función para calcular el descuento**

Crea una función `precio_con_descuento` que reciba el precio y un porcentaje de descuento, y devuelva el precio final.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE FUNCTION precio_con_descuento(p_precio DECIMAL(10,2), p_descuento DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  RETURN p_precio - (p_precio * p_descuento / 100);
END $$
DELIMITER ;

SELECT precio_con_descuento(200, 15) AS precio_final;
```

</details>

---

### **Ejercicio 3: Función con validación de texto**

Crea una función `formatear_nombre` que reciba un nombre y lo devuelva en mayúsculas con espacios eliminados al inicio y al final.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE FUNCTION formatear_nombre(p_nombre VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
  RETURN UPPER(TRIM(p_nombre));
END $$
DELIMITER ;

SELECT formatear_nombre('  maria lopez  ') AS nombre_formateado;
```

</details>

---

### **Ejercicio 4: Función para clasificar clientes por gasto**

Crea una función `clasificar_cliente` que reciba el total gastado y devuelva 'ALTO', 'MEDIO' o 'BAJO' según:

- `>= 1000` → ALTO
- `>= 500 y < 1000` → MEDIO
- `< 500` → BAJO

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE FUNCTION clasificar_cliente(p_total DECIMAL(12,2))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
  IF p_total >= 1000 THEN
    RETURN 'ALTO';
  ELSEIF p_total >= 500 THEN
    RETURN 'MEDIO';
  ELSE
    RETURN 'BAJO';
  END IF;
END $$
DELIMITER ;

SELECT clasificar_cliente(750) AS categoria;
```

</details>

---

### **Ejercicio 5: Función en combinación con una consulta**

Crea una función `edad_en_meses` que reciba una edad en años y devuelva la edad en meses. Úsala para mostrar el nombre y la edad en meses de los clientes.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE FUNCTION edad_en_meses(p_edad INT)
RETURNS INT
DETERMINISTIC
BEGIN
  RETURN p_edad * 12;
END $$
DELIMITER ;

SELECT first_name, edad_en_meses(age) AS meses
FROM customers;
```

</details>
