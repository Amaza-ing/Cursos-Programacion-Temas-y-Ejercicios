# **Curso Completo de Spring MVC desde Cero**

Bienvenido al **Curso Completo de Spring MVC**, un curso diseñado para aprender a crear aplicaciones web Java paso a paso usando **Spring MVC**, **JSP**, **Tomcat**, **Maven**, **IntelliJ**, **MySQL** y **DBeaver**.

Este curso está pensado para alumnos que ya tienen una base de Java y quieren entender cómo funciona una aplicación web tradicional con Spring MVC: desde la configuración inicial hasta los controladores, vistas, formularios, validación, conexión con base de datos, gestión de errores, internacionalización y pequeñas mejoras de mantenimiento.

---

## 📌 **¿Qué aprenderás en este curso?**

🔹 La arquitectura básica de una aplicación web con Spring MVC.<br>
🔹 El papel de `DispatcherServlet`, `web.xml` y la configuración XML.<br>
🔹 Cómo desplegar una aplicación en Tomcat.<br>
🔹 Cómo crear controladores con anotaciones como `@Controller`, `@GetMapping` y `@RequestMapping`.<br>
🔹 Cómo enviar datos desde el controlador a las vistas usando `Model`.<br>
🔹 Cómo crear vistas JSP protegidas dentro de `WEB-INF`.<br>
🔹 Cómo procesar formularios con `@ModelAttribute`.<br>
🔹 Cómo validar datos con `@Valid`, `BindingResult` y Jakarta Bean Validation.<br>
🔹 Cómo conectar la aplicación con MySQL usando DBeaver, JDBC y `JdbcTemplate`.<br>
🔹 Cómo organizar el acceso a datos mediante una capa DAO.<br>
🔹 Cómo gestionar excepciones con `@ControllerAdvice` y `@ExceptionHandler`.<br>
🔹 Cómo crear páginas de error personalizadas.<br>
🔹 Cómo internacionalizar una aplicación con archivos `messages.properties`.<br>
🔹 Cómo cambiar el idioma de la aplicación con `LocaleResolver` y `LocaleChangeInterceptor`.<br>
🔹 Cómo añadir temas visuales claro/oscuro mediante CSS y sesión.<br>
🔹 Cómo mejorar el proyecto con Lombok, archivos `.properties`, fragmentos JSP y atributos globales.<br>

Este curso está estructurado en **temas prácticos**, con explicaciones paso a paso, código comentado y ejercicios resueltos para reforzar lo aprendido.

---

## 📂 **Estructura del curso**

Cada tema está en un archivo **Markdown (`.md`)** dentro de este repositorio. Puedes explorar los temas en la carpeta correspondiente:

| 📚 Tema                                                                                              | Descripción                                                                                                                                             |
| ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 🚀 [Tema 1: Introducción](Temas/Tema-01-Introducción.md)                                             | Arquitectura de una aplicación web con Spring MVC, estructura del proyecto, `web.xml`, `DispatcherServlet`, configuración XML y primera vista JSP.      |
| 🐱‍🏍 [Tema 1B: Anexo Tomcat](Temas/Tema-01b-Anexo-Tomcat.md)                                        | Instalación, configuración y uso de Tomcat para desplegar la aplicación, especialmente si se trabaja con IntelliJ Community.                            |
| 🎛️ [Tema 2: Vistas y Controladores](Temas/Tema-02-Vistas-y-Controladores.md)                         | Creación de controladores con anotaciones, rutas, servicios, modelos, vistas JSP, `Model`, `@RequestParam` y JSTL.                                      |
| 📝 [Tema 3: Formularios](Temas/Tema-03-Formularios.md)                                               | Procesamiento de formularios con `@ModelAttribute`, validación con `@Valid`, uso de `BindingResult`, etiquetas `<form:...>` y patrón Post-Redirect-Get. |
| 🗄️ [Tema 4: MySQL](Temas/Tema-04-MySQL.md)                                                           | Persistencia de datos usando MySQL, DBeaver, `DataSource`, `JdbcTemplate`, DAO, consultas SQL y recuperación de claves generadas.                       |
| 🌍 [Tema 5: Excepciones e Internacionalización](Temas/Tema-05-Excepciones-y-Internacionalización.md) | Gestión global de errores, excepciones personalizadas, páginas 404/500, internacionalización, cambio de idioma y temas visuales.                        |
| 🛠️ [Tema 6: Mejoras](Temas/Tema-06-Mejoras.md)                                                       | Mejoras sencillas para limpiar el proyecto: Lombok, `database.properties`, fragmentos JSP reutilizables y atributos globales.                           |

