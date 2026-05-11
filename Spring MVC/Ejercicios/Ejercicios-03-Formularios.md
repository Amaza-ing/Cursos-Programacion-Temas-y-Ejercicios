# Ejercicios Tema 3: Formularios, validación y procesamiento de datos en Spring MVC

## Introducción

En estos ejercicios vas a practicar los contenidos principales del **Tema 3**:

- Creación de formularios en Spring MVC.
- Uso de `@ModelAttribute`.
- Uso de `@Valid`.
- Uso de `BindingResult`.
- Validación con Jakarta Bean Validation.
- Uso de etiquetas `<form:form>`, `<form:input>`, `<form:select>` y `<form:errors>`.
- Procesamiento de peticiones `GET` y `POST`.
- Redirección después de guardar datos.
- Uso de mensajes temporales con `RedirectAttributes`.
- Separación entre controlador, modelo y servicio.

Los ejercicios siguen una progresión paso a paso. Usaremos como ejemplo una pequeña aplicación de gestión de **productos**, diferente al ejemplo de cursos visto en la teoría.

Cada solución está oculta bajo el botón **mostrar solución**.

---

# Ejercicio 1 — Añadir las dependencias necesarias para validación

## Enunciado

En el Tema 3 vamos a validar formularios usando anotaciones como:

```java
@NotBlank
@Size
@NotNull
@Min
@Max
```

Añade al `pom.xml` la dependencia necesaria para usar Jakarta Bean Validation con Hibernate Validator.

---

<details>
<summary>mostrar solución</summary>

```xml
<!-- Implementación de Jakarta Bean Validation -->
<dependency>
    <groupId>org.hibernate.validator</groupId>
    <artifactId>hibernate-validator</artifactId>
    <version>8.0.3.Final</version>
</dependency>
```

### Explicación

Las anotaciones como:

```java
@NotBlank
@Size
@Min
@Max
```

pertenecen a Jakarta Bean Validation.

Sin una implementación de validación, Spring MVC no podrá aplicar correctamente esas reglas cuando usemos:

```java
@Valid
```

Hibernate Validator es una implementación habitual de Jakarta Bean Validation.

</details>

---

# Ejercicio 2 — Crear el modelo `Product` con validación

## Enunciado

Crea una clase llamada `Product` en el paquete:

```text
com.example.shop.model
```

La clase debe tener estos atributos:

| Atributo   | Tipo      |
| ---------- | --------- |
| `id`       | `Long`    |
| `name`     | `String`  |
| `category` | `String`  |
| `price`    | `Double`  |
| `stock`    | `Integer` |

Añade las siguientes validaciones:

| Campo      | Validación                            |
| ---------- | ------------------------------------- |
| `name`     | Obligatorio y entre 3 y 60 caracteres |
| `category` | Obligatorio                           |
| `price`    | Obligatorio y mínimo 0.01             |
| `stock`    | Obligatorio y mínimo 0                |

La clase debe tener constructor vacío, constructor con todos los campos, getters y setters.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

Usamos:

```java
@NotBlank
```

para campos de texto que no pueden estar vacíos.

Usamos:

```java
@NotNull
```

para campos numéricos que deben tener valor.

El campo `price` es `Double`, no `double`, porque necesitamos que pueda valer `null` cuando el usuario deja el campo vacío.

El campo `stock` es `Integer`, no `int`, por la misma razón.

Si usamos tipos primitivos como `int` o `double`, no podemos representar bien la ausencia de valor.

</details>

---

# Ejercicio 3 — Crear un servicio mutable de productos

## Enunciado

Crea una clase llamada `ProductService` en el paquete:

```text
com.example.shop.service
```

Debe estar anotada con `@Service`.

La clase debe:

1. Tener una lista mutable de productos.
2. Cargar tres productos iniciales.
3. Tener un contador `nextId`.
4. Tener un método `findAll()`.
5. Tener un método `findById(Long id)`.
6. Tener un método `save(Product product)` que asigne un id nuevo y guarde el producto.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

Usamos:

```java
new ArrayList<>()
```

porque necesitamos una lista modificable.

Si usáramos:

```java
List.of(...)
```

no podríamos añadir productos nuevos.

El método `save` hace tres cosas:

```java
product.setId(nextId);
products.add(product);
nextId++;
```

Primero asigna un identificador, después guarda el producto y finalmente aumenta el contador para el siguiente producto.

