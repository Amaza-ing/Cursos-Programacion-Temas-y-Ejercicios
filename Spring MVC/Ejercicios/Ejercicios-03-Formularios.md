# Exercises Topic 3: Forms, validation and data processing in Spring MVC

## Introduction

In these exercises you'll practice the main contents of **Topic 3**:

- Creating forms in Spring MVC.
- Using `@ModelAttribute`.
- Using `@Valid`.
- Using `BindingResult`.
- Validation with Jakarta Bean Validation.
- Using the `<form:form>`, `<form:input>`, `<form:select>` and `<form:errors>` tags.
- Processing `GET` and `POST` requests.
- Redirecting after saving data.
- Using temporary messages with `RedirectAttributes`.
- Separating the controller, the model and the service.

The exercises follow a step-by-step progression. As an example, we'll use a small **product** management application, different from the courses example you saw in the theory.

Each solution is hidden under the **show solution** button.

---

# Exercise 1 — Add the necessary dependencies for validation

## Statement

In Topic 3 we are going to validate forms using annotations such as:

```java
@NotBlank
@Size
@NotNull
@Min
@Max
```

Add to `pom.xml` the dependency you need to use Jakarta Bean Validation with Hibernate Validator.

---

<details>
<summary>Show solution</summary>

```xml
<!-- Implementación de Jakarta Bean Validation -->
<dependency>
    <groupId>org.hibernate.validator</groupId>
    <artifactId>hibernate-validator</artifactId>
    <version>8.0.3.Final</version>
</dependency>
```

### Explanation

Annotations like:

```java
@NotBlank
@Size
@Min
@Max
```

belong to Jakarta Bean Validation.

Without a validation implementation, Spring MVC will not be able to correctly apply those rules when we use:

```java
@Valid
```

Hibernate Validator is a common implementation of Jakarta Bean Validation.

</details>

---

# Exercise 2 — Create the `Product` model with validation

## Statement

Create a class called `Product` in the package:

```text
com.example.shop.model
```

The class must have these attributes:

| Attribute | Type |
| ---------- | --------- |
| `id` | `Long` |
| `name` | `String` |
| `category` | `String` |
| `price` | `Double` |
| `stock` | `Integer` |

Add the following validations:

| Field | Validation |
| ---------- | ------------------------------------- |
| `name` | Required and between 3 and 60 characters |
| `category` | Required |
| `price` | Required and minimum 0.01 |
| `stock` | Required and minimum 0 |

The class must have an empty constructor, a constructor with all the fields, getters and setters.

---

<details>
<summary>Show solution</summary>

```java
package com.example.shop.model;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public class Product {

    private Long id;

    @NotBlank(message = "El nombre es obligatorio.")
    @Size(min = 3, max = 60, message = "El nombre debe tener entre 3 y 60 caracteres.")
    private String name;

    @NotBlank(message = "La categoría es obligatoria.")
    private String category;

    @NotNull(message = "El precio es obligatorio.")
    @DecimalMin(value = "0.01", message = "El precio debe ser mayor que 0.")
    private Double price;

    @NotNull(message = "El stock es obligatorio.")
    @Min(value = 0, message = "El stock no puede ser negativo.")
    private Integer stock;

    public Product() {
    }

    public Product(Long id, String name, String category, Double price, Integer stock) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.price = price;
        this.stock = stock;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }
}
```

### Explanation

We use:

```java
@NotBlank
```

for text fields that cannot be empty.

We use:

```java
@NotNull
```

for numeric fields that must have a value.

The `price` field is `Double`, not `double`, because it needs to be able to hold `null` when the user leaves the field empty.

The `stock` field is `Integer`, not `int`, for the same reason.

If we use primitive types like `int` or `double`, we can't properly represent the absence of a value.

</details>

---

# Exercise 3 — Create a mutable product service

## Statement
Create a class called `ProductService` in the package:

```text
com.example.shop.service
```

It must be annotated with `@Service`.

The class must:

1. Have a mutable list of products.
2. Load three initial products.
3. Have a `nextId` counter.
4. Have a `findAll()` method.
5. Have a `findById(Long id)` method.
6. Have a `save(Product product)` method that assigns a new id and saves the product.

---

<details>
<summary>Show solution</summary>

