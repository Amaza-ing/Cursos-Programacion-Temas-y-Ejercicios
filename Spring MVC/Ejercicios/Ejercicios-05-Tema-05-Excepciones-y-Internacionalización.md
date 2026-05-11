# Ejercicios resueltos — Tema 5: Excepciones, internacionalización y temas visuales en Spring MVC

## Introducción

En estos ejercicios vas a practicar los contenidos del tema dedicado a:

- Gestión de excepciones en Spring MVC.
- Creación de excepciones personalizadas.
- Uso de `@ControllerAdvice`.
- Uso de `@ExceptionHandler`.
- Creación de páginas de error personalizadas.
- Configuración de páginas 404 y 500.
- Internacionalización con archivos `messages`.
- Uso de `MessageSource`.
- Cambio de idioma con `LocaleResolver` y `LocaleChangeInterceptor`.
- Uso de `<spring:message>` en JSP.
- Internacionalización de mensajes de validación.
- Cambio de tema visual claro/oscuro mediante sesión y CSS.

Los ejercicios son parecidos a los del curso, pero usan una aplicación distinta: una pequeña aplicación de gestión de **eventos**.

Cada solución está oculta bajo el botón **mostrar solución**.

---

# Ejercicio 1 — Crear una excepción personalizada

## Enunciado

Crea una excepción personalizada llamada `EventNotFoundException`.

Debe estar en el paquete:

```text
com.example.events.exception
```

La excepción debe:

1. Extender de `RuntimeException`.
2. Guardar el identificador del evento que no se ha encontrado.
3. Tener un constructor que reciba `Long eventId`.
4. Tener un getter para `eventId`.

---

<details>
<summary>mostrar solución</summary>

```java
package com.example.events.exception;

public class EventNotFoundException extends RuntimeException {

    private final Long eventId;

    public EventNotFoundException(Long eventId) {
        super("No se ha encontrado ningún evento con id " + eventId);
        this.eventId = eventId;
    }

    public Long getEventId() {
        return eventId;
    }
}
```

### Explicación

Esta excepción representa un error concreto de la aplicación:

```text
El usuario ha pedido un evento que no existe.
```

Extendemos de:

```java
RuntimeException
```

porque no queremos obligar a capturarla con `try-catch` en todos los métodos.

Guardamos el identificador:

```java
private final Long eventId;
```

para poder mostrarlo después en una página de error.

</details>

---

# Ejercicio 2 — Lanzar una excepción desde el servicio

## Enunciado

Tienes este servicio de eventos:

```java
package com.example.events.service;

import com.example.events.model.Event;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventService {

    private final List<Event> events = List.of(
            new Event(1L, "Conferencia Java", "Madrid", "2026-06-10"),
            new Event(2L, "Taller Spring MVC", "Valencia", "2026-06-18"),
            new Event(3L, "Encuentro de desarrollo web", "Sevilla", "2026-07-02")
    );

    public List<Event> findAll() {
        return events;
    }

    public Event findById(Long id) {
        return events.stream()
                .filter(event -> event.getId().equals(id))
                .findFirst()
                .orElse(null);
    }
}
```

Añade un método llamado:

```java
findByIdOrThrow(Long id)
```

Este método debe devolver el evento si existe. Si no existe, debe lanzar `EventNotFoundException`.

---

<details>
<summary>mostrar solución</summary>

```java
package com.example.events.service;

import com.example.events.exception.EventNotFoundException;
import com.example.events.model.Event;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventService {

    private final List<Event> events = List.of(
            new Event(1L, "Conferencia Java", "Madrid", "2026-06-10"),
            new Event(2L, "Taller Spring MVC", "Valencia", "2026-06-18"),
            new Event(3L, "Encuentro de desarrollo web", "Sevilla", "2026-07-02")
    );

    public List<Event> findAll() {
        return events;
    }

    public Event findById(Long id) {
        return events.stream()
                .filter(event -> event.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public Event findByIdOrThrow(Long id) {
        Event event = findById(id);

        if (event == null) {
            throw new EventNotFoundException(id);
        }

        return event;
    }
}
```

### Explicación

El método:

```java
findByIdOrThrow(Long id)
```

tiene una intención clara:

```text
Busca un evento.
Si existe, lo devuelve.
Si no existe, lanza una excepción.
```

Así evitamos repetir esta comprobación en todos los controladores:

