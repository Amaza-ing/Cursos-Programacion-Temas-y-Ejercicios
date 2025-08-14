# **Tema 20: Uso de REPEAT y LOOP en MySQL**

En este tema aprenderemos a:

- Entender qué son los bucles `REPEAT` y `LOOP`.
- Usarlos dentro de procedimientos almacenados.
- Diferenciar su comportamiento respecto a `WHILE`.

---

## **1. Bucle REPEAT**

`REPEAT` ejecuta un bloque de instrucciones **al menos una vez** y luego evalúa la condición de parada.

### **Sintaxis:**

```sql
[etiqueta:] REPEAT
   -- instrucciones
UNTIL condición
END REPEAT [etiqueta];
```

### **Ejemplo:**

Insertar números del 1 al 5 en una tabla `numbers`.

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

**Características:**

- Siempre se ejecuta al menos una vez.
- La condición se evalúa al final.

---

## **2. Bucle LOOP**

`LOOP` repite instrucciones hasta que se interrumpe explícitamente con `LEAVE`.

### **Sintaxis:**

```sql
[etiqueta:] LOOP
   -- instrucciones
   LEAVE etiqueta; -- para salir del bucle
END LOOP [etiqueta];
```

### **Ejemplo:**

Insertar números pares del 2 al 10.

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

**Características:**

- No evalúa condición automáticamente.
- Necesita `LEAVE` para terminar.

---

## **3. Diferencias entre WHILE, REPEAT y LOOP**

| Bucle  | Evaluación de condición | Ejecución mínima           |
| ------ | ----------------------- | -------------------------- |
| WHILE  | Antes de entrar         | 0 veces                    |
| REPEAT | Después de ejecutar     | 1 vez                      |
| LOOP   | Manual (con LEAVE)      | Depende de control interno |

---

## **4. Uso combinado de etiquetas y LEAVE**

Podemos usar etiquetas para controlar múltiples bucles anidados.

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

## **5. Buenas prácticas**

- Usar `REPEAT` cuando necesites ejecutar el bloque al menos una vez.
- Usar `LOOP` para casos donde la condición de salida no es fija desde el inicio.
- Evitar bucles infinitos asegurando una condición de salida clara.
- Utilizar etiquetas descriptivas para mejorar la legibilidad.

---

## **6. Conclusión**

- `REPEAT` evalúa la condición al final, garantizando al menos una ejecución.
- `LOOP` requiere `LEAVE` para salir, ofreciendo flexibilidad total.
- Elegir entre ellos depende de la lógica de control necesaria.