</details>

---

# Ejercicio 4 — Crear un controlador para listar productos

## Enunciado

Crea un controlador llamado `ProductController` en el paquete:

```text
com.example.shop.controller
```

Debe:

1. Estar anotado con `@Controller`.
2. Tener una ruta base `/products`.
3. Recibir `ProductService` por constructor.
4. Tener un método que responda a `GET /products`.
5. Añadir al modelo:
   - `pageTitle` con el valor `Listado de productos`.
   - `products` con la lista de productos.
6. Devolver la vista `products/list`.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La ruta base es:

```java
@RequestMapping("/products")
```

Como el método tiene:

```java
@GetMapping
```

responde a:

```text
GET /products
```

El controlador no crea los productos directamente. Se los pide al servicio:

```java
productService.findAll()
```

La vista devuelta es:

```java
return "products/list";
```

Spring buscará:

```text
/WEB-INF/views/products/list.jsp
```

</details>

---

# Ejercicio 5 — Crear la vista de listado de productos

## Enunciado

Crea la vista:

```text
src/main/webapp/WEB-INF/views/products/list.jsp
```

Debe mostrar una tabla con:

```text
Nombre | Categoría | Precio | Stock | Acción
```

También debe incluir un botón para crear un producto nuevo que apunte a:

```text
/products/new
```

Usa JSTL para recorrer la lista de productos.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La lista se recorre con:

```jsp
<c:forEach var="product" items="${products}">
```

El atributo `products` viene del controlador:

```java
model.addAttribute("products", productService.findAll());
```

Para acceder a las propiedades usamos:

```jsp
${product.name}
${product.category}
${product.price}
${product.stock}
```

Cada expresión llama internamente al getter correspondiente.

Por ejemplo:

```jsp
${product.name}
```

llama a:

```java
getName()
```

</details>

---

# Ejercicio 6 — Mostrar el formulario de creación

## Enunciado

Añade a `ProductController` un método que responda a:

```text
GET /products/new
```

Este método debe:

1. Añadir al modelo `pageTitle` con el valor `Crear nuevo producto`.
2. Añadir al modelo un objeto vacío `Product` con el nombre `product`.
3. Devolver la vista `products/form`.

---

<details>
<summary>mostrar solución</summary>

```java
@GetMapping("/new")
public String showCreateForm(Model model) {
    model.addAttribute("pageTitle", "Crear nuevo producto");
    model.addAttribute("product", new Product());

    return "products/form";
}
```

### Controlador completo hasta este punto

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

### Explicación

El formulario necesita un objeto al que vincularse.

Por eso añadimos:

```java
model.addAttribute("product", new Product());
```

La vista usará ese objeto con:

```jsp
<form:form modelAttribute="product">
```

El nombre debe coincidir exactamente:

```text
product
```

</details>

---

# Ejercicio 7 — Crear la vista del formulario con etiquetas de Spring

## Enunciado

Crea la vista:

```text
src/main/webapp/WEB-INF/views/products/form.jsp
```

El formulario debe:

1. Usar la librería de etiquetas de formulario de Spring.
2. Enviar los datos por `POST` a `/products`.
3. Estar vinculado al atributo `product`.
4. Tener campos para:
   - `name`
   - `category`
   - `price`
   - `stock`
5. Mostrar errores debajo de cada campo.

Para `category`, usa un desplegable con las opciones:

```text
Informática
Papelería
Hogar
Otros
```

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La línea:

```jsp
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
```

permite usar etiquetas de formulario de Spring.

La etiqueta principal es:

```jsp
<form:form modelAttribute="product">
```

Esto significa que el formulario está vinculado al objeto `product` enviado desde el controlador.

Cada campo se conecta con una propiedad de `Product`.

Por ejemplo:

```jsp
<form:input path="name" />
```

se conecta con:

```java
private String name;
```

Los errores se muestran con:

```jsp
<form:errors path="name" cssClass="error" />
```

</details>

---

# Ejercicio 8 — Procesar el formulario con `@ModelAttribute`

## Enunciado

Añade a `ProductController` un método que responda a:

```text
POST /products
```

El método debe:

1. Recibir un objeto `Product` mediante `@ModelAttribute("product")`.
2. Guardarlo usando `productService.save(product)`.
3. Redirigir a `/products`.

