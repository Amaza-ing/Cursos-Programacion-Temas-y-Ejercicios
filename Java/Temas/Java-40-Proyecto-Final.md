# Tema 40. Proyecto Final

## 1. Introducción

Llegamos al último tema del curso.

A lo largo del curso has aprendido muchas piezas importantes de Java:

- variables
- operadores
- condicionales
- bucles
- métodos
- arrays
- `ArrayList`
- clases y objetos
- encapsulación
- constructores
- métodos estáticos
- herencia
- polimorfismo
- packages
- clases abstractas
- interfaces
- `equals`
- excepciones
- enums
- `HashMap`
- otras colecciones
- `BigDecimal`
- generics
- lambdas
- interfaces funcionales
- `Stream API`
- `Optional`
- Date/Time API
- `Files` y `Path`
- records
- sealed classes
- concurrencia básica
- anotaciones
- Maven

Ahora vamos a unir muchos de esos conceptos en un proyecto final.

El objetivo no es hacer una aplicación enorme, sino crear un proyecto suficientemente completo para practicar Java moderno con una estructura parecida a la que podrías encontrar en un proyecto real.

---

## 2. Proyecto final: gestor de tareas por consola

Vamos a crear una aplicación de consola llamada:

```text
Task Manager
```

La aplicación permitirá gestionar tareas.

Cada tarea tendrá:

- id
- título
- descripción
- prioridad
- estado
- fecha límite
- fecha de creación

El usuario podrá:

- crear tareas
- listar tareas
- buscar tareas por id
- marcar tareas como completadas
- eliminar tareas
- filtrar tareas por estado
- guardar las tareas en un archivo
- cargar las tareas desde un archivo

---

## 3. Conceptos del curso que se van a practicar

En este proyecto usaremos:

- clases
- records
- enums
- interfaces
- sealed classes
- excepciones personalizadas
- `ArrayList`
- `HashMap`
- `Optional`
- `Stream API`
- `LocalDate`
- `LocalDateTime`
- `Files`
- `Path`
- `BigDecimal` de forma opcional
- Maven
- paquetes
- métodos estáticos
- encapsulación
- separación por responsabilidades

---

## 4. Resultado esperado

La aplicación mostrará un menú como este:

```text
==== Task Manager ====
1. Create task
2. List tasks
3. Find task by id
4. Complete task
5. Delete task
6. List tasks by status
7. Save tasks
8. Load tasks
0. Exit
Choose an option:
```

El usuario podrá interactuar desde la consola escribiendo números y textos.

---

## 5. Crear el proyecto Maven

La estructura del proyecto será:

```text
java-task-manager
├── pom.xml
└── src
    └── main
        └── java
            └── com
                └── amazaing
                    └── taskmanager
                        ├── Main.java
                        ├── app
                        │   └── TaskApplication.java
                        ├── exception
                        │   └── TaskNotFoundException.java
                        ├── model
                        │   ├── Priority.java
                        │   ├── Task.java
                        │   └── TaskStatus.java
                        ├── repository
                        │   ├── FileTaskRepository.java
                        │   └── TaskRepository.java
                        ├── result
                        │   ├── DeleteResult.java
                        │   ├── DeleteSuccess.java
                        │   └── DeleteError.java
                        ├── service
                        │   └── TaskService.java
                        └── util
                            ├── ConsoleReader.java
                            └── DateUtils.java
```

Esta estructura separa el código por responsabilidades.

---

## 6. Responsabilidades de cada paquete

### 6.1. `model`

Contiene las clases o records que representan datos principales del proyecto.

Ejemplo:

```text
Task
TaskStatus
Priority
```

### 6.2. `service`

Contiene la lógica de negocio.

Ejemplo:

```text
TaskService
```

### 6.3. `repository`

Contiene la lógica para guardar y cargar datos.

Ejemplo:

```text
TaskRepository
FileTaskRepository
```

### 6.4. `app`

Contiene la lógica de interacción de la aplicación.

Ejemplo:

```text
TaskApplication
```

### 6.5. `exception`

Contiene excepciones propias.

Ejemplo:

```text
TaskNotFoundException
```

### 6.6. `result`

Contiene sealed interfaces y records para representar resultados.

Ejemplo:

```text
DeleteResult
DeleteSuccess
DeleteError
```

### 6.7. `util`

Contiene clases de utilidad.

Ejemplo:

```text
ConsoleReader
DateUtils
```

---

## 7. `pom.xml`

Primero creamos el archivo `pom.xml`.

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             https://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.amazaing</groupId>
    <artifactId>java-task-manager</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>

    <properties>
        <maven.compiler.release>25</maven.compiler.release>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <configuration>
                    <archive>
                        <manifest>
                            <mainClass>com.amazaing.taskmanager.Main</mainClass>
                        </manifest>
                    </archive>
                </configuration>
            </plugin>
        </plugins>
    </build>

