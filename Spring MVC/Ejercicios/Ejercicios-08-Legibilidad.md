# Solved exercises — Topic 8: Readability

## Introduction

In these exercises you will practice the improvements from **Topic 8**, where we learned how to make the CRUD more readable using more expressive HTTP methods and cleaner routes.

Instead of working with courses, we will use a small **product management** application. This way you will practice the same idea, but with a different example.

You will work with:

- Clean routes using `@PathVariable`.
- Difference between `@RequestParam` and `@PathVariable`.
- Using `@PutMapping` to update.
- Using `@DeleteMapping` to delete.
- `HiddenHttpMethodFilter` configuration.
- HTML forms that submit `POST` with `_method=put` or `_method=delete`.
- Reuse of forms to create and edit.
- Private methods to prepare forms.
- Constants for views and redirects.
- Diagnosis of frequent errors.

Each solution is hidden under the **show solution** button.

---

# Exercise 1 — Relate HTTP method and CRUD operation

## Statement

Complete the table by indicating which HTTP method you would use for each operation in a product application.

| Operation | Recommended HTTP method |
| -------------------------------- | ----------------------- |
| See all products | ?                       |
| See the details of a product | ?                       |
| Show creation form | ?                       |
| Create a new product | ?                       |
| Show edit form | ?                       |
| Update an existing product | ?                       |
| Delete an existing product | ?                       |

---

<details>
<summary>show solution</summary>

| Operation | Recommended HTTP method |
| -------------------------------- | ----------------------- |
| See all products | `GET` |
| See the details of a product | `GET` |
| Show creation form | `GET` |
| Create a new product | `POST` |
| Show edit form | `GET` |
| Update an existing product | `PUT` |
| Delete an existing product | `DELETE` |

### Explanation

The general idea is:

```text
GET    → consultar información
POST   → crear un recurso nuevo
PUT    → actualizar un recurso existente
DELETE → borrar un recurso existente
```

In a Spring MVC application with JSP we still use traditional forms, but we can make Spring interpret some forms like `PUT` or `DELETE` using `HiddenHttpMethodFilter`.

</details>

---

# Exercise 2 — Transform old routes into clean routes

## Statement

Transform these old routes into cleaner routes using Theme 8 style.

| Old route | New route |
| --------------------------- | ---------- |
| `GET /products/detail?id=4` | ?          |
| `GET /products/edit?id=4` | ?          |
| `POST /products/update` | ?          |
| `POST /products/delete` | ?          |

---

<details>
<summary>show solution</summary>

| Old route | New route |
| --------------------------- | ---------------------- |
| `GET /products/detail?id=4` | `GET /products/4` |
| `GET /products/edit?id=4` | `GET /products/4/edit` |
| `POST /products/update` | `PUT /products/4` |
| `POST /products/delete` | `DELETE /products/4` |

### Explanation

Before, the identifier traveled as a parameter:

```text
/products/detail?id=4
```

Now it is part of the route:

```text
/products/4
```

This allows the driver to use:

```java
@PathVariable Long id
```

instead of:

```java
@RequestParam("id") Long id
```

</details>

---

# Exercise 3 — Differentiate `@RequestParam` and `@PathVariable`

## Statement

Indicate which annotation you would use to collect the `id` in each case.

## Case A

```text
/products/detail?id=7
```

## Case B

```text
/products/7
```

Then write an example controller method for each case.

---

<details>
<summary>show solution</summary>

## Case A

The URL is:

```text
/products/detail?id=7
```

Here the `id` is in the query string, so we use:

```java
@RequestParam("id")
```

Example:

```java
@GetMapping("/detail")
public String productDetail(
        @RequestParam("id") Long id,
        Model model) {

    return "products/detail";
}
```

## Case B

The URL is:

```text
/products/7
```

Here the `id` is part of the path, so we use:

```java
@PathVariable
```

Example:

```java
@GetMapping("/{id}")
public String productDetail(
        @PathVariable Long id,
        Model model) {

    return "products/detail";
}
```

### Explanation

`@RequestParam` reads values that come after `?`.

`@PathVariable` reads values ​​that are part of the route.

</details>

---

# Exercise 4 — Activate `HiddenHttpMethodFilter` in `web.xml`

## Statement

We want HTML forms to be able to submit actions that Spring interprets as `PUT` or `DELETE`.

