# **Exercises - Topic 12: Triggers in MySQL**

Below you will find 5 practical exercises to work with **triggers** in MySQL.

Try to solve them before looking at the solution.

---

### **Exercise 1: Audit price updates**

Create an `audit_price_update` trigger that records the `product_id`, the old price and the new price in a `price_changes_log` table every time a product's price is updated.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE TRIGGER audit_price_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
  IF NEW.price <> OLD.price THEN
    INSERT INTO price_changes_log(product_id, old_price, new_price, change_date)
    VALUES (OLD.id, OLD.price, NEW.price, NOW());
  END IF;
END $$
DELIMITER ;
```

</details>

---

### **Exercise 2: Validate minimum stock before inserting**

Create a `validate_stock_before_insert` trigger that prevents inserting a product into `inventory` if the quantity (`quantity`) is less than 0.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE TRIGGER validate_stock_before_insert
BEFORE INSERT ON inventory
FOR EACH ROW
BEGIN
  IF NEW.quantity < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'La cantidad no puede ser negativa';
  END IF;
END $$
DELIMITER ;
```

</details>

---

### **Exercise 3: Update the last-modified date**

Create an `update_last_modified` trigger that, every time a record in `customers` is updated, automatically changes the `last_modified` field to the current date and time.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE TRIGGER update_last_modified
BEFORE UPDATE ON customers
FOR EACH ROW
BEGIN
  SET NEW.last_modified = NOW();
END $$
DELIMITER ;
```

</details>

---

### **Exercise 4: Record order deletions**

Create a `log_order_deletion` trigger that, when an order is deleted from `orders`, inserts a record into `deleted_orders_log` with the `order_id` and the deletion date.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE TRIGGER log_order_deletion
AFTER DELETE ON orders
FOR EACH ROW
BEGIN
  INSERT INTO deleted_orders_log(order_id, deleted_at)
  VALUES (OLD.id, NOW());
END $$
DELIMITER ;
```

</details>

---

### **Exercise 5: Prevent changes to the administrator role**

Create a `prevent_admin_role_change` trigger that prevents changing a user's `role` field in `users` if the old value was `'admin'`.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE TRIGGER prevent_admin_role_change
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
  IF OLD.role = 'admin' AND NEW.role <> 'admin' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No se permite cambiar el rol de administrador';
  END IF;
END $$
DELIMITER ;
```

</details>