</project>
```

Este proyecto no necesita dependencias externas.

Usaremos solo Java estándar.

---

## 8. Modelo principal: `Task`

Vamos a representar una tarea con un `record`.

Ruta:

```text
src/main/java/com/amazaing/taskmanager/model/Task.java
```

Código:

```java
package com.amazaing.taskmanager.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public record Task(
        int id,
        String title,
        String description,
        Priority priority,
        TaskStatus status,
        LocalDate dueDate,
        LocalDateTime createdAt
) {
    public Task {
        if (id <= 0) {
            throw new IllegalArgumentException("Id must be positive");
        }

        if (title == null || title.isBlank()) {
            throw new IllegalArgumentException("Title cannot be blank");
        }

        if (description == null) {
            description = "";
        }

        if (priority == null) {
            priority = Priority.MEDIUM;
        }

        if (status == null) {
            status = TaskStatus.PENDING;
        }

        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
    }

    public boolean isOverdue() {
        return status != TaskStatus.COMPLETED
                && dueDate != null
                && dueDate.isBefore(LocalDate.now());
    }

    public Task complete() {
        return new Task(
                id,
                title,
                description,
                priority,
                TaskStatus.COMPLETED,
                dueDate,
                createdAt
        );
    }
}
```

---

## 9. Por qué usamos un record para `Task`

Usamos un record porque una tarea, en este diseño, se trata como un dato inmutable.

Si queremos modificar una tarea, no cambiamos la instancia original.

Creamos una nueva:

```java
Task completedTask = task.complete();
```

Esto reduce errores y hace el código más predecible.

---

## 10. Enum `Priority`

Ruta:

```text
src/main/java/com/amazaing/taskmanager/model/Priority.java
```

Código:

```java
package com.amazaing.taskmanager.model;

public enum Priority {
    LOW,
    MEDIUM,
    HIGH
}
```

Usamos un enum porque la prioridad solo puede tener un conjunto cerrado de valores.

---

## 11. Enum `TaskStatus`

Ruta:

```text
src/main/java/com/amazaing/taskmanager/model/TaskStatus.java
```

Código:

```java
package com.amazaing.taskmanager.model;

public enum TaskStatus {
    PENDING,
    IN_PROGRESS,
    COMPLETED
}
```

También usamos un enum para el estado de la tarea.

---

## 12. Excepción personalizada

Vamos a crear una excepción propia para cuando no se encuentra una tarea.

Ruta:

```text
src/main/java/com/amazaing/taskmanager/exception/TaskNotFoundException.java
```

Código:

```java
package com.amazaing.taskmanager.exception;

public class TaskNotFoundException extends RuntimeException {
    public TaskNotFoundException(int id) {
        super("Task not found with id: " + id);
    }
}
```

Usamos una excepción personalizada para que el error sea más expresivo.

---

## 13. Interfaz `TaskRepository`

El repositorio será responsable de guardar y cargar tareas.

Ruta:

```text
src/main/java/com/amazaing/taskmanager/repository/TaskRepository.java
```

Código:

```java
package com.amazaing.taskmanager.repository;

import com.amazaing.taskmanager.model.Task;

import java.util.List;

public interface TaskRepository {
    void save(List<Task> tasks);

    List<Task> load();
}
```

Esto permite que la aplicación no dependa directamente de cómo se guardan los datos.

---

## 14. Implementación con archivos: `FileTaskRepository`

Ruta:

```text
src/main/java/com/amazaing/taskmanager/repository/FileTaskRepository.java
```

Código:

```java
package com.amazaing.taskmanager.repository;

import com.amazaing.taskmanager.model.Priority;
import com.amazaing.taskmanager.model.Task;
import com.amazaing.taskmanager.model.TaskStatus;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class FileTaskRepository implements TaskRepository {
    private final Path filePath;

    public FileTaskRepository(Path filePath) {
        this.filePath = filePath;
    }

    @Override
    public void save(List<Task> tasks) {
        List<String> lines = new ArrayList<>();

        for (Task task : tasks) {
            lines.add(toLine(task));
        }

        try {
            Files.createDirectories(filePath.getParent());
            Files.write(filePath, lines);
        } catch (IOException e) {
            throw new RuntimeException("Could not save tasks", e);
        }
    }

    @Override
    public List<Task> load() {
        if (!Files.exists(filePath)) {
            return new ArrayList<>();
        }

        try {
            List<String> lines = Files.readAllLines(filePath);
            List<Task> tasks = new ArrayList<>();

            for (String line : lines) {
                if (!line.isBlank()) {
                    tasks.add(fromLine(line));
                }
            }

            return tasks;
        } catch (IOException e) {
            throw new RuntimeException("Could not load tasks", e);
        }
    }

    private String toLine(Task task) {
        String dueDateText = task.dueDate() == null ? "" : task.dueDate().toString();

        return task.id() + ";"
                + escape(task.title()) + ";"
                + escape(task.description()) + ";"
                + task.priority() + ";"
                + task.status() + ";"
                + dueDateText + ";"
                + task.createdAt();
    }

    private Task fromLine(String line) {
        String[] parts = line.split(";", -1);

        int id = Integer.parseInt(parts[0]);
        String title = unescape(parts[1]);
        String description = unescape(parts[2]);
        Priority priority = Priority.valueOf(parts[3]);
        TaskStatus status = TaskStatus.valueOf(parts[4]);

        LocalDate dueDate = parts[5].isBlank()
                ? null
                : LocalDate.parse(parts[5]);

        LocalDateTime createdAt = LocalDateTime.parse(parts[6]);

        return new Task(id, title, description, priority, status, dueDate, createdAt);
    }

    private String escape(String value) {
        return value.replace(";", ",");
    }

    private String unescape(String value) {
        return value;
    }
}
```

Este repositorio guarda cada tarea en una línea de texto separando los campos con `;`.

---

## 15. Nota sobre el guardado en archivo

Este sistema de guardado es sencillo.

No es perfecto, pero es suficiente para practicar:

- `Files`
- `Path`
- listas
- conversión de texto a objetos
- conversión de objetos a texto
- excepciones

En una aplicación real podrías usar:

- JSON
- XML
- una base de datos
- una API externa

Pero para un proyecto final de Java básico, este sistema es muy útil.

---

## 16. Sealed interface para resultados de eliminación

Vamos a usar una sealed interface para representar el resultado de borrar una tarea.

Ruta:

```text
src/main/java/com/amazaing/taskmanager/result/DeleteResult.java
```

Código:

```java
package com.amazaing.taskmanager.result;