Add to `web.xml` the necessary configuration to activate `HiddenHttpMethodFilter`.

---

<details>
<summary>show solution</summary>

```xml
<filter>
    <filter-name>hiddenHttpMethodFilter</filter-name>
    <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
</filter>

<filter-mapping>
    <filter-name>hiddenHttpMethodFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

### Explanation

Traditional HTML forms only submit:

```text
GET
POST
```

To simulate `PUT` or `DELETE`, we submit an `POST` form with a hidden field:

```html
<input type="hidden" name="_method" value="put" />
```

or:

```html
<input type="hidden" name="_method" value="delete" />
```

`HiddenHttpMethodFilter` reads that field and causes Spring to treat the request as `PUT` or `DELETE`.

</details>

---

# Exercise 5 — Create a detail route with `@PathVariable`

## Statement

You have this old method in `ProductController`:

```java
@GetMapping("/detail")
public String productDetail(
        @RequestParam("id") Long id,
        Model model) {

    Product product = productService.findByIdOrThrow(id);

    model.addAttribute("pageTitle", product.getName());
    model.addAttribute("product", product);

    return "products/detail";
}
```

Modify it to respond to:

```text
GET /products/{id}
```

For example:

```text
GET /products/3
```

---

<details>
<summary>show solution</summary>

```java
@GetMapping("/{id}")
public String productDetail(
        @PathVariable Long id,
        Model model) {

    Product product = productService.findByIdOrThrow(id);

    model.addAttribute("pageTitle", product.getName());
    model.addAttribute("product", product);

    return "products/detail";
}
```

### Import required

```java
import org.springframework.web.bind.annotation.PathVariable;
```

### Explanation

The annotation:

```java
@GetMapping("/{id}")
```

indicates that the path contains a variable.

If the user enters:

```text
/products/3
```

Spring assigns:

```java
id = 3L;
```

</details>

---

# Exercise 6 — Create an edit path with `@PathVariable`

## Statement

Create a method that displays a product edit form.

You must respond to:

```text
GET /products/{id}/edit
```

You must:

1. Receive the `id` with `@PathVariable`.
2. Search for the product with `productService.findByIdOrThrow(id)`.
3. Add to model:
   - `pageTitleCode` with `products.edit.title`.
   - `formAction` with `/products/ID_DEL_PRODUCTO`.
   - `formMethod` with `put`.
   - `submitCode` with `products.update`.
   - `product` with the found product.
4. Return `products/form`.

---

<details>
<summary>show solution</summary>

```java
@GetMapping("/{id}/edit")
public String showEditForm(
        @PathVariable Long id,
        Model model) {

    Product product = productService.findByIdOrThrow(id);

    model.addAttribute("pageTitleCode", "products.edit.title");
    model.addAttribute("formAction", "/products/" + product.getId());
    model.addAttribute("formMethod", "put");
    model.addAttribute("submitCode", "products.update");
    model.addAttribute("product", product);

    return "products/form";
}
```

### Explanation

The route:

```java
@GetMapping("/{id}/edit")
```

allows URLs like:

```text
/products/5/edit
```

The form will then be sent to:

```text
/products/5
```

but with:

```text
_method=put
```

for Spring to execute the `@PutMapping` method.

</details>

---

# Exercise 7 — Update using `@PutMapping`

## Statement

Create a method to update a product.

You must respond to:

```text
PUT /products/{id}
```

You must:

1. Receive the `id` with `@PathVariable`.
2. Receive the product with `@Valid @ModelAttribute("product")`.
3. Receive `BindingResult`.
4. Assign the `id` of the path to the product with `product.setId(id)`.
5. If there are errors, return to `products/form`.
6. If there are no errors, call `productService.update(product)`.
7. Add `success.product.updated` flash message.
8. Redirect to `/products`.

---

<details>
<summary>show solution</summary>

```java
@PutMapping("/{id}")
public String updateProduct(
        @PathVariable Long id,
        @Valid @ModelAttribute("product") Product product,
        BindingResult bindingResult,
        Model model,
        RedirectAttributes redirectAttributes) {

    product.setId(id);

    if (bindingResult.hasErrors()) {
        model.addAttribute("pageTitleCode", "products.edit.title");
        model.addAttribute("formAction", "/products/" + id);
        model.addAttribute("formMethod", "put");
        model.addAttribute("submitCode", "products.update");

        return "products/form";
    }

    productService.update(product);

    addFlashMessage(
            redirectAttributes,
            "success.product.updated"
    );

    return "redirect:/products";
}
```

### Imports required

```java
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;
```

### Explanation

The path contains the `id`:

```text
/products/5
```

That's why we receive:

```java
@PathVariable Long id
```

Then we do:

```java
product.setId(id);
```

This way we ensure that the object that arrives at the service has the correct identifier.

</details>

---

# Exercise 8 — Delete using `@DeleteMapping`

## Statement

Create a method to delete a product.

You must respond to:

```text
DELETE /products/{id}
```

You must:

1. Receive the `id` with `@PathVariable`.
2. Call `productService.deleteById(id)`.
3. Add flash message `success.product.deleted`.
4. Redirect to `/products`.

---

<details>
<summary>show solution</summary>

```java
@DeleteMapping("/{id}")
public String deleteProduct(
        @PathVariable Long id,
        RedirectAttributes redirectAttributes) {

    productService.deleteById(id);

    addFlashMessage(
            redirectAttributes,
            "success.product.deleted"
    );

    return "redirect:/products";
}
```

### Import required

```java
import org.springframework.web.bind.annotation.DeleteMapping;
```

### Explanation

The route:

```text
DELETE /products/5
```

clearly states that we want to delete the product with id `5`.

The controller no longer needs to receive the id with:

```java
@RequestParam("id")
```

because the id is part of the route.

</details>

---

# Exercise 9 — Create private methods to prepare forms

## Statement

In `ProductController`, create two private methods:

```java
prepareCreateForm(...)
prepareEditForm(...)
```

`prepareCreateForm` must prepare the form to create a product.

`prepareEditForm` must prepare the form to edit a product.

Use these attributes:

| Attribute | Create | Edit |
| --------------- | ----------------------- | --------------------- |
| `pageTitleCode` | `products.create.title` | `products.edit.title` |
| `formAction` | `/products` | `/products/{id}` |
| `formMethod` | `post` | `put` |
| `submitCode` | `products.create` | `products.update` |
| `product` | product received | product received |

---

<details>
<summary>show solution</summary>

```java
private void prepareCreateForm(Model model, Product product) {
    model.addAttribute("pageTitleCode", "products.create.title");
    model.addAttribute("formAction", "/products");
    model.addAttribute("formMethod", "post");
    model.addAttribute("submitCode", "products.create");
    model.addAttribute("product", product);
}

