# Ejercicios resueltos — Tema 8: Legibilidad

## Introducción

En estos ejercicios vas a practicar las mejoras del **Tema 8**, donde aprendimos a hacer que el CRUD sea más legible usando métodos HTTP más expresivos y rutas más limpias.

En lugar de trabajar con cursos, usaremos una pequeña aplicación de gestión de **productos**. Así practicarás la misma idea, pero con un ejemplo diferente.

Vas a trabajar con:

- Rutas limpias usando `@PathVariable`.
- Diferencia entre `@RequestParam` y `@PathVariable`.
- Uso de `@PutMapping` para actualizar.
- Uso de `@DeleteMapping` para borrar.
- Configuración de `HiddenHttpMethodFilter`.
- Formularios HTML que envían `POST` con `_method=put` o `_method=delete`.
- Reutilización de formularios para crear y editar.
- Métodos privados para preparar formularios.
- Constantes para vistas y redirecciones.
- Diagnóstico de errores frecuentes.

Cada solución está oculta bajo el botón **mostrar solución**.

---

# Ejercicio 1 — Relacionar método HTTP y operación CRUD

## Enunciado

Completa la tabla indicando qué método HTTP usarías para cada operación de una aplicación de productos.

| Operación                        | Método HTTP recomendado |
| -------------------------------- | ----------------------- |
| Ver todos los productos          | ?                       |
| Ver el detalle de un producto    | ?                       |
| Mostrar formulario de creación   | ?                       |
| Crear un producto nuevo          | ?                       |
| Mostrar formulario de edición    | ?                       |
| Actualizar un producto existente | ?                       |
| Borrar un producto existente     | ?                       |

---

<details>
<summary>mostrar solución</summary>

| Operación                        | Método HTTP recomendado |
| -------------------------------- | ----------------------- |
| Ver todos los productos          | `GET`                   |
| Ver el detalle de un producto    | `GET`                   |
| Mostrar formulario de creación   | `GET`                   |
| Crear un producto nuevo          | `POST`                  |
| Mostrar formulario de edición    | `GET`                   |
| Actualizar un producto existente | `PUT`                   |
| Borrar un producto existente     | `DELETE`                |

### Explicación

La idea general es:

```text
GET    → consultar información
POST   → crear un recurso nuevo
PUT    → actualizar un recurso existente
DELETE → borrar un recurso existente
```

En una aplicación Spring MVC con JSP seguimos usando formularios tradicionales, pero podemos hacer que Spring interprete algunos formularios como `PUT` o `DELETE` usando `HiddenHttpMethodFilter`.

</details>

---

# Ejercicio 2 — Transformar rutas antiguas en rutas limpias

## Enunciado

Transforma estas rutas antiguas en rutas más limpias usando el estilo del Tema 8.

| Ruta antigua                | Ruta nueva |
| --------------------------- | ---------- |
| `GET /products/detail?id=4` | ?          |
| `GET /products/edit?id=4`   | ?          |
| `POST /products/update`     | ?          |
| `POST /products/delete`     | ?          |

---

<details>
<summary>mostrar solución</summary>

| Ruta antigua                | Ruta nueva             |
| --------------------------- | ---------------------- |
| `GET /products/detail?id=4` | `GET /products/4`      |
| `GET /products/edit?id=4`   | `GET /products/4/edit` |
| `POST /products/update`     | `PUT /products/4`      |
| `POST /products/delete`     | `DELETE /products/4`   |

### Explicación

Antes el identificador viajaba como parámetro:

```text
/products/detail?id=4
```

Ahora forma parte de la ruta:

```text
/products/4
```

Esto permite que el controlador use:

```java
@PathVariable Long id
```

en lugar de:

```java
@RequestParam("id") Long id
```

</details>

---

# Ejercicio 3 — Diferenciar `@RequestParam` y `@PathVariable`

## Enunciado

Indica qué anotación usarías para recoger el `id` en cada caso.

## Caso A

```text
/products/detail?id=7
```

## Caso B

```text
/products/7
```

Después escribe un ejemplo de método controlador para cada caso.

---

<details>
<summary>mostrar solución</summary>

