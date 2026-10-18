# **Exercises - Topic 19: Using WHILE in MySQL**

Below you will find 6 practical exercises to work with **WHILE loops** in MySQL.

Try to solve them before looking at the solution.

---

### **Exercise 1: Insert multiples of 3**

Create an `insertar_multiplos_tres` procedure that inserts the multiples of 3 from 3 to 30 into the `numbers(value)` table.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE insertar_multiplos_tres()
BEGIN
  DECLARE v_num INT DEFAULT 3;

  WHILE v_num <= 30 DO
    INSERT INTO numbers(value) VALUES (v_num);
    SET v_num = v_num + 3;
  END WHILE;
END $$
DELIMITER ;
```

</details>

---

### **Exercise 2: Fill a table with dates**

Create a `rellenar_fechas` procedure that inserts the dates from `'2025-01-01'` to `'2025-01-10'` into the `dates_list(fecha)` table.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE rellenar_fechas()
BEGIN
  DECLARE v_fecha DATE DEFAULT '2025-01-01';

  WHILE v_fecha <= '2025-01-10' DO
    INSERT INTO dates_list(fecha) VALUES (v_fecha);
    SET v_fecha = DATE_ADD(v_fecha, INTERVAL 1 DAY);
  END WHILE;
END $$
DELIMITER ;
```

</details>

---

### **Exercise 3: Reduce inventory step by step**

Create a `vender_producto` procedure that takes `p_id INT` and `p_cantidad INT`. It should subtract 1 from the inventory in `products_stock(product_id, quantity)` until `p_cantidad` units have been sold.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE vender_producto(IN p_id INT, IN p_cantidad INT)
BEGIN
  DECLARE v_contador INT DEFAULT 0;

  WHILE v_contador < p_cantidad DO
    UPDATE products_stock
    SET quantity = quantity - 1
    WHERE product_id = p_id AND quantity > 0;
    SET v_contador = v_contador + 1;
  END WHILE;
END $$
DELIMITER ;
```

</details>

---

### **Exercise 4: Insert powers of 2**

Create an `insertar_potencias_dos` procedure that inserts the powers of 2 from 1 to 1024 into `numbers(value)`.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE insertar_potencias_dos()
BEGIN
  DECLARE v_valor INT DEFAULT 1;

  WHILE v_valor <= 1024 DO
    INSERT INTO numbers(value) VALUES (v_valor);
    SET v_valor = v_valor * 2;
  END WHILE;
END $$
DELIMITER ;
```

</details>

---

### **Exercise 5: Increase salaries up to a limit**

Create an `incrementar_sueldos` procedure that increases by 50 the salary (`salary`) of all the employees in `employees` whose salary is less than 1000, repeating the increase until everyone earns at least 1000.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE incrementar_sueldos()
BEGIN
  DECLARE v_min_salary DECIMAL(10,2);

  SELECT MIN(salary) INTO v_min_salary FROM employees;

  WHILE v_min_salary < 1000 DO
    UPDATE employees
    SET salary = salary + 50
    WHERE salary < 1000;

    SELECT MIN(salary) INTO v_min_salary FROM employees;
  END WHILE;
END $$
DELIMITER ;
```

</details>

---

### **Exercise 6: Countdown**

Create a `contador_regresivo` procedure that starts at `p_inicio INT` and inserts decreasing values into the `numbers(value)` table until it reaches 1.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE contador_regresivo(IN p_inicio INT)
BEGIN
  DECLARE v_num INT;
  SET v_num = p_inicio;

  WHILE v_num >= 1 DO
    INSERT INTO numbers(value) VALUES (v_num);
    SET v_num = v_num - 1;
  END WHILE;
END $$
DELIMITER ;
```

</details>