private void prepareEditForm(Model model, Product product) {
    model.addAttribute("pageTitleCode", "products.edit.title");
    model.addAttribute("formAction", "/products/" + product.getId());
    model.addAttribute("formMethod", "put");
    model.addAttribute("submitCode", "products.update");
    model.addAttribute("product", product);
}
```

### Explanation

These methods avoid repeating many times:

```java
model.addAttribute(...)
```

In creation we use:

```text
POST /products
```

In editing we use:

```text
PUT /products/{id}
```

The `products/form.jsp` view will be able to work in both cases.

</details>

---

# Exercise 10 — Use private methods in creation

## Statement

Modify these two methods to use `prepareCreateForm`.

Method displaying the form:

```java
@GetMapping("/new")
public String showCreateForm(Model model) {
    model.addAttribute("pageTitleCode", "products.create.title");
    model.addAttribute("formAction", "/products");
    model.addAttribute("formMethod", "post");
    model.addAttribute("submitCode", "products.create");
    model.addAttribute("product", new Product());

    return "products/form";
}
```

Method that processes the form:

```java
@PostMapping
public String createProduct(
        @Valid @ModelAttribute("product") Product product,
        BindingResult bindingResult,
        Model model,
        RedirectAttributes redirectAttributes) {

    if (bindingResult.hasErrors()) {
        model.addAttribute("pageTitleCode", "products.create.title");
        model.addAttribute("formAction", "/products");
        model.addAttribute("formMethod", "post");
        model.addAttribute("submitCode", "products.create");

        return "products/form";
    }

    productService.save(product);

    return "redirect:/products";
}
```

---

<details>
<summary>show solution</summary>

```java
@GetMapping("/new")
public String showCreateForm(Model model) {
    prepareCreateForm(model, new Product());

    return "products/form";
}
```

```java
@PostMapping
public String createProduct(
        @Valid @ModelAttribute("product") Product product,
        BindingResult bindingResult,
        Model model,
        RedirectAttributes redirectAttributes) {

    if (bindingResult.hasErrors()) {
        prepareCreateForm(model, product);
        return "products/form";
    }

    productService.save(product);

    addFlashMessage(
            redirectAttributes,
            "success.product.created"
    );

    return "redirect:/products";
}
```

### Explanation
With `prepareCreateForm` we avoid repeating the same attributes.

If there are errors, we send again the same product received:

```java
prepareCreateForm(model, product);
```

Thus the form preserves the data that the user had written.

</details>

---

# Exercise 11 — Add constants for views and redirects

## Statement

In `ProductController`, add constants to avoid repeating these strings:

```java
"redirect:/products"
"products/form"
```

Then use them in the controller methods.

---

<details>
<summary>show solution</summary>

At the beginning of the class we add:

```java
private static final String REDIRECT_PRODUCTS = "redirect:/products";
private static final String PRODUCT_FORM_VIEW = "products/form";
```

Example of use:

```java
@GetMapping("/new")
public String showCreateForm(Model model) {
    prepareCreateForm(model, new Product());

    return PRODUCT_FORM_VIEW;
}
```

```java
@PostMapping
public String createProduct(
        @Valid @ModelAttribute("product") Product product,
        BindingResult bindingResult,
        Model model,
        RedirectAttributes redirectAttributes) {

    if (bindingResult.hasErrors()) {
        prepareCreateForm(model, product);
        return PRODUCT_FORM_VIEW;
    }

    productService.save(product);

    addFlashMessage(
            redirectAttributes,
            "success.product.created"
    );

    return REDIRECT_PRODUCTS;
}
```

### Explanation

This does not change how the application works.

But it avoids repeating text strings and reduces typing errors.

</details>

---

# Exercise 12 — Create a form that sends `PUT`

## Statement

Modify this form so that when `formMethod` is `put`, it adds a hidden field `_method` with value `put`.

```jsp
<form:form
        method="post"
        action="${pageContext.request.contextPath}${formAction}"
        modelAttribute="product"
        cssClass="form">

    <form:hidden path="id" />

    <!-- campos del formulario -->