En este ejercicio todavía no añadas validación.

---

<details>
<summary>mostrar solución</summary>

```java
@PostMapping
public String createProduct(@ModelAttribute("product") Product product) {
    productService.save(product);

    return "redirect:/products";
}
```

### Controlador con imports necesarios

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

### Explicación

La anotación:

```java
@ModelAttribute("product")
```

hace que Spring MVC construya un objeto `Product` a partir de los campos enviados por el formulario.

Si el formulario envía:

```text
name=Monitor
category=Informática
price=149.99
stock=8
```

Spring hace algo parecido a:

```java
Product product = new Product();
product.setName("Monitor");
product.setCategory("Informática");
product.setPrice(149.99);
product.setStock(8);
```

Después guardamos el producto y redirigimos:

```java
return "redirect:/products";
```

</details>

---

# Ejercicio 9 — Añadir validación con `@Valid` y `BindingResult`

## Enunciado

Modifica el método `createProduct` para que:

1. Valide el producto con `@Valid`.
2. Reciba un `BindingResult`.
3. Si hay errores, vuelva a mostrar la vista `products/form`.
4. Si no hay errores, guarde el producto y redirija a `/products`.

Recuerda que si hay errores debes volver a añadir `pageTitle` al modelo.

---

<details>
<summary>mostrar solución</summary>

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

### Imports necesarios

```java
import jakarta.validation.Valid;
import org.springframework.validation.BindingResult;
```

### Explicación

La anotación:

```java
@Valid
```

activa las validaciones definidas en `Product`.

Por ejemplo:

```java
@NotBlank(message = "El nombre es obligatorio.")
private String name;
```

Si el usuario deja el nombre vacío, Spring añade un error a `BindingResult`.

Por eso comprobamos:

```java
if (bindingResult.hasErrors()) {
```

Si hay errores, no guardamos el producto. Volvemos al formulario:

```java
return "products/form";
```

Si no hay errores, guardamos y redirigimos:

```java
productService.save(product);
return "redirect:/products";
```

`BindingResult` debe ir justo después del objeto validado:

```java
@Valid @ModelAttribute("product") Product product,
BindingResult bindingResult,
```

</details>

---

# Ejercicio 10 — Añadir mensaje de éxito con `RedirectAttributes`

## Enunciado

Modifica el método `createProduct` para que, cuando el producto se guarde correctamente, añada un mensaje temporal llamado `successMessage`.

El mensaje debe ser:

```text
El producto se ha creado correctamente.
```

Después, modifica `list.jsp` para mostrar ese mensaje si existe.

---

<details>
<summary>mostrar solución</summary>

## Controlador

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

### Import necesario

```java
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
```

## Vista `list.jsp`

Añade este bloque antes de la tabla:

```jsp
<c:if test="${not empty successMessage}">
    <div class="success">
        ${successMessage}
    </div>
</c:if>
```

La vista quedaría así en la parte principal:

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

### Explicación

`RedirectAttributes` permite enviar datos temporales después de una redirección.

Esto es útil porque después de guardar hacemos:

```java
return "redirect:/products";
```

El atributo flash:

```java
redirectAttributes.addFlashAttribute("successMessage", "...");
```

estará disponible en la siguiente petición, pero no se quedará permanentemente en sesión.

</details>

---

# Ejercicio 11 — Crear una vista de detalle de producto

## Enunciado

Añade una ruta:

```text
GET /products/detail?id=1
```

El método debe:

1. Recibir el parámetro `id` con `@RequestParam`.
2. Buscar el producto.
3. Si no existe, devolver la vista `products/not-found`.
4. Si existe, añadir `product` y `pageTitle` al modelo.
5. Devolver la vista `products/detail`.

Después crea la vista `detail.jsp`.

---

<details>
<summary>mostrar solución</summary>

## Método en `ProductController`

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

### Import necesario

```java
import org.springframework.web.bind.annotation.RequestParam;
```

## Vista `detail.jsp`

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

## Vista `not-found.jsp`

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

### Explicación

`@RequestParam` permite leer un parámetro concreto de la URL.

Si la URL es:

```text
/products/detail?id=2
```

Spring asigna:

```java
id = 2L;
```

Después buscamos el producto con:

```java
productService.findById(id)
```

Si no existe, mostramos una página específica.

</details>

---

# Ejercicio 12 — Añadir validación a un campo desplegable