## Caso A

La URL es:

```text
/products/detail?id=7
```

Aquí el `id` está en la query string, así que usamos:

```java
@RequestParam("id")
```

Ejemplo:

```java
@GetMapping("/detail")
public String productDetail(
        @RequestParam("id") Long id,
        Model model) {

    return "products/detail";
}
```

## Caso B

La URL es:

```text
/products/7
```

Aquí el `id` forma parte de la ruta, así que usamos:

```java
@PathVariable
```

Ejemplo:

```java
@GetMapping("/{id}")
public String productDetail(
        @PathVariable Long id,
        Model model) {

    return "products/detail";
}
```

### Explicación

`@RequestParam` lee valores que vienen después de `?`.

`@PathVariable` lee valores que forman parte de la ruta.

</details>

---

# Ejercicio 4 — Activar `HiddenHttpMethodFilter` en `web.xml`

## Enunciado

Queremos que los formularios HTML puedan enviar acciones que Spring interprete como `PUT` o `DELETE`.

Añade en `web.xml` la configuración necesaria para activar `HiddenHttpMethodFilter`.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

Los formularios HTML tradicionales solo envían:

```text
GET
POST
```

Para simular `PUT` o `DELETE`, enviamos un formulario `POST` con un campo oculto:

```html
<input type="hidden" name="_method" value="put" />
```

o:

```html
<input type="hidden" name="_method" value="delete" />
```

`HiddenHttpMethodFilter` lee ese campo y hace que Spring trate la petición como `PUT` o `DELETE`.

</details>

---

# Ejercicio 5 — Crear una ruta de detalle con `@PathVariable`

## Enunciado

Tienes este método antiguo en `ProductController`:

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

Modifícalo para que responda a:

```text
GET /products/{id}
```

Por ejemplo:

```text
GET /products/3
```

---

<details>
<summary>mostrar solución</summary>

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

### Import necesario

```java
import org.springframework.web.bind.annotation.PathVariable;
```

### Explicación

La anotación:

```java
@GetMapping("/{id}")
```

indica que la ruta contiene una variable.

Si el usuario entra en:

```text
/products/3
```

Spring asigna:

```java
id = 3L;
```

</details>

---

# Ejercicio 6 — Crear una ruta de edición con `@PathVariable`

## Enunciado

Crea un método que muestre el formulario de edición de un producto.

Debe responder a:

```text
GET /products/{id}/edit
```

Debe:

1. Recibir el `id` con `@PathVariable`.
2. Buscar el producto con `productService.findByIdOrThrow(id)`.
3. Añadir al modelo:
   - `pageTitleCode` con `products.edit.title`.
   - `formAction` con `/products/ID_DEL_PRODUCTO`.
   - `formMethod` con `put`.
   - `submitCode` con `products.update`.
   - `product` con el producto encontrado.
4. Devolver `products/form`.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La ruta:

```java
@GetMapping("/{id}/edit")
```

permite URLs como:

```text
/products/5/edit
```

El formulario se enviará después a:

```text
/products/5
```

pero con:

```text
_method=put
```

para que Spring ejecute el método `@PutMapping`.

</details>

---

# Ejercicio 7 — Actualizar usando `@PutMapping`

## Enunciado

Crea un método para actualizar un producto.

Debe responder a:

```text
PUT /products/{id}
```

Debe:

1. Recibir el `id` con `@PathVariable`.
2. Recibir el producto con `@Valid @ModelAttribute("product")`.
3. Recibir `BindingResult`.
4. Asignar el `id` de la ruta al producto con `product.setId(id)`.
5. Si hay errores, volver a `products/form`.
6. Si no hay errores, llamar a `productService.update(product)`.
7. Añadir mensaje flash `success.product.updated`.
8. Redirigir a `/products`.

---

<details>
<summary>mostrar solución</summary>

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

### Imports necesarios

```java
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;
```

### Explicación

La ruta contiene el `id`:

```text
/products/5
```

Por eso recibimos:

```java
@PathVariable Long id
```

Después hacemos:

```java
product.setId(id);
```

Así nos aseguramos de que el objeto que llega al servicio tiene el identificador correcto.

