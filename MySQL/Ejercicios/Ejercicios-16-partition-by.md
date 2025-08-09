# **Ejercicios - Tema 15: Uso de PARTITION BY en MySQL**

A continuación, encontrarás 5 ejercicios prácticos para trabajar con **PARTITION BY** y funciones de ventana en MySQL.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Contar registros por categoría**

En la tabla `products(id, category_id, name, price)`, muestra todos los productos junto con el **número total de productos** que hay en su misma categoría.

<details><summary>Mostrar Solución</summary>

```sql
SELECT id,
       category_id,
       name,
       COUNT(*) OVER (PARTITION BY category_id) AS total_categoria
FROM products;
```

</details>

---

### **Ejercicio 2: Calcular promedio por departamento**

En la tabla `employees(id, department_id, salary)`, muestra cada empleado, su salario y el **salario promedio** de su departamento.

<details><summary>Mostrar Solución</summary>

```sql
SELECT id,
       department_id,
       salary,
       AVG(salary) OVER (PARTITION BY department_id) AS salario_promedio
FROM employees;
```

</details>

---

### **Ejercicio 3: Ranking de ventas por vendedor**

En la tabla `sales(id, seller_id, amount)`, asigna un **número de ranking** a cada venta dentro de cada vendedor, de mayor a menor `amount`.

<details><summary>Mostrar Solución</summary>

```sql
SELECT seller_id,
       id AS sale_id,
       amount,
       RANK() OVER (PARTITION BY seller_id ORDER BY amount DESC) AS ranking
FROM sales;
```

</details>

---

### **Ejercicio 4: Acumulado de ingresos por mes**

En la tabla `invoices(id, customer_id, total_amount, invoice_date)`, calcula el **acumulado** de `total_amount` para cada cliente, ordenado por `invoice_date`.

<details><summary>Mostrar Solución</summary>

```sql
SELECT customer_id,
       id AS invoice_id,
       invoice_date,
       total_amount,
       SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY invoice_date) AS acumulado_cliente
FROM invoices;
```

</details>

---

### **Ejercicio 5: Diferencia con la venta más alta del vendedor**

En la tabla `sales(id, seller_id, amount)`, muestra cada venta junto con la **diferencia** respecto a la venta más alta del mismo vendedor.

<details><summary>Mostrar Solución</summary>

```sql
SELECT seller_id,
       id AS sale_id,
       amount,
       MAX(amount) OVER (PARTITION BY seller_id) - amount AS diferencia_maxima
FROM sales;
```

</details>
