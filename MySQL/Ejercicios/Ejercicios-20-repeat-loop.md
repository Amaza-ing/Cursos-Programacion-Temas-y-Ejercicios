# **Exercises - Topic 20: Using REPEAT and LOOP in MySQL**

Below you will find 6 practical exercises to work with **REPEAT** and **LOOP** loops in MySQL.

Try to solve them before consulting the solution.

---

### **Exercise 1: REPEAT to insert odd numbers**

Create a procedure `insertar_impares_repeat` that inserts into `numbers(value)` the **odd** numbers from 1 to nine (1, 3, 5, 7, 9) using `REPEAT`.

<details><summary>Show Solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE insertar_impares_repeat()
BEGIN
  DECLARE v INT DEFAULT 1;
  REPEAT
    INSERT INTO numbers(value) VALUES (v);
    SET v = v + 2;
  UNTIL v > 9
  END REPEAT;
END $$
DELIMITER ;
```

</details>

---

### **Exercise 2: REPEAT with accumulated sum**

Create a procedure `sumar_de_siete_en_siete` that accumulates in `v_total` in 7 at a time and records each value in `accumulated(total)` **until** `v_total` is **greater than or equal to 70**.

<details><summary>Show Solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE sumar_de_siete_en_siete()
BEGIN
  DECLARE v_total INT DEFAULT 0;
  REPEAT
    SET v_total = v_total + 7;
    INSERT INTO accumulated(total) VALUES (v_total);
  UNTIL v_total >= 70
  END REPEAT;
END $$
DELIMITER ;
```

</details>

---

### **Exercise 3: LOOP with `LEAVE` and `ITERATE`**

Create a procedure `insertar_multiplos_de_cinco` that loops numbers from 1 to 50 using `LOOP`. Insert into `numbers(value)` **only multiples of 5**. Use `ITERATE` to **skip** those that are not and `LEAVE` to exit when exceeding 50.

<details><summary>Show Solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE insertar_multiplos_de_cinco()
BEGIN
  DECLARE v INT DEFAULT 1;
  bucle: LOOP
    IF v > 50 THEN
      LEAVE bucle;
    END IF;

    IF v % 5 <> 0 THEN
      SET v = v + 1;
      ITERATE bucle;
    END IF;

    INSERT INTO numbers(value) VALUES (v);
    SET v = v + 1;
  END LOOP bucle;
END $$
DELIMITER ;
```

</details>

---

### **Exercise 4: Nested LOOP for join table**

Create a procedure `generar_combinaciones_3x3` that fills `pairs(a, b)` with all combinations **(a, b)** where `a` and `b` range from **1 to 3** using two nested `LOOP` and `LEAVE` in each.

<details><summary>Show Solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE generar_combinaciones_3x3()
BEGIN
  DECLARE a INT DEFAULT 1;
  DECLARE b INT;

  ext: LOOP
    IF a > 3 THEN LEAVE ext; END IF;

    SET b = 1;
    int: LOOP
      IF b > 3 THEN LEAVE int; END IF;
      INSERT INTO pairs(a, b) VALUES (a, b);
      SET b = b + 1;
    END LOOP int;

    SET a = a + 1;
  END LOOP ext;
END $$
DELIMITER ;
```

</details>

---

### **Exercise 5: Process queue with LOOP until there are no elements left**

Given a table `task_queue(id, processed TINYINT(1))`, create a procedure `procesar_cola` that, using `LOOP`, marks **unprocessed** tasks **one at a time** as `processed = 1`. Stop the loop when **no more exist**.

<details><summary>Show Solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE procesar_cola()
BEGIN
  DECLARE v_id INT;
  bucle: LOOP
    SELECT id INTO v_id FROM task_queue WHERE processed = 0 LIMIT 1;
    IF v_id IS NULL THEN
      LEAVE bucle;
    END IF;

    UPDATE task_queue SET processed = 1 WHERE id = v_id;
  END LOOP bucle;
END $$
DELIMITER ;
```

</details>

---

### **Exercise 6: REPEAT to generate backward dates**

Create a procedure `generar_ultimos_dias` that receives `p_dias INT` and populates `dates_list(fecha)` with the dates **from today backwards** `p_dias` days (including today) using `REPEAT`.

<details><summary>Show Solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE generar_ultimos_dias(IN p_dias INT)
BEGIN
  DECLARE v INT DEFAULT 0;
  REPEAT
    INSERT INTO dates_list(fecha) VALUES (DATE_SUB(CURDATE(), INTERVAL v DAY));
    SET v = v + 1;
  UNTIL v > p_dias
  END REPEAT;
END $$
DELIMITER ;
```

</details>