```java
package com.example.shop.service;

import com.example.shop.model.Product;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductService {

    private final List<Product> products = new ArrayList<>();

    private Long nextId = 4L;

    public ProductService() {
        products.add(new Product(1L, "Teclado mecánico", "Informática", 59.99, 12));
        products.add(new Product(2L, "Ratón inalámbrico", "Informática", 24.99, 30));
        products.add(new Product(3L, "Cuaderno A5", "Papelería", 3.50, 100));
    }

    public List<Product> findAll() {
        return products;
    }

    public Product findById(Long id) {
        return products.stream()
                .filter(product -> product.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public void save(Product product) {
        product.setId(nextId);
        products.add(product);
        nextId++;
    }
}
```

### Explanation

We use:

```java
new ArrayList<>()
```

because we need a modifiable list.

If we used:

```java
List.of(...)
```

we couldn't add new products.

The `save` method does three things:

```java
product.setId(nextId);
products.add(product);
nextId++;
```

It first assigns an identifier, then saves the product, and finally increments the counter for the next product.

</details>

---

# Exercise 4 — Create a controller to list products

## Statement

Create a controller named `ProductController` in the package:

```text
com.example.shop.controller
```

It must:

1. Be annotated with `@Controller`.
2. Have the base path `/products`.
3. Receive `ProductService` through its constructor.
4. Have a method that responds to `GET /products`.
5. Add to the model:
   - `pageTitle` with the value `Listado de productos`.
   - `products` with the list of products.
6. Return the `products/list` view.

---

<details>
<summary>Show solution</summary>

```java
package com.example.shop.controller;

import com.example.shop.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/products")
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public String listProducts(Model model) {
        model.addAttribute("pageTitle", "Listado de productos");
        model.addAttribute("products", productService.findAll());

        return "products/list";
    }
}
```

### Explanation

The base route is:

```java
@RequestMapping("/products")
```

Since the method has:

```java
@GetMapping
```

it responds to:

```text
GET /products
```

The controller doesn't create the products directly. It asks the service for them:

```java
productService.findAll()
```

The view returned is:

```java
return "products/list";
```

Spring will look for:

```text
/WEB-INF/views/products/list.jsp
```

</details>

---

# Exercise 5 — Create the product listing view

## Statement

Create the view:

```text
src/main/webapp/WEB-INF/views/products/list.jsp
```

It must show a table with:

```text
Nombre | Categoría | Precio | Stock | Acción
```

It must also include a button to create a new product that points to:

```text
/products/new
```

Use JSTL to loop through the list of products.

---

<details>
<summary>Show solution</summary>

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">Inicio</a>
        <a href="${pageContext.request.contextPath}/products">Productos</a>
    </nav>
</header>

<main class="container">
    <section class="card wide">
        <h1>${pageTitle}</h1>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/products/new">
                Crear nuevo producto
            </a>
        </p>

        <table class="table">
            <thead>
            <tr>
                <th>Nombre</th>
                <th>Categoría</th>
                <th>Precio</th>
                <th>Stock</th>
                <th>Acción</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="product" items="${products}">
                <tr>
                    <td>${product.name}</td>
                    <td>${product.category}</td>
                    <td>${product.price} €</td>
                    <td>${product.stock}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/products/detail?id=${product.id}">
                            Ver detalle
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </section>
</main>

</body>
</html>
```

### Explanation

We loop through the list with:

```jsp
<c:forEach var="product" items="${products}">
```

The `products` attribute comes from the controller:

```java
model.addAttribute("products", productService.findAll());
```

To access the properties we use:

```jsp
${product.name}
${product.category}
${product.price}
${product.stock}
```

Each expression internally calls the corresponding getter.

For example:

```jsp
${product.name}
```

calls:

```java
getName()
```

</details>

---

# Exercise 6 — Show the creation form

## Statement

Add a method to `ProductController` that responds to:

```text
GET /products/new
```

This method must:

1. Add to the model `pageTitle` with the value `Crear nuevo producto`.
2. Add an empty `Product` object to the model with the name `product`.
3. Return the `products/form` view.

---

<details>
<summary>Show solution</summary>

```java
@GetMapping("/new")
public String showCreateForm(Model model) {
    model.addAttribute("pageTitle", "Crear nuevo producto");
    model.addAttribute("product", new Product());

    return "products/form";
}
```

### Complete controller so far

```java
package com.example.shop.controller;

