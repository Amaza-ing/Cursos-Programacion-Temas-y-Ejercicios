# **Tema 14: Variables Booleanas y de Tipo Fecha en MySQL**

En este tema aprenderemos a:

- Usar y declarar variables booleanas en MySQL.
- Trabajar con variables y columnas de tipo fecha (`DATE`, `DATETIME`, `TIMESTAMP`).
- Aplicar funciones y operadores comunes para manipular fechas.

---

## **1. Variables booleanas en MySQL**

En MySQL no existe un tipo de dato `BOOLEAN` puro; en su lugar, se utiliza `TINYINT(1)` donde:

- `0` = FALSO (`FALSE`)
- `1` = VERDADERO (`TRUE`)

### **Ejemplo:**

```sql
CREATE TABLE customers (
  id INT PRIMARY KEY,
  first_name VARCHAR(50),
  is_active BOOLEAN
);
```

Internamente, `BOOLEAN` es un alias de `TINYINT(1)`.

Podemos asignar valores así:

```sql
UPDATE customers SET is_active = TRUE WHERE id = 1;
UPDATE customers SET is_active = FALSE WHERE id = 2;
```

También se pueden usar en condiciones:

```sql
SELECT * FROM customers WHERE is_active = TRUE;
```

También se comparan comunmente usando **IS**:

```sql
SELECT * FROM customers WHERE is_active IS TRUE;
```

O si evaluamos si una condición es **TRUE** ni siquiera hace falta especificarlo:

```sql
SELECT * FROM customers WHERE is_active;
```

---

## **2. Variables y columnas de tipo fecha**

### **Tipos principales:**

- `DATE`: Solo fecha (`YYYY-MM-DD`).
- `DATETIME`: Fecha y hora (`YYYY-MM-DD HH:MM:SS`).
- `TIMESTAMP`: Fecha y hora con zona horaria (ajusta automáticamente según la zona configurada).

### **Ejemplo de creación:**

```sql
CREATE TABLE events (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  event_date DATE,
  created_at DATETIME DEFAULT NOW()
);
```

---

## **3. Funciones comunes para fechas**

- `NOW()`: Fecha y hora actuales.
- `CURDATE()`: Fecha actual.
- `CURTIME()`: Hora actual.
- `DATE_ADD(fecha, INTERVAL X unidad)`: Suma tiempo.
- `DATE_SUB(fecha, INTERVAL X unidad)`: Resta tiempo.
- `DATEDIFF(fecha1, fecha2)`: Diferencia en días.
- `DATE_FORMAT(fecha, formato)`: Devuelve la fecha con un formato específico.

### **Ejemplos:**

```sql
SELECT NOW();
SELECT DATE_ADD(CURDATE(), INTERVAL 7 DAY) AS una_semana_despues;
SELECT DATEDIFF('2025-05-10', '2025-05-01') AS dias_diferencia;
SELECT DATE_FORMAT(NOW(), '%d/%m/%Y') AS fecha_formateada;
```

---

## **4. Variables locales de tipo booleano o fecha**

En procedimientos o funciones podemos declarar variables así:

```sql
DELIMITER $$
CREATE PROCEDURE ejemplo_variables()
BEGIN
  DECLARE v_activo BOOLEAN DEFAULT TRUE;
  DECLARE v_hoy DATE DEFAULT CURDATE();

  IF v_activo THEN
    SELECT CONCAT('Hoy es ', v_hoy) AS mensaje;
  END IF;
END $$
DELIMITER ;
```

---

## **5. Comparaciones y uso en condiciones**

Podemos filtrar por fechas o booleanos:

```sql
SELECT * FROM events WHERE event_date > CURDATE();
SELECT * FROM customers WHERE is_active = 1;
```

---

## **6. Buenas prácticas**

- Usar `BOOLEAN` para claridad, aunque internamente sea `TINYINT(1)`.
- Preferir `DATETIME` o `TIMESTAMP` según la necesidad de zona horaria.
- Aprovechar funciones como `DATE_ADD`, `DATE_SUB` y `DATE_FORMAT` para manipular fechas.
- Mantener coherencia en el formato de fechas.

---

## **7. Conclusión**

- Las variables booleanas se usan como `TRUE` o `FALSE`, pero son equivalentes a `1` y `0`.
- MySQL ofrece tipos de fecha y funciones para manipular y formatear fechas.
- Son fundamentales para manejar datos temporales y estados lógicos en las bases de datos.

---

En el siguiente tema aprenderemos a **crear subconsultas y a utilizar WITH**.
