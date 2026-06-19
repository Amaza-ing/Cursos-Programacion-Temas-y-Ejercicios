# Tema 3 — Procesamiento de formularios en Spring MVC

## 1. Objetivo del tema

En este tema aprenderemos a trabajar con formularios en una aplicación Spring MVC.

Hasta ahora, la aplicación permite navegar entre páginas, mostrar un listado de cursos y ver el detalle de un curso concreto. En este tema añadiremos una funcionalidad nueva: **crear cursos desde un formulario web**.

El objetivo es entender este flujo completo:

```text
1. El usuario entra en una página con un formulario.
2. Spring MVC prepara un objeto vacío para ese formulario.
3. La vista JSP muestra los campos.
4. El usuario rellena el formulario.
5. El navegador envía los datos mediante POST.
6. Spring MVC convierte esos datos en un objeto Java.
7. Spring valida el objeto.
8. Si hay errores, vuelve al formulario y los muestra.
9. Si todo es correcto, guarda los datos.
10. Redirige al listado de cursos.
```

Durante este tema trabajaremos con estos conceptos:

- `@ModelAttribute`
- `@Valid`
- `BindingResult`
- etiquetas de formulario de Spring
- validación de campos
- mensajes de error
- redirecciones
- patrón Post-Redirect-Get
- mensajes temporales con `RedirectAttributes`

En este tema **no usaremos todavía MySQL**. Guardaremos los cursos temporalmente en memoria para centrarnos en el procesamiento de formularios. Más adelante podríamos sustituir esta lista por una base de datos.

---

## 2. Punto de partida

Partimos del proyecto creado en los temas anteriores.

La aplicación ya tiene estas rutas:

```text
/                     → Página de inicio
/home                 → Página de inicio
/about                → Página sobre el curso
/courses              → Listado de cursos
/courses/detail?id=1  → Detalle de un curso
```

En este tema añadiremos estas rutas nuevas:

```text
/courses/new          → Muestra el formulario para crear un curso
/courses              → Procesa el formulario mediante POST
```

Es importante observar que `/courses` se usará de dos formas diferentes:

```text
GET  /courses    → muestra el listado de cursos
POST /courses    → procesa el formulario de creación
```

Esto es muy habitual en aplicaciones web.

El método `GET` suele usarse para **mostrar páginas**.

El método `POST` suele usarse para **enviar datos al servidor**.

---

## 3. Estructura final del proyecto

Al terminar este tema, el proyecto tendrá esta estructura:

```text
spring-mvc-day1
│
├── pom.xml
│
└── src
    └── main
        ├── java
        │   └── com
        │       └── example
        │           └── springmvcday1
        │               ├── controller
        │               │   ├── HomeController.java
        │               │   └── CourseController.java
        │               │
        │               ├── model
        │               │   └── Course.java
        │               │
        │               └── service
        │                   └── CourseService.java
        │
        └── webapp
            ├── resources
            │   └── css
            │       └── styles.css
            │
            └── WEB-INF
                ├── web.xml
                ├── spring
                │   └── app-servlet.xml
                │
                └── views
                    ├── home.jsp
                    ├── about.jsp
                    │
                    └── courses
                        ├── list.jsp
                        ├── detail.jsp
                        ├── form.jsp
                        └── not-found.jsp
```

El archivo nuevo más importante será:

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

Ese archivo contendrá el formulario para crear un curso.

---

