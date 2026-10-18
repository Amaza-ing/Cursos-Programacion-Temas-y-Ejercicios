# Topic 40. Final Project

## 1. Introduction

We've reached the last topic of the course.

Throughout the course you have learned many important pieces of Java:

- variables
- operators
- conditionals
- loops
- methods
- arrays
- `ArrayList`
- classes and objects
- encapsulation
- constructors
- static methods
- inheritance
- polymorphism
- packages
- abstract classes
- interfaces
- `equals`
- exceptions
- enums
- `HashMap`
- other collections
- `BigDecimal`
- generics
- lambdas
- functional interfaces
- `Stream API`
- `Optional`
- Date/Time API
- `Files` and `Path`
- records
- sealed classes
- basic concurrency
- annotations
- Maven

Now we are going to combine many of those concepts into a final project.

The goal is not to make a huge application, but to create a project complete enough to practice modern Java with a structure similar to what you would find in a real project.

---

## 2. Final project: console task manager

Let's create a console application called:

```text
Task Manager
```

The application will let you manage tasks.

Each task will have:

- id
- title
- description
- priority
- status
- deadline
- creation date

The user will be able to:

- create tasks
- list tasks
- search tasks by id
- mark tasks as completed
- delete tasks
- filter tasks by status
- save tasks to a file
- load tasks from a file

---

## 3. Course concepts you'll practice

In this project we will use:

- classes
- records
- enums
- interfaces
- sealed classes
- custom exceptions
- `ArrayList`
- `HashMap`
- `Optional`
- `Stream API`
- `LocalDate`
- `LocalDateTime`
- `Files`
- `Path`
- `BigDecimal` optionally
- Maven
- packages
- static methods
- encapsulation
- separation by responsibility

---

## 4. Expected result

The app will display a menu like this:

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

The user will be able to interact from the console by typing numbers and text.

---

## 5. Creating the Maven project

The structure of the project will be:

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

This structure separates the code by responsibilities.

---

## 6. Responsibilities of each package

### 6.1. `model`

Contains the classes or records that represent the main data of the project.

Example:

```text
Task
TaskStatus
Priority
```

### 6.2. `service`

Contains the business logic.

Example:

```text
TaskService
```

### 6.3. `repository`

Contains the logic to save and load data.

Example:

```text
TaskRepository
FileTaskRepository
```

### 6.4. `app`

Contains the interaction logic of the application.

Example:

```text
TaskApplication
```

### 6.5. `exception`

Contains custom exceptions.

Example:

```text
TaskNotFoundException
```

### 6.6. `result`

Contains sealed interfaces and records to represent results.

Example:

```text
DeleteResult
DeleteSuccess
DeleteError
```

### 6.7. `util`

Contains utility classes.

Example:

```text
ConsoleReader
DateUtils
```

---

## 7. `pom.xml`

First we create the `pom.xml` file.

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

This project does not need external dependencies.

We will use only standard Java.

---

## 8. Main model: `Task`

Let's represent a task with a `record`.

Path:
```text
src/main/java/com/amazaing/taskmanager/model/Task.java
```

Code:

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

## 9. Why we use a record for `Task`

We use a record because a task, in this design, is treated as immutable data.

If we want to modify a task, we do not change the original instance.

We create a new one:

```java
Task completedTask = task.complete();
```

This reduces errors and makes the code more predictable.

---

## 10. The `Priority` enum

Path:

```text
src/main/java/com/amazaing/taskmanager/model/Priority.java
```

Code:

```java
package com.amazaing.taskmanager.model;

public enum Priority {
    LOW,
    MEDIUM,
    HIGH
}
```

We use an enum because priority can only have a closed set of values.

---

## 11. The `TaskStatus` enum

Path:

```text
src/main/java/com/amazaing/taskmanager/model/TaskStatus.java
```

Code:

```java
package com.amazaing.taskmanager.model;

public enum TaskStatus {
    PENDING,
    IN_PROGRESS,
    COMPLETED
}
```

We also use an enum for the task status.

---

## 12. Custom exception

Let's create our own exception for when a task is not found.

Path:

```text
src/main/java/com/amazaing/taskmanager/exception/TaskNotFoundException.java
```

Code:

```java
package com.amazaing.taskmanager.exception;

public class TaskNotFoundException extends RuntimeException {
    public TaskNotFoundException(int id) {
        super("Task not found with id: " + id);
    }
}
```

We use a custom exception to make the error more expressive.

---

## 13. `TaskRepository` interface

The repository will be responsible for saving and loading tasks.

Path:

```text
src/main/java/com/amazaing/taskmanager/repository/TaskRepository.java
```

Code:

