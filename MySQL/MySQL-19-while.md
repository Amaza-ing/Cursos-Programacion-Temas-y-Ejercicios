# **Tema 19: Uso de WHILE en MySQL**

En este tema aprenderemos a:

- Entender qué es un bucle `WHILE` en MySQL.
- Utilizar `WHILE` dentro de procedimientos almacenados.
- Controlar la ejecución repetitiva de instrucciones hasta que se cumpla una condición.

---

## **1. ¿Qué es WHILE en MySQL?**

`WHILE` es una estructura de control que permite ejecutar un bloque de instrucciones repetidamente mientras una condición sea verdadera.

Se usa principalmente **dentro de procedimientos almacenados o funciones**.

---

## **2. Sintaxis básica**

```sql
[etiqueta:] WHILE condición DO
   -- instrucciones
END WHILE [etiqueta];
```

- **condición**: Expresión lógica que se evalúa antes de cada iteración.
- Si la condición es verdadera, se ejecuta el bloque de instrucciones.
- Si es falsa, se sale del bucle.

---

## **3. Ejemplo básico**

Contar de 1 a 5 e insertar los valores en una tabla `numbers`.

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

## **4. WHILE con condición dependiente de datos**

Podemos usar `WHILE` para procesar registros mientras haya datos que cumplan ciertas condiciones.

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

## **5. WHILE con etiqueta y LEAVE**

Podemos etiquetar un bucle para salir de él con `LEAVE`.

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

## **6. Diferencias con otros bucles**

| Bucle    | Evaluación de condición   | Uso común                                              |
| -------- | ------------------------- | ------------------------------------------------------ |
| `WHILE`  | Antes de cada iteración   | Cuando sabemos la condición de parada antes de empezar |
| `REPEAT` | Después de cada iteración | Cuando necesitamos ejecutar al menos una vez           |
| `LOOP`   | Manual (con `LEAVE`)      | Casos donde el fin no está definido de antemano        |

---

## **7. Buenas prácticas**

- Evitar bucles infinitos asegurando que la condición cambie en cada iteración.
- Usar variables para llevar control del bucle.
- Mantener el número de iteraciones lo más bajo posible para no afectar el rendimiento.

---

## **8. Conclusión**

- `WHILE` permite ejecutar un bloque repetidamente mientras la condición sea verdadera.
- Es útil para tareas repetitivas como insertar múltiples registros o procesar datos por lotes.
- Controlar el flujo con `LEAVE` y etiquetas evita bucles infinitos.

---

En el próximo tema aprenderemos a **usar bucles REPEAT y LOOP para iteraciones más flexibles en MySQL**.