## Enunciado

En `Product`, el campo `category` tiene esta validación:

```java
@NotBlank(message = "La categoría es obligatoria.")
private String category;
```

Explica por qué en el formulario es importante que la primera opción tenga valor vacío:

```jsp
<form:option value="" label="Selecciona una categoría" />
```

Después modifica el desplegable para que tenga estas categorías:

```text
Informática
Libros
Ropa
Alimentación
```

---

<details>
<summary>mostrar solución</summary>

## Explicación

La primera opción debe tener valor vacío:

```jsp
<form:option value="" label="Selecciona una categoría" />
```

porque así podemos detectar que el usuario no ha seleccionado ninguna categoría real.

Si la primera opción tuviera un valor válido, como:

```jsp
<form:option value="Informática" label="Informática" />
```

entonces el formulario se enviaría con una categoría válida aunque el usuario no hubiera elegido nada.

Como tenemos:

```java
@NotBlank(message = "La categoría es obligatoria.")
```

necesitamos que la opción inicial envíe un valor vacío para que la validación pueda activarse.

## Código actualizado

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

# Ejercicio 13 — Diagnosticar errores frecuentes en formularios

## Enunciado

Lee cada caso y explica cuál es el problema.

## Caso A

En el controlador se añade el objeto así:

```java
model.addAttribute("product", new Product());
```

Pero en la JSP se escribe:

```jsp
<form:form modelAttribute="item">
```

¿Qué ocurre?

---

## Caso B

En el método POST se escribe:

```java
public String createProduct(
        @Valid @ModelAttribute("product") Product product,
        Model model,
        BindingResult bindingResult) {
```

¿Por qué está mal?

---

## Caso C

En la clase `Product` existe el atributo:

```java
private String name;
```

Pero en la JSP se escribe:

```jsp
<form:input path="productName" />
```

¿Qué ocurre?

---

<details>
<summary>mostrar solución</summary>

## Caso A

El nombre del atributo no coincide.

El controlador envía:

```java
model.addAttribute("product", new Product());
```

pero la JSP busca:

```jsp
modelAttribute="item"
```

Spring no encontrará un objeto llamado `item` en el modelo.

La solución es usar el mismo nombre:

```jsp
<form:form modelAttribute="product">
```

---

## Caso B

El problema es el orden de los parámetros.

`BindingResult` debe ir justo después del objeto validado.

Incorrecto:

```java
@Valid @ModelAttribute("product") Product product,
Model model,
BindingResult bindingResult
```

Correcto:

```java
@Valid @ModelAttribute("product") Product product,
BindingResult bindingResult,
Model model
```

Si `BindingResult` no está colocado justo después del objeto validado, Spring no asociará correctamente los errores de validación.

---

## Caso C

El campo de la JSP no coincide con ninguna propiedad del modelo.

La clase tiene:

```java
private String name;
```

Por tanto, el formulario debe usar:

```jsp
<form:input path="name" />
```

Si escribimos:

```jsp
<form:input path="productName" />
```

Spring intentará buscar una propiedad llamada `productName`, pero no existe.

</details>

---

# Ejercicio 14 — Reto final: formulario completo para registrar clientes

## Enunciado

Crea una nueva sección para registrar clientes.

Debes crear:

1. Una clase `Customer`.
2. Una clase `CustomerService`.
3. Una clase `CustomerController`.
4. Una vista `customers/list.jsp`.
5. Una vista `customers/form.jsp`.

El modelo `Customer` debe tener:

| Campo            | Tipo     | Validación                           |
| ---------------- | -------- | ------------------------------------ |
| `id`             | `Long`   | Sin validación                       |
| `fullName`       | `String` | Obligatorio, entre 3 y 80 caracteres |
| `email`          | `String` | Obligatorio y formato email          |
| `membershipType` | `String` | Obligatorio                          |

Las rutas deben ser:

```text
GET  /customers      → listado de clientes
GET  /customers/new  → formulario
POST /customers      → guardar cliente
```

El formulario debe tener un desplegable para `membershipType` con:

```text
Basic
Premium
VIP
```

---

<details>
<summary>mostrar solución</summary>

## Modelo `Customer.java`

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

## Servicio `CustomerService.java`

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

## Controlador `CustomerController.java`

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

## Vista `customers/list.jsp`

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

## Vista `customers/form.jsp`

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