```java
if (event == null) {
    ...
}
```

La lógica queda centralizada en el servicio.

</details>

---

# Ejercicio 3 — Simplificar el controlador usando la excepción

## Enunciado

Tienes este método en `EventController`:

```java
@GetMapping("/detail")
public String eventDetail(@RequestParam("id") Long id, Model model) {
    Event event = eventService.findById(id);

    if (event == null) {
        model.addAttribute("pageTitle", "Evento no encontrado");
        model.addAttribute("eventId", id);

        return "events/not-found";
    }

    model.addAttribute("pageTitle", event.getTitle());
    model.addAttribute("event", event);

    return "events/detail";
}
```

Modifícalo para usar:

```java
eventService.findByIdOrThrow(id)
```

El método ya no debe comprobar manualmente si el evento es `null`.

---

<details>
<summary>mostrar solución</summary>

```java
@GetMapping("/detail")
public String eventDetail(@RequestParam("id") Long id, Model model) {
    Event event = eventService.findByIdOrThrow(id);

    model.addAttribute("pageTitle", event.getTitle());
    model.addAttribute("event", event);

    return "events/detail";
}
```

### Explicación

Antes el controlador hacía dos cosas:

```text
1. Buscaba el evento.
2. Decidía qué hacer si no existía.
```

Ahora el controlador solo se ocupa del caso correcto:

```text
Si el evento existe, prepara la vista de detalle.
```

Si el evento no existe, el servicio lanza:

```java
EventNotFoundException
```

y esa excepción se gestionará en una clase global.

</details>

---

# Ejercicio 4 — Crear un manejador global de excepciones

## Enunciado

Crea una clase llamada `GlobalExceptionHandler` en el paquete:

```text
com.example.events.exception
```

Debe:

1. Estar anotada con `@ControllerAdvice`.
2. Tener un método para capturar `EventNotFoundException`.
3. Añadir al modelo:
   - `pageTitle`
   - `eventId`
   - `errorMessage`
4. Devolver la vista:

```text
error/event-not-found
```

---

<details>
<summary>mostrar solución</summary>

```java
package com.example.events.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(EventNotFoundException.class)
    public String handleEventNotFound(
            EventNotFoundException exception,
            Model model) {

        model.addAttribute("pageTitle", "Evento no encontrado");
        model.addAttribute("eventId", exception.getEventId());
        model.addAttribute("errorMessage", exception.getMessage());

        return "error/event-not-found";
    }
}
```

### Explicación

La anotación:

```java
@ControllerAdvice
```

permite definir lógica común para varios controladores.

La anotación:

```java
@ExceptionHandler(EventNotFoundException.class)
```

indica que este método se ejecutará cuando se lance una excepción de tipo `EventNotFoundException`.

La vista devuelta:

```java
return "error/event-not-found";
```

se convertirá en:

```text
/WEB-INF/views/error/event-not-found.jsp
```

</details>

---

# Ejercicio 5 — Crear la vista `event-not-found.jsp`

## Enunciado

Crea la vista:

```text
src/main/webapp/WEB-INF/views/error/event-not-found.jsp
```

La vista debe mostrar:

1. El título recibido en `${pageTitle}`.
2. El identificador del evento recibido en `${eventId}`.
3. El mensaje de error recibido en `${errorMessage}`.
4. Un enlace para volver al listado de eventos.

---

<details>
<summary>mostrar solución</summary>

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
        <a href="${pageContext.request.contextPath}/events">Eventos</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            No se ha encontrado ningún evento con el identificador ${eventId}.
        </p>

        <p class="error">
            ${errorMessage}
        </p>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/events">
                Volver al listado de eventos
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explicación

Esta vista no la devuelve directamente `EventController`.

La devuelve el manejador global:

```java
GlobalExceptionHandler
```

cuando captura:

```java
EventNotFoundException
```

Eso permite separar la lógica normal del controlador de la lógica de errores.

</details>

---

# Ejercicio 6 — Añadir un manejador general de errores

## Enunciado

Amplía `GlobalExceptionHandler` para capturar cualquier excepción no prevista.

Debe capturar:

```java
Exception.class
```

El método debe:

1. Añadir `pageTitle` con el valor `Error inesperado`.
2. Añadir `errorMessage` con el mensaje de la excepción.
3. Devolver la vista:

```text
error/general-error
```

---