📌 **Para ver todos los temas disponibles, revisa la carpeta [`Temas`](Temas).**

También puedes encontrar ejercicios resueltos en la carpeta de [`Ejercicios`](Ejercicios), si el repositorio incluye materiales prácticos.

---

## 🧭 **Orden recomendado para seguir el curso**

Se recomienda seguir los temas en este orden:

1. **Tema 1: Introducción**  
   Para entender la arquitectura base de Spring MVC y la estructura del proyecto.

2. **Tema 1B: Anexo Tomcat**  
   Para preparar el entorno de ejecución y saber cómo desplegar el proyecto.

3. **Tema 2: Vistas y Controladores**  
   Para empezar a crear rutas, controladores, modelos, servicios y vistas.

4. **Tema 3: Formularios**  
   Para aprender a recibir datos del usuario, validarlos y procesarlos correctamente.

5. **Tema 4: MySQL**  
   Para sustituir los datos en memoria por datos persistentes en una base de datos.

6. **Tema 5: Excepciones e Internacionalización**  
   Para hacer la aplicación más robusta, usable y preparada para varios idiomas.

7. **Tema 6: Mejoras**  
   Para limpiar el código y aplicar buenas prácticas sencillas de mantenimiento.

---

## 🛠️ **Tecnologías utilizadas**

Durante el curso trabajaremos con:

- **Java**
- **Spring MVC**
- **Maven**
- **JSP**
- **JSTL**
- **Jakarta Servlet**
- **Jakarta Bean Validation**
- **Hibernate Validator**
- **Tomcat**
- **IntelliJ IDEA**
- **MySQL**
- **DBeaver**
- **Spring JDBC**
- **JdbcTemplate**
- **Lombok**
- **HTML**
- **CSS**

---

## ✅ **Requisitos previos**

Este curso no parte desde cero absoluto en programación. Es recomendable tener:

- Conocimientos básicos de **Java**.
- Saber crear clases, atributos, métodos, constructores, getters y setters.
- Conocer conceptos básicos de programación orientada a objetos.
- Saber usar HTML básico.
- Conocer de forma general qué es una aplicación web.
- Tener instalado un JDK compatible.
- Tener instalado Maven o usar Maven desde IntelliJ.
- Tener instalado Tomcat para desplegar la aplicación.
- Tener MySQL y DBeaver si se va a realizar el tema de base de datos.

No es necesario tener experiencia previa con Spring MVC, ya que el curso explica la estructura paso a paso.

---

## 💻 **Herramientas recomendadas**

Para seguir el curso se recomienda usar:

- **IntelliJ IDEA** como IDE.
- **Apache Tomcat** como servidor.
- **MySQL** como base de datos.
- **DBeaver** para gestionar la base de datos.
- **Git y GitHub** para guardar el progreso del proyecto.
- Un navegador actualizado como Chrome, Edge o Firefox.

---

## 📌 **Cómo usar este repositorio**

Puedes seguir el curso directamente desde GitHub o descargarlo en tu ordenador.

1️⃣ **Clona el repositorio** en tu máquina local:

```bash
git clone URL_DEL_REPOSITORIO
```

2️⃣ **Abre el proyecto en IntelliJ**.

3️⃣ **Revisa la carpeta `Temas`** y sigue los archivos `.md` en orden.