</form:form>
```

---

<details>
<summary>show solution</summary>

```jsp
<form:form
        method="post"
        action="${pageContext.request.contextPath}${formAction}"
        modelAttribute="product"
        cssClass="form">

    <c:if test="${formMethod == 'put'}">
        <input type="hidden" name="_method" value="put">
    </c:if>

    <form:hidden path="id" />

    <!-- campos del formulario -->

</form:form>
```

### Explanation

The form still uses:

```jsp
method="post"
```

But when we are editing, we add:

```html
<input type="hidden" name="_method" value="put" />
```

`HiddenHttpMethodFilter` detects that field and Spring executes the method with:

```java
@PutMapping
```

</details>

---

# Exercise 13 — Create a deletion form that sends `DELETE`

## Statement

In `products/list.jsp`, create a form to delete a product using:

```text
DELETE /products/{id}
```

Remember that the HTML form must use `method="post"` and a hidden field `_method`.

---

<details>
<summary>show solution</summary>

```jsp
<form method="post"
      action="${pageContext.request.contextPath}/products/${product.id}"
      class="inline-form"
      onsubmit="return confirm('<spring:message code="products.confirmDelete" />');">

    <input type="hidden" name="_method" value="delete">

    <button type="submit" class="link-button">
        <spring:message code="products.delete" />
    </button>
</form>
```

### Explanation

The browser actually sends:

```text
POST /products/3
```

but the form includes:

```text
_method=delete
```

So `HiddenHttpMethodFilter` causes Spring to interpret it as:

```text
DELETE /products/3
```

and it runs:

```java
@DeleteMapping("/{id}")
```

</details>

---

# Exercise 14 — Update list links

## Statement

You have these old links in `products/list.jsp`:

```jsp
<a href="${pageContext.request.contextPath}/products/detail?id=${product.id}">
    Ver detalle
</a>

<a href="${pageContext.request.contextPath}/products/edit?id=${product.id}">
    Editar