<details>
<summary>mostrar solución</summary>

```java
package com.example.events.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(EventNotFoundException.class)
    public String handleEventNotFound(
            EventNotFoundException exception,
            Model model) {

        model.addAttribute("pageTitle", "Evento no encontrado");
        model.addAttribute("eventId", exception.getEventId());
        model.addAttribute("errorMessage", exception.getMessage());

        return "error/event-not-found";
    }

    @ExceptionHandler(Exception.class)
    public String handleGeneralException(
            Exception exception,
            Model model) {

        model.addAttribute("pageTitle", "Error inesperado");
        model.addAttribute("errorMessage", exception.getMessage());

        return "error/general-error";
    }
}
```

### Explicación

El método:

```java
@ExceptionHandler(Exception.class)
```

funciona como red de seguridad.

Captura errores que no tengan un manejador más específico.

No sustituye a una buena gestión de errores, pero evita que el usuario vea una página técnica del servidor.

</details>

---

# Ejercicio 7 — Crear la vista de error general

## Enunciado

Crea la vista:

```text
src/main/webapp/WEB-INF/views/error/general-error.jsp
```

Debe mostrar:

1. El título recibido en `${pageTitle}`.
2. Un mensaje indicando que ha ocurrido un error inesperado.
3. El mensaje técnico recibido en `${errorMessage}`.
4. Un enlace para volver al inicio.

---

<details>
<summary>mostrar solución</summary>

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
        <a href="${pageContext.request.contextPath}/events">Eventos</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            Ha ocurrido un error inesperado en la aplicación.
        </p>

        <p class="error">
            ${errorMessage}
        </p>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/home">
                Volver al inicio
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explicación

Esta vista se usa cuando ocurre una excepción no prevista.

En una aplicación real, no siempre conviene mostrar el mensaje técnico al usuario final. Para un curso, sí puede ser útil para entender qué está pasando.

</details>

---

# Ejercicio 8 — Configurar páginas 404 y 500 en `web.xml`

## Enunciado

Modifica `web.xml` para que:

1. Los errores 404 redirijan a `/error/404`.
2. Los errores 500 redirijan a `/error/500`.

Escribe solo el bloque XML necesario.

---

<details>
<summary>mostrar solución</summary>

```xml
<error-page>
    <error-code>404</error-code>
    <location>/error/404</location>
</error-page>

<error-page>
    <error-code>500</error-code>
    <location>/error/500</location>
</error-page>
```

### Explicación

El error 404 se produce cuando el usuario intenta acceder a una URL que no existe.

Por ejemplo:

```text
/pagina-inventada
```

El error 500 se produce cuando hay un error interno en el servidor.

Con esta configuración, el servidor redirige esos errores a rutas controladas por Spring MVC.

</details>

---

# Ejercicio 9 — Crear `ErrorPageController`

## Enunciado

Crea un controlador llamado `ErrorPageController` en el paquete:

```text
com.example.events.controller
```

Debe tener dos métodos:

```text
GET /error/404
GET /error/500
```

El primer método debe devolver la vista:

```text
error/not-found
```

El segundo debe devolver:

```text
error/general-error
```

---

<details>
<summary>mostrar solución</summary>

```java
package com.example.events.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ErrorPageController {

    @GetMapping("/error/404")
    public String notFound(Model model) {
        model.addAttribute("pageTitle", "Página no encontrada");
        return "error/not-found";
    }

    @GetMapping("/error/500")
    public String serverError(Model model) {
        model.addAttribute("pageTitle", "Error del servidor");
        model.addAttribute("errorMessage", "Ha ocurrido un error interno.");
        return "error/general-error";
    }
}
```

### Explicación

Cuando el servidor detecta un 404, envía al usuario a:

```text
/error/404
```

Spring ejecuta este método:

```java
@GetMapping("/error/404")
```

y muestra una JSP personalizada.

</details>

---

# Ejercicio 10 — Crear la vista 404 personalizada

## Enunciado

Crea la vista:

```text
src/main/webapp/WEB-INF/views/error/not-found.jsp
```

Debe mostrar:

1. El título recibido en `${pageTitle}`.
2. Un mensaje indicando que la página no existe.
3. Un enlace para volver al inicio.

---

<details>
<summary>mostrar solución</summary>

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
        <a href="${pageContext.request.contextPath}/events">Eventos</a>
    </nav>