public sealed interface DeleteResult permits DeleteSuccess, DeleteError {
}
```

---

## 17. Record `DeleteSuccess`

Ruta:

```text
src/main/java/com/amazaing/taskmanager/result/DeleteSuccess.java
```

Código:

```java
package com.amazaing.taskmanager.result;

public record DeleteSuccess(int id) implements DeleteResult {
}
```

---

## 18. Record `DeleteError`

Ruta:

```text
src/main/java/com/amazaing/taskmanager/result/DeleteError.java
```

Código:

```java
package com.amazaing.taskmanager.result;

public record DeleteError(String message) implements DeleteResult {
}
```

Esto nos permite devolver un resultado claro sin usar solo `boolean`.

---

## 19. Servicio principal: `TaskService`

Ruta:

```text
src/main/java/com/amazaing/taskmanager/service/TaskService.java
```

Código:

```java
package com.amazaing.taskmanager.service;

import com.amazaing.taskmanager.exception.TaskNotFoundException;
import com.amazaing.taskmanager.model.Priority;
import com.amazaing.taskmanager.model.Task;
import com.amazaing.taskmanager.model.TaskStatus;
import com.amazaing.taskmanager.repository.TaskRepository;
import com.amazaing.taskmanager.result.DeleteError;
import com.amazaing.taskmanager.result.DeleteResult;
import com.amazaing.taskmanager.result.DeleteSuccess;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

public class TaskService {
    private final TaskRepository repository;
    private final List<Task> tasks;
    private int nextId;

    public TaskService(TaskRepository repository) {
        this.repository = repository;
        this.tasks = new ArrayList<>();
        this.nextId = 1;
    }

    public Task createTask(
            String title,
            String description,
            Priority priority,
            LocalDate dueDate
    ) {
        Task task = new Task(
                nextId,
                title,
                description,
                priority,
                TaskStatus.PENDING,
                dueDate,
                LocalDateTime.now()
        );

        tasks.add(task);
        nextId++;

        return task;
    }

    public List<Task> findAll() {
        return tasks.stream()
                .sorted(Comparator.comparing(Task::id))
                .toList();
    }

    public Optional<Task> findById(int id) {
        return tasks.stream()
                .filter(task -> task.id() == id)
                .findFirst();
    }

    public Task completeTask(int id) {
        Task task = findById(id)
                .orElseThrow(() -> new TaskNotFoundException(id));

        Task completedTask = task.complete();

        tasks.remove(task);
        tasks.add(completedTask);

        return completedTask;
    }

    public DeleteResult deleteTask(int id) {
        Optional<Task> task = findById(id);

        if (task.isEmpty()) {
            return new DeleteError("Task not found with id: " + id);
        }

        tasks.remove(task.get());

        return new DeleteSuccess(id);
    }

    public List<Task> findByStatus(TaskStatus status) {
        return tasks.stream()
                .filter(task -> task.status() == status)
                .sorted(Comparator.comparing(Task::id))
                .toList();
    }

    public void saveTasks() {
        repository.save(tasks);
    }

    public void loadTasks() {
        tasks.clear();
        tasks.addAll(repository.load());
        updateNextId();
    }

