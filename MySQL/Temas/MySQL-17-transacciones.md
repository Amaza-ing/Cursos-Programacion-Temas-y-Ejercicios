# **Tema 17: Transacciones en MySQL**

En este tema aprenderemos a:

- Comprender qué es una transacción y su utilidad.
- Usar transacciones para garantizar la integridad de los datos.
- Controlar el inicio, confirmación y cancelación de transacciones.
- Conocer las propiedades ACID.

---

## **1. ¿Qué es una transacción?**

Una **transacción** es un conjunto de operaciones SQL que se ejecutan como una unidad indivisible. Esto significa que **o se ejecutan todas correctamente o no se ejecuta ninguna**.

---

## **2. Propiedades ACID**

Las transacciones se rigen por cuatro propiedades conocidas como **ACID**:

- **Atomicidad**: Todas las operaciones se completan o ninguna se aplica.
- **Consistencia**: La base de datos pasa de un estado válido a otro.
- **Aislamiento**: Las transacciones concurrentes no interfieren entre sí.
- **Durabilidad**: Los cambios confirmados persisten incluso ante fallos.

---

## **3. Sintaxis básica de transacciones**

```sql
START TRANSACTION;
-- operaciones SQL
COMMIT; -- confirma los cambios
```

Si algo falla, puedes deshacer los cambios:

```sql
ROLLBACK; -- revierte la transacción
```

---

## **4. Ejemplo básico**

Supongamos que queremos transferir dinero de una cuenta a otra:

```sql
START TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;
```

Si alguna de las dos actualizaciones falla, podemos hacer:

```sql
ROLLBACK;
```

---

## **5. Uso de SAVEPOINT**

Un **savepoint** es un punto de guardado intermedio dentro de una transacción:

```sql
START TRANSACTION;
UPDATE accounts SET balance = balance - 50 WHERE id = 1;
SAVEPOINT sp1;
UPDATE accounts SET balance = balance + 50 WHERE id = 2;
ROLLBACK TO sp1; -- vuelve al estado después del primer UPDATE
COMMIT;
```

---

## **6. Aislamiento de transacciones**

MySQL permite ajustar el nivel de aislamiento para controlar cómo interactúan las transacciones concurrentes:

- `READ UNCOMMITTED`
- `READ COMMITTED`
- `REPEATABLE READ` (por defecto)
- `SERIALIZABLE`

Ejemplo para cambiarlo:

```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

---

## **7. Buenas prácticas**

- Iniciar la transacción lo más cerca posible de las operaciones críticas.
- Confirmar (`COMMIT`) o revertir (`ROLLBACK`) lo antes posible.
- Evitar mantener transacciones abiertas demasiado tiempo para no bloquear recursos.

---

## **8. Conclusión**

- Las transacciones permiten garantizar que un conjunto de operaciones se ejecute de forma segura y consistente.
- Las propiedades ACID aseguran la fiabilidad en la manipulación de datos.
- Herramientas como `SAVEPOINT` y niveles de aislamiento ofrecen mayor control sobre su ejecución.

---

En el siguiente tema aprenderemos a **usar el IF en consultas y en procedimientos almacenados**.