</a>
```

Update them to use clean routes.

---

<details>
<summary>show solution</summary>

```jsp
<a href="${pageContext.request.contextPath}/products/${product.id}">
    Ver detalle
</a>

<a href="${pageContext.request.contextPath}/products/${product.id}/edit">
    Editar
</a>
```

### Explanation

Before we used query string:

```text
/products/detail?id=3
```

Now we use routes with `PathVariable`:

```text
/products/3
/products/3/edit
```

This makes the routes cleaner and more expressive.

</details>

---

# Exercise 15 — Create a complete stock table in `list.jsp`

## Statement

Create the actions cell for a products table.

Must include:

1. Link to detail with `/products/{id}`.
2. Link to edition with `/products/{id}/edit`.
3. Deletion form with `DELETE /products/{id}`.

Use internationalized messages.

---

<details>
<summary>show solution</summary>

```jsp
<td class="actions-cell">
    <a href="${pageContext.request.contextPath}/products/${product.id}">
        <spring:message code="products.detail" />
    </a>

    <a href="${pageContext.request.contextPath}/products/${product.id}/edit">
        <spring:message code="products.edit" />
    </a>

    <form method="post"
          action="${pageContext.request.contextPath}/products/${product.id}"
          class="inline-form"
          onsubmit="return confirm('<spring:message code="products.confirmDelete" />');">

        <input type="hidden" name="_method" value="delete">

        <button type="submit" class="link-button">
            <spring:message code="products.delete" />
        </button>
    </form>
</td>
```

### Explanation

The cell combines three actions:

```text
GET    /products/{id}
GET    /products/{id}/edit
DELETE /products/{id}
```

Deletion requires a form because it modifies data.

</details>

---

# Exercise 16 — Create complete `ProductController` with clean paths

## Statement

Create a complete `ProductController` using:

```java
@GetMapping
@GetMapping("/{id}")
@GetMapping("/new")
@PostMapping
@GetMapping("/{id}/edit")
@PutMapping("/{id}")
@DeleteMapping("/{id}")
```

The driver must use:

- `ProductService`
- `MessageSource`
- private methods `prepareCreateForm`, `prepareEditForm`
- private method `addFlashMessage`
- constants for form view and redirection

---

<details>
<summary>show solution</summary>

```java
package com.example.shop.controller;

import com.example.shop.model.Product;
import com.example.shop.service.ProductService;
import jakarta.validation.Valid;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Locale;

@Controller
@RequestMapping("/products")
public class ProductController {

    private static final String REDIRECT_PRODUCTS = "redirect:/products";
    private static final String PRODUCT_FORM_VIEW = "products/form";

    private final ProductService productService;
    private final MessageSource messageSource;

    public ProductController(
            ProductService productService,
            MessageSource messageSource) {

        this.productService = productService;
        this.messageSource = messageSource;
    }

    @GetMapping
    public String listProducts(Model model) {
        model.addAttribute("pageTitleCode", "products.list.title");
        model.addAttribute("products", productService.findAll());

        return "products/list";
    }

    @GetMapping("/{id}")
    public String productDetail(
            @PathVariable Long id,
            Model model) {

        Product product = productService.findByIdOrThrow(id);

        model.addAttribute("pageTitle", product.getName());
        model.addAttribute("product", product);

        return "products/detail";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        prepareCreateForm(model, new Product());

        return PRODUCT_FORM_VIEW;
    }

    @PostMapping
    public String createProduct(
            @Valid @ModelAttribute("product") Product product,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            prepareCreateForm(model, product);
            return PRODUCT_FORM_VIEW;
        }

        productService.save(product);

        addFlashMessage(
                redirectAttributes,
                "success.product.created"
        );

        return REDIRECT_PRODUCTS;
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(
            @PathVariable Long id,
            Model model) {

        Product product = productService.findByIdOrThrow(id);

        prepareEditForm(model, product);

        return PRODUCT_FORM_VIEW;
    }

    @PutMapping("/{id}")
    public String updateProduct(
            @PathVariable Long id,
            @Valid @ModelAttribute("product") Product product,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        product.setId(id);

        if (bindingResult.hasErrors()) {
            prepareEditForm(model, product);
            return PRODUCT_FORM_VIEW;
        }

        productService.update(product);

        addFlashMessage(
                redirectAttributes,
                "success.product.updated"
        );

        return REDIRECT_PRODUCTS;
    }

