# **Complete Spring MVC Course from Scratch**

Welcome to the **Complete Spring MVC Course**, a course designed to teach you how to create Java web applications step by step using **Spring MVC**, **JSP**, **Tomcat**, **Maven**, **IntelliJ**, **MySQL** and **DBeaver**.

This course is designed for students who already have a foundation in Java and want to understand how a traditional web application works with Spring MVC: from the initial configuration to controllers, views, forms, validation, database connection, error handling, internationalization and small maintenance improvements.

---

## 📌 **What will you learn in this course?**

🔹 The basic architecture of a web application with Spring MVC.<br>
🔹 The role of `DispatcherServlet`, `web.xml` and the XML configuration.<br>
🔹 How to deploy an application to Tomcat.<br>
🔹 How to create controllers with annotations like `@Controller`, `@GetMapping` and `@RequestMapping`.<br>
🔹 How to send data from the controller to the views using `Model`.<br>
🔹 How to create protected JSP views inside `WEB-INF`.<br>
🔹 How to process forms with `@ModelAttribute`.<br>
🔹 How to validate data with `@Valid`, `BindingResult` and Jakarta Bean Validation.<br>
🔹 How to connect the application to MySQL using DBeaver, JDBC and `JdbcTemplate`.<br>
🔹 How to organize data access with a DAO layer.<br>
🔹 How to handle exceptions with `@ControllerAdvice` and `@ExceptionHandler`.<br>
🔹 How to create custom error pages.<br>
🔹 How to internationalize an application with `messages.properties` files.<br>
🔹 How to change the application's language with `LocaleResolver` and `LocaleChangeInterceptor`.<br>
🔹 How to add light/dark visual themes using CSS and the session.<br>
🔹 How to improve the project with Lombok, `.properties` files, JSP fragments and global attributes.<br>

This course is organized into **practical topics**, with step-by-step explanations, commented code and solved exercises to reinforce what you've learned.

---

## 📂 **Course structure**

Each topic is in a **Markdown (`.md`)** file in this repository. You can explore the topics in the corresponding folder:

| 📚 Topic | Description |
| ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 🚀 [Topic 1: Introduction](Temas/Tema-01-Introducción.md) | Architecture of a web application with Spring MVC, project structure, `web.xml`, `DispatcherServlet`, XML configuration and a first JSP view.      |
| 🐱‍🏍 [Topic 1B: Tomcat Appendix](Temas/Tema-01b-Anexo-Tomcat.md) | Installing, configuring and using Tomcat to deploy the application, especially if you work with IntelliJ Community.                            |
| 🎛️ [Topic 2: Views and Controllers](Temas/Tema-02-Vistas-y-Controladores.md) | Creating controllers with annotations, routes, services, models, JSP views, `Model`, `@RequestParam` and JSTL.                                      |
| 📝 [Topic 3: Forms](Temas/Tema-03-Formularios.md) | Form processing with `@ModelAttribute`, validation with `@Valid`, using `BindingResult`, `<form:...>` tags and the Post-Redirect-Get pattern. |
| 🗄️ [Topic 4: MySQL](Temas/Tema-04-MySQL.md) | Data persistence using MySQL, DBeaver, `DataSource`, `JdbcTemplate`, DAO, SQL queries and retrieving generated keys.                       |
| 🌍 [Topic 5: Exceptions and Internationalization](Temas/Tema-05-Excepciones-y-Internacionalización.md) | Global error handling, custom exceptions, 404/500 pages, internationalization, language switching and visual themes.                        |
| 🛠️ [Topic 6: Improvements](Temas/Tema-06-Mejoras.md) | Simple improvements to clean up the project: Lombok, `database.properties`, reusable JSP fragments and global attributes.                           |

📌 **To see all the available topics, check the [`Temas`](Temas) folder.**

You can also find solved exercises in the [`Ejercicios`](Ejercicios) folder, if the repository includes practical materials.

---

## 🧭 **Recommended order to follow the course**

We recommend following the topics in this order:

1. **Topic 1: Introduction**  
   To understand the base architecture of Spring MVC and the project structure.

2. **Topic 1B: Tomcat Appendix**  
   To prepare the runtime environment and learn how to deploy the project.