    private void updateNextId() {
        nextId = tasks.stream()
                .map(Task::id)
                .max(Integer::compareTo)
                .orElse(0) + 1;
    }
}
```

---

## 20. Conceptos usados en `TaskService`

En esta clase practicamos:

- encapsulación
- listas
- `Optional`
- streams
- lambdas
- method references
- sealed result
- records
- excepciones
- enums
- Date/Time API

Este servicio contiene la lógica principal del proyecto.

---

## 21. Clase de utilidad `DateUtils`

Ruta:

```text
src/main/java/com/amazaing/taskmanager/util/DateUtils.java
```

Código:

```java
package com.amazaing.taskmanager.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class DateUtils {
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    private DateUtils() {
    }

    public static LocalDate parseDateOrNull(String text) {
        if (text == null || text.isBlank()) {
            return null;
        }

        try {
            return LocalDate.parse(text, FORMATTER);
        } catch (DateTimeParseException e) {
            return null;
        }
    }

    public static String formatDate(LocalDate date) {
        if (date == null) {
            return "No due date";
        }

        return date.format(FORMATTER);
    }
}
```

Esta clase usa métodos estáticos porque son utilidades puras.

---

## 22. Clase de utilidad `ConsoleReader`

Ruta:

```text
src/main/java/com/amazaing/taskmanager/util/ConsoleReader.java
```

Código:

```java
package com.amazaing.taskmanager.util;

import com.amazaing.taskmanager.model.Priority;
import com.amazaing.taskmanager.model.TaskStatus;

import java.util.Scanner;

public class ConsoleReader {
    private final Scanner scanner;

    public ConsoleReader() {
        this.scanner = new Scanner(System.in);
    }

    public String readText(String message) {
        System.out.print(message);
        return scanner.nextLine();
    }

    public int readInt(String message) {
        while (true) {
            System.out.print(message);

            try {
                return Integer.parseInt(scanner.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Please enter a valid number.");
            }
        }
    }

    public Priority readPriority() {
        while (true) {
            System.out.println("Choose priority:");
            System.out.println("1. LOW");
            System.out.println("2. MEDIUM");
            System.out.println("3. HIGH");

            int option = readInt("Option: ");

            switch (option) {
                case 1:
                    return Priority.LOW;
                case 2:
                    return Priority.MEDIUM;
                case 3:
                    return Priority.HIGH;
                default:
                    System.out.println("Invalid priority.");
            }
        }
    }

    public TaskStatus readStatus() {
        while (true) {
            System.out.println("Choose status:");
            System.out.println("1. PENDING");
            System.out.println("2. IN_PROGRESS");
            System.out.println("3. COMPLETED");

            int option = readInt("Option: ");

            switch (option) {
                case 1:
                    return TaskStatus.PENDING;
                case 2:
                    return TaskStatus.IN_PROGRESS;
                case 3:
                    return TaskStatus.COMPLETED;
                default:
                    System.out.println("Invalid status.");
            }
        }
    }
}
```

Esta clase centraliza la lectura desde consola.

---

## 23. Aplicación principal: `TaskApplication`

Ruta:

```text
src/main/java/com/amazaing/taskmanager/app/TaskApplication.java
```

Código:

```java
package com.amazaing.taskmanager.app;

import com.amazaing.taskmanager.exception.TaskNotFoundException;
import com.amazaing.taskmanager.model.Priority;
import com.amazaing.taskmanager.model.Task;
import com.amazaing.taskmanager.model.TaskStatus;
import com.amazaing.taskmanager.result.DeleteError;
import com.amazaing.taskmanager.result.DeleteResult;
import com.amazaing.taskmanager.result.DeleteSuccess;
import com.amazaing.taskmanager.service.TaskService;
import com.amazaing.taskmanager.util.ConsoleReader;
import com.amazaing.taskmanager.util.DateUtils;

import java.time.LocalDate;
import java.util.List;

public class TaskApplication {
    private final TaskService taskService;
    private final ConsoleReader consoleReader;

    public TaskApplication(TaskService taskService) {
        this.taskService = taskService;
        this.consoleReader = new ConsoleReader();
    }

    public void run() {
        boolean running = true;

        while (running) {
            printMenu();

            int option = consoleReader.readInt("Choose an option: ");

            switch (option) {
                case 1:
                    createTask();
                    break;
                case 2:
                    listTasks();
                    break;
                case 3:
                    findTaskById();
                    break;
                case 4:
                    completeTask();
                    break;
                case 5:
                    deleteTask();
                    break;
                case 6:
                    listTasksByStatus();
                    break;
                case 7:
                    saveTasks();
                    break;
                case 8:
                    loadTasks();
                    break;
                case 0:
                    running = false;
                    break;
                default:
                    System.out.println("Invalid option.");
            }
        }

        System.out.println("Goodbye!");
    }

    private void printMenu() {
        System.out.println();
        System.out.println("==== Task Manager ====");
        System.out.println("1. Create task");
        System.out.println("2. List tasks");
        System.out.println("3. Find task by id");
        System.out.println("4. Complete task");
        System.out.println("5. Delete task");
        System.out.println("6. List tasks by status");
        System.out.println("7. Save tasks");
        System.out.println("8. Load tasks");
        System.out.println("0. Exit");
    }

    private void createTask() {
        String title = consoleReader.readText("Title: ");
        String description = consoleReader.readText("Description: ");
        Priority priority = consoleReader.readPriority();
        String dueDateText = consoleReader.readText("Due date (dd/MM/yyyy) or empty: ");

        LocalDate dueDate = DateUtils.parseDateOrNull(dueDateText);

        Task task = taskService.createTask(title, description, priority, dueDate);

        System.out.println("Task created: " + task.id());
    }

