# Solved exercises — Topic 5: Exceptions, internationalization and visual themes in Spring MVC

## Introduction

In these exercises you will practice the contents of the topic dedicated to:

- Exception management in Spring MVC.
- Creation of custom exceptions.
- Use of `@ControllerAdvice`.
- Use of `@ExceptionHandler`.
- Creation of custom error pages.
- Configuration of 404 and 500 pages.
- Internationalization with `messages` files.
- Use of `MessageSource`.
- Language change with `LocaleResolver` and `LocaleChangeInterceptor`.
- Use of `<spring:message>` in JSP.
- Internationalization of validation messages.
- Light/dark visual theme change via session and CSS.

The exercises are similar to those in the course, but use a different application: a small **events** management application.

Each solution is hidden under the **show solution** button.

---

# Exercise 1 — Create a custom exception

## Statement

Create a custom exception called `EventNotFoundException`.

It should be in the package:

```text
com.example.events.exception
```

The exception must:

1. Extend `RuntimeException`.
2. Save the event identifier that was not found.
3. Have a constructor that receives `Long eventId`.
4. Have a getter for `eventId`.

---

<details>
<summary>show solution</summary>

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

### Explanation

This exception represents a specific error in the application:

```text
El usuario ha pedido un evento que no existe.
```

We extend from:

```java
RuntimeException
```

because we don't want to force capturing it with `try-catch` in all methods.

We save the identifier:

```java
private final Long eventId;
```

to be able to display it later on an error page.

</details>

---

# Exercise 2 — Throw an exception from the service

## Statement

You have this event service:

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

Add a method called:

```java
findByIdOrThrow(Long id)
```

This method should return the event if it exists. If it does not exist, you must cast `EventNotFoundException`.

---

<details>
<summary>show solution</summary>

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

### Explanation

The method:

```java
findByIdOrThrow(Long id)
```

has a clear intention:

```text
Busca un evento.
Si existe, lo devuelve.
Si no existe, lanza una excepción.
```

This way we avoid repeating this check on all controllers:

```java
if (event == null) {
    ...
}
```

The logic remains centralized in the service.

</details>

---

# Exercise 3 — Simplify the handler using the exception

## Statement

You have this method in `EventController`:

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

Modify it to use:

```java
eventService.findByIdOrThrow(id)
```

The method no longer needs to manually check if the event is `null`.

---

<details>
<summary>show solution</summary>

```java
@GetMapping("/detail")
public String eventDetail(@RequestParam("id") Long id, Model model) {
    Event event = eventService.findByIdOrThrow(id);

    model.addAttribute("pageTitle", event.getTitle());
    model.addAttribute("event", event);

    return "events/detail";
}
```

### Explanation

Before the controller did two things:

```text
1. Buscaba el evento.
2. Decidía qué hacer si no existía.
```

Now the driver only handles the correct case:

```text
Si el evento existe, prepara la vista de detalle.
```

If the event does not exist, the service throws:

```java
EventNotFoundException
```

and that exception will be handled in a global class.

</details>

---

# Exercise 4 — Create a global exception handler

## Statement

Create a class called `GlobalExceptionHandler` in the package:

```text
com.example.events.exception
```

You must:

1. Be registered with `@ControllerAdvice`.
2. Have a method to capture `EventNotFoundException`.
3. Add to model:
   - `pageTitle`
   - `eventId`
   - `errorMessage`
4. Return the view:
```text
error/event-not-found
```

---

<details>
<summary>show solution</summary>

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

### Explanation

The annotation:

```java
@ControllerAdvice
```

allows you to define common logic for several controllers.

The annotation:

```java
@ExceptionHandler(EventNotFoundException.class)
```

indicates that this method will be executed when an exception of type `EventNotFoundException` is thrown.

The returned view:

```java
return "error/event-not-found";
```

will become:

```text
/WEB-INF/views/error/event-not-found.jsp
```

</details>

---

# Exercise 5 — Create the `event-not-found.jsp` view

## Statement

Create the view:

```text
src/main/webapp/WEB-INF/views/error/event-not-found.jsp
```

The view should show:

1. The title received in `${pageTitle}`.
2. The event identifier received in `${eventId}`.
3. The error message received in `${errorMessage}`.
4. A link to return to the list of events.

---

<details>
<summary>show solution</summary>

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

### Explanation

This view is not returned directly by `EventController`.

Returned by the global handler:

```java
GlobalExceptionHandler
```

when capture:

```java
EventNotFoundException
```

This allows the normal controller logic to be separated from the error logic.

</details>

---

# Exercise 6 — Add a general error handler

## Statement