import com.example.shop.model.Product;
import com.example.shop.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/products")
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public String listProducts(Model model) {
        model.addAttribute("pageTitle", "Listado de productos");
        model.addAttribute("products", productService.findAll());

        return "products/list";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("pageTitle", "Crear nuevo producto");
        model.addAttribute("product", new Product());

        return "products/form";
    }
}
```

### Explanation

The form needs an object to bind to.

That's why we add:

```java
model.addAttribute("product", new Product());
```

The view will use that object with:

```jsp
<form:form modelAttribute="product">
```

The name must match exactly:

```text
product
```

</details>

---

# Exercise 7 — Create the form view with Spring tags

## Statement

Create the view:
```text
src/main/webapp/WEB-INF/views/products/form.jsp
```

The form must:

1. Use Spring's form tag library.
2. Send the data via `POST` to `/products`.
3. Be bound to the `product` attribute.
4. Have fields for:
   - `name`
   - `category`
   - `price`
   - `stock`
5. Show errors below each field.

For `category`, use a dropdown with the options:

```text
Informática
Papelería
Hogar
Otros
```

---

<details>
<summary>Show solution</summary>

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">Inicio</a>
        <a href="${pageContext.request.contextPath}/products">Productos</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <form:form
                method="post"
                action="${pageContext.request.contextPath}/products"
                modelAttribute="product"
                cssClass="form">

            <div class="form-group">
                <form:label path="name">Nombre</form:label>
                <form:input path="name" cssClass="input" />
                <form:errors path="name" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="category">Categoría</form:label>
                <form:select path="category" cssClass="input">
                    <form:option value="" label="Selecciona una categoría" />
                    <form:option value="Informática" label="Informática" />
                    <form:option value="Papelería" label="Papelería" />
                    <form:option value="Hogar" label="Hogar" />
                    <form:option value="Otros" label="Otros" />
                </form:select>
                <form:errors path="category" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="price">Precio</form:label>
                <form:input path="price" type="number" step="0.01" cssClass="input" />
                <form:errors path="price" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="stock">Stock</form:label>
                <form:input path="stock" type="number" cssClass="input" />
                <form:errors path="stock" cssClass="error" />
            </div>

            <div class="form-actions">
                <button type="submit" class="button">
                    Guardar producto
                </button>

                <a class="secondary-button" href="${pageContext.request.contextPath}/products">
                    Cancelar
                </a>
            </div>

        </form:form>
    </section>
</main>

</body>
</html>
```

### Explanation

The line:

```jsp
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
```

lets you use Spring's form tags.

The main tag is:

```jsp
<form:form modelAttribute="product">
```

This means that the form is bound to the `product` object sent from the controller.

Each field connects to a property of `Product`.

For example:

```jsp
<form:input path="name" />
```

is connected to:

```java
private String name;
```

Errors are shown with:

```jsp
<form:errors path="name" cssClass="error" />
```

</details>

---

# Exercise 8 — Process the form with `@ModelAttribute`

## Statement

Add a method to `ProductController` that responds to:

```text
POST /products
```

The method must:

1. Receive a `Product` object using `@ModelAttribute("product")`.
2. Save it using `productService.save(product)`.
3. Redirect to `/products`.

Don't add validation yet in this exercise.

---

<details>
<summary>Show solution</summary>

```java
@PostMapping
public String createProduct(@ModelAttribute("product") Product product) {
    productService.save(product);

    return "redirect:/products";
}
```

### Controller with the necessary imports

```java
package com.example.shop.controller;

import com.example.shop.model.Product;
import com.example.shop.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/products")
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public String listProducts(Model model) {
        model.addAttribute("pageTitle", "Listado de productos");
        model.addAttribute("products", productService.findAll());

        return "products/list";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("pageTitle", "Crear nuevo producto");
        model.addAttribute("product", new Product());

        return "products/form";
    }

    @PostMapping
    public String createProduct(@ModelAttribute("product") Product product) {
        productService.save(product);

        return "redirect:/products";
    }
}
```

### Explanation

The annotation:

```java
@ModelAttribute("product")
```

makes Spring MVC build a `Product` object from the fields submitted by the form.

If the form sends:

```text
name=Monitor
category=Informática
price=149.99
stock=8
```

Spring does something like:

```java
Product product = new Product();
product.setName("Monitor");
product.setCategory("Informática");
product.setPrice(149.99);
product.setStock(8);
```

Then we save the product and redirect:

```java
return "redirect:/products";
```

</details>

---

# Exercise 9 — Add validation with `@Valid` and `BindingResult`

## Statement

Modify the `createProduct` method so that:

1. It validates the product with `@Valid`.
2. It receives a `BindingResult`.
3. If there are errors, it shows the `products/form` view again.
4. If there are no errors, it saves the product and redirects to `/products`.