</header>

<main class="container">
    <section class="card">
        <h1>${pageTitle}</h1>

        <p class="message">
            La página que estás intentando abrir no existe.
        </p>

        <p>
            Comprueba la dirección o vuelve a una sección existente de la aplicación.
        </p>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/home">
                Volver al inicio
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explicación

Esta vista se muestra cuando el usuario entra en una URL que no existe.

Es más agradable que mostrar la página de error por defecto de Tomcat.

</details>

---

# Ejercicio 11 — Configurar internacionalización en `app-servlet.xml`

## Enunciado

Modifica `app-servlet.xml` para añadir internacionalización.

Debes configurar:

1. Un `messageSource`.
2. Un `SessionLocaleResolver` con español como idioma por defecto.
3. Un `LocaleChangeInterceptor` que cambie el idioma usando el parámetro `lang`.

---

<details>
<summary>mostrar solución</summary>

```xml
<!-- Internacionalización: archivos messages.properties -->
<bean id="messageSource"
      class="org.springframework.context.support.ResourceBundleMessageSource">
    <property name="basename" value="messages" />
    <property name="defaultEncoding" value="UTF-8" />
</bean>

<!-- Idioma por defecto y almacenamiento del idioma en sesión -->
<bean id="localeResolver"
      class="org.springframework.web.servlet.i18n.SessionLocaleResolver">
    <property name="defaultLocale" value="es" />
</bean>

<!-- Permite cambiar el idioma usando ?lang=es o ?lang=en -->
<mvc:interceptors>
    <bean class="org.springframework.web.servlet.i18n.LocaleChangeInterceptor">
        <property name="paramName" value="lang" />
    </bean>
</mvc:interceptors>
```

### Explicación

El bean:

```xml
messageSource
```

permite que Spring busque textos en archivos como:

```text
messages_es.properties
messages_en.properties
```

El bean:

```xml
localeResolver
```

guarda el idioma activo del usuario en sesión.

El interceptor:

```xml
LocaleChangeInterceptor
```

detecta URLs como:

```text
/home?lang=en
```

y cambia el idioma activo.

</details>

---

# Ejercicio 12 — Crear archivos de mensajes

## Enunciado

Crea estos archivos en:

```text
src/main/resources
```

```text
messages.properties
messages_es.properties
messages_en.properties
```

Deben incluir mensajes para:

- Navegación.
- Página de inicio.
- Listado de eventos.
- Errores.

Crea al menos cinco claves.

---

<details>
<summary>mostrar solución</summary>

## `messages.properties`

```properties
nav.home=Inicio
nav.events=Eventos
language.spanish=Español
language.english=Inglés

home.title=Bienvenida a la aplicación de eventos
home.message=Gestiona eventos con Spring MVC.

events.list.title=Listado de eventos
events.detail=Ver detalle
events.back=Volver

error.notFound.title=Página no encontrada
error.general.title=Error inesperado
```

## `messages_es.properties`

```properties
nav.home=Inicio
nav.events=Eventos
language.spanish=Español
language.english=Inglés

home.title=Bienvenida a la aplicación de eventos
home.message=Gestiona eventos con Spring MVC.

events.list.title=Listado de eventos
events.detail=Ver detalle
events.back=Volver

error.notFound.title=Página no encontrada
error.general.title=Error inesperado
```

## `messages_en.properties`

```properties
nav.home=Home
nav.events=Events
language.spanish=Spanish
language.english=English

home.title=Welcome to the events application
home.message=Manage events with Spring MVC.

events.list.title=Event list
events.detail=View detail
events.back=Back

error.notFound.title=Page not found
error.general.title=Unexpected error
```

### Explicación

Las claves deben llamarse igual en todos los archivos.

Lo que cambia es el valor.

Por ejemplo:

```properties
nav.home=Inicio
```

en español y:

```properties
nav.home=Home
```

en inglés.

</details>

---

# Ejercicio 13 — Usar `<spring:message>` en una JSP

## Enunciado

Modifica una vista `home.jsp` para que no tenga los textos escritos directamente.

Debe usar:

```jsp
<spring:message code="..." />
```

La página debe mostrar:

1. El título `home.title`.
2. El mensaje `home.message`.
3. Un enlace a eventos usando `nav.events`.
4. Enlaces para cambiar idioma a español e inglés.

---