    private void listTasks() {
        List<Task> tasks = taskService.findAll();

        if (tasks.isEmpty()) {
            System.out.println("No tasks found.");
            return;
        }

        for (Task task : tasks) {
            printTask(task);
        }
    }

    private void findTaskById() {
        int id = consoleReader.readInt("Task id: ");

        taskService.findById(id)
                .ifPresentOrElse(
                        this::printTask,
                        () -> System.out.println("Task not found.")
                );
    }

    private void completeTask() {
        int id = consoleReader.readInt("Task id: ");

        try {
            Task task = taskService.completeTask(id);
            System.out.println("Task completed: " + task.title());
        } catch (TaskNotFoundException e) {
            System.out.println(e.getMessage());
        }
    }

    private void deleteTask() {
        int id = consoleReader.readInt("Task id: ");

        DeleteResult result = taskService.deleteTask(id);

        switch (result) {
            case DeleteSuccess success ->
                    System.out.println("Task deleted: " + success.id());
            case DeleteError error ->
                    System.out.println(error.message());
        }
    }

    private void listTasksByStatus() {
        TaskStatus status = consoleReader.readStatus();

        List<Task> tasks = taskService.findByStatus(status);

        if (tasks.isEmpty()) {
            System.out.println("No tasks found with status: " + status);
            return;
        }

        for (Task task : tasks) {
            printTask(task);
        }
    }

    private void saveTasks() {
        taskService.saveTasks();
        System.out.println("Tasks saved.");
    }

    private void loadTasks() {
        taskService.loadTasks();
        System.out.println("Tasks loaded.");
    }

    private void printTask(Task task) {
        System.out.println("-------------------------");
        System.out.println("Id: " + task.id());
        System.out.println("Title: " + task.title());
        System.out.println("Description: " + task.description());
        System.out.println("Priority: " + task.priority());
        System.out.println("Status: " + task.status());
        System.out.println("Due date: " + DateUtils.formatDate(task.dueDate()));
        System.out.println("Created at: " + task.createdAt());
        System.out.println("Overdue: " + task.isOverdue());
    }
}
```

---

## 24. Clase `Main`

Ruta:

```text
src/main/java/com/amazaing/taskmanager/Main.java
```

Código:

```java
package com.amazaing.taskmanager;

import com.amazaing.taskmanager.app.TaskApplication;
import com.amazaing.taskmanager.repository.FileTaskRepository;
import com.amazaing.taskmanager.repository.TaskRepository;
import com.amazaing.taskmanager.service.TaskService;

import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        Path filePath = Path.of("data", "tasks.txt");

        TaskRepository repository = new FileTaskRepository(filePath);
        TaskService service = new TaskService(repository);
        TaskApplication application = new TaskApplication(service);

        application.run();
    }
}
```

Esta clase conecta las piezas principales.

---

## 25. Ejecutar el proyecto desde el IDE

Si usas un IDE, puedes ejecutar directamente la clase:

```text
Main.java
```

El programa abrirá el menú en la consola integrada.

---

## 26. Ejecutar el proyecto con Maven

Desde la terminal, puedes compilar con:

```bash
mvn compile
```

Crear el `.jar`:

```bash
mvn package
```

Ejecutar el `.jar`:

```bash
java -jar target/java-task-manager-1.0.0.jar
```

---

## 27. Probar la aplicación

Una posible prueba sería:

```text
1. Create task
Title: Study Java
Description: Review final project
Priority: MEDIUM
Due date: 30/06/2026
```

Después:

```text
2. List tasks
```

Deberías ver la tarea creada.

Luego:

```text
7. Save tasks
```

Después puedes cerrar, volver a abrir y usar:

```text
8. Load tasks
```

---

## 28. Archivo generado

Cuando guardes las tareas, se creará un archivo:

```text
data/tasks.txt
```

Con contenido parecido a:

```text
1;Study Java;Review final project;MEDIUM;PENDING;2026-06-30;2026-06-21T12:30:10.123
```

Cada línea representa una tarea.

---

## 29. Mejoras posibles

Este proyecto es funcional, pero se puede mejorar.

Algunas mejoras posibles:

- editar una tarea
- cambiar el estado a `IN_PROGRESS`
- filtrar por prioridad
- ordenar por fecha límite
- buscar por texto
- guardar en JSON
- añadir tests con JUnit
- usar una base de datos
- crear una interfaz gráfica
- convertirlo en una API REST con Spring
- añadir usuarios
- añadir categorías
- añadir etiquetas
- añadir exportación CSV

---

## 30. Mejora 1: cambiar estado a `IN_PROGRESS`

Ahora mismo solo completamos tareas.

Podrías añadir un método:

```java
public Task startTask(int id) {
    Task task = findById(id)
            .orElseThrow(() -> new TaskNotFoundException(id));

    Task updatedTask = new Task(
            task.id(),
            task.title(),
            task.description(),
            task.priority(),
            TaskStatus.IN_PROGRESS,
            task.dueDate(),
            task.createdAt()
    );

    tasks.remove(task);
    tasks.add(updatedTask);

    return updatedTask;
}
```

Después podrías añadir una opción nueva al menú.

---

## 31. Mejora 2: filtrar por prioridad

Puedes añadir en `TaskService`:

```java
public List<Task> findByPriority(Priority priority) {
    return tasks.stream()
            .filter(task -> task.priority() == priority)
            .sorted(Comparator.comparing(Task::id))
            .toList();
}
```

Esto practica:

- enums
- streams
- lambdas
- listas

---

## 32. Mejora 3: ordenar por fecha límite

Puedes crear un método:

```java
public List<Task> findAllSortedByDueDate() {
    return tasks.stream()
            .filter(task -> task.dueDate() != null)
            .sorted(Comparator.comparing(Task::dueDate))
            .toList();
}
```

Esto practica:

- `LocalDate`
- `Comparator`
- streams
- method references

---

## 33. Mejora 4: buscar por texto

Puedes buscar tareas que contengan una palabra en el título o descripción.

```java
public List<Task> searchByText(String text) {
    String lowerText = text.toLowerCase();

    return tasks.stream()
            .filter(task -> task.title().toLowerCase().contains(lowerText)
                    || task.description().toLowerCase().contains(lowerText))
            .sorted(Comparator.comparing(Task::id))
            .toList();
}
```

---

## 34. Mejora 5: guardar automáticamente al salir

Ahora mismo el usuario debe elegir la opción de guardar.

Podrías modificar el método `run` para guardar antes de salir.

Ejemplo:

```java
case 0:
    saveTasks();
    running = false;
    break;