[![Formularios](https://img.youtube.com/vi/fjZBNBwiu8c/0.jpg)](https://www.youtube.com/watch?v=fjZBNBwiu8c&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

## 4. Añadir la dependencia de validación

Para validar formularios en Java usaremos **Jakarta Bean Validation**.

Esta tecnología permite declarar reglas directamente en la clase Java.

Por ejemplo:

```java
@NotBlank(message = "El título es obligatorio.")
private String title;
```

Con esa anotación indicamos que el campo `title` no puede estar vacío.

Para que estas anotaciones funcionen, necesitamos añadir Hibernate Validator al `pom.xml`.

### Código que debemos añadir en `pom.xml`

Dentro de la etiqueta `<dependencies>`, añadimos esta dependencia:

```xml
<!-- Implementación de Jakarta Bean Validation -->
<dependency>
    <groupId>org.hibernate.validator</groupId>
    <artifactId>hibernate-validator</artifactId>
    <version>8.0.3.Final</version>
</dependency>
```

### Bloque completo de dependencias

El bloque completo de dependencias del proyecto quedaría así:

```xml
<dependencies>

    <!-- Spring MVC -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-webmvc</artifactId>
        <version>${spring.version}</version>
    </dependency>

    <!-- Servlet API: la proporciona Tomcat en tiempo de ejecución -->
    <dependency>
        <groupId>jakarta.servlet</groupId>
        <artifactId>jakarta.servlet-api</artifactId>
        <version>6.0.0</version>
        <scope>provided</scope>
    </dependency>

    <!-- JSTL API para usar etiquetas como c:forEach en JSP -->
    <dependency>
        <groupId>jakarta.servlet.jsp.jstl</groupId>
        <artifactId>jakarta.servlet.jsp.jstl-api</artifactId>
        <version>3.0.2</version>
    </dependency>

    <!-- Implementación de JSTL -->
    <dependency>
        <groupId>org.glassfish.web</groupId>
        <artifactId>jakarta.servlet.jsp.jstl</artifactId>
        <version>3.0.1</version>
    </dependency>

    <!-- Implementación de Jakarta Bean Validation -->
    <dependency>
        <groupId>org.hibernate.validator</groupId>
        <artifactId>hibernate-validator</artifactId>
        <version>8.0.3.Final</version>
    </dependency>

</dependencies>
```

### Explicación

La dependencia nueva es esta:

```xml
<dependency>
    <groupId>org.hibernate.validator</groupId>
    <artifactId>hibernate-validator</artifactId>
    <version>8.0.3.Final</version>
</dependency>
```

Gracias a ella podremos usar anotaciones como:

```java
@NotBlank
@Size
@NotNull
@Min
@Max
```

Estas anotaciones se colocan en la clase del modelo, no en el controlador ni en la vista.

La idea es que las reglas de validación formen parte del propio objeto que queremos validar.

---

## 5. Actualizar la clase `Course`

En el tema anterior nuestra clase `Course` era muy sencilla. Tenía atributos, constructor y getters.

Ahora necesitamos que Spring MVC pueda crear un objeto `Course` a partir de los datos enviados por un formulario.

Para eso, la clase debe tener:

1. Un constructor vacío.
2. Getters.
3. Setters.
4. Anotaciones de validación.

El archivo que vamos a modificar es:

```text
src/main/java/com/example/springmvcday1/model/Course.java
```

### Código completo de `Course.java`

```java
package com.example.springmvcday1.model;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public class Course {

    private Long id;

    @NotBlank(message = "El título es obligatorio.")
    @Size(min = 3, max = 80, message = "El título debe tener entre 3 y 80 caracteres.")
    private String title;

    @NotBlank(message = "El nivel es obligatorio.")
    private String level;

    @NotNull(message = "La duración es obligatoria.")
    @Min(value = 1, message = "La duración mínima es de 1 hora.")
    @Max(value = 200, message = "La duración máxima es de 200 horas.")
    private Integer durationInHours;

    public Course() {
    }

    public Course(Long id, String title, String level, Integer durationInHours) {
        this.id = id;
        this.title = title;
        this.level = level;
        this.durationInHours = durationInHours;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public Integer getDurationInHours() {
        return durationInHours;
    }

    public void setDurationInHours(Integer durationInHours) {
        this.durationInHours = durationInHours;
    }
}
```

---

[![Validación](https://img.youtube.com/vi/JEYTTwuVz38/0.jpg)](https://www.youtube.com/watch?v=JEYTTwuVz38&list=PLzA2VyZwsq_-_2eSWslazLtvKEolZduFi)

---

## 6. Explicación de la clase `Course`

### 6.1. Importaciones de validación

Al principio importamos estas clases:

```java
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
```

Cada una sirve para una regla de validación diferente.

| Anotación   | Función                                                           |
| ----------- | ----------------------------------------------------------------- |
| `@NotBlank` | Comprueba que un texto no esté vacío ni formado solo por espacios |
| `@Size`     | Comprueba la longitud de un texto                                 |
| `@NotNull`  | Comprueba que el valor no sea `null`                              |
| `@Min`      | Comprueba que un número tenga un valor mínimo                     |
| `@Max`      | Comprueba que un número no supere un valor máximo                 |

---

### 6.2. Validación del título

El atributo `title` queda así:

```java
@NotBlank(message = "El título es obligatorio.")
@Size(min = 3, max = 80, message = "El título debe tener entre 3 y 80 caracteres.")
private String title;
```

Esto significa que el título debe cumplir dos condiciones:

```text
1. No puede estar vacío.
2. Debe tener entre 3 y 80 caracteres.
```

Si el usuario deja el campo vacío, aparecerá este mensaje:

```text
El título es obligatorio.
```

Si escribe un título demasiado corto o demasiado largo, aparecerá este mensaje:

```text
El título debe tener entre 3 y 80 caracteres.
```

---

### 6.3. Validación del nivel

El atributo `level` queda así:

```java
@NotBlank(message = "El nivel es obligatorio.")
private String level;
```

Esto significa que el usuario debe elegir un nivel.

Más adelante, en la vista JSP, crearemos un desplegable con estas opciones:

```text
Inicial
Intermedio
Avanzado
```

---

### 6.4. Validación de la duración

El atributo `durationInHours` queda así:

```java
@NotNull(message = "La duración es obligatoria.")
@Min(value = 1, message = "La duración mínima es de 1 hora.")
@Max(value = 200, message = "La duración máxima es de 200 horas.")
private Integer durationInHours;
```

Esto significa que la duración debe cumplir tres condiciones:

```text
1. No puede estar vacía.
2. Debe ser como mínimo 1.
3. Debe ser como máximo 200.
```

Por ejemplo:

| Valor introducido | Resultado                                 |
| ----------------- | ----------------------------------------- |
| vacío             | Error: la duración es obligatoria         |
| `0`               | Error: la duración mínima es de 1 hora    |
| `201`             | Error: la duración máxima es de 200 horas |
| `20`              | Correcto                                  |

---

### 6.5. Por qué usamos `Integer` y no `int`

En el tema anterior usábamos:

```java
private int durationInHours;
```

Ahora usamos:

```java
private Integer durationInHours;
```

La razón es importante.

`int` es un tipo primitivo y no puede valer `null`.

`Integer` es un objeto y sí puede valer `null`.

Cuando el usuario deja el campo vacío, necesitamos que Spring pueda representar ese campo como `null`. Así se puede activar esta validación:

```java
@NotNull(message = "La duración es obligatoria.")
```

Por eso, en formularios, muchas veces es preferible usar `Integer` en lugar de `int`.

---

### 6.6. Constructor vacío

Añadimos este constructor:

```java
public Course() {
}
```

Este constructor es necesario para que Spring pueda crear un objeto vacío antes de rellenarlo con los datos del formulario.

Cuando el usuario envía el formulario, Spring hace internamente algo parecido a esto:

```java
Course course = new Course();
course.setTitle(valorDelFormulario);
course.setLevel(valorDelFormulario);
course.setDurationInHours(valorDelFormulario);
```

Para poder hacer `new Course()`, la clase necesita un constructor vacío.

---

### 6.7. Setters

También añadimos métodos `set`:

```java
public void setTitle(String title) {
    this.title = title;
}
```

Spring usa estos setters para introducir en el objeto los valores enviados por el formulario.

Por ejemplo, si el formulario envía esto:

```text
title=Spring MVC práctico
```

Spring hará algo equivalente a:

```java
course.setTitle("Spring MVC práctico");
```

---

## 7. Actualizar el servicio `CourseService`

En el tema anterior, la lista de cursos se había creado con `List.of(...)`.

Esa forma sirve para crear una lista fija, pero no permite añadir nuevos cursos.

Ahora necesitamos una lista modificable, porque el formulario creará cursos nuevos.

El archivo que vamos a modificar es:

```text
src/main/java/com/example/springmvcday1/service/CourseService.java
```

### Código completo de `CourseService.java`

```java
package com.example.springmvcday1.service;

import com.example.springmvcday1.model.Course;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CourseService {

    private final List<Course> courses = new ArrayList<>();

    private Long nextId = 4L;

    public CourseService() {
        courses.add(new Course(1L, "Spring MVC desde cero", "Inicial", 20));
        courses.add(new Course(2L, "Spring MVC con formularios", "Intermedio", 15));
        courses.add(new Course(3L, "Spring MVC avanzado", "Avanzado", 25));
    }

    public List<Course> findAll() {
        return courses;
    }

    public Course findById(Long id) {
        return courses.stream()
                .filter(course -> course.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public void save(Course course) {
        course.setId(nextId);
        courses.add(course);
        nextId++;
    }
}
```

---

## 8. Explicación de `CourseService`

### 8.1. Lista modificable

Ahora usamos:

```java
private final List<Course> courses = new ArrayList<>();
```

`ArrayList` permite añadir nuevos elementos.

Esto es necesario porque el método `save()` añadirá cursos a la lista.

---

### 8.2. Identificador del siguiente curso

También añadimos:

```java
private Long nextId = 4L;
```

Los cursos iniciales ya tienen estos identificadores:

```text
1
2
3
```

Por tanto, el siguiente curso que se cree desde el formulario tendrá identificador `4`.

Después, el siguiente tendrá `5`, y así sucesivamente.

---

### 8.3. Carga inicial de cursos

En el constructor añadimos tres cursos iniciales:

```java
public CourseService() {
    courses.add(new Course(1L, "Spring MVC desde cero", "Inicial", 20));
    courses.add(new Course(2L, "Spring MVC con formularios", "Intermedio", 15));
    courses.add(new Course(3L, "Spring MVC avanzado", "Avanzado", 25));
}
```

Esto permite que la aplicación tenga datos desde el primer momento.

---

### 8.4. Método `findAll()`

El método:

```java
public List<Course> findAll() {
    return courses;
}
```

devuelve todos los cursos.

Lo usa el controlador para mostrar el listado.

---

### 8.5. Método `findById()`

El método:

```java
public Course findById(Long id) {
    return courses.stream()
            .filter(course -> course.getId().equals(id))
            .findFirst()
            .orElse(null);
}
```

busca un curso por su identificador.

Si encuentra el curso, lo devuelve.

Si no lo encuentra, devuelve `null`.

---

### 8.6. Método `save()`

El método nuevo es:

```java
public void save(Course course) {
    course.setId(nextId);
    courses.add(course);
    nextId++;
}
```

Este método hace tres cosas:

```text
1. Asigna un identificador al curso nuevo.
2. Añade el curso a la lista.
3. Incrementa el contador para el siguiente curso.
```

Por ejemplo, si llega un curso con estos datos:

```text
Título: Java Web
Nivel: Inicial
Duración: 12
```

el método `save()` le asignará el identificador `4` y lo añadirá a la lista.

Después `nextId` pasará a valer `5`.

---

## 9. Actualizar el controlador `CourseController`

Ahora añadiremos dos métodos nuevos al controlador:

```text
GET  /courses/new
POST /courses
```

El archivo que vamos a modificar es:

```text
src/main/java/com/example/springmvcday1/controller/CourseController.java
```

### Código completo actualizado de `CourseController.java`

```java
package com.example.springmvcday1.controller;

import com.example.springmvcday1.model.Course;
import com.example.springmvcday1.service.CourseService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/courses")
public class CourseController {

    private final CourseService courseService;

    public CourseController(CourseService courseService) {
        this.courseService = courseService;
    }

    @GetMapping
    public String listCourses(Model model) {
        model.addAttribute("pageTitle", "Listado de cursos");
        model.addAttribute("courses", courseService.findAll());

        return "courses/list";
    }

    @GetMapping("/detail")
    public String courseDetail(@RequestParam("id") Long id, Model model) {
        Course course = courseService.findById(id);

        if (course == null) {
            model.addAttribute("pageTitle", "Curso no encontrado");
            model.addAttribute("courseId", id);

            return "courses/not-found";
        }

        model.addAttribute("pageTitle", course.getTitle());
        model.addAttribute("course", course);

        return "courses/detail";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("pageTitle", "Crear nuevo curso");
        model.addAttribute("course", new Course());

        return "courses/form";
    }

    @PostMapping
    public String createCourse(
            @Valid @ModelAttribute("course") Course course,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("pageTitle", "Crear nuevo curso");
            return "courses/form";
        }

        courseService.save(course);

        redirectAttributes.addFlashAttribute(
                "successMessage",
                "El curso se ha creado correctamente."
        );

        return "redirect:/courses";
    }
}
```

---

## 10. Explicación del método que muestra el formulario

El primer método nuevo es:

```java
@GetMapping("/new")
public String showCreateForm(Model model) {
    model.addAttribute("pageTitle", "Crear nuevo curso");
    model.addAttribute("course", new Course());

    return "courses/form";
}
```

Este método responde a la ruta:

```text
GET /courses/new
```

Su responsabilidad es mostrar el formulario vacío.

---

### 10.1. Añadir el título de la página

Primero añadimos:

```java
model.addAttribute("pageTitle", "Crear nuevo curso");
```

Este atributo se usará en la vista JSP para mostrar el título.

En la JSP podremos escribir:

```jsp
${pageTitle}
```

Y se mostrará:

```text
Crear nuevo curso
```

---

### 10.2. Añadir el objeto del formulario

Después añadimos:

```java
model.addAttribute("course", new Course());
```

Esta línea es fundamental.

Estamos creando un objeto vacío:

```java
new Course()
```

Y lo estamos enviando a la vista con el nombre:

```text
course
```

Ese objeto será usado por el formulario.

La relación será esta:

```text
Controlador crea un Course vacío
↓
La vista recibe ese objeto como "course"
↓
El formulario se vincula a ese objeto
↓
Cada campo del formulario se vincula a una propiedad
```

---

### 10.3. Devolver la vista del formulario

Finalmente devolvemos:

```java
return "courses/form";
```

Esto no es el nombre exacto del archivo.

Es el nombre lógico de la vista.

Como en `app-servlet.xml` tenemos configurado el `ViewResolver`, Spring hará esta transformación:

```text
courses/form
```

se convierte en:

```text
/WEB-INF/views/courses/form.jsp
```

---

## 11. Explicación del método que procesa el formulario

El segundo método nuevo es:

```java
@PostMapping
public String createCourse(
        @Valid @ModelAttribute("course") Course course,
        BindingResult bindingResult,
        Model model,
        RedirectAttributes redirectAttributes) {

    if (bindingResult.hasErrors()) {
        model.addAttribute("pageTitle", "Crear nuevo curso");
        return "courses/form";
    }

    courseService.save(course);

    redirectAttributes.addFlashAttribute(
            "successMessage",
            "El curso se ha creado correctamente."
    );

    return "redirect:/courses";
}
```

Este método responde a:

```text
POST /courses
```

Como el controlador tiene esta ruta general:

```java
@RequestMapping("/courses")
```

Y el método tiene:

```java
@PostMapping
```

el resultado es:

```text
POST /courses
```

---

## 12. `@ModelAttribute`

La parte más importante del método es esta:

```java
@ModelAttribute("course") Course course
```

Esto le dice a Spring:

```text
Toma los datos enviados por el formulario y colócalos dentro de un objeto Course.
```

Por ejemplo, si el formulario envía estos datos:

```text
title=Spring MVC práctico
level=Intermedio
durationInHours=12
```

Spring creará o rellenará un objeto similar a este:

```java
Course course = new Course();
course.setTitle("Spring MVC práctico");
course.setLevel("Intermedio");
course.setDurationInHours(12);
```

Así evitamos leer manualmente cada campo.

Sin `@ModelAttribute`, tendríamos que hacer algo mucho más repetitivo:

```java
@PostMapping
public String createCourse(
        @RequestParam("title") String title,
        @RequestParam("level") String level,
        @RequestParam("durationInHours") Integer durationInHours) {

    Course course = new Course();
    course.setTitle(title);
    course.setLevel(level);
    course.setDurationInHours(durationInHours);

    courseService.save(course);

    return "redirect:/courses";
}
```

Con `@ModelAttribute`, Spring hace esa conversión automáticamente.

---

## 13. `@Valid`

Antes de `@ModelAttribute` hemos escrito:

```java
@Valid
```

El parámetro completo queda así:

```java
@Valid @ModelAttribute("course") Course course
```

Esto significa:

```text
Después de rellenar el objeto Course, valida sus anotaciones.
```

Spring revisará reglas como estas:

```java
@NotBlank(message = "El título es obligatorio.")
@Size(min = 3, max = 80, message = "El título debe tener entre 3 y 80 caracteres.")
private String title;
```

Si el título está vacío, se generará un error.

Si el título tiene menos de 3 caracteres, también se generará un error.

Si todo es correcto, no habrá errores de validación.

---

## 14. `BindingResult`

Después del objeto validado aparece:

```java
BindingResult bindingResult
```

Este objeto contiene el resultado de la validación.

Si hay errores, estarán dentro de `bindingResult`.

Por eso usamos:

```java
if (bindingResult.hasErrors()) {
    model.addAttribute("pageTitle", "Crear nuevo curso");
    return "courses/form";
}
```

Esto significa:

```text
Si el formulario tiene errores:
    - no guardes el curso
    - vuelve a mostrar el formulario
    - muestra los mensajes de error
```

### Importante

`BindingResult` debe ir justo después del objeto que se está validando.

Correcto:

```java
public String createCourse(
        @Valid @ModelAttribute("course") Course course,
        BindingResult bindingResult,
        Model model) {
```

Incorrecto:

```java
public String createCourse(
        @Valid @ModelAttribute("course") Course course,
        Model model,
        BindingResult bindingResult) {
```

Si se coloca mal, Spring no asociará correctamente los errores de validación al objeto `course`.

---

## 15. Guardar el curso

Si no hay errores, ejecutamos:

```java
courseService.save(course);
```

El controlador no guarda el curso directamente.

Delega esa tarea en el servicio.

Esto mantiene separadas las responsabilidades:

| Clase              | Responsabilidad                                    |
| ------------------ | -------------------------------------------------- |
| `CourseController` | Recibir peticiones web y decidir qué vista mostrar |
| `CourseService`    | Gestionar los datos de los cursos                  |
| `Course`           | Representar los datos de un curso                  |

---

## 16. Mensaje de éxito con `RedirectAttributes`

Después de guardar el curso, añadimos un mensaje temporal:

```java
redirectAttributes.addFlashAttribute(
        "successMessage",
        "El curso se ha creado correctamente."
);
```

Este mensaje se mostrará en el listado después de la redirección.

La palabra clave aquí es **flash attribute**.

Un atributo flash es un dato temporal que vive solo durante la siguiente petición.

El flujo será:

```text
POST /courses
↓
Se guarda el curso
↓
Se crea successMessage como flash attribute
↓
Se redirige a /courses
↓
El listado muestra successMessage
↓
El mensaje desaparece
```

Esto es útil para mostrar mensajes como:

```text
El curso se ha creado correctamente.
```

---

## 17. Redirección después de guardar

Finalmente devolvemos:

```java
return "redirect:/courses";
```

Esto no busca una JSP llamada `redirect:/courses`.

Cuando Spring ve que la cadena empieza por `redirect:`, entiende que debe enviar una redirección al navegador.

El navegador hará una nueva petición a:

```text
/courses
```

Esto es muy importante después de procesar formularios.

---

## 18. Patrón Post-Redirect-Get

Después de procesar correctamente un formulario, es recomendable no devolver directamente una vista.

Es mejor redirigir.

Este patrón se llama **Post-Redirect-Get**.

La secuencia es:

```text
POST → redirect → GET
```

En nuestro caso:

```text
POST /courses
↓
redirect:/courses
↓
GET /courses
```

Esto evita un problema habitual: que el formulario se envíe dos veces si el usuario refresca la página.

Si después de guardar devolviéramos directamente una vista, al pulsar F5 el navegador podría intentar repetir el POST.

Con una redirección, la última petición es un GET normal, por lo que refrescar la página no vuelve a crear el curso.

---

## 19. Crear la vista `form.jsp`

Ahora vamos a crear la vista del formulario.

Ruta del archivo:

```text
src/main/webapp/WEB-INF/views/courses/form.jsp
```

Para crear formularios en JSP con Spring MVC usamos la librería de etiquetas de formulario de Spring.

Esta librería se activa con esta línea al principio del archivo:

```jsp
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
```

### Código completo de `form.jsp`

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
        <a href="${pageContext.request.contextPath}/courses">Cursos</a>
        <a href="${pageContext.request.contextPath}/about">Sobre el curso</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            Rellena los datos para crear un nuevo curso.
        </p>

        <form:form
                method="post"
                action="${pageContext.request.contextPath}/courses"
                modelAttribute="course"
                cssClass="form">

            <div class="form-group">
                <form:label path="title">Título</form:label>
                <form:input path="title" cssClass="input" />
                <form:errors path="title" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="level">Nivel</form:label>
                <form:select path="level" cssClass="input">
                    <form:option value="" label="Selecciona un nivel" />
                    <form:option value="Inicial" label="Inicial" />
                    <form:option value="Intermedio" label="Intermedio" />
                    <form:option value="Avanzado" label="Avanzado" />
                </form:select>
                <form:errors path="level" cssClass="error" />
            </div>

            <div class="form-group">
                <form:label path="durationInHours">Duración en horas</form:label>
                <form:input path="durationInHours" type="number" cssClass="input" />
                <form:errors path="durationInHours" cssClass="error" />
            </div>

            <div class="form-actions">
                <button type="submit" class="button">
                    Crear curso
                </button>

                <a class="secondary-button" href="${pageContext.request.contextPath}/courses">
                    Cancelar
                </a>
            </div>

        </form:form>
    </section>
</main>

</body>
</html>
```

---

## 20. Explicación de `form.jsp`

### 20.1. Directiva de página

La primera línea es:

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
```

Esto indica que la página usa codificación UTF-8.

Es importante para que se vean correctamente las tildes y la ñ.

---

### 20.2. Librería de formularios de Spring

La segunda línea es:

```jsp
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
```

Gracias a esta línea podemos usar etiquetas como:

```jsp
<form:form>
<form:input>
<form:select>
<form:option>
<form:errors>
```

Estas etiquetas son útiles porque se conectan directamente con el objeto del modelo.

---

### 20.3. La etiqueta `form:form`

El formulario empieza así:

```jsp
<form:form
        method="post"
        action="${pageContext.request.contextPath}/courses"
        modelAttribute="course"
        cssClass="form">
```

Esta etiqueta genera un formulario HTML.

Veamos cada parte.

#### `method="post"`

Indica que los datos se enviarán mediante POST.

```jsp
method="post"
```

Eso significa que el formulario será procesado por este método del controlador:

```java
@PostMapping
public String createCourse(...) {
    ...
}
```

#### `action="${pageContext.request.contextPath}/courses"`

Indica a qué URL se enviarán los datos.

```jsp
action="${pageContext.request.contextPath}/courses"
```

Usamos:

```jsp
${pageContext.request.contextPath}
```

para no escribir manualmente el nombre de la aplicación.

Si la aplicación está desplegada como:

```text
/spring-mvc-day1
```

la acción final será:

```text
/spring-mvc-day1/courses
```

#### `modelAttribute="course"`

Esta es la parte más importante:

```jsp
modelAttribute="course"
```

Indica que el formulario está vinculado al objeto del modelo llamado `course`.

Ese objeto se añadió en el controlador:

```java
model.addAttribute("course", new Course());
```

Por tanto, cada campo del formulario se conectará con una propiedad de ese objeto.

---

### 20.4. Campo `title`

El campo del título es:

```jsp
<div class="form-group">
    <form:label path="title">Título</form:label>
    <form:input path="title" cssClass="input" />
    <form:errors path="title" cssClass="error" />
</div>
```

La parte clave es:

```jsp
path="title"
```

Esto significa que este campo se conecta con la propiedad `title` de la clase `Course`.

En Java, esa propiedad es:

```java
private String title;
```

Cuando el usuario envíe el formulario, Spring hará algo similar a:

```java
course.setTitle(valorIntroducido);
```

La etiqueta:

```jsp
<form:errors path="title" cssClass="error" />
```

mostrará los errores relacionados con el título.

Por ejemplo, si el usuario deja el título vacío, se mostrará:

```text
El título es obligatorio.
```

---

### 20.5. Campo `level`

El campo del nivel es:

```jsp
<div class="form-group">
    <form:label path="level">Nivel</form:label>
    <form:select path="level" cssClass="input">
        <form:option value="" label="Selecciona un nivel" />
        <form:option value="Inicial" label="Inicial" />
        <form:option value="Intermedio" label="Intermedio" />
        <form:option value="Avanzado" label="Avanzado" />
    </form:select>
    <form:errors path="level" cssClass="error" />
</div>
```

Este campo se conecta con:

```java
private String level;
```

El usuario podrá elegir una de estas opciones:

```text
Inicial
Intermedio
Avanzado
```

La primera opción tiene valor vacío:

```jsp
<form:option value="" label="Selecciona un nivel" />
```

Esto permite detectar que el usuario no ha seleccionado ningún nivel.

Si envía el formulario sin elegir nivel, se activará esta validación:

```java
@NotBlank(message = "El nivel es obligatorio.")
private String level;
```

Y el error se mostrará aquí:

```jsp
<form:errors path="level" cssClass="error" />
```

---

### 20.6. Campo `durationInHours`

El campo de duración es:

```jsp
<div class="form-group">
    <form:label path="durationInHours">Duración en horas</form:label>
    <form:input path="durationInHours" type="number" cssClass="input" />
    <form:errors path="durationInHours" cssClass="error" />
</div>
```

Este campo se conecta con:

```java
private Integer durationInHours;
```

Si el usuario introduce `20`, Spring intentará convertir ese valor a `Integer`.

Después se aplicarán estas validaciones:

```java
@NotNull(message = "La duración es obligatoria.")
@Min(value = 1, message = "La duración mínima es de 1 hora.")
@Max(value = 200, message = "La duración máxima es de 200 horas.")
private Integer durationInHours;
```

Si hay errores, se mostrarán aquí:

```jsp
<form:errors path="durationInHours" cssClass="error" />
```

---

### 20.7. Botones del formulario

Al final tenemos:

```jsp
<div class="form-actions">
    <button type="submit" class="button">
        Crear curso
    </button>

    <a class="secondary-button" href="${pageContext.request.contextPath}/courses">
        Cancelar
    </a>
</div>
```

El botón:

```html
<button type="submit" class="button">Crear curso</button>
```

envía el formulario.

El enlace:

```jsp
<a class="secondary-button" href="${pageContext.request.contextPath}/courses">
    Cancelar
</a>
```

lleva al usuario de vuelta al listado sin enviar datos.

---

## 21. Actualizar la vista `list.jsp`

Ahora debemos modificar el listado para añadir dos cosas:

1. Un botón para ir al formulario.
2. Un mensaje de éxito después de crear un curso.

El archivo que modificamos es:

```text
src/main/webapp/WEB-INF/views/courses/list.jsp
```

### Código completo actualizado de `list.jsp`

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
        <a href="${pageContext.request.contextPath}/courses">Cursos</a>
        <a href="${pageContext.request.contextPath}/about">Sobre el curso</a>
    </nav>
</header>

<main class="container">
    <section class="card wide">
        <h1>${pageTitle}</h1>

        <p class="message">
            Estos cursos vienen del controlador, que a su vez obtiene los datos desde un servicio.
        </p>

        <c:if test="${not empty successMessage}">
            <div class="success">
                ${successMessage}
            </div>
        </c:if>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/courses/new">
                Crear nuevo curso
            </a>
        </p>

        <table class="table">
            <thead>
            <tr>
                <th>Título</th>
                <th>Nivel</th>
                <th>Duración</th>
                <th>Acción</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="course" items="${courses}">
                <tr>
                    <td>${course.title}</td>
                    <td>${course.level}</td>
                    <td>${course.durationInHours} horas</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/courses/detail?id=${course.id}">
                            Ver detalle
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <p>
            <a class="secondary-button" href="${pageContext.request.contextPath}/home">
                Volver al inicio
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

---

## 22. Explicación de los cambios en `list.jsp`

### 22.1. Mostrar mensaje de éxito

Añadimos este bloque:

```jsp
<c:if test="${not empty successMessage}">
    <div class="success">
        ${successMessage}
    </div>
</c:if>
```

Este bloque usa JSTL.

La etiqueta:

```jsp
<c:if>
```

permite mostrar contenido solo si se cumple una condición.

En este caso, la condición es:

```jsp
${not empty successMessage}
```

Es decir:

```text
Si successMessage no está vacío, muestra el mensaje.
```

Ese mensaje se crea en el controlador:

```java
redirectAttributes.addFlashAttribute(
        "successMessage",
        "El curso se ha creado correctamente."
);
```

---

### 22.2. Botón para crear un curso

También añadimos este enlace:

```jsp
<a class="button" href="${pageContext.request.contextPath}/courses/new">
    Crear nuevo curso
</a>
```

Este enlace lleva al usuario a:

```text
/courses/new
```

Esa ruta será atendida por este método:

```java
@GetMapping("/new")
public String showCreateForm(Model model) {
    ...
}
```

---

## 23. Actualizar el archivo CSS

Ahora añadiremos estilos para:

- formulario
- campos
- errores
- mensaje de éxito
- botones secundarios

El archivo es:

```text
src/main/webapp/resources/css/styles.css
```

Añadimos este código al final del archivo:

```css
.form {
  margin-top: 24px;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  font-weight: bold;
}

.input {
  width: 100%;
  box-sizing: border-box;
  padding: 10px 12px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 16px;
}

.input:focus {
  outline: none;
  border-color: #2563eb;
}

.error {
  display: block;
  margin-top: 6px;
  color: #b91c1c;
  font-size: 14px;
}

.success {
  margin: 20px 0;
  padding: 12px 16px;
  background-color: #dcfce7;
  border: 1px solid #86efac;
  color: #166534;
  border-radius: 8px;
}

.form-actions {
  display: flex;
  gap: 12px;
  align-items: center;
  margin-top: 24px;
}

.secondary-button {
  display: inline-block;
  margin-top: 16px;
  padding: 10px 16px;
  background-color: #e5e7eb;
  color: #111827;
  border-radius: 8px;
  text-decoration: none;
}

.secondary-button:hover {
  background-color: #d1d5db;
  text-decoration: none;
}
```

---

## 24. Explicación del CSS

### 24.1. Estilos del formulario

```css
.form {
  margin-top: 24px;
}
```

Añade separación entre el texto introductorio y el formulario.

---

### 24.2. Grupos de campos

```css
.form-group {
  margin-bottom: 20px;
}
```

Separa visualmente cada campo del formulario.

---

### 24.3. Etiquetas

```css
.form-group label {
  display: block;
  margin-bottom: 8px;
  font-weight: bold;
}
```

Hace que la etiqueta de cada campo aparezca encima del input y en negrita.

---

### 24.4. Campos del formulario

```css
.input {
  width: 100%;
  box-sizing: border-box;
  padding: 10px 12px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 16px;
}
```

Esta clase se aplica a los campos del formulario.

Por ejemplo:

```jsp
<form:input path="title" cssClass="input" />
```

---

### 24.5. Errores

```css
.error {
  display: block;
  margin-top: 6px;
  color: #b91c1c;
  font-size: 14px;
}
```

Esta clase se aplica a los mensajes de error.

Por ejemplo:

```jsp
<form:errors path="title" cssClass="error" />
```

Si hay un error en el campo `title`, el mensaje aparecerá con este estilo.

---

### 24.6. Mensaje de éxito

```css
.success {
  margin: 20px 0;
  padding: 12px 16px;
  background-color: #dcfce7;
  border: 1px solid #86efac;
  color: #166534;
  border-radius: 8px;
}
```

Esta clase se aplica al mensaje que aparece después de crear un curso correctamente.

---

## 25. Flujo completo cuando el formulario es correcto

Veamos todo el proceso paso a paso.

### Paso 1

El usuario entra en:

```text
http://localhost:8080/spring-mvc-day1/courses/new
```

### Paso 2

Spring ejecuta este método:

```java
@GetMapping("/new")
public String showCreateForm(Model model) {
    model.addAttribute("pageTitle", "Crear nuevo curso");
    model.addAttribute("course", new Course());

    return "courses/form";
}
```

### Paso 3

El controlador envía a la vista:

```text
pageTitle → Crear nuevo curso
course    → objeto Course vacío
```

### Paso 4

Spring muestra la vista:

```text
/WEB-INF/views/courses/form.jsp
```

### Paso 5

El usuario rellena el formulario:

```text
Título: Spring MVC práctico
Nivel: Intermedio
Duración: 12
```

### Paso 6

El usuario pulsa el botón:

```text
Crear curso
```

### Paso 7

El navegador envía una petición:

```text
POST /courses
```

### Paso 8

Spring ejecuta:

```java
@PostMapping
public String createCourse(...) {
    ...
}
```

### Paso 9

Spring crea un objeto `Course` con los datos enviados:

```java
course.setTitle("Spring MVC práctico");
course.setLevel("Intermedio");
course.setDurationInHours(12);
```

### Paso 10

Spring valida el objeto.

Como los datos son correctos, no hay errores.

### Paso 11

El controlador guarda el curso:

```java
courseService.save(course);
```

### Paso 12

El controlador crea un mensaje de éxito:

```java
redirectAttributes.addFlashAttribute(
        "successMessage",
        "El curso se ha creado correctamente."
);
```

### Paso 13

El controlador redirige al listado:

```java
return "redirect:/courses";
```

### Paso 14

El navegador hace una nueva petición:

```text
GET /courses
```

### Paso 15

Se muestra el listado actualizado con el nuevo curso.

---

## 26. Flujo completo cuando el formulario tiene errores

Ahora supongamos que el usuario envía el formulario vacío.

### Paso 1

El usuario entra en:

```text
/courses/new
```

### Paso 2

Spring muestra el formulario.

### Paso 3

El usuario no rellena nada y pulsa:

```text
Crear curso
```

### Paso 4

El navegador envía:

```text
POST /courses
```

### Paso 5

Spring intenta crear un objeto `Course`.

Pero los campos no cumplen las reglas:

```java
@NotBlank(message = "El título es obligatorio.")
private String title;

@NotBlank(message = "El nivel es obligatorio.")
private String level;

@NotNull(message = "La duración es obligatoria.")
private Integer durationInHours;
```

### Paso 6

`BindingResult` contiene errores.

### Paso 7

El controlador ejecuta:

```java
if (bindingResult.hasErrors()) {
    model.addAttribute("pageTitle", "Crear nuevo curso");
    return "courses/form";
}
```

### Paso 8

El curso no se guarda.

### Paso 9

Spring vuelve a mostrar:

```text
/WEB-INF/views/courses/form.jsp
```

### Paso 10

La vista muestra los errores usando:

```jsp
<form:errors path="title" cssClass="error" />
<form:errors path="level" cssClass="error" />
<form:errors path="durationInHours" cssClass="error" />
```

---

## 27. Diferencia entre `@RequestParam` y `@ModelAttribute`

En el tema anterior usamos:

```java
@RequestParam("id") Long id
```

Esto servía para leer un único parámetro de la URL:

```text
/courses/detail?id=1
```

`@RequestParam` es útil para leer valores sueltos.

Por ejemplo:

```java
@RequestParam("id") Long id
@RequestParam("search") String search
```

Pero cuando tenemos un formulario con varios campos, sería incómodo leer cada campo por separado:

```java
@PostMapping
public String createCourse(
        @RequestParam("title") String title,
        @RequestParam("level") String level,
        @RequestParam("durationInHours") Integer durationInHours) {
    ...
}
```

En esos casos usamos:

```java
@ModelAttribute("course") Course course
```

Así Spring crea un objeto completo con todos los datos del formulario.

| Anotación         | Uso principal                                 |
| ----------------- | --------------------------------------------- |
| `@RequestParam`   | Leer parámetros individuales                  |
| `@ModelAttribute` | Construir un objeto a partir de varios campos |

---

## 28. Diferencia entre devolver una vista y devolver una redirección

En Spring MVC no es lo mismo devolver esto:

```java
return "courses/form";
```

que devolver esto:

```java
return "redirect:/courses";
```

---

### 28.1. Devolver una vista

Cuando devolvemos:

```java
return "courses/form";
```

Spring usa el `ViewResolver`.

Con nuestra configuración, buscará:

```text
/WEB-INF/views/courses/form.jsp
```

Esto se usa cuando queremos mostrar una página directamente.

Por ejemplo, cuando hay errores de validación:

```java
if (bindingResult.hasErrors()) {
    model.addAttribute("pageTitle", "Crear nuevo curso");
    return "courses/form";
}
```

---

### 28.2. Devolver una redirección

Cuando devolvemos:

```java
return "redirect:/courses";
```

Spring no busca una JSP.

En su lugar, envía una respuesta al navegador diciendo:

```text
Haz una nueva petición a /courses
```

Esto se usa después de procesar correctamente un formulario.

---

## 29. Posible ampliación con MySQL

En este tema hemos guardado los cursos en memoria:

```java
private final List<Course> courses = new ArrayList<>();
```

Esto significa que los datos se pierden cuando se reinicia la aplicación.

Es suficiente para aprender formularios.

Más adelante podríamos sustituir este almacenamiento por una base de datos MySQL.

El flujo sería:

```text
Formulario
↓
CourseController
↓
CourseService
↓
CourseRepository
↓
MySQL
```

En ese caso, usaríamos DBeaver para gestionar la base de datos y comprobar los registros guardados.

Pero para este tema conviene separar los conceptos:

```text
Primero: entender formularios y validación.
Después: añadir persistencia en base de datos.
```

---

## 30. Errores habituales

### Error 1: olvidar el objeto del formulario

Si en el controlador no añadimos esto:

```java
model.addAttribute("course", new Course());
```

pero en la JSP usamos:

```jsp
<form:form modelAttribute="course">
```

Spring no encontrará el objeto asociado al formulario.

El formulario necesita que exista un atributo del modelo llamado exactamente:

```text
course
```

---

### Error 2: usar nombres de campos que no existen

Si en la JSP escribimos:

```jsp
<form:input path="name" />
```

pero la clase `Course` no tiene una propiedad llamada `name`, el enlace fallará.

La clase tiene:

```java
private String title;
```

Por tanto, el formulario debe usar:

```jsp
<form:input path="title" />
```

Los valores de `path` deben coincidir con las propiedades del objeto.

---

### Error 3: olvidar `BindingResult`

Si escribimos:

```java
@PostMapping
public String createCourse(@Valid @ModelAttribute("course") Course course) {
    courseService.save(course);
    return "redirect:/courses";
}
```

no podremos comprobar si hay errores.

Lo correcto es:

```java
@PostMapping
public String createCourse(
        @Valid @ModelAttribute("course") Course course,
        BindingResult bindingResult) {
    ...
}
```

---

### Error 4: colocar mal `BindingResult`

Incorrecto:

```java
public String createCourse(
        @Valid @ModelAttribute("course") Course course,
        Model model,
        BindingResult bindingResult) {
```

Correcto:

```java
public String createCourse(
        @Valid @ModelAttribute("course") Course course,
        BindingResult bindingResult,
        Model model) {
```

`BindingResult` debe ir justo después del objeto validado.

---

### Error 5: usar `int` en lugar de `Integer`

Si usamos:

```java
private int durationInHours;
```

un valor vacío no se representa bien como `null`.

Para formularios es más claro usar:

```java
private Integer durationInHours;
```

Así esta validación puede funcionar correctamente:

```java
@NotNull(message = "La duración es obligatoria.")
```

---

### Error 6: devolver `courses/list` después de guardar

Después de guardar correctamente, podríamos pensar en hacer esto:

```java
return "courses/list";
```

Pero es mejor hacer:

```java
return "redirect:/courses";
```

Así evitamos que el formulario se vuelva a enviar si el usuario refresca la página.

---

### Error 7: olvidar la dependencia de validación

Si usamos anotaciones como:

```java
@NotBlank
@Size
@Min
```

pero no tenemos Hibernate Validator en el `pom.xml`, la validación no funcionará correctamente.

Por eso añadimos:

```xml
<dependency>
    <groupId>org.hibernate.validator</groupId>
    <artifactId>hibernate-validator</artifactId>
    <version>8.0.3.Final</version>
</dependency>
```

---

### Error 8: olvidar la librería de formularios en JSP

Si usamos etiquetas como:

```jsp
<form:form>
<form:input>
<form:errors>
```

pero no añadimos esta línea al principio de la JSP:

```jsp
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
```

la vista no podrá interpretar esas etiquetas.

---

## 31. Resumen final del tema

En este tema hemos aprendido a procesar formularios en Spring MVC.

La idea principal es:

```text
Spring MVC puede convertir automáticamente los datos de un formulario en un objeto Java.
```

El flujo completo es:

```text
GET /courses/new
↓
El controlador crea un Course vacío
↓
La vista form.jsp muestra el formulario
↓
El usuario rellena los campos
↓
POST /courses
↓
Spring rellena un objeto Course con @ModelAttribute
↓
Spring valida el objeto con @Valid
↓
BindingResult guarda los errores
↓
Si hay errores, se vuelve a mostrar el formulario
↓
Si no hay errores, se guarda el curso
↓
redirect:/courses
↓
Se muestra el listado actualizado
```

Las piezas principales son:

| Elemento             | Función                                                 |
| -------------------- | ------------------------------------------------------- |
| `@ModelAttribute`    | Vincula datos del formulario con un objeto Java         |
| `@Valid`             | Activa la validación del objeto                         |
| `BindingResult`      | Guarda los errores de validación                        |
| `form:form`          | Crea un formulario vinculado al modelo                  |
| `form:input`         | Crea un campo asociado a una propiedad                  |
| `form:select`        | Crea un desplegable asociado a una propiedad            |
| `form:errors`        | Muestra errores de validación                           |
| `RedirectAttributes` | Permite enviar mensajes temporales tras una redirección |
| `redirect:/...`      | Redirige al navegador a otra ruta                       |
| Post-Redirect-Get    | Evita reenvíos accidentales del formulario              |

La frase clave que debemos recordar es:

```text
El controlador no necesita leer manualmente cada campo del formulario.
Spring MVC recibe los datos, crea el objeto, lo valida y permite decidir qué vista mostrar.
```