    @DeleteMapping("/{id}")
    public String deleteProduct(
            @PathVariable Long id,
            RedirectAttributes redirectAttributes) {

        productService.deleteById(id);

        addFlashMessage(
                redirectAttributes,
                "success.product.deleted"
        );

        return REDIRECT_PRODUCTS;
    }

    private void prepareCreateForm(Model model, Product product) {
        model.addAttribute("pageTitleCode", "products.create.title");
        model.addAttribute("formAction", "/products");
        model.addAttribute("formMethod", "post");
        model.addAttribute("submitCode", "products.create");
        model.addAttribute("product", product);
    }

    private void prepareEditForm(Model model, Product product) {
        model.addAttribute("pageTitleCode", "products.edit.title");
        model.addAttribute("formAction", "/products/" + product.getId());
        model.addAttribute("formMethod", "put");
        model.addAttribute("submitCode", "products.update");
        model.addAttribute("product", product);
    }

    private void addFlashMessage(
            RedirectAttributes redirectAttributes,
            String messageCode) {

        Locale locale = LocaleContextHolder.getLocale();

        String message = messageSource.getMessage(
                messageCode,
                null,
                locale
        );

        redirectAttributes.addFlashAttribute("successMessage", message);
    }
}
```

### Explanation

This controller expresses the CRUD more clearly:

```text
POST   /products      → crear
PUT    /products/{id} → actualizar
DELETE /products/{id} → borrar
```

Also, use clean paths for detail and editing.

</details>

---

# Exercise 17 — Update full `products/form.jsp`

## Statement

Create a reusable JSP form to create and edit products.

You must:

1. Always send `method="post"`.
2. Use `${formAction}` as action.
3. Add `_method=put` only if `formMethod == 'put'`.
4. Have hidden field `id`.
5. Have fields for:
   - `name`
   - `category`
   - `price`
   - `stock`
6. Use `${submitCode}` for the button text.

---

<details>
<summary>show solution</summary>

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <%@ include file="/WEB-INF/views/fragments/head.jspf" %>
</head>
<body>

<%@ include file="/WEB-INF/views/fragments/header.jspf" %>

<main class="container">
    <section class="card">
        <h1>
            <spring:message code="${pageTitleCode}" />
        </h1>

        <form:form
                method="post"
                action="${pageContext.request.contextPath}${formAction}"
                modelAttribute="product"
                cssClass="form">

            <c:if test="${formMethod == 'put'}">
                <input type="hidden" name="_method" value="put">
            </c:if>

            <form:hidden path="id" />

            <div class="form-group">
                <form:label path="name">Nombre</form:label>
                <form:input path="name" cssClass="input" />
                <form:errors path="name" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="category">Categoría</form:label>
                <form:select path="category" cssClass="input">
                    <form:option value="">
                        Selecciona una categoría
                    </form:option>

                    <c:forEach var="category" items="${productCategories}">
                        <form:option value="${category}">
                            ${category}
                        </form:option>
                    </c:forEach>
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
                    <spring:message code="${submitCode}" />
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

Even though we are editing, the form uses:

```jsp
method="post"
```

The difference is in:

```jsp
<input type="hidden" name="_method" value="put">
```

That field only appears when the form is in edit mode.

</details>

---

# Exercise 18 — Update full `products/list.jsp`

## Statement

Create an `products/list.jsp` view that uses the new clean paths.

Must include:

1. List of products.
2. Link to detail: `/products/{id}`.
3. Link to edit: `/products/{id}/edit`.
4. Form to delete with `_method=delete`.
5. Success message if `successMessage` exists.

---

<details>
<summary>show solution</summary>

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <%@ include file="/WEB-INF/views/fragments/head.jspf" %>
</head>
<body>

<%@ include file="/WEB-INF/views/fragments/header.jspf" %>

<main class="container">
    <section class="card wide">
        <h1>
            <spring:message code="products.list.title" />
        </h1>

        <c:if test="${not empty successMessage}">
            <div class="success">
                ${successMessage}
            </div>
        </c:if>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/products/new">
                <spring:message code="products.create" />
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
                    <td class="actions-cell">
                        <a href="${pageContext.request.contextPath}/products/${product.id}">
                            <spring:message code="products.detail" />
                        </a>

                        <a href="${pageContext.request.contextPath}/products/${product.id}/edit">
                            <spring:message code="products.edit" />
                        </a>

                        <form method="post"
                              action="${pageContext.request.contextPath}/products/${product.id}"
                              class="inline-form"
                              onsubmit="return confirm('<spring:message code="products.confirmDelete" />');">

                            <input type="hidden" name="_method" value="delete">

                            <button type="submit" class="link-button">
                                <spring:message code="products.delete" />
                            </button>
                        </form>
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

The view no longer uses routes like:

```text
/products/detail?id=1
/products/edit?id=1
/products/delete
```

Now use cleaner routes:

```text
/products/1
/products/1/edit
DELETE /products/1
```

</details>

---

# Exercise 19 — Diagnose errors with `HiddenHttpMethodFilter`

## Statement

Read the following cases and explain what happens.

## Case A

The edit form contains:

```html
<input type="hidden" name="_method" value="put" />
```

but in `web.xml` `HiddenHttpMethodFilter` has not been set.

What's happening?

---

## Case B

In `web.xml`, `HiddenHttpMethodFilter` is configured, but the form does not contain the `_method` field.

What's happening?

---

## Case C

The form has:

```html
<input type="hidden" name="method" value="put" />
```

instead of:

```html
<input type="hidden" name="_method" value="put" />
```

What's happening?

---

<details>
<summary>show solution</summary>

## Case A

The form will arrive as `POST`.

Spring will not transform it into `PUT`.

Therefore, the method:

```java
@PutMapping("/{id}")
```

will not be executed.

---

## Case B

Even though the filter is configured, it has no `_method` field to read.

The request will still be `POST`.

---

## Case C

The field name is wrong.

`HiddenHttpMethodFilter` expects a field called:

```text
_method
```

Not:

```text
method
```

The solution is:

```html
<input type="hidden" name="_method" value="put" />
```

</details>

---

# Exercise 20 — Diagnose errors with clean routes

## Statement

Read the following cases and explain what happens.

## Case A

The controller has:

```java
@GetMapping("/{id}")
```

but the JSP links to:

```text
/products/detail?id=1
```

What's happening?

---

## Case B

The controller has:

```java
@GetMapping("/{id}")
public String detail(@RequestParam("id") Long id) {
    ...
}
```

What's wrong?

---

## Case C

The editing method uses:

```java
@PutMapping("/{id}")
```

but the form sends to:

```text
/products/update
```

What's happening?

---

<details>
<summary>show solution</summary>

## Case A

The JSP continues to use the old route.
The controller expects a route like:

```text
/products/1
```

but the JSP generates:

```text
/products/detail?id=1
```

You need to update the link:

```jsp
/products/${product.id}
```

---

## Case B

The annotation does not correspond to the route.

If the route is:

```java
@GetMapping("/{id}")
```

the id must be received with:

```java
@PathVariable Long id
```

Not with:

```java
@RequestParam("id")
```

---

## Case C

The form is not pointing to the correct path.

If the driver waits:

```text
PUT /products/{id}
```

The form must be sent to:

```text
/products/ID
```

with:

```html
<input type="hidden" name="_method" value="put" />
```

You should not send to:

```text
/products/update
```

</details>

---

# Exercise 21 — Final challenge: improve employee CRUD

## Statement

You have an employee Spring MVC application. Currently using old routes:

```text
GET  /employees/detail?id=1
GET  /employees/edit?id=1
POST /employees/update
POST /employees/delete
```

Transform the controller and views to use:

```text
GET    /employees/{id}
GET    /employees/{id}/edit
PUT    /employees/{id}
DELETE /employees/{id}
```

Create:

1. `HiddenHttpMethodFilter` configuration.
2. Main methods of `EmployeeController`.
3. Edit form fragment with `_method=put`.
4. Listing fragment with link to detail, link to edit and deletion form.

---

<details>
<summary>show solution</summary>

## 1. `web.xml`

```xml
<filter>
    <filter-name>hiddenHttpMethodFilter</filter-name>
    <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