```

Así reduces el riesgo de perder información.

---

## 35. Mejora 6: cargar automáticamente al iniciar

En `Main`, después de crear el servicio, podrías cargar las tareas.

```java
TaskService service = new TaskService(repository);
service.loadTasks();
```

Así la aplicación recupera los datos automáticamente al empezar.

---

## 36. Mejora 7: añadir tests

Podrías añadir JUnit al `pom.xml`.

```xml
<dependencies>
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter</artifactId>
        <version>5.10.2</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

Después puedes crear tests para `TaskService`.

---

## 37. Ejemplo de test para `TaskService`

```java
package com.amazaing.taskmanager.service;

import com.amazaing.taskmanager.model.Priority;
import com.amazaing.taskmanager.repository.TaskRepository;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TaskServiceTest {
    @Test
    void shouldCreateTask() {
        TaskRepository repository = new InMemoryTaskRepository();
        TaskService service = new TaskService(repository);

        service.createTask("Study", "Study Java", Priority.HIGH, null);

        assertEquals(1, service.findAll().size());
    }
}
```

Para este test necesitarías crear un repositorio en memoria.

---

## 38. Repositorio en memoria para tests

```java
package com.amazaing.taskmanager.service;

import com.amazaing.taskmanager.model.Task;
import com.amazaing.taskmanager.repository.TaskRepository;

import java.util.ArrayList;
import java.util.List;

public class InMemoryTaskRepository implements TaskRepository {
    private List<Task> tasks = new ArrayList<>();

    @Override
    public void save(List<Task> tasks) {
        this.tasks = new ArrayList<>(tasks);
    }

    @Override
    public List<Task> load() {
        return new ArrayList<>(tasks);
    }
}
```

Esto evita depender de archivos reales durante los tests.

---

## 39. Mejora 8: usar anotaciones propias

Podrías crear una anotación para marcar opciones del menú.

Ejemplo:

```java
public @interface MenuOption {
    int value();
    String description();
}
```

Aunque no es necesario para este proyecto, sería una forma interesante de practicar anotaciones.

---

## 40. Mejora 9: añadir concurrencia

Podrías guardar las tareas en segundo plano.

Ejemplo conceptual:

```java
Thread saveThread = new Thread(() -> taskService.saveTasks());
saveThread.start();
```

O con `ExecutorService`:

```java
ExecutorService executor = Executors.newSingleThreadExecutor();

executor.execute(() -> taskService.saveTasks());

executor.shutdown();
```

Para este proyecto no es obligatorio, pero sirve para practicar concurrencia básica.

---

## 41. Mejora 10: usar JSON

El sistema actual guarda texto separado por `;`.

Una mejora más profesional sería guardar las tareas en JSON.

Ejemplo conceptual:

```json
[
  {
    "id": 1,
    "title": "Study Java",
    "priority": "HIGH"
  }
]
```

Para esto podrías usar librerías como:

- Jackson
- Gson

Y gestionarlas con Maven.

---

## 42. Repaso de conceptos aplicados

Este proyecto aplica muchos conceptos del curso.

### 42.1. Clases

```java
public class TaskService {
}
```

### 42.2. Records

```java
public record Task(...) {
}
```

### 42.3. Enums

```java
public enum Priority {
    LOW,
    MEDIUM,
    HIGH
}
```