3. **Topic 2: Views and Controllers**  
   To start creating routes, controllers, models, services and views.

4. **Topic 3: Forms**  
   To learn how to receive user data, validate it and process it correctly.

5. **Topic 4: MySQL**  
   To replace in-memory data with persistent data in a database.

6. **Topic 5: Exceptions and Internationalization**  
   To make the application more robust, usable and ready for multiple languages.

7. **Topic 6: Improvements**  
   To clean up the code and apply some simple maintenance best practices.

---

## 🛠️ **Technologies used**

During the course we will work with:

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

## ✅ **Prerequisites**

This course doesn't start from absolute zero in programming. Before you begin, it's a good idea to have:

- Basic knowledge of **Java**.
- Know how to create classes, attributes, methods, constructors, getters and setters.
- Know basic concepts of object-oriented programming.
- Know how to use basic HTML.
- Know in general terms what a web application is.
- Have a compatible JDK installed.
- Have Maven installed or use Maven from IntelliJ.
- Have Tomcat installed to deploy the application.
- Have MySQL and DBeaver if you're going to do the database topic.

You don't need any previous experience with Spring MVC, as the course explains the structure step by step.

---

## 💻 **Recommended tools**

To follow the course, we recommend using:

- **IntelliJ IDEA** as your IDE.
- **Apache Tomcat** as the server.
- **MySQL** as the database.
- **DBeaver** to manage the database.
- **Git and GitHub** to save your project's progress.
- An up-to-date browser such as Chrome, Edge or Firefox.

---

## 📌 **How to use this repository**

You can follow the course directly from this page or download the code from GitHub to your computer.

This repository is split into branches, step by step.

1️⃣ **Clone the repository** on your local machine:

```bash
git clone https://github.com/Amaza-ing/AMazaing-Spring-MVC
```

2️⃣ **Open the project in IntelliJ**.

3️⃣ **Check the `Temas` folder** and follow the `.md` files in order.

4️⃣ **Create the Spring MVC project step by step** following the explanations.

5️⃣ **Run the application with Tomcat**.

6️⃣ **Do the exercises** for each topic to practice.

7️⃣ **Check the solutions** only after trying to solve the exercises on your own.

---

## 🧪 **Exercises**

The course is designed to combine theory and practice.

Each theory block can come with exercises on:

- Creating XML configurations.
- Creating controllers.
- Creating JSP views.
- Sending data with `Model`.
- Creating models and services.
- Processing forms.
- Validating data.
- Connecting to MySQL.
- Creating DAOs.
- Handling errors.
- Internationalizing views.
- Applying improvements to the project.

The solved exercises are meant as support, but we recommend trying to solve them first without looking at the solution.

---

## 📚 **What you should know when you finish**

By the end of the course you should be able to:

- Explain what Spring MVC is and how its basic architecture works.
- Configure a Java web application with `web.xml` and `DispatcherServlet`.
- Create controllers with annotations.
- Create JSP views within `WEB-INF`.
- Send data to views using `Model`.
- Process forms with Spring MVC.
- Validate data with Jakarta Bean Validation.
- Redirect correctly after a `POST`.
- Connect an application to MySQL.
- Use `JdbcTemplate` to run SQL queries.
- Organize data access through DAOs.
- Create custom exceptions.
- Manage errors globally.
- Internationalize an application.
- Change the language from the interface.
- Apply a light or dark visual theme.
- Improve project maintenance with Lombok, JSP fragments and `.properties` files.

---

## 🧩 **Recommendations for studying**

To make the most of the course:

- Do not copy the code without understanding it.
- Run the project after each important block.
- When an error appears, read the stack trace calmly.
- Check paths, view names and package names.
- Check that the dependencies are in the `pom.xml`.
- Practice creating similar examples, not identical ones.
- Use DBeaver to check what is really happening in the database.
- Check the solved exercises only after trying them yourself.

---

## 🚀 **Start learning Spring MVC!**

This course is designed so that you can learn Spring MVC **step by step**, understanding each file, each class and each configuration.

Spring MVC may seem complex at first because it combines many pieces:

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

But if you go topic by topic, you will see that each part has a clear responsibility within the application.

---

## Made by Adrián Maza.

I hope this course helps you understand Spring MVC in a clear, practical and orderly way.

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