</details>

---

# Ejercicio 8 — Borrar usando `@DeleteMapping`

## Enunciado

Crea un método para borrar un producto.

Debe responder a:

```text
DELETE /products/{id}
```

Debe:

1. Recibir el `id` con `@PathVariable`.
2. Llamar a `productService.deleteById(id)`.
3. Añadir mensaje flash `success.product.deleted`.
4. Redirigir a `/products`.

---

<details>
<summary>mostrar solución</summary>

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

### Import necesario

```java
import org.springframework.web.bind.annotation.DeleteMapping;
```

### Explicación

La ruta:

```text
DELETE /products/5
```

expresa claramente que queremos borrar el producto con id `5`.

El controlador ya no necesita recibir el id con:

```java
@RequestParam("id")
```

porque el id forma parte de la ruta.

</details>

---

# Ejercicio 9 — Crear métodos privados para preparar formularios

## Enunciado

En `ProductController`, crea dos métodos privados:

```java
prepareCreateForm(...)
prepareEditForm(...)
```

`prepareCreateForm` debe preparar el formulario para crear un producto.

`prepareEditForm` debe preparar el formulario para editar un producto.

Usa estos atributos:

| Atributo        | Crear                   | Editar                |
| --------------- | ----------------------- | --------------------- |
| `pageTitleCode` | `products.create.title` | `products.edit.title` |
| `formAction`    | `/products`             | `/products/{id}`      |
| `formMethod`    | `post`                  | `put`                 |
| `submitCode`    | `products.create`       | `products.update`     |
| `product`       | producto recibido       | producto recibido     |

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

Estos métodos evitan repetir muchas veces:

```java
model.addAttribute(...)
```

En creación usamos:

```text
POST /products
```

En edición usamos:

```text
PUT /products/{id}
```

La vista `products/form.jsp` podrá funcionar en ambos casos.

</details>

---

# Ejercicio 10 — Usar los métodos privados en creación

## Enunciado

Modifica estos dos métodos para usar `prepareCreateForm`.

Método que muestra el formulario:

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

Método que procesa el formulario:

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
<summary>mostrar solución</summary>

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

### Explicación

Con `prepareCreateForm` evitamos repetir los mismos atributos.

Si hay errores, enviamos de nuevo el mismo producto recibido:

```java
prepareCreateForm(model, product);
```

Así el formulario conserva los datos que el usuario había escrito.

</details>

---

# Ejercicio 11 — Añadir constantes para vistas y redirecciones

## Enunciado

En `ProductController`, añade constantes para evitar repetir estas cadenas:

```java
"redirect:/products"
"products/form"
```

Después úsalas en los métodos del controlador.

---

<details>
<summary>mostrar solución</summary>

Al principio de la clase añadimos:

```java
private static final String REDIRECT_PRODUCTS = "redirect:/products";
private static final String PRODUCT_FORM_VIEW = "products/form";
```

Ejemplo de uso:

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

### Explicación

Esto no cambia el funcionamiento de la aplicación.

Pero evita repetir cadenas de texto y reduce errores de escritura.

</details>

---

# Ejercicio 12 — Crear un formulario que envíe `PUT`

## Enunciado

Modifica este formulario para que, cuando `formMethod` sea `put`, añada un campo oculto `_method` con valor `put`.

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
<summary>mostrar solución</summary>

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

### Explicación

El formulario sigue usando:

```jsp
method="post"
```

Pero cuando estamos editando, añadimos:

```html
<input type="hidden" name="_method" value="put" />
```

`HiddenHttpMethodFilter` detecta ese campo y Spring ejecuta el método con:

```java
@PutMapping
```

</details>

---

# Ejercicio 13 — Crear un formulario de borrado que envíe `DELETE`

## Enunciado

En `products/list.jsp`, crea un formulario para borrar un producto usando:

```text
DELETE /products/{id}
```

Recuerda que el formulario HTML debe usar `method="post"` y un campo oculto `_method`.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

El navegador envía realmente:

```text
POST /products/3
```

pero el formulario incluye:

```text
_method=delete
```