Extends `GlobalExceptionHandler` to catch any unforeseen exceptions.

You must capture:

```java
Exception.class
```

The method must:

1. Add `pageTitle` with the value `Error inesperado`.
2. Add `errorMessage` with the exception message.
3. Return the view:

```text
error/general-error
```

---

<details>
<summary>show solution</summary>

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

### Explanation

The method:

```java
@ExceptionHandler(Exception.class)
```

It works as a safety net.

Catch errors that do not have a more specific handler.

It is not a substitute for good error handling, but it prevents the user from seeing a technical page from the server.

</details>

---

# Exercise 7 — Create the general error view

## Statement

Create the view:

```text
src/main/webapp/WEB-INF/views/error/general-error.jsp
```

Must show:

1. The title received in `${pageTitle}`.
2. A message indicating that an unexpected error has occurred.
3. The technical message received in `${errorMessage}`.
4. A link to return to the beginning.

---

<details>
<summary>show solution</summary>

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

### Explanation

This view is used when an unforeseen exception occurs.

In a real application, it is not always convenient to show the technical message to the end user. For a course, it can be useful to understand what is happening.

</details>

---

# Exercise 8 — Configure pages 404 and 500 in `web.xml`

## Statement

Modify `web.xml` so that:

1. 404 errors redirect to `/error/404`.
2. 500 errors redirect to `/error/500`.

Write only the necessary XML block.

---

<details>
<summary>show solution</summary>

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

### Explanation

The 404 error occurs when the user tries to access a URL that does not exist.

For example:

```text
/pagina-inventada
```

Error 500 occurs when there is an internal error on the server.

With this configuration, the server redirects those errors to routes controlled by Spring MVC.

</details>

---

# Exercise 9 — Create `ErrorPageController`

## Statement

Create a handler named `ErrorPageController` in the package:

```text
com.example.events.controller
```

You should have two methods:

```text
GET /error/404
GET /error/500
```

The first method should return the view:

```text
error/not-found
```

The second should return:

```text
error/general-error
```

---

<details>
<summary>show solution</summary>

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

### Explanation

When the server detects a 404, it sends the user to:

```text
/error/404
```

Spring executes this method:

```java
@GetMapping("/error/404")
```

and displays a custom JSP.

</details>

---

# Exercise 10 — Create custom 404 view

## Statement

Create the view:

```text
src/main/webapp/WEB-INF/views/error/not-found.jsp
```

Must show:

1. The title received in `${pageTitle}`.
2. A message indicating that the page does not exist.
3. A link to return to the beginning.

---

<details>
<summary>show solution</summary>

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

### Explanation

This view is displayed when the user enters a URL that does not exist.

It's nicer than showing the default Tomcat error page.

</details>

---

# Exercise 11 — Configure internationalization in `app-servlet.xml`

## Statement

Modify `app-servlet.xml` to add internationalization.

You must configure:

1. An `messageSource`.
2. An `SessionLocaleResolver` with Spanish as the default language.
3. An `LocaleChangeInterceptor` that changes the language using the `lang` parameter.

---

<details>
<summary>show solution</summary>

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

### Explanation

The bean:

```xml
messageSource
```

allows Spring to search for texts in files like:

```text
messages_es.properties
messages_en.properties
```

The bean:

```xml
localeResolver
```

saves the active language of the user in session.

The interceptor:

```xml
LocaleChangeInterceptor
```

detects URLs like:

```text
/home?lang=en
```

and change the active language.

</details>

---

# Exercise 12 — Create message files

## Statement

Create these files in:

```text
src/main/resources
```

```text
messages.properties
messages_es.properties
messages_en.properties
```

They must include messages to:

- Navigation.
- Home page.
- List of events.
- Errors.

Create at least five keys.

---

<details>
<summary>show solution</summary>

##`messages.properties`

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

##`messages_es.properties`

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

##`messages_en.properties`

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

### Explanation

The keys must be named the same in all files.

What changes is the value.

For example:

```properties
nav.home=Inicio
```

in Spanish and:

```properties
nav.home=Home
```

in English.

</details>

---

# Exercise 13 — Use `<spring:message>` in a JSP

## Statement

Modifies an `home.jsp` view so that it does not have the texts written directly.

You must use:

```jsp
<spring:message code="..." />
```

The page should display:

1. The title `home.title`.
2. The message `home.message`.
3. A link to events using `nav.events`.
4. Links to change language to Spanish and English.

---

<details>
<summary>show solution</summary>

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

### Explanation

To use Spring tags in JSP we need:

```jsp
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
```

Then we can display messages like this:

```jsp
<spring:message code="home.title" />
```