4️⃣ **Crea el proyecto Spring MVC paso a paso** siguiendo las explicaciones.

5️⃣ **Ejecuta la aplicación con Tomcat**.

6️⃣ **Realiza los ejercicios** de cada tema para practicar.

7️⃣ **Consulta las soluciones** solo después de intentar resolver los ejercicios por tu cuenta.

---

## 🧪 **Ejercicios**

El curso está pensado para combinar teoría y práctica.

Cada bloque de teoría puede acompañarse de ejercicios sobre:

- Crear configuraciones XML.
- Crear controladores.
- Crear vistas JSP.
- Enviar datos con `Model`.
- Crear modelos y servicios.
- Procesar formularios.
- Validar datos.
- Conectar con MySQL.
- Crear DAOs.
- Gestionar errores.
- Internacionalizar vistas.
- Aplicar mejoras al proyecto.

Los ejercicios resueltos están pensados para consultarse como apoyo, pero es recomendable intentar resolverlos primero sin mirar la solución.

---

## 📚 **Qué deberías saber al terminar**

Al finalizar el curso deberías ser capaz de:

- Explicar qué es Spring MVC y cómo funciona su arquitectura básica.
- Configurar una aplicación web Java con `web.xml` y `DispatcherServlet`.
- Crear controladores con anotaciones.
- Crear vistas JSP dentro de `WEB-INF`.
- Enviar datos a las vistas usando `Model`.
- Procesar formularios con Spring MVC.
- Validar datos con Jakarta Bean Validation.
- Redirigir correctamente después de un `POST`.
- Conectar una aplicación con MySQL.
- Usar `JdbcTemplate` para ejecutar consultas SQL.
- Organizar el acceso a datos mediante DAOs.
- Crear excepciones personalizadas.
- Gestionar errores de forma global.
- Internacionalizar una aplicación.
- Cambiar el idioma desde la interfaz.
- Aplicar un tema visual claro u oscuro.
- Mejorar el mantenimiento del proyecto con Lombok, fragmentos JSP y archivos `.properties`.

---

## 🧩 **Recomendaciones para estudiar**

Para aprovechar mejor el curso:

- No copies el código sin entenderlo.
- Ejecuta el proyecto después de cada bloque importante.
- Cuando aparezca un error, lee con calma la traza.
- Comprueba rutas, nombres de vistas y nombres de paquetes.
- Revisa que las dependencias estén en el `pom.xml`.
- Practica creando ejemplos parecidos, no idénticos.
- Usa DBeaver para comprobar qué ocurre realmente en la base de datos.
- Consulta los ejercicios resueltos solo después de intentarlo.

---

## 🚀 **¡Empieza a aprender Spring MVC!**

Este curso está diseñado para que puedas aprender Spring MVC **paso a paso**, entendiendo cada archivo, cada clase y cada configuración.

Spring MVC puede parecer complejo al principio porque combina muchas piezas:

```text
Servlets
XML
Controladores
Vistas
Modelos
Servicios
Formularios
Validación
Base de datos
Errores
Internacionalización
```

Pero si avanzas tema a tema, verás que cada parte tiene una responsabilidad clara dentro de la aplicación.

---

## Hecho por Adrián Maza.

Espero que este curso te ayude a entender Spring MVC de forma clara, práctica y ordenada.

<div>
  <h5>
    <a href="https://www.youtube.com/@AMaza-Ing" target="_blank">
      YouTube/AMaza-ing
    </a>
  </h5>
  <h5>
    <a
      href="https://www.linkedin.com/in/adrian-maza-vazquez/"
      target="_blank"
    >
      LinkedIn/Adrián-Maza
    </a>
  </h5>
  <h5>
    <a href="https://www.amaza-ing.com/" target="_blank">
      AMazaing Web
    </a>
  </h5>
  <h5>
    <a href="https://github.com/Amaza-ing" target="_blank">
      GitHub/AMaza-ing
    </a>
  </h5>
</div>