```java
package com.amazaing.taskmanager.repository;

import com.amazaing.taskmanager.model.Task;

import java.util.List;

public interface TaskRepository {
    void save(List<Task> tasks);

    List<Task> load();
}
```

This means the application doesn't depend directly on how the data is stored.

---

## 14. File-based implementation: `FileTaskRepository`

Path:

```text
src/main/java/com/amazaing/taskmanager/repository/FileTaskRepository.java
```

Code:

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

This repository saves each task on its own line of text, separating the fields with `;`.

---

## 15. A note on saving to a file

This saving system is simple.

It's not perfect, but it's enough to practice:

- `Files`
- `Path`
- lists
- converting text to objects
- converting objects to text
- exceptions

In a real application you could use:

- JSON
- XML
- a database
- an external API

But for a basic Java capstone project, this system is very useful.

---

## 16. Sealed interface for deletion results

We are going to use a sealed interface to represent the result of deleting a task.

Path:

```text
src/main/java/com/amazaing/taskmanager/result/DeleteResult.java
```

Code:

```java
package com.amazaing.taskmanager.result;

public sealed interface DeleteResult permits DeleteSuccess, DeleteError {
}
```

---

## 17. The `DeleteSuccess` record

Path:

```text
src/main/java/com/amazaing/taskmanager/result/DeleteSuccess.java
```

Code:

```java
package com.amazaing.taskmanager.result;

public record DeleteSuccess(int id) implements DeleteResult {
}
```

---

## 18. The `DeleteError` record

Path:

```text
src/main/java/com/amazaing/taskmanager/result/DeleteError.java
```

Code:

```java
package com.amazaing.taskmanager.result;

public record DeleteError(String message) implements DeleteResult {
}
```

This lets us return a clear result instead of just a `boolean`.

---

## 19. Main service: `TaskService`

Path:

```text
src/main/java/com/amazaing/taskmanager/service/TaskService.java
```

Code:

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

## 20. Concepts used in `TaskService`

In this class we practice:

- encapsulation
- lists
- `Optional`
- streams
- lambdas
- method references
- sealed result
- records
- exceptions
- enums
- Date/Time API

This service contains the main logic of the project.

---

## 21. `DateUtils` utility class

Path:

```text
src/main/java/com/amazaing/taskmanager/util/DateUtils.java
```

Code:

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

This class uses static methods because they are pure utilities.

---

## 22. `ConsoleReader` utility class

Path:

```text
src/main/java/com/amazaing/taskmanager/util/ConsoleReader.java
```

Code:

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

This class centralizes reading from the console.

---

## 23. Main application: `TaskApplication`

Path:

```text
src/main/java/com/amazaing/taskmanager/app/TaskApplication.java
```

Code:

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

## 24. `Main` class

Path:

```text
src/main/java/com/amazaing/taskmanager/Main.java
```

Code:

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

This class connects the main pieces.

---

## 25. Running the project from the IDE

If you use an IDE, you can directly run the class:

```text
Main.java
```

The program will open the menu in the integrated console.

---

## 26. Running the project with Maven

From the terminal, you can compile with:

```bash
mvn compile
```

Create the `.jar`:

```bash
mvn package
```

Run the `.jar`:

```bash
java -jar target/java-task-manager-1.0.0.jar
```

---

## 27. Trying out the application

A possible test run would be:

```text
1. Create task
Title: Study Java
Description: Review final project
Priority: MEDIUM
Due date: 30/06/2026
```

After that:

```text
2. List tasks
```

You should see the task you created.

Then:

```text
7. Save tasks
```

Then you can close the app, open it again and use:

```text
8. Load tasks
```

---

## 28. Generated file

When you save tasks, a file will be created:

```text
data/tasks.txt
```

With content similar to:

```text
1;Study Java;Review final project;MEDIUM;PENDING;2026-06-30;2026-06-21T12:30:10.123
```

Each line represents a task.

---

## 29. Possible improvements

This project is functional, but it can be improved.

Some possible improvements:

- edit a task
- change the status to `IN_PROGRESS`
- filter by priority
- sort by deadline
- search by text
- save to JSON
- add tests with JUnit
- use a database
- create a graphical interface
- convert it to a REST API with Spring
- add users
- add categories
- add tags
- add CSV export

---

## 30. Improvement 1: change the status to `IN_PROGRESS`

Right now we only complete tasks.

You could add a method:

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

You could then add a new option to the menu.

---

## 31. Improvement 2: filter by priority

You can add this to `TaskService`:

```java
public List<Task> findByPriority(Priority priority) {
    return tasks.stream()
            .filter(task -> task.priority() == priority)
            .sorted(Comparator.comparing(Task::id))
            .toList();
}
```

This lets you practice:

- enums
- streams
- lambdas
- lists

---