Spring will look for that key in the file corresponding to the active language.

</details>

---

# Exercise 14 — Internationalize the list of events

## Statement

You have this table in `events/list.jsp`:

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

Create the necessary keys in the message files and modify the JSP to use `<spring:message>`.

---

<details>
<summary>show solution</summary>

## Keys in `messages_es.properties`

```properties
events.title=Título
events.city=Ciudad
events.date=Fecha
events.action=Acción
events.detail=Ver detalle
```

## Keys in `messages_en.properties`

```properties
events.title=Title
events.city=City
events.date=Date
events.action=Action
events.detail=View detail
```

## Modified JSP

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

### Explanation

Fixed texts disappear from view.

Now the view only has keys:

```jsp
<spring:message code="events.title" />
```

The actual text is obtained from the active language file.

</details>

---

# Exercise 15 — Get an internationalized message from the controller

## Statement

In a controller, after creating an event, we want to display an internationalized success message.

Create a key called:

```text
success.event.created
```

in Spanish and English.

Then modify the driver to get that message with `MessageSource` and send it as a flash attribute called `successMessage`.

---

<details>
<summary>show solution</summary>

##`messages_es.properties`

```properties
success.event.created=El evento se ha creado correctamente.
```

##`messages_en.properties`

```properties
success.event.created=The event has been created successfully.
```

## Controller

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

### Explanation

First we inject:

```java
MessageSource
```

Then we get the current language:

```java
Locale locale = LocaleContextHolder.getLocale();
```

Then we look for the message:

```java
messageSource.getMessage("success.event.created", null, locale)
```

Thus the message changes according to the user's active language.

</details>

---

# Exercise 16 — Internationalize validation messages

## Statement

You have this model:

```java
public class Event {

    @NotBlank(message = "El título es obligatorio.")
    private String title;

    @NotBlank(message = "La ciudad es obligatoria.")
    private String city;
}
```

Modify it so that messages come out of `messages` files.

Also create the keys in Spanish and English.

---

<details>
<summary>show solution</summary>

## Model `Event.java`

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

##`messages_es.properties`

```properties
event.title.notBlank=El título es obligatorio.
event.city.notBlank=La ciudad es obligatoria.
```

##`messages_en.properties`

```properties
event.title.notBlank=The title is required.
event.city.notBlank=The city is required.
```

### Explanation

Instead of typing the message directly:

```java
@NotBlank(message = "El título es obligatorio.")
```

we use a key:

```java
@NotBlank(message = "{event.title.notBlank}")
```

Spring will look for that key in the corresponding message file.

</details>

---

# Exercise 17 — Create a controller to change the visual theme

## Statement

Create a driver called `ThemeController`.

It should be in the package:

```text
com.example.events.controller
```

You must respond to:

```text
/theme/change?theme=dark
/theme/change?theme=light
```

The controller must:

1. Read the `theme` parameter.
2. Save the topic in session.
3. If the topic is not `dark`, use `light`.
4. Redirect to `/home`.

---

<details>
<summary>show solution</summary>

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

### Explanation

The parameter is received with:

```java
@RequestParam(defaultValue = "light") String theme
```

If the user enters:

```text
/theme/change?theme=dark
```

the value will be:

```text
dark
```

We save the topic in session:

```java
session.setAttribute("theme", theme);
```

Thus the choice is maintained for the duration of the user's session.

</details>

---

# Exercise 18 — Load dark CSS only if the theme is `dark`

## Statement

Modify a JSP so that:

1. Always load `styles.css`.
2. Read the topic from `sessionScope.theme`.
3. If the topic is `dark`, also upload `styles-dark.css`.

Use JSTL.

---

<details>
<summary>show solution</summary>

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">