### 42.4. Interfaces

```java
public interface TaskRepository {
}
```

### 42.5. Sealed interfaces

```java
public sealed interface DeleteResult permits DeleteSuccess, DeleteError {
}
```

### 42.6. Optional

```java
public Optional<Task> findById(int id) {
}
```

### 42.7. Streams

```java
tasks.stream()
        .filter(task -> task.status() == status)
        .toList();
```

### 42.8. Date/Time API

```java
LocalDate.now()
LocalDateTime.now()
```

### 42.9. Files y Path

```java
Path.of("data", "tasks.txt")
Files.write(filePath, lines)
```

### 42.10. Excepciones

```java
throw new TaskNotFoundException(id);
```

### 42.11. Maven

```bash
mvn clean package
```

---

## 43. Por qué separar por capas

Este proyecto separa:

- modelo
- servicio
- repositorio
- aplicación
- utilidades

Esto evita que todo el código esté mezclado en `Main`.

Por ejemplo, `Main` solo arranca la aplicación:

```java
application.run();
```

La lógica de tareas está en:

```java
TaskService
```

La persistencia está en:

```java
FileTaskRepository
```

La consola está en:

```java
TaskApplication
```

Esta separación hace el proyecto más fácil de mantener.

---

## 44. Qué podría ir mal

Algunos errores posibles:

- escribir una fecha con formato incorrecto
- intentar completar una tarea inexistente
- borrar una tarea inexistente
- no guardar antes de salir
- modificar manualmente el archivo y romper el formato
- no tener permisos para escribir en la carpeta
- ejecutar desde una ruta inesperada

Parte de programar consiste en pensar en estos casos.

---

## 45. Posible mejora de validación de fecha

Ahora, si la fecha no se puede parsear, devolvemos `null`.

Podrías mejorar esto preguntando hasta que el usuario escriba una fecha válida.

Ejemplo conceptual:

```java
LocalDate dueDate = null;

while (dueDate == null) {
    String text = consoleReader.readText("Due date: ");
    dueDate = DateUtils.parseDateOrNull(text);
}
```

Pero recuerda que también quieres permitir fechas vacías, así que tendrías que distinguir entre:

- vacío permitido
- texto incorrecto

---

## 46. Posible mejora del modelo

Ahora `TaskStatus` tiene tres valores:

```java
PENDING
IN_PROGRESS
COMPLETED
```

Podrías añadir:

```java
CANCELLED
```

Y después añadir una opción para cancelar tareas.

---

## 47. Posible mejora con `BigDecimal`

Si quisieras convertir el proyecto en un gestor de tareas profesionales, podrías añadir un coste estimado.

Ejemplo:

```java
BigDecimal estimatedCost
```

Así practicarías:

- `BigDecimal`
- validación
- sumas
- filtros
- reportes

---

## 48. Posible mejora con reportes

Puedes crear un reporte de tareas:

- total de tareas
- tareas pendientes
- tareas completadas
- tareas vencidas
- tareas por prioridad

Ejemplo:

```java
long completed = tasks.stream()
        .filter(task -> task.status() == TaskStatus.COMPLETED)
        .count();
```

Esto refuerza `Stream API`.

---

## 49. Posible mejora con `HashMap`

Ahora buscamos por id usando streams.

Podrías usar un `HashMap<Integer, Task>` para optimizar búsquedas.

Ejemplo:

```java
private final Map<Integer, Task> tasksById = new HashMap<>();
```

Esto practicaría:

- mapas
- claves
- valores
- actualización de datos

---

## 50. Posible mejora con packages y módulos

Podrías convertir el proyecto en un proyecto modular añadiendo:

```text
module-info.java
```

Ejemplo:

```java
module com.amazaing.taskmanager {
    exports com.amazaing.taskmanager.model;
    exports com.amazaing.taskmanager.service;
}
```

Para un primer proyecto no es obligatorio, pero sería una forma de practicar el tema de módulos.

---

## 51. Checklist para completar el proyecto

Antes de dar el proyecto por terminado, comprueba:

- el proyecto compila con `mvn compile`
- el `.jar` se genera con `mvn package`
- la aplicación arranca
- puedes crear tareas
- puedes listar tareas
- puedes buscar por id
- puedes completar tareas
- puedes borrar tareas
- puedes guardar tareas
- puedes cargar tareas
- el archivo se crea en `data/tasks.txt`
- el código está organizado por paquetes
- los nombres de clases y métodos son claros

---

## 52. Ejercicio final propuesto

Completa las siguientes mejoras:

1. Añade una opción para marcar una tarea como `IN_PROGRESS`.
2. Añade una opción para filtrar por prioridad.
3. Haz que las tareas se carguen automáticamente al iniciar.
4. Haz que las tareas se guarden automáticamente al salir.
5. Añade una opción para listar tareas vencidas.
6. Añade un reporte con número total de tareas por estado.
7. Añade tests para `TaskService`.

Con estas mejoras, el proyecto quedaría mucho más completo.

---

## 53. Cómo presentar este proyecto en GitHub