</filter>

<filter-mapping>
    <filter-name>hiddenHttpMethodFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

## 2. Main methods of `EmployeeController`

```java
@Controller
@RequestMapping("/employees")
public class EmployeeController {

    private static final String REDIRECT_EMPLOYEES = "redirect:/employees";
    private static final String EMPLOYEE_FORM_VIEW = "employees/form";

    private final EmployeeService employeeService;

    public EmployeeController(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    @GetMapping
    public String listEmployees(Model model) {
        model.addAttribute("employees", employeeService.findAll());
        return "employees/list";
    }

    @GetMapping("/{id}")
    public String employeeDetail(
            @PathVariable Long id,
            Model model) {

        Employee employee = employeeService.findByIdOrThrow(id);

        model.addAttribute("employee", employee);

        return "employees/detail";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        prepareCreateForm(model, new Employee());

        return EMPLOYEE_FORM_VIEW;
    }

    @PostMapping
    public String createEmployee(
            @Valid @ModelAttribute("employee") Employee employee,
            BindingResult bindingResult,
            Model model) {

        if (bindingResult.hasErrors()) {
            prepareCreateForm(model, employee);
            return EMPLOYEE_FORM_VIEW;
        }

        employeeService.save(employee);

        return REDIRECT_EMPLOYEES;
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(
            @PathVariable Long id,
            Model model) {

        Employee employee = employeeService.findByIdOrThrow(id);

        prepareEditForm(model, employee);

        return EMPLOYEE_FORM_VIEW;
    }

    @PutMapping("/{id}")
    public String updateEmployee(
            @PathVariable Long id,
            @Valid @ModelAttribute("employee") Employee employee,
            BindingResult bindingResult,
            Model model) {

        employee.setId(id);

        if (bindingResult.hasErrors()) {
            prepareEditForm(model, employee);
            return EMPLOYEE_FORM_VIEW;
        }

        employeeService.update(employee);

        return REDIRECT_EMPLOYEES;
    }

    @DeleteMapping("/{id}")
    public String deleteEmployee(@PathVariable Long id) {
        employeeService.deleteById(id);

        return REDIRECT_EMPLOYEES;
    }

    private void prepareCreateForm(Model model, Employee employee) {
        model.addAttribute("formAction", "/employees");
        model.addAttribute("formMethod", "post");
        model.addAttribute("buttonText", "Crear empleado");
        model.addAttribute("employee", employee);
    }

    private void prepareEditForm(Model model, Employee employee) {
        model.addAttribute("formAction", "/employees/" + employee.getId());
        model.addAttribute("formMethod", "put");
        model.addAttribute("buttonText", "Actualizar empleado");
        model.addAttribute("employee", employee);
    }
}
```

