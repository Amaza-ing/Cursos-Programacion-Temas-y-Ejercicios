# **Topic 12: Triggers in MySQL**

In this topic we will learn to:

- Understand what a trigger is and when to use it.
- Create triggers to automate actions.
- Know the different execution times (`BEFORE` and `AFTER`).
- Manage and delete triggers.

---

## **1. What is a trigger?**

A **trigger** (or trigger) is a database object that is automatically executed when a specific event (`INSERT`, `UPDATE`, `DELETE`) occurs on a table.

### **Advantages:**

- Automate tasks such as auditing, validations or calculations.
- Ensures data integrity at the database level.

### **Disadvantages:**

- Can make data flow difficult to track.
- Bad design can affect performance.

---

## **2. Types of triggers depending on the time of execution**

- **`BEFORE`**: Executed before the operation is performed.
- **`AFTER`**: Executed after the operation is performed.

---

## **3. Create a basic trigger**

Example: Audit inserts into the `orders` table by saving data to an `orders_log` table.

```sql
DELIMITER $$
CREATE TRIGGER log_new_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
  INSERT INTO orders_log(order_id, log_date)
  VALUES (NEW.id, NOW());
END $$
DELIMITER ;
```

- `NEW.columna` refers to the new value of the column.
- In `BEFORE` triggers, `NEW.columna` can also be modified to change the value before inserting it.

---

## **4. BEFORE trigger with validation**

Example: Avoid inserting a negative price in `products`.

```sql
DELIMITER $$
CREATE TRIGGER validate_product_price
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  IF NEW.price < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'El precio no puede ser negativo';
  END IF;
END $$
DELIMITER ;
```

---

## **5. Delete a trigger**

```sql
DROP TRIGGER IF EXISTS log_new_order;
```

---

## **6. View existing triggers**

```sql
SHOW TRIGGERS;
```

---

[![Triggers](https://img.youtube.com/vi/Z_IzfkrJDDg/0.jpg)](https://www.youtube.com/watch?v=Z_IzfkrJDDg&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **7. Good practices**

- Use triggers only when the logic must **always** be executed together with the operation.
- Avoid very complex logic so as not to affect performance.
- Document each trigger and its purpose.

---

## **8. Conclusion**

- Triggers allow you to automate actions when changes occur in a table.
- They can be executed before or after the operation.
- They are useful for auditing, validations and automatic data maintenance.

---

In the next topic we will learn to **create and use functions** and we will see the difference with stored procedures.