<details>
<summary>mostrar solución</summary>

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <title><spring:message code="home.title" /></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">
            <spring:message code="nav.home" />
        </a>

        <a href="${pageContext.request.contextPath}/events">
            <spring:message code="nav.events" />
        </a>
    </nav>

    <div class="toolbar">
        <a href="${pageContext.request.contextPath}/home?lang=es">
            <spring:message code="language.spanish" />
        </a>

        <a href="${pageContext.request.contextPath}/home?lang=en">
            <spring:message code="language.english" />
        </a>
    </div>
</header>

<main class="container">
    <section class="card">
        <h1>
            <spring:message code="home.title" />
        </h1>

        <p class="message">
            <spring:message code="home.message" />
        </p>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/events">
                <spring:message code="nav.events" />
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explicación

Para usar etiquetas de Spring en JSP necesitamos:

```jsp
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
```

Después podemos mostrar mensajes así:

```jsp
<spring:message code="home.title" />
```

Spring buscará esa clave en el archivo correspondiente al idioma activo.

</details>

---

# Ejercicio 14 — Internacionalizar el listado de eventos

## Enunciado

Tienes esta tabla en `events/list.jsp`:

```jsp
<table>
    <thead>
    <tr>
        <th>Título</th>
        <th>Ciudad</th>
        <th>Fecha</th>
        <th>Acción</th>
    </tr>
    </thead>
</table>
```

Crea las claves necesarias en los archivos de mensajes y modifica la JSP para usar `<spring:message>`.

---

<details>
<summary>mostrar solución</summary>

## Claves en `messages_es.properties`

```properties
events.title=Título
events.city=Ciudad
events.date=Fecha
events.action=Acción
events.detail=Ver detalle
```

## Claves en `messages_en.properties`

```properties
events.title=Title
events.city=City
events.date=Date
events.action=Action
events.detail=View detail
```

## JSP modificada

```jsp
<table class="table">
    <thead>
    <tr>
        <th><spring:message code="events.title" /></th>
        <th><spring:message code="events.city" /></th>
        <th><spring:message code="events.date" /></th>
        <th><spring:message code="events.action" /></th>
    </tr>
    </thead>

    <tbody>
    <c:forEach var="event" items="${events}">
        <tr>
            <td>${event.title}</td>
            <td>${event.city}</td>
            <td>${event.date}</td>
            <td>
                <a href="${pageContext.request.contextPath}/events/detail?id=${event.id}">
                    <spring:message code="events.detail" />
                </a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
```

### Explicación

Los textos fijos desaparecen de la vista.

Ahora la vista solo tiene claves:

```jsp
<spring:message code="events.title" />
```

El texto real se obtiene del archivo de idioma activo.

</details>

---

# Ejercicio 15 — Obtener un mensaje internacionalizado desde el controlador

## Enunciado

En un controlador, después de crear un evento, queremos mostrar un mensaje de éxito internacionalizado.

Crea una clave llamada:

```text
success.event.created
```

en español e inglés.

Después modifica el controlador para obtener ese mensaje con `MessageSource` y enviarlo como atributo flash llamado `successMessage`.

---

<details>
<summary>mostrar solución</summary>

## `messages_es.properties`

```properties
success.event.created=El evento se ha creado correctamente.
```

## `messages_en.properties`

```properties
success.event.created=The event has been created successfully.
```

## Controlador

```java
package com.example.events.controller;

import com.example.events.model.Event;
import com.example.events.service.EventService;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Locale;

@Controller
public class EventController {

    private final EventService eventService;
    private final MessageSource messageSource;

    public EventController(
            EventService eventService,
            MessageSource messageSource) {

        this.eventService = eventService;
        this.messageSource = messageSource;
    }

    @PostMapping("/events")
    public String createEvent(
            Event event,
            RedirectAttributes redirectAttributes) {

        eventService.save(event);

        Locale locale = LocaleContextHolder.getLocale();

        String successMessage = messageSource.getMessage(
                "success.event.created",
                null,
                locale
        );

        redirectAttributes.addFlashAttribute("successMessage", successMessage);

        return "redirect:/events";
    }
}
```

### Explicación

Primero inyectamos:

```java
MessageSource
```

Después obtenemos el idioma actual:

```java
Locale locale = LocaleContextHolder.getLocale();
```

Luego buscamos el mensaje:

```java
messageSource.getMessage("success.event.created", null, locale)
```