<c:if test="${currentTheme == 'dark'}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles-dark.css">
</c:if>
```

### Explanation

First we calculate the current topic:

```jsp
<c:set var="currentTheme" value="${empty sessionScope.theme ? 'light' : sessionScope.theme}" />
```

If there is no topic in session, we use:

```text
light
```

Then we always load the main CSS:

```jsp
styles.css
```

And only if the theme is dark do we load:

```jsp
styles-dark.css
```

The second file overwrites some styles from the first.

</details>

---

# Exercise 19 — Create `styles-dark.css`
## Statement

Create a file:

```text
src/main/webapp/resources/css/styles-dark.css
```

You should change the main colors of the app to a dark theme.

Includes styles for:

- `body`
- `.header`
- `.card`
- `h1`
-`.table`
- `.input`
- `.button`
- `.error`

---

<details>
<summary>show solution</summary>

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

### Explanation

This file does not replace `styles.css`.

It loads afterwards, only if the user has chosen the dark theme.

That's why you can overwrite colors without repeating the entire design.

</details>

---

# Exercise 20 — Add language and theme links to the menu

## Statement

Modify the header of a JSP to include:

1. Link to home.
2. Link to events.
3. Language change to Spanish.
4. Language change to English.
5. Change to light theme.
6. Switch to dark theme.

Use internationalized messages for texts.

---

<details>
<summary>show solution</summary>

## Required keys

```properties
nav.home=Inicio
nav.events=Eventos
language.spanish=Español
language.english=Inglés
theme.light=Tema claro
theme.dark=Tema oscuro
```

##JSP

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

### Explanation

The links:

```text
/home?lang=es
/home?lang=en
```

are detected by `LocaleChangeInterceptor`.

The links:

```text
/theme/change?theme=light
/theme/change?theme=dark
```

They are managed by `ThemeController`.

</details>

---

# Exercise 21 — Diagnose frequent errors

## Statement

Read each case and explain what the problem is.

## Case A

This exception is thrown:

```java
throw new EventNotFoundException(id);
```

but the handler has:

```java
@ExceptionHandler(NullPointerException.class)
```

Why isn't the expected error page displayed?

---

## Case B

In the JSP it is used:

```jsp
<spring:message code="events.list.title" />
```

but in `messages_es.properties` it appears:

```properties
event.list.title=Listado de eventos
```

What's happening?

---

## Case C

You enter:

```text
/home?lang=en
```

but the page is still in Spanish.

What might be missing from the setup?

---

## Case D

The user presses “Dark theme”, but when changing the page they return to the light theme.

What could be happening?

---

<details>
<summary>show solution</summary>

## Case A

The exception type does not match.

It is launched:

```java
EventNotFoundException
```

but the handler captures:

```java
NullPointerException
```

There must be a method with:

```java
@ExceptionHandler(EventNotFoundException.class)
```

---

## Case B

The key does not match.

The JSP seeks:

```text
events.list.title
```

but the file has:

```text
event.list.title
```

Spring will not find the expected key.

The solution is for both names to match exactly.

For example:

```properties
events.list.title=Listado de eventos
```

---

## Case C

The `LocaleChangeInterceptor` may be missing.

There should be something like this in `app-servlet.xml`:

```xml
<mvc:interceptors>
    <bean class="org.springframework.web.servlet.i18n.LocaleChangeInterceptor">
        <property name="paramName" value="lang" />
    </bean>
</mvc:interceptors>
```

An `localeResolver` must also exist.

---

## Case D

The topic may not be saving in session.

The controller must do:

```java
session.setAttribute("theme", theme);
```

And the JSPs should read:

```jsp
sessionScope.theme
```

If the theme is saved only as a model attribute, it will be lost when changing pages.

</details>

---

# Exercise 22 — Final challenge: add errors, language and theme to a reservations section

## Statement

Create a small reservations section using what you learned in Topic 5.

You must create:

1. An `ReservationNotFoundException` exception.
2. An `findByIdOrThrow` method on `ReservationService`.
3. A handler in `GlobalExceptionHandler`.
4. An `error/reservation-not-found.jsp` view.
5. Internationalized messages for:
   - `reservations.list.title`
   - `reservations.detail`
   - `error.reservationNotFound.title`
   - `error.reservationNotFound.message`
6. Links to change language.
7. Support for light/dark theme in view.

There is no need to create persistence with MySQL.

---

<details>
<summary>show solution</summary>

##`ReservationNotFoundException.java`Exception

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

## Method in `ReservationService`

```java
public Reservation findByIdOrThrow(Long id) {
    Reservation reservation = findById(id);

    if (reservation == null) {
        throw new ReservationNotFoundException(id);
    }

    return reservation;
}
```

## Handler in `GlobalExceptionHandler`

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

## Messages in `messages_es.properties`

```properties
reservations.list.title=Listado de reservas
reservations.detail=Ver detalle
error.reservationNotFound.title=Reserva no encontrada
error.reservationNotFound.message=No se ha encontrado ninguna reserva con el identificador {0}.
```

## Messages in `messages_en.properties`

```properties
reservations.list.title=Reservation list
reservations.detail=View detail
error.reservationNotFound.title=Reservation not found
error.reservationNotFound.message=No reservation was found with id {0}.
```

## View `reservation-not-found.jsp`

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

### Explanation

This challenge brings together the three main blocks of the topic:

```text
Excepciones
Internacionalización
Tema visual
```

The exception allows the error to be separated from the driver.

Messages allow you to change the interface language.

The session allows you to save the topic chosen by the user.

</details>