Remember that if there are errors you must add `pageTitle` to the model again.

---

<details>
<summary>Show solution</summary>

```java
@PostMapping
public String createProduct(
        @Valid @ModelAttribute("product") Product product,
        BindingResult bindingResult,
        Model model) {

    if (bindingResult.hasErrors()) {
        model.addAttribute("pageTitle", "Crear nuevo producto");
        return "products/form";
    }

    productService.save(product);

    return "redirect:/products";
}
```

### Required imports

```java
import jakarta.validation.Valid;
import org.springframework.validation.BindingResult;
```

### Explanation

The annotation:

```java
@Valid
```

activates the validations defined in `Product`.

For example:

```java
@NotBlank(message = "El nombre es obligatorio.")
private String name;
```

If the user leaves the name empty, Spring adds an error to `BindingResult`.

That's why we check:

```java
if (bindingResult.hasErrors()) {
```

If there are errors, we don't save the product. We go back to the form:

```java
return "products/form";
```

If there are no errors, we save and redirect:

```java
productService.save(product);
return "redirect:/products";
```

`BindingResult` must come right after the validated object:

```java
@Valid @ModelAttribute("product") Product product,
BindingResult bindingResult,
```

</details>

---

# Exercise 10 — Add a success message with `RedirectAttributes`

## Statement

Modify the `createProduct` method so that, when the product is saved successfully, it adds a temporary message called `successMessage`.

The message must be:

```text
El producto se ha creado correctamente.
```

Then modify `list.jsp` to display that message if it exists.

---

<details>
<summary>Show solution</summary>

## Controller

```java
@PostMapping
public String createProduct(
        @Valid @ModelAttribute("product") Product product,
        BindingResult bindingResult,
        Model model,
        RedirectAttributes redirectAttributes) {

    if (bindingResult.hasErrors()) {
        model.addAttribute("pageTitle", "Crear nuevo producto");
        return "products/form";
    }

    productService.save(product);

    redirectAttributes.addFlashAttribute(
            "successMessage",
            "El producto se ha creado correctamente."
    );

    return "redirect:/products";
}
```

### Required import

```java
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
```

## View `list.jsp`

Add this block before the table:

```jsp
<c:if test="${not empty successMessage}">
    <div class="success">
        ${successMessage}
    </div>
</c:if>
```

The main part of the view would look like this:

```jsp
<main class="container">
    <section class="card wide">
        <h1>${pageTitle}</h1>

        <c:if test="${not empty successMessage}">
            <div class="success">
                ${successMessage}
            </div>
        </c:if>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/products/new">
                Crear nuevo producto
            </a>
        </p>

        <!-- Tabla de productos -->
    </section>
</main>
```

### Explanation

`RedirectAttributes` lets you send temporary data after a redirect.

This is useful because after saving we do:

```java
return "redirect:/products";
```

The flash attribute:

```java
redirectAttributes.addFlashAttribute("successMessage", "...");
```

will be available in the next request, but won't stay in the session permanently.

</details>

---

# Exercise 11 — Create a product detail view

## Statement

Add a route:

```text
GET /products/detail?id=1
```

The method must:

1. Receive the `id` parameter with `@RequestParam`.
2. Look up the product.
3. If it does not exist, return the `products/not-found` view.
4. If it exists, add `product` and `pageTitle` to the model.
5. Return the `products/detail` view.

Then create the view `detail.jsp`.

---

<details>
<summary>Show solution</summary>

## Method in `ProductController`

```java
@GetMapping("/detail")
public String productDetail(@RequestParam("id") Long id, Model model) {
    Product product = productService.findById(id);

    if (product == null) {
        model.addAttribute("pageTitle", "Producto no encontrado");
        model.addAttribute("productId", id);

        return "products/not-found";
    }

    model.addAttribute("pageTitle", product.getName());
    model.addAttribute("product", product);

    return "products/detail";
}
```

### Required import

```java
import org.springframework.web.bind.annotation.RequestParam;
```

## View `detail.jsp`

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">Inicio</a>
        <a href="${pageContext.request.contextPath}/products">Productos</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${product.name}</h1>

        <ul class="details">
            <li>
                <strong>Categoría:</strong> ${product.category}
            </li>
            <li>
                <strong>Precio:</strong> ${product.price} €
            </li>
            <li>
                <strong>Stock:</strong> ${product.stock}
            </li>
            <li>
                <strong>Identificador:</strong> ${product.id}
            </li>
        </ul>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/products">
                Volver al listado
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