Así el mensaje cambia según el idioma activo del usuario.

</details>

---

# Ejercicio 16 — Internacionalizar mensajes de validación

## Enunciado

Tienes este modelo:

```java
public class Event {

    @NotBlank(message = "El título es obligatorio.")
    private String title;

    @NotBlank(message = "La ciudad es obligatoria.")
    private String city;
}
```

Modifícalo para que los mensajes salgan de los archivos `messages`.

Crea también las claves en español e inglés.

---

<details>
<summary>mostrar solución</summary>

## Modelo `Event.java`

```java
package com.example.events.model;

import jakarta.validation.constraints.NotBlank;

public class Event {

    private Long id;

    @NotBlank(message = "{event.title.notBlank}")
    private String title;

    @NotBlank(message = "{event.city.notBlank}")
    private String city;

    private String date;

    public Event() {
    }

    public Event(Long id, String title, String city, String date) {
        this.id = id;
        this.title = title;
        this.city = city;
        this.date = date;
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getCity() {
        return city;
    }

    public String getDate() {
        return date;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
```

## `messages_es.properties`

```properties
event.title.notBlank=El título es obligatorio.
event.city.notBlank=La ciudad es obligatoria.
```

## `messages_en.properties`

```properties
event.title.notBlank=The title is required.
event.city.notBlank=The city is required.
```

### Explicación

En lugar de escribir el mensaje directamente:

```java
@NotBlank(message = "El título es obligatorio.")
```

usamos una clave:

```java
@NotBlank(message = "{event.title.notBlank}")
```

Spring buscará esa clave en el archivo de mensajes correspondiente.

</details>

---

# Ejercicio 17 — Crear un controlador para cambiar el tema visual

## Enunciado

Crea un controlador llamado `ThemeController`.

Debe estar en el paquete:

```text
com.example.events.controller
```

Debe responder a:

```text
/theme/change?theme=dark
/theme/change?theme=light
```

El controlador debe:

1. Leer el parámetro `theme`.
2. Guardar el tema en sesión.
3. Si el tema no es `dark`, usar `light`.
4. Redirigir a `/home`.

---

<details>
<summary>mostrar solución</summary>

```java
package com.example.events.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/theme")
public class ThemeController {

    @GetMapping("/change")
    public String changeTheme(
            @RequestParam(defaultValue = "light") String theme,
            HttpSession session) {

        if (!theme.equals("dark")) {
            theme = "light";
        }

        session.setAttribute("theme", theme);

        return "redirect:/home";
    }
}
```

### Explicación

El parámetro se recibe con:

```java
@RequestParam(defaultValue = "light") String theme
```

Si el usuario entra en:

```text
/theme/change?theme=dark
```

el valor será:

```text
dark
```

Guardamos el tema en sesión:

```java
session.setAttribute("theme", theme);
```

Así la elección se mantiene mientras dure la sesión del usuario.

</details>

---

# Ejercicio 18 — Cargar CSS oscuro solo si el tema es `dark`

## Enunciado

Modifica una JSP para que:

1. Siempre cargue `styles.css`.
2. Lea el tema desde `sessionScope.theme`.
3. Si el tema es `dark`, cargue también `styles-dark.css`.

Usa JSTL.

---

<details>
<summary>mostrar solución</summary>

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">

<c:if test="${currentTheme == 'dark'}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
</c:if>
```

### Explicación

Primero calculamos el tema actual:

```jsp
<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />
```

Si no hay tema en sesión, usamos:

```text
light
```

Después siempre cargamos el CSS principal:

```jsp
styles.css
```

Y solo si el tema es oscuro cargamos:

```jsp
styles-dark.css
```

El segundo archivo sobrescribe algunos estilos del primero.

</details>

---

# Ejercicio 19 — Crear `styles-dark.css`

## Enunciado

Crea un archivo:

```text
src/main/webapp/resources/css/styles-dark.css
```

Debe cambiar los colores principales de la aplicación a un tema oscuro.

Incluye estilos para:

- `body`
- `.header`
- `.card`
- `h1`
- `.table`
- `.input`
- `.button`
- `.error`

---

<details>
<summary>mostrar solución</summary>

```css
body {
  background-color: #111827;
  color: #e5e7eb;
}

.header {
  background-color: #020617;
}

.card {
  background-color: #1f2937;
  color: #e5e7eb;
}

