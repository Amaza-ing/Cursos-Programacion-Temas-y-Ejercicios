# **Topic 20: Using REPEAT and LOOP in MySQL**

In this topic we will learn to:

- Understand what the `REPEAT` and `LOOP` loops are.
- Use them within stored procedures.
- Differentiate its behavior with respect to `WHILE`.

---

## **1. REPEAT Loop**

`REPEAT` executes a block of statements **at least once** and then evaluates the stop condition.

### **Syntax:**

```sql
[etiqueta:] REPEAT
   -- instrucciones
UNTIL condición
END REPEAT [etiqueta];
```

### **Example:**

Insert numbers from 1 to 5 into an `numbers` table.

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

**Features:**

- Always runs at least once.
- The condition is evaluated at the end.

---

## **2. LOOP**

`LOOP` repeats instructions until explicitly interrupted with `LEAVE`.

### **Syntax:**

```sql
[etiqueta:] LOOP
   -- instrucciones
   LEAVE etiqueta; -- para salir del bucle
END LOOP [etiqueta];
```

### **Example:**

Insert even numbers from 2 to 10.

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

**Features:**

- Does not evaluate condition automatically.
- You need `LEAVE` to finish.

---

[![LOOP](https://img.youtube.com/vi/F3lHxZ5jDa4/0.jpg)](https://www.youtube.com/watch?v=F3lHxZ5jDa4&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **3. Differences between WHILE, REPEAT and LOOP**

| Loop | Condition Assessment | Minimum execution |
| ------ | ----------------------- | -------------------------- |
| WHILE | Before entering | 0 times |
| REPEAT | After running | 1 time |
| LOOP | Manual (with LEAVE) | Depends on internal control |

---

## **4. Combined use of tags and LEAVE**

We can use tags to control multiple nested loops.

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

- Use `REPEAT` when you need to execute the block at least once.
- Use `LOOP` for cases where the exit condition is not fixed from the beginning.
- Avoid infinite loops by ensuring a clear exit condition.
- Use descriptive labels to improve readability.

---

## **6. Conclusion**

- `REPEAT` evaluates the condition at the end, guaranteeing at least one execution.
- `LOOP` requires `LEAVE` to exit, offering full flexibility.
- Choosing between them depends on the control logic needed.