## 32. Improvement 3: sort by deadline

You can create a method:

```java
public List<Task> findAllSortedByDueDate() {
    return tasks.stream()
            .filter(task -> task.dueDate() != null)
            .sorted(Comparator.comparing(Task::dueDate))
            .toList();
}
```

This lets you practice:

- `LocalDate`
- `Comparator`
- streams
- method references

---

## 33. Improvement 4: search by text

You can search for tasks that contain a word in the title or description.

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

## 34. Improvement 5: save automatically on exit

Right now the user must choose the save option.

You could modify the `run` method to save before exiting.

Example:

```java
case 0:
    saveTasks();
    running = false;
    break;
```

This way you reduce the risk of losing information.

---

## 35. Improvement 6: load automatically on startup

In `Main`, after creating the service, you could load the tasks.

```java
TaskService service = new TaskService(repository);
service.loadTasks();
```

That way the application gets its data back automatically when it starts.

---

## 36. Improvement 7: add tests

You could add JUnit to the `pom.xml`.

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

Then you can create tests for `TaskService`.

---

## 37. Example test for `TaskService`

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

For this test you would need to create an in-memory repository.

---

## 38. In-memory repository for tests

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

This avoids depending on real files during testing.

---

## 39. Improvement 8: use your own annotations

You could create an annotation to mark menu options.

Example:

```java
public @interface MenuOption {
    int value();
    String description();
}
```

Although it isn't necessary for this project, it would be an interesting way to practice annotations.

---

## 40. Improvement 9: add concurrency

You could save tasks in the background.

Conceptual example:

```java
Thread saveThread = new Thread(() -> taskService.saveTasks());
saveThread.start();
```

Or with `ExecutorService`:

```java
ExecutorService executor = Executors.newSingleThreadExecutor();

executor.execute(() -> taskService.saveTasks());

executor.shutdown();
```

It isn't required for this project, but it's a good way to practice basic concurrency.

---

## 41. Improvement 10: use JSON

The current system saves text separated by `;`.
A more professional improvement would be to save tasks in JSON.

Conceptual example:

```json
[
  {
    "id": 1,
    "title": "Study Java",
    "priority": "HIGH"
  }
]
```

For this you could use libraries like:

- Jackson
- Gson

And manage them with Maven.

---

## 42. Review of the concepts applied

This project applies many concepts from the course.

### 42.1. Classes

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

### 42.9. Files and Path

```java
Path.of("data", "tasks.txt")
Files.write(filePath, lines)
```

### 42.10. Exceptions

```java
throw new TaskNotFoundException(id);
```

### 42.11. Maven

```bash
mvn clean package
```

---

## 43. Why separate into layers

This project separates:

- model
- service
- repository
- application
- utilities

This prevents all the code from being mixed up in `Main`.

For example, `Main` just starts the application:

```java
application.run();
```

The task logic is in:

```java
TaskService
```

Persistence is in:

```java
FileTaskRepository
```

The console handling is in:

```java
TaskApplication
```

This separation makes the project easier to maintain.

---

## 44. What could go wrong

Some possible errors:

- typing a date in the wrong format
- trying to complete a task that doesn't exist
- deleting a task that doesn't exist
- not saving before exiting
- editing the file by hand and breaking the format
- not having permission to write to the folder
- running the app from an unexpected path

Part of programming is thinking about these cases.

---

## 45. Possible date validation improvement

Right now, if the date can't be parsed, we return `null`.

You could improve this by asking until the user enters a valid date.

Conceptual example:

```java
LocalDate dueDate = null;

while (dueDate == null) {
    String text = consoleReader.readText("Due date: ");
    dueDate = DateUtils.parseDateOrNull(text);
}
```

But remember that you also want to allow empty dates, so you would have to distinguish between:

- an empty value (allowed)
- invalid text

---

## 46. Possible model improvement

Right now `TaskStatus` has three values:

```java
PENDING
IN_PROGRESS
COMPLETED
```

You could add:

```java
CANCELLED
```

And then add an option to cancel tasks.

---

## 47. Possible improvement with `BigDecimal`

If you wanted to turn the project into a professional task manager, you could add an estimated cost.

Example:

```java
BigDecimal estimatedCost
```

That way you would practice:

- `BigDecimal`
- validation
- sums
- filters
- reports

---

## 48. Possible improvement with reports

You can create a task report:

- total tasks
- pending tasks
- completed tasks
- overdue tasks
- tasks by priority

Example:

```java
long completed = tasks.stream()
        .filter(task -> task.status() == TaskStatus.COMPLETED)
        .count();
```

This reinforces `Stream API`.

---

## 49. Possible improvement with `HashMap`

Right now we search by id using streams.

You could use a `HashMap<Integer, Task>` to optimize searches.