h1 {
  color: #f9fafb;
}

.table th {
  background-color: #111827;
  color: #f9fafb;
}

.table th,
.table td {
  border-bottom: 1px solid #374151;
}

.input {
  background-color: #111827;
  color: #f9fafb;
  border-color: #4b5563;
}

.button {
  background-color: #60a5fa;
  color: #111827;
}

.error {
  color: #fca5a5;
}
```

### Explicación

Este archivo no sustituye a `styles.css`.

Se carga después, solo si el usuario ha elegido el tema oscuro.

Por eso puede sobrescribir colores sin repetir todo el diseño.

</details>

---

# Ejercicio 20 — Añadir enlaces de idioma y tema al menú

## Enunciado

Modifica el encabezado de una JSP para que incluya:

1. Enlace a inicio.
2. Enlace a eventos.
3. Cambio de idioma a español.
4. Cambio de idioma a inglés.
5. Cambio a tema claro.
6. Cambio a tema oscuro.

Usa mensajes internacionalizados para los textos.

---

<details>
<summary>mostrar solución</summary>

## Claves necesarias

```properties
nav.home=Inicio
nav.events=Eventos
language.spanish=Español
language.english=Inglés
theme.light=Tema claro
theme.dark=Tema oscuro
```

## JSP

```jsp
<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">
            <spring:message code="nav.home" />
        </a>

        <a href="${pageContext.request.contextPath}/events">
            <spring:message code="nav.events" />
        </a>
    </nav>

    <div class="toolbar">
        <a href="${pageContext.request.contextPath}/home?lang=es">
            <spring:message code="language.spanish" />
        </a>

        <a href="${pageContext.request.contextPath}/home?lang=en">
            <spring:message code="language.english" />
        </a>

        <a href="${pageContext.request.contextPath}/theme/change?theme=light">
            <spring:message code="theme.light" />
        </a>

        <a href="${pageContext.request.contextPath}/theme/change?theme=dark">
            <spring:message code="theme.dark" />
        </a>
    </div>
</header>
```

### Explicación

Los enlaces:

```text
/home?lang=es
/home?lang=en
```

son detectados por `LocaleChangeInterceptor`.

Los enlaces:

```text
/theme/change?theme=light
/theme/change?theme=dark
```

son gestionados por `ThemeController`.

</details>

---

# Ejercicio 21 — Diagnosticar errores frecuentes

## Enunciado

Lee cada caso y explica cuál es el problema.

## Caso A

Se lanza esta excepción:

```java
throw new EventNotFoundException(id);
```

pero el manejador tiene:

```java
@ExceptionHandler(NullPointerException.class)
```

¿Por qué no se muestra la página de error esperada?

---

## Caso B

En la JSP se usa:

```jsp
<spring:message code="events.list.title" />
```

pero en `messages_es.properties` aparece:

```properties
event.list.title=Listado de eventos
```

¿Qué ocurre?

---

## Caso C

Se entra en:

```text
/home?lang=en
```

pero la página sigue en español.

¿Qué puede faltar en la configuración?

---

## Caso D

El usuario pulsa “Tema oscuro”, pero al cambiar de página vuelve al tema claro.

¿Qué puede estar ocurriendo?

---

<details>
<summary>mostrar solución</summary>

## Caso A

El tipo de excepción no coincide.

Se lanza:

```java
EventNotFoundException
```

pero el manejador captura:

```java
NullPointerException
```

Debe existir un método con:

```java
@ExceptionHandler(EventNotFoundException.class)
```

---

## Caso B

La clave no coincide.

La JSP busca:

```text
events.list.title
```

pero el archivo tiene:

```text
event.list.title
```

Spring no encontrará la clave esperada.

La solución es que ambos nombres coincidan exactamente.

Por ejemplo:

```properties
events.list.title=Listado de eventos
```

---

## Caso C

Puede faltar el `LocaleChangeInterceptor`.

Debe existir algo parecido a esto en `app-servlet.xml`:

```xml
<mvc:interceptors>
    <bean class="org.springframework.web.servlet.i18n.LocaleChangeInterceptor">
        <property name="paramName" value="lang" />
    </bean>
