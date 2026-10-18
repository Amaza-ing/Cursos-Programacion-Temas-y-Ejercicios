# **Topic 20: Using REPEAT and LOOP in MySQL**

In this topic we will learn how to:

- Understand what the `REPEAT` and `LOOP` loops are.
- Use them inside stored procedures.
- Tell how their behavior differs from `WHILE`.

---

## **1. The REPEAT loop**

`REPEAT` runs a block of statements **at least once** and then evaluates the stopping condition.

### **Syntax:**

```sql
[etiqueta:] REPEAT
   -- instrucciones
UNTIL condición
END REPEAT [etiqueta];
```

### **Example:**

Insert the numbers from 1 to 5 into a `numbers` table.

```sql
DELIMITER $$
CREATE PROCEDURE insertar_numeros_repeat()
BEGIN
  DECLARE v_num INT DEFAULT 1;

  REPEAT
    INSERT INTO numbers(value) VALUES (v_num);
    SET v_num = v_num + 1;
  UNTIL v_num > 5
  END REPEAT;
END $$
DELIMITER ;
```

**Characteristics:**

- It always runs at least once.
- The condition is evaluated at the end.

---

## **2. The LOOP loop**

`LOOP` repeats statements until it is explicitly interrupted with `LEAVE`.

### **Syntax:**

```sql
[etiqueta:] LOOP
   -- instrucciones
   LEAVE etiqueta; -- para salir del bucle
END LOOP [etiqueta];
```

### **Example:**

Insert the even numbers from 2 to 10.

```sql
DELIMITER $$
CREATE PROCEDURE insertar_pares_loop()
BEGIN
  DECLARE v_num INT DEFAULT 2;

  bucle: LOOP
    IF v_num > 10 THEN
      LEAVE bucle;
    END IF;
    INSERT INTO numbers(value) VALUES (v_num);
    SET v_num = v_num + 2;
  END LOOP bucle;
END $$
DELIMITER ;
```

**Characteristics:**

- It does not evaluate any condition automatically.
- It needs `LEAVE` to finish.

---

[![LOOP loop](https://img.youtube.com/vi/F3lHxZ5jDa4/0.jpg)](https://www.youtube.com/watch?v=F3lHxZ5jDa4&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **3. Differences between WHILE, REPEAT and LOOP**

| Loop | Condition check | Minimum runs |
| ------ | ----------------------- | -------------------------- |
| WHILE | Before entering | 0 times |
| REPEAT | After running | 1 time |
| LOOP | Manual (with LEAVE) | Depends on internal control |

---

## **4. Using labels and LEAVE together**

We can use labels to control multiple nested loops.

```sql
DELIMITER $$
CREATE PROCEDURE ejemplo_anidado()
BEGIN
  DECLARE v_outer INT DEFAULT 1;
  DECLARE v_inner INT;

  bucle_externo: LOOP
    IF v_outer > 3 THEN
      LEAVE bucle_externo;
    END IF;

    SET v_inner = 1;
    bucle_interno: LOOP
      IF v_inner > 2 THEN
        LEAVE bucle_interno;
      END IF;
      INSERT INTO numbers(value) VALUES (v_outer * v_inner);
      SET v_inner = v_inner + 1;
    END LOOP bucle_interno;

    SET v_outer = v_outer + 1;
  END LOOP bucle_externo;
END $$
DELIMITER ;
```

---

## **5. Good practices**

- Use `REPEAT` when you need to run the block at least once.
- Use `LOOP` for cases where the exit condition is not fixed from the start.
- Avoid infinite loops by making sure there is a clear exit condition.
- Use descriptive labels to improve readability.

---

## **6. Conclusion**

- `REPEAT` evaluates the condition at the end, which guarantees at least one run.
- `LOOP` requires `LEAVE` to exit, which gives you full flexibility.
- Which one you choose depends on the control logic you need.
