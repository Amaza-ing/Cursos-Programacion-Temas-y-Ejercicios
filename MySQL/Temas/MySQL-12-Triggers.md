# **Topic 12: Triggers in MySQL**

In this topic we will learn how to:

- Understand what a trigger is and when to use it.
- Create triggers to automate actions.
- Know the different timings for running them (`BEFORE` and `AFTER`).
- Manage and delete triggers.

---

## **1. What is a trigger?**

A **trigger** is a database object that runs automatically when a specific event (`INSERT`, `UPDATE`, `DELETE`) occurs on a table.

### **Advantages:**

- It automates tasks such as auditing, validations or calculations.
- It ensures data integrity at the database level.

### **Disadvantages:**

- It can make the data flow harder to follow.
- A bad design can hurt performance.

---

## **2. Types of triggers based on when they run**

- **`BEFORE`**: runs before the operation is performed.
- **`AFTER`**: runs after the operation is performed.

---

## **3. Creating a basic trigger**

Example: audit inserts into the `orders` table by saving data to an `orders_log` table.

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
- In `BEFORE` triggers, you can also modify `NEW.columna` to change the value before it is inserted.

---

## **4. BEFORE trigger with validation**

Example: prevent inserting a negative price into `products`.

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

## **5. Deleting a trigger**

```sql
DROP TRIGGER IF EXISTS log_new_order;
```

---

## **6. Viewing existing triggers**

```sql
SHOW TRIGGERS;
```

---

[![Triggers](https://img.youtube.com/vi/Z_IzfkrJDDg/0.jpg)](https://www.youtube.com/watch?v=Z_IzfkrJDDg&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **7. Good practices**

- Use triggers only when the logic must **always** run together with the operation.
- Avoid very complex logic so you don't hurt performance.
- Document each trigger and its purpose.

---

## **8. Conclusion**

- Triggers let you automate actions when changes occur in a table.
- They can run before or after the operation.
- They are useful for auditing, validations and automatic data maintenance.

---

In the next topic we will learn how to **create and use functions** and we will see how they differ from stored procedures.