## View `not-found.jsp`

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">Inicio</a>
        <a href="${pageContext.request.contextPath}/products">Productos</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            No se ha encontrado ningún producto con el identificador ${productId}.
        </p>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/products">
                Volver al listado
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explanation

`@RequestParam` lets you read a specific parameter from the URL.

If the URL is:

```text
/products/detail?id=2
```

Spring assigns:

```java
id = 2L;
```

Then we look up the product with:

```java
productService.findById(id)
```

If it does not exist, we show a specific page.

</details>

---

# Exercise 12 — Add validation to a dropdown field

## Statement

In `Product`, the `category` field has this validation:

```java
@NotBlank(message = "La categoría es obligatoria.")
private String category;
```

Explain why it's important for the first option in the form to have an empty value:

```jsp
<form:option value="" label="Selecciona una categoría" />
```

Then modify the dropdown so that it has these categories:

```text
Informática
Libros
Ropa
Alimentación
```

---

<details>
<summary>Show solution</summary>

## Explanation

The first option must have an empty value:

```jsp
<form:option value="" label="Selecciona una categoría" />
```

because this way we can detect that the user has not selected any real category.

If the first option had a valid value, such as:

```jsp
<form:option value="Informática" label="Informática" />
```

then the form would be submitted with a valid category even if the user had not chosen anything.

Since we have:

```java
@NotBlank(message = "La categoría es obligatoria.")
```

we need the initial option to send an empty value so that validation can be triggered.

## Updated code

```jsp
<form:select path="category" cssClass="input">
    <form:option value="" label="Selecciona una categoría" />
    <form:option value="Informática" label="Informática" />
    <form:option value="Libros" label="Libros" />
    <form:option value="Ropa" label="Ropa" />
    <form:option value="Alimentación" label="Alimentación" />
</form:select>
<form:errors path="category" cssClass="error" />
```

</details>

---

# Exercise 13 — Diagnose common errors in forms

## Statement

Read each case and explain what the problem is.

## Case A

In the controller the object is added like this:

```java
model.addAttribute("product", new Product());
```

But the JSP has:

```jsp
<form:form modelAttribute="item">
```

What's happening?

---

## Case B

The POST method has:

```java
public String createProduct(
        @Valid @ModelAttribute("product") Product product,
        Model model,
        BindingResult bindingResult) {
```

Why is it wrong?

---

## Case C

The `Product` class has the attribute:

```java
private String name;
```

But the JSP has:

```jsp
<form:input path="productName" />
```

What's happening?

---

<details>
<summary>Show solution</summary>

## Case A

The attribute name does not match.

The controller sends:

```java
model.addAttribute("product", new Product());
```

but the JSP looks for:

```jsp
modelAttribute="item"
```

Spring will not find an object named `item` in the model.

The solution is to use the same name:

```jsp
<form:form modelAttribute="product">
```

---

## Case B

The problem is the order of the parameters.
`BindingResult` must come right after the validated object.

Incorrect:

```java
@Valid @ModelAttribute("product") Product product,
Model model,
BindingResult bindingResult
```

Correct:

```java
@Valid @ModelAttribute("product") Product product,
BindingResult bindingResult,
Model model
```

If `BindingResult` is not placed right after the validated object, Spring won't associate the validation errors correctly.

---

## Case C

The JSP field does not match any model property.

The class has:

```java
private String name;
```

Therefore, the form must use:

```jsp
<form:input path="name" />
```

If we write:

```jsp
<form:input path="productName" />
```

Spring will try to look for a property called `productName`, but it does not exist.

</details>

---

# Exercise 14 — Final challenge: a complete form to register customers

## Statement

Create a new section to register customers.

You must create:

1. A `Customer` class.
2. A `CustomerService` class.
3. A `CustomerController` class.
4. A `customers/list.jsp` view.
5. A `customers/form.jsp` view.

The `Customer` model must have:

| Field | Type | Validation |
| ---------------- | -------- | ------------------------------------ |
| `id` | `Long` | No validation |
| `fullName` | `String` | Required, between 3 and 80 characters |
| `email` | `String` | Required and email format |
| `membershipType` | `String` | Required |

The routes must be:

```text
GET  /customers      → listado de clientes
GET  /customers/new  → formulario
POST /customers      → guardar cliente
```

The form must have a dropdown for `membershipType` with:

```text
Basic
Premium
VIP
```

---

<details>
<summary>Show solution</summary>

## Model `Customer.java`