Si subes este proyecto a GitHub, podrías añadir un `README.md`.

Ejemplo de secciones:

````markdown
# Java Task Manager

Aplicación de consola para gestionar tareas usando Java 25 y Maven.

## Funcionalidades

- Crear tareas
- Listar tareas
- Buscar por id
- Completar tareas
- Eliminar tareas
- Guardar y cargar desde archivo

## Tecnologías

- Java 25
- Maven
- Records
- Enums
- Stream API
- Optional
- Files y Path

## Ejecución

```bash
mvn clean package
java -jar target/java-task-manager-1.0.0.jar
```
````

````

Un buen README ayuda a que otras personas entiendan tu proyecto.

---

## 54. Buenas prácticas aplicadas

En este proyecto hemos intentado aplicar buenas prácticas:

- separar responsabilidades
- usar nombres claros
- evitar código demasiado largo en `Main`
- usar interfaces para desacoplar
- usar records para datos inmutables
- usar enums para valores cerrados
- usar exceptions para errores relevantes
- usar `Optional` cuando puede no existir un valor
- usar streams para búsquedas y filtros
- usar Maven para organizar el proyecto
- guardar datos fuera del código fuente

---

## 55. Errores típicos al hacer este proyecto

### 55.1. No respetar los paquetes

Si una clase tiene:

```java
package com.amazaing.taskmanager.model;
````

debe estar en la carpeta correcta:

```text
com/amazaing/taskmanager/model
```

### 55.2. Olvidar imports

Por ejemplo:

```java
import java.time.LocalDate;
import java.util.List;
```

### 55.3. Ejecutar desde una ruta inesperada

El archivo se guarda en:

```text
data/tasks.txt
```

relativo a la carpeta desde la que se ejecuta la aplicación.

### 55.4. No guardar después de crear tareas

Si no guardas, se pierden al cerrar.

### 55.5. Romper el formato del archivo manualmente

Si editas `tasks.txt` a mano y quitas campos, la carga puede fallar.

### 55.6. Copiar clases sin actualizar paquetes

Cada archivo debe tener el `package` correcto.

---

## 56. Resumen final del proyecto

En este proyecto has creado una aplicación de consola completa para gestionar tareas.

La aplicación permite:

- crear tareas
- listar tareas
- buscar tareas
- completar tareas
- borrar tareas
- filtrar tareas
- guardar y cargar datos

Y has practicado muchas herramientas de Java moderno:

```java
record
enum
interface
sealed interface
Optional
Stream API
LocalDate
LocalDateTime
Files
Path
Maven
```

Lo más importante no es memorizar todo el código, sino entender cómo se conectan las piezas.

Un proyecto real no es solo una clase con un `main`.

Un proyecto real suele tener:

- modelos
- servicios
- repositorios
- utilidades
- control de errores
- persistencia
- estructura de carpetas
- herramienta de construcción

Este proyecto final te da una base muy buena para seguir avanzando hacia aplicaciones más profesionales.

---

## 57. Siguientes pasos después del curso

Después de terminar este curso, podrías continuar con:

- testing con JUnit
- bases de datos con JDBC
- MySQL desde Java
- Spring Boot
- APIs REST
- programación web con Java
- persistencia con JPA e Hibernate
- Gradle
- diseño de patrones
- arquitectura por capas
- aplicaciones con interfaz gráfica
- despliegue de aplicaciones Java

Java es un ecosistema muy amplio, y este curso te da la base para seguir creciendo.

---

## 58. Cierre del curso

Has llegado al final del curso de Java.

Empezaste con los conceptos básicos del lenguaje y has terminado creando un proyecto organizado con muchas herramientas modernas.

La clave ahora es practicar.

No basta con leer código: hay que escribirlo, romperlo, arreglarlo y mejorarlo.

Este proyecto final es un buen punto de partida para experimentar, añadir funciones y convertirlo en algo propio.

---

## 59. Reto final

Intenta hacer una versión ampliada del proyecto con estas características:

- menú más limpio
- carga automática
- guardado automático
- edición de tareas
- búsqueda por texto
- filtro por prioridad
- listado de tareas vencidas
- estadísticas por estado
- tests unitarios
- README completo
- repositorio GitHub

Cuando termines, tendrás un proyecto de Java muy completo para enseñar como práctica final.

---

## 60. Resumen final

Este tema cierra el curso con una aplicación práctica.

El objetivo ha sido unir los conceptos principales en un proyecto con sentido.

Has visto cómo:

- organizar un proyecto Maven
- crear modelos con records
- usar enums para opciones cerradas
- aplicar `Optional` en búsquedas
- usar `Stream API` para filtrar y ordenar
- trabajar con fechas
- guardar datos en archivos
- separar responsabilidades
- crear una pequeña arquitectura por capas

A partir de aquí, el siguiente paso natural es crear proyectos cada vez más grandes y conectarlos con tecnologías como bases de datos, APIs y frameworks como Spring MVC o Spring Boot.

---

¡Enhorabuena por llegar al final del curso!
