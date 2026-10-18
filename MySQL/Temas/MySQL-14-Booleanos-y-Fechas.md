# **Topic 14: Boolean and Date Type Variables in MySQL**

In this topic we will learn how to:

- Use and declare Boolean variables in MySQL.
- Work with date variables and columns (`DATE`, `DATETIME`, `TIMESTAMP`).
- Apply common functions and operators to manipulate dates.

---

## **1. Boolean variables in MySQL**

In MySQL there is no true `BOOLEAN` data type; instead, `TINYINT(1)` is used, where:

- `0` = false (`FALSE`)
- `1` = true (`TRUE`)

### **Example:**

```sql
CREATE TABLE customers (
  id INT PRIMARY KEY,
  first_name VARCHAR(50),
  is_active BOOLEAN
);
```

Internally, `BOOLEAN` is an alias for `TINYINT(1)`.

We can assign values like this:

```sql
UPDATE customers SET is_active = TRUE WHERE id = 1;
UPDATE customers SET is_active = FALSE WHERE id = 2;
```

They can also be used in conditions:

```sql
SELECT * FROM customers WHERE is_active = TRUE;
```

They are also often compared using **IS**:

```sql
SELECT * FROM customers WHERE is_active IS TRUE;
```

And if we are checking whether a condition is **TRUE**, we don't even need to write it:

```sql
SELECT * FROM customers WHERE is_active;
```

---

## **2. Date variables and columns**

### **Main types:**

- `DATE`: date only (`YYYY-MM-DD`).
- `DATETIME`: date and time (`YYYY-MM-DD HH:MM:SS`).
- `TIMESTAMP`: date and time with time zone (adjusts automatically to the configured time zone).

### **Table creation example:**

```sql
CREATE TABLE events (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  event_date DATE,
  created_at DATETIME DEFAULT NOW()
);
```

---

## **3. Common date functions**

- `NOW()`: current date and time.
- `CURDATE()`: current date.
- `CURTIME()`: current time.
- `DATE_ADD(fecha, INTERVAL X unidad)`: adds time.
- `DATE_SUB(fecha, INTERVAL X unidad)`: subtracts time.
- `DATEDIFF(fecha1, fecha2)`: difference in days.
- `DATE_FORMAT(fecha, formato)`: returns the date in a specific format.

### **Examples:**

```sql
SELECT NOW();
SELECT DATE_ADD(CURDATE(), INTERVAL 7 DAY) AS una_semana_despues;
SELECT DATEDIFF('2025-05-10', '2025-05-01') AS dias_diferencia;
SELECT DATE_FORMAT(NOW(), '%d/%m/%Y') AS fecha_formateada;
```

---

## **4. Local Boolean or date variables**

In procedures or functions we can declare variables like this:

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

## **5. Comparisons and use in conditions**

We can filter by dates or Booleans:

```sql
SELECT * FROM events WHERE event_date > CURDATE();
SELECT * FROM customers WHERE is_active = 1;
```

---

[![BOOL & DATETIME](https://img.youtube.com/vi/aIsdK6ct-h4/0.jpg)](https://www.youtube.com/watch?v=aIsdK6ct-h4&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **6. Good practices**

- Use `BOOLEAN` for clarity, even if internally it is `TINYINT(1)`.
- Choose `DATETIME` or `TIMESTAMP` depending on whether you need time zones.
- Make the most of functions such as `DATE_ADD`, `DATE_SUB` and `DATE_FORMAT` to manipulate dates.
- Keep your date format consistent.

---

## **7. Conclusion**

- Boolean variables are used as `TRUE` or `FALSE`, but they are equivalent to `1` and `0`.
- MySQL offers date types and functions to manipulate and format dates.
- They are essential for handling time-related data and logical states in databases.

---

In the next topic we will learn how to **create subqueries and use WITH**.
