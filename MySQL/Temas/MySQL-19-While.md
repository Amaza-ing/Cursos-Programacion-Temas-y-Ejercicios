# **Topic 19: Using WHILE in MySQL**

In this topic we will learn to:

- Understand what an `WHILE` loop is in MySQL.
- Use `WHILE` within stored procedures.
- Control the repetitive execution of instructions until a condition is met.

---

## **1. What is WHILE in MySQL?**

`WHILE` is a control structure that allows a block of instructions to be executed repeatedly as long as a condition is true.

It is primarily used **within stored procedures or functions**.

---

## **2. Basic syntax**

```sql
[etiqueta:] WHILE condición DO
   -- instrucciones
END WHILE [etiqueta];
```

- **condition**: Logical expression that is evaluated before each iteration.
- If the condition is true, the statement block is executed.
- If it is false, the loop is exited.

---

## **3. Basic example**

Count from 1 to 5 and insert the values into an `numbers` table.

```sql
DELIMITER $$
CREATE PROCEDURE insertar_numeros()
BEGIN
  DECLARE v_contador INT DEFAULT 1;

  WHILE v_contador <= 5 DO
    INSERT INTO numbers(value) VALUES (v_contador);
    SET v_contador = v_contador + 1;
  END WHILE;
END $$
DELIMITER ;
```

---

## **4. WHILE with data dependent condition**

We may use `WHILE` to process records as long as there is data that meets certain conditions.

```sql
DELIMITER $$
CREATE PROCEDURE procesar_pedidos()
BEGIN
  DECLARE v_pedidos INT;
  SET v_pedidos = (SELECT COUNT(*) FROM orders WHERE status = 'PENDING');

  WHILE v_pedidos > 0 DO
    UPDATE orders SET status = 'PROCESSED'
    WHERE id = (SELECT id FROM orders WHERE status = 'PENDING' LIMIT 1);
    SET v_pedidos = v_pedidos - 1;
  END WHILE;
END $$
DELIMITER ;
```

---

## **5. WHILE with label and LEAVE**

We can tag a loop to exit it with `LEAVE`.

```sql
DELIMITER $$
CREATE PROCEDURE contar_hasta(IN p_limite INT)
BEGIN
  DECLARE v_num INT DEFAULT 1;

  bucle: WHILE TRUE DO
    IF v_num > p_limite THEN
      LEAVE bucle;
    END IF;
    INSERT INTO numbers(value) VALUES (v_num);
    SET v_num = v_num + 1;
  END WHILE bucle;
END $$
DELIMITER ;
```

---

## **6. Differences from other loops**

| Loop | Condition Assessment | Common use |
| -------- | ------------------------- | ------------------------------------------------------ |
| `WHILE` | Before each iteration | When we know the stopping condition before starting |
| `REPEAT` | After each iteration | When we need to run at least once |
| `LOOP` | Manual (with `LEAVE`) | Cases where the purpose is not defined in advance |

---

[![WHILE](https://img.youtube.com/vi/0-bLHp3q1vw/0.jpg) loop](https://www.youtube.com/watch?v=0-bLHp3q1vw&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **7. Good practices**

- Avoid infinite loops by ensuring that the condition changes in each iteration.
- Use variables to control the loop.
- Keep the number of iterations as low as possible so as not to affect performance.

---

## **8. Conclusion**

- `WHILE` allows a block to be executed repeatedly as long as the condition is true.
- It is useful for repetitive tasks such as inserting multiple records or processing data in batches.
- Controlling the flow with `LEAVE` and tags prevents infinite loops.

---

In the next topic we will learn how to **use REPEAT and LOOP loops for more flexible iterations in MySQL**.