Entonces `HiddenHttpMethodFilter` hace que Spring lo interprete como:

```text
DELETE /products/3
```

y se ejecuta:

```java
@DeleteMapping("/{id}")
```

</details>

---

# Ejercicio 14 — Actualizar enlaces del listado

## Enunciado

Tienes estos enlaces antiguos en `products/list.jsp`:

```jsp
<a href="${pageContext.request.contextPath}/products/detail?id=${product.id}">
    Ver detalle
</a>

<a href="${pageContext.request.contextPath}/products/edit?id=${product.id}">
    Editar
</a>
```

Actualízalos para usar rutas limpias.

---

<details>
<summary>mostrar solución</summary>

```jsp
<a href="${pageContext.request.contextPath}/products/${product.id}">
    Ver detalle
</a>

<a href="${pageContext.request.contextPath}/products/${product.id}/edit">
    Editar
</a>
```

### Explicación

Antes usábamos query string:

```text
/products/detail?id=3
```

Ahora usamos rutas con `PathVariable`:

```text
/products/3
/products/3/edit
```

Esto hace que las rutas sean más limpias y expresivas.

</details>

---

# Ejercicio 15 — Crear una tabla de acciones completa en `list.jsp`

## Enunciado

Crea la celda de acciones para una tabla de productos.

Debe incluir:

1. Enlace a detalle con `/products/{id}`.
2. Enlace a edición con `/products/{id}/edit`.
3. Formulario de borrado con `DELETE /products/{id}`.

Usa mensajes internacionalizados.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La celda combina tres acciones:

```text
GET    /products/{id}
GET    /products/{id}/edit
DELETE /products/{id}
```

El borrado necesita un formulario porque modifica datos.

</details>

---

# Ejercicio 16 — Crear `ProductController` completo con rutas limpias

## Enunciado

Crea un `ProductController` completo usando:

```java
@GetMapping
@GetMapping("/{id}")
@GetMapping("/new")
@PostMapping
@GetMapping("/{id}/edit")
@PutMapping("/{id}")
@DeleteMapping("/{id}")
```

El controlador debe usar:

- `ProductService`
- `MessageSource`
- métodos privados `prepareCreateForm`, `prepareEditForm`
- método privado `addFlashMessage`
- constantes para vista de formulario y redirección

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

Este controlador expresa el CRUD de forma más clara:

```text
POST   /products      → crear
PUT    /products/{id} → actualizar
DELETE /products/{id} → borrar
```

Además, usa rutas limpias para detalle y edición.

</details>

---

# Ejercicio 17 — Actualizar `products/form.jsp` completo

## Enunciado

Crea un formulario JSP reutilizable para crear y editar productos.

Debe:

1. Enviar siempre `method="post"`.
2. Usar `${formAction}` como acción.
3. Añadir `_method=put` solo si `formMethod == 'put'`.
4. Tener campo oculto `id`.
5. Tener campos para:
   - `name`
   - `category`
   - `price`
   - `stock`
6. Usar `${submitCode}` para el texto del botón.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

Aunque estemos editando, el formulario usa:

```jsp
method="post"
```

La diferencia está en:

```jsp
<input type="hidden" name="_method" value="put">
```

Ese campo solo aparece cuando el formulario está en modo edición.

</details>

---

# Ejercicio 18 — Actualizar `products/list.jsp` completo

## Enunciado

Crea una vista `products/list.jsp` que use las nuevas rutas limpias.

Debe incluir:

1. Listado de productos.
2. Enlace a detalle: `/products/{id}`.
3. Enlace a editar: `/products/{id}/edit`.
4. Formulario para borrar con `_method=delete`.
5. Mensaje de éxito si existe `successMessage`.

---

<details>
<summary>mostrar solución</summary>

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

### Explicación

La vista ya no usa rutas como:

```text
/products/detail?id=1
/products/edit?id=1
/products/delete
```

Ahora usa rutas más limpias:

```text
/products/1
/products/1/edit
DELETE /products/1
```

</details>

---

# Ejercicio 19 — Diagnosticar errores con `HiddenHttpMethodFilter`

## Enunciado

Lee los siguientes casos y explica qué ocurre.