Example:

```java
private final Map<Integer, Task> tasksById = new HashMap<>();
```

This would let you practice:

- maps
- keys
- values
- updating data

---

## 50. Possible improvement with packages and modules

You could turn the project into a modular project by adding:

```text
module-info.java
```

Example:

```java
module com.amazaing.taskmanager {
    exports com.amazaing.taskmanager.model;
    exports com.amazaing.taskmanager.service;
}
```

It isn't required for a first project, but it would be a good way to practice what you learned in the modules topic.

---

## 51. Checklist for finishing the project

Before you consider the project finished, check that:
- the project compiles with `mvn compile`
- the `.jar` is generated with `mvn package`
- the application starts
- you can create tasks
- you can list tasks
- you can search by id
- you can complete tasks
- you can delete tasks
- you can save tasks
- you can load tasks
- the file is created in `data/tasks.txt`
- the code is organized by packages
- class and method names are clear

---

## 52. Suggested final exercise

Complete the following improvements:

1. Add an option to mark a task as `IN_PROGRESS`.
2. Add an option to filter by priority.
3. Make tasks load automatically on startup.
4. Make tasks save automatically on exit.
5. Add an option to list overdue tasks.
6. Add a report with the total number of tasks by status.
7. Add tests for `TaskService`.

With these improvements, the project would be much more complete.

---

## 53. How to present this project on GitHub

If you upload this project to GitHub, you could add a `README.md`.

Example sections:

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

A good README helps other people understand your project.

---

## 54. Best practices applied

In this project we've tried to apply best practices:

- separating responsibilities
- using clear names
- avoiding overly long code in `Main`
- using interfaces to decouple
- using records for immutable data
- using enums for closed sets of values
- using exceptions for relevant errors
- using `Optional` when a value may not exist
- using streams for searches and filters
- using Maven to organize the project
- keeping data outside the source code

---

## 55. Common mistakes when building this project

### 55.1. Not respecting the packages

If a class has:

```java
package com.amazaing.taskmanager.model;
```

It should be in the correct folder:

```text
com/amazaing/taskmanager/model
```

### 55.2. Forgetting imports

For example:

```java
import java.time.LocalDate;
import java.util.List;
```

### 55.3. Running from an unexpected path

The file is saved in:

```text
data/tasks.txt
```

relative to the folder from which the application is run.

### 55.4. Not saving after creating tasks

If you don't save, they're lost when you close the app.

### 55.5. Breaking the file format by hand

If you edit `tasks.txt` by hand and remove fields, loading may fail.

### 55.6. Copying classes without updating packages

Each file must have the correct `package`.

---

## 56. Final project summary

In this project you have created a complete console application to manage tasks.

The application lets you:

- create tasks
- list tasks
- search for tasks
- complete tasks
- delete tasks
- filter tasks
- save and load data

And you have practiced many modern Java tools:

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

The most important thing is not to memorize all the code, but to understand how the pieces connect.

A real project is not just a class with a `main`.

A real project usually has:

- models
- services
- repositories
- utilities
- error handling
- persistence
- folder structure
- a build tool

This final project gives you a very good foundation to keep moving towards more professional applications.

---

## 57. Next steps after the course

After finishing this course, you could continue with:

- testing with JUnit
- databases with JDBC
- MySQL from Java
- Spring Boot
- REST APIs
- web programming with Java
- persistence with JPA and Hibernate
- Gradle
- design patterns
- layered architecture
- applications with a graphical interface
- Java application deployment

Java is a very broad ecosystem, and this course gives you the foundation to keep growing.

---

## 58. Wrapping up the course

You have reached the end of the Java course.

You started with the basics of the language and have ended up creating an organized project with many modern tools.

The key now is to practice.
It's not enough to read code: you have to write it, break it, fix it and improve it.

This final project is a good starting point for experimenting, adding features and making it your own.

---

## 59. Final challenge

Try making an expanded version of the project with these features:

- cleaner menu
- automatic loading
- automatic saving
- task editing
- text search
- filter by priority
- list of overdue tasks
- statistics by status
- unit tests
- a complete README
- GitHub repository

When you finish, you'll have a very complete Java project to show as your final assignment.

---

## 60. Final summary

This topic closes the course with a practical application.

The goal has been to bring the main concepts together in a meaningful project.

You've seen how to:

- organize a Maven project
- create models with records
- use enums for closed options
- apply `Optional` in searches
- use `Stream API` to filter and sort
- work with dates
- save data to files
- separate responsibilities
- create a small layered architecture

From here, the natural next step is to build increasingly larger projects and connect them to technologies such as databases, APIs and frameworks like Spring MVC or Spring Boot.

---

Congratulations on reaching the end of the course!