</mvc:interceptors>
```

También debe existir un `localeResolver`.

---

## Caso D

Puede que el tema no se esté guardando en sesión.

El controlador debe hacer:

```java
session.setAttribute("theme", theme);
```

Y las JSP deben leer:

```jsp
sessionScope.theme
```

Si el tema se guarda solo como atributo del modelo, se perderá al cambiar de página.

</details>

---

# Ejercicio 22 — Reto final: añadir errores, idioma y tema a una sección de reservas

## Enunciado

Crea una pequeña sección de reservas usando lo aprendido en el Tema 5.

Debes crear:

1. Una excepción `ReservationNotFoundException`.
2. Un método `findByIdOrThrow` en `ReservationService`.
3. Un manejador en `GlobalExceptionHandler`.
4. Una vista `error/reservation-not-found.jsp`.
5. Mensajes internacionalizados para:
   - `reservations.list.title`
   - `reservations.detail`
   - `error.reservationNotFound.title`
   - `error.reservationNotFound.message`
6. Enlaces para cambiar idioma.
7. Soporte para tema claro/oscuro en la vista.

No hace falta crear persistencia con MySQL.

---

<details>
<summary>mostrar solución</summary>

## Excepción `ReservationNotFoundException.java`

```java
package com.example.events.exception;

public class ReservationNotFoundException extends RuntimeException {

    private final Long reservationId;

    public ReservationNotFoundException(Long reservationId) {
        super("No se ha encontrado ninguna reserva con id " + reservationId);
        this.reservationId = reservationId;
    }

    public Long getReservationId() {
        return reservationId;
    }
}
```

## Método en `ReservationService`

```java
public Reservation findByIdOrThrow(Long id) {
    Reservation reservation = findById(id);

    if (reservation == null) {
        throw new ReservationNotFoundException(id);
    }

    return reservation;
}
```

## Manejador en `GlobalExceptionHandler`

```java
@ExceptionHandler(ReservationNotFoundException.class)
public String handleReservationNotFound(
        ReservationNotFoundException exception,
        Model model) {

    model.addAttribute("pageTitleCode", "error.reservationNotFound.title");
    model.addAttribute("reservationId", exception.getReservationId());

    return "error/reservation-not-found";
}
```

## Mensajes en `messages_es.properties`

```properties
reservations.list.title=Listado de reservas
reservations.detail=Ver detalle
error.reservationNotFound.title=Reserva no encontrada
error.reservationNotFound.message=No se ha encontrado ninguna reserva con el identificador {0}.
```

## Mensajes en `messages_en.properties`

```properties
reservations.list.title=Reservation list
reservations.detail=View detail
error.reservationNotFound.title=Reservation not found
error.reservationNotFound.message=No reservation was found with id {0}.
```

## Vista `reservation-not-found.jsp`

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <title><spring:message code="error.reservationNotFound.title" /></title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">

    <c:if test="${currentTheme == 'dark'}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
    </c:if>
</head>
<body>

<header class="header">
    <nav class="nav">
        <a href="${pageContext.request.contextPath}/home">
            <spring:message code="nav.home" />
        </a>

        <a href="${pageContext.request.contextPath}/reservations">
            <spring:message code="reservations.list.title" />
        </a>
    </nav>

    <div class="toolbar">
        <a href="${pageContext.request.contextPath}/home?lang=es">
            <spring:message code="language.spanish" />
        </a>

        <a href="${pageContext.request.contextPath}/home?lang=en">
            <spring:message code="language.english" />
        </a>

        <a href="${pageContext.request.contextPath}/theme/change?theme=light">
            <spring:message code="theme.light" />
        </a>

        <a href="${pageContext.request.contextPath}/theme/change?theme=dark">
            <spring:message code="theme.dark" />
        </a>
    </div>
</header>

<main class="container">
    <section class="card">
        <h1>
            <spring:message code="error.reservationNotFound.title" />
        </h1>

        <p class="message">
            <spring:message code="error.reservationNotFound.message"
                            arguments="${reservationId}" />
        </p>

        <p>
            <a class="button" href="${pageContext.request.contextPath}/reservations">
                <spring:message code="reservations.list.title" />
            </a>
        </p>
    </section>
</main>

</body>
</html>
```

### Explicación

Este reto reúne los tres grandes bloques del tema:

```text
Excepciones
Internacionalización
Tema visual
```

La excepción permite separar el error del controlador.

Los mensajes permiten cambiar el idioma de la interfaz.

La sesión permite guardar el tema elegido por el usuario.

</details>