## Caso A

El formulario de edición contiene:

```html
<input type="hidden" name="_method" value="put" />
```

pero en `web.xml` no se ha configurado `HiddenHttpMethodFilter`.

¿Qué ocurre?

---

## Caso B

En `web.xml` sí está configurado `HiddenHttpMethodFilter`, pero el formulario no contiene el campo `_method`.

¿Qué ocurre?

---

## Caso C

El formulario tiene:

```html
<input type="hidden" name="method" value="put" />
```

en lugar de:

```html
<input type="hidden" name="_method" value="put" />
```

¿Qué ocurre?

---

<details>
<summary>mostrar solución</summary>

## Caso A

El formulario llegará como `POST`.

Spring no lo transformará en `PUT`.

Por tanto, el método:

```java
@PutMapping("/{id}")
```

no se ejecutará.

---

## Caso B

Aunque el filtro esté configurado, no tiene ningún campo `_method` que leer.

La petición seguirá siendo `POST`.

---

## Caso C

El nombre del campo está mal.

`HiddenHttpMethodFilter` espera un campo llamado:

```text
_method
```

No:

```text
method
```

La solución es:

```html
<input type="hidden" name="_method" value="put" />
```

</details>

---

# Ejercicio 20 — Diagnosticar errores con rutas limpias

## Enunciado

Lee los siguientes casos y explica qué ocurre.

## Caso A

El controlador tiene:

```java
@GetMapping("/{id}")
```

pero la JSP enlaza a:

```text
/products/detail?id=1
```

¿Qué ocurre?

---

## Caso B

El controlador tiene:

```java
@GetMapping("/{id}")
public String detail(@RequestParam("id") Long id) {
    ...
}
```

¿Qué está mal?

---

## Caso C

El método de edición usa:

```java
@PutMapping("/{id}")
```

pero el formulario envía a:

```text
/products/update
```

¿Qué ocurre?

---

<details>
<summary>mostrar solución</summary>

## Caso A

La JSP sigue usando la ruta antigua.

El controlador espera una ruta como:

```text
/products/1
```

pero la JSP genera:

```text
/products/detail?id=1
```

Hay que actualizar el enlace:

```jsp
/products/${product.id}
```

---

## Caso B

La anotación no corresponde con la ruta.

Si la ruta es:

```java
@GetMapping("/{id}")
```

el id debe recibirse con:

```java
@PathVariable Long id
```

No con:

```java
@RequestParam("id")
```

---

## Caso C

El formulario no está apuntando a la ruta correcta.

Si el controlador espera:

```text
PUT /products/{id}
```

el formulario debe enviar a:

```text
/products/ID
```

con:

```html
<input type="hidden" name="_method" value="put" />
```

No debe enviar a:

```text
/products/update
```

</details>

---

# Ejercicio 21 — Reto final: mejorar el CRUD de empleados

## Enunciado

Tienes una aplicación Spring MVC de empleados. Actualmente usa rutas antiguas:

```text
GET  /employees/detail?id=1
GET  /employees/edit?id=1
POST /employees/update
POST /employees/delete
```

Transforma el controlador y las vistas para usar:

```text
GET    /employees/{id}
GET    /employees/{id}/edit
PUT    /employees/{id}
DELETE /employees/{id}
```

Crea:

1. Configuración de `HiddenHttpMethodFilter`.
2. Métodos principales de `EmployeeController`.
3. Fragmento de formulario de edición con `_method=put`.
4. Fragmento de listado con enlace a detalle, enlace a edición y formulario de borrado.

---

<details>
<summary>mostrar solución</summary>

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

## 2. Métodos principales de `EmployeeController`

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

## 3. Fragmento de formulario con `_method=put`

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

## 4. Fragmento de listado con acciones

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

### Explicación

Este reto aplica todo lo aprendido:

```text
@PathVariable para ids en la ruta.
@PutMapping para actualizar.
@DeleteMapping para borrar.
HiddenHttpMethodFilter para interpretar _method.
Formularios POST con _method=put o _method=delete.
```

El resultado es un CRUD más legible y más expresivo.

</details>