```java
package com.example.shop.model;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class Customer {

    private Long id;

    @NotBlank(message = "El nombre completo es obligatorio.")
    @Size(min = 3, max = 80, message = "El nombre debe tener entre 3 y 80 caracteres.")
    private String fullName;

    @NotBlank(message = "El email es obligatorio.")
    @Email(message = "Introduce un email válido.")
    private String email;

    @NotBlank(message = "El tipo de membresía es obligatorio.")
    private String membershipType;

    public Customer() {
    }

    public Customer(Long id, String fullName, String email, String membershipType) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.membershipType = membershipType;
    }

    public Long getId() {
        return id;
    }

    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public String getMembershipType() {
        return membershipType;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setMembershipType(String membershipType) {
        this.membershipType = membershipType;
    }
}
```

## `CustomerService.java` service

```java
package com.example.shop.service;

import com.example.shop.model.Customer;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CustomerService {

    private final List<Customer> customers = new ArrayList<>();

    private Long nextId = 3L;

    public CustomerService() {
        customers.add(new Customer(1L, "Laura Sánchez", "laura@example.com", "Premium"));
        customers.add(new Customer(2L, "Mario López", "mario@example.com", "Basic"));
    }

    public List<Customer> findAll() {
        return customers;
    }

    public void save(Customer customer) {
        customer.setId(nextId);
        customers.add(customer);
        nextId++;
    }
}
```

## `CustomerController.java` controller

```java
package com.example.shop.controller;

import com.example.shop.model.Customer;
import com.example.shop.service.CustomerService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/customers")
public class CustomerController {

    private final CustomerService customerService;

    public CustomerController(CustomerService customerService) {
        this.customerService = customerService;
    }

    @GetMapping
    public String listCustomers(Model model) {
        model.addAttribute("pageTitle", "Listado de clientes");
        model.addAttribute("customers", customerService.findAll());

        return "customers/list";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("pageTitle", "Registrar cliente");
        model.addAttribute("customer", new Customer());

        return "customers/form";
    }

    @PostMapping
    public String createCustomer(
            @Valid @ModelAttribute("customer") Customer customer,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("pageTitle", "Registrar cliente");
            return "customers/form";
        }

        customerService.save(customer);

        redirectAttributes.addFlashAttribute(
                "successMessage",
                "El cliente se ha registrado correctamente."
        );

        return "redirect:/customers";
    }
}
```

## View `customers/list.jsp`

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">Inicio</a>
        <a href="${pageContext.request.contextPath}/products">Productos</a>
        <a href="${pageContext.request.contextPath}/customers">Clientes</a>
    </nav>
</header>

<main class="container">
    <section class="card wide">
        <h1>${pageTitle}</h1>

        <c:if test="${not empty successMessage}">
            <div class="success">
                ${successMessage}
            </div>
        </c:if>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/customers/new">
                Registrar cliente
            </a>
        </p>

        <table class="table">
            <thead>
            <tr>
                <th>Nombre completo</th>
                <th>Email</th>
                <th>Membresía</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="customer" items="${customers}">
                <tr>
                    <td>${customer.fullName}</td>
                    <td>${customer.email}</td>
                    <td>${customer.membershipType}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </section>
</main>

</body>
</html>
```

## View `customers/form.jsp`

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">Inicio</a>
        <a href="${pageContext.request.contextPath}/products">Productos</a>
        <a href="${pageContext.request.contextPath}/customers">Clientes</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <form:form
                method="post"
                action="${pageContext.request.contextPath}/customers"
                modelAttribute="customer"
                cssClass="form">

            <div class="form-group">
                <form:label path="fullName">Nombre completo</form:label>
                <form:input path="fullName" cssClass="input" />
                <form:errors path="fullName" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="email">Email</form:label>
                <form:input path="email" type="email" cssClass="input" />
                <form:errors path="email" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="membershipType">Tipo de membresía</form:label>
                <form:select path="membershipType" cssClass="input">
                    <form:option value="" label="Selecciona una membresía" />
                    <form:option value="Basic" label="Basic" />
                    <form:option value="Premium" label="Premium" />
                    <form:option value="VIP" label="VIP" />
                </form:select>
                <form:errors path="membershipType" cssClass="error" />
            </div>

            <div class="form-actions">
                <button type="submit" class="button">
                    Registrar cliente
                </button>

                <a class="secondary-button" href="${pageContext.request.contextPath}/customers">
                    Cancelar
                </a>
            </div>

        </form:form>
    </section>
</main>

</body>
</html>
```

</details>