## 3. Form fragment with `_method=put`

```jsp
<form:form
        method="post"
        action="${pageContext.request.contextPath}${formAction}"
        modelAttribute="employee"
        cssClass="form">

    <c:if test="${formMethod == 'put'}">
        <input type="hidden" name="_method" value="put">
    </c:if>

    <form:hidden path="id" />

    <div class="form-group">
        <form:label path="fullName">Nombre completo</form:label>
        <form:input path="fullName" cssClass="input" />
        <form:errors path="fullName" cssClass="error" />
    </div>

    <div class="form-group">
        <form:label path="department">Departamento</form:label>
        <form:input path="department" cssClass="input" />
        <form:errors path="department" cssClass="error" />
    </div>

    <button type="submit" class="button">
        ${buttonText}
    </button>

</form:form>
```

## 4. Listing fragment with actions

```jsp
<td class="actions-cell">
    <a href="${pageContext.request.contextPath}/employees/${employee.id}">
        Ver detalle
    </a>

    <a href="${pageContext.request.contextPath}/employees/${employee.id}/edit">
        Editar
    </a>

    <form method="post"
          action="${pageContext.request.contextPath}/employees/${employee.id}"
          class="inline-form"
          onsubmit="return confirm('¿Seguro que quieres borrar este empleado?');">

        <input type="hidden" name="_method" value="delete">

        <button type="submit" class="link-button">
            Borrar
        </button>
    </form>
</td>
```

### Explanation

This challenge applies everything learned:

```text
@PathVariable para ids en la ruta.
@PutMapping para actualizar.
@DeleteMapping para borrar.
HiddenHttpMethodFilter para interpretar _method.
Formularios POST con _method=put o _method=delete.
```

The result is a more readable and more expressive CRUD.

</details>
