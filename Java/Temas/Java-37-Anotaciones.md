# Topic 37. Annotations

## 1. Introduction

In Java you have often seen symbols that begin with `@`.

For example:

```java
@Override
```

or:

```java
@FunctionalInterface
```

These elements are called **annotations**.

Annotations allow you to add extra information to the code.

This information can be used by:

- the compiler
- the IDE
- external tools
- frameworks
- libraries
- the program itself at runtime

In modern Java, annotations appear constantly.

For example, they are widely used in:

- Spring
- Jakarta EE
- JUnit
- Hibernate
- Lombok
- validation
- JSON serialization
- documentation
- code analysis

In this topic you will learn:

- What an annotation is
- What annotations are for
- Common Java annotations
- `@Override`
- `@Deprecated`
- `@SuppressWarnings`
- `@FunctionalInterface`
- How to create your own annotations
- What `@Retention` and `@Target` are
- How to use annotations with classes, methods and attributes
- A basic introduction to reading annotations with reflection
- Common mistakes and best practices

---

## 2. What is an annotation?

An annotation is a way to add metadata to code.

The word **metadata** means:

> information about other information

For example, this annotation:

```java
@Override
```

indicates that a method is overriding a method of a superclass or interface.

Example:

```java
public class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("Woof");
    }
}
```

An annotation is not a regular statement like an `if` or a `for`.  
It is extra information that Java or a tool can interpret.

---

## 3. What are annotations for?

Annotations can be used for many things.

Some common uses are:

- giving information to the compiler
- generating warnings
- marking obsolete code
- configuring frameworks
- validating data
- defining web routes
- marking automated tests
- mapping classes to database tables
- reducing repetitive code

A typical example in frameworks:

```java
@RestController
public class ProductController {
}
```

Here the annotation tells a framework that this class has a special role.

---

## 4. Built-in annotations in Java

Java includes several commonly used annotations.

Some of the most important are:

- `@Override`
- `@Deprecated`
- `@SuppressWarnings`
- `@FunctionalInterface`
- `@SafeVarargs`

In this topic we'll look at the most useful ones to start with.

---

## 5. `@Override`

`@Override` indicates that a method overrides another inherited method.

Example:

```java
public class Animal {
    public void makeSound() {
        System.out.println("Animal sound");
    }
}
```

```java
public class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("Woof");
    }
}
```

The annotation helps detect errors.

---

## 6. Why `@Override` is useful

Imagine that you misspell the method name.

```java
public class Dog extends Animal {
    @Override
    public void makeSond() {
        System.out.println("Woof");
    }
}
```

Since `makeSond` does not exist in the parent class, Java flags an error.

Without `@Override`, Java could interpret it as a new method and the error would be more difficult to detect.

That's why it's good practice to use `@Override` whenever you override a method.

---

## 7. `@Override` with interfaces

It is also used when implementing methods of an interface.

```java
public interface Printable {
    void print();
}
```

```java
public class Report implements Printable {
    @Override
    public void print() {
        System.out.println("Printing report...");
    }
}
```

This makes it clear that `print` comes from the interface.

---

## 8. `@Deprecated`

`@Deprecated` indicates that an element is no longer recommended.

It can be applied to:

- classes
- methods
- constructors
- attributes

Example:
```java
public class UserService {
    @Deprecated
    public void oldMethod() {
        System.out.println("Old method");
    }

    public void newMethod() {
        System.out.println("New method");
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        UserService service = new UserService();

        service.oldMethod();
        service.newMethod();
    }
}
```

The IDE will normally display a warning when using `oldMethod`.

---

## 9. What `@Deprecated` is for

It warns that something still exists, but shouldn't be used in new code.

This is very common when an API evolves.

Example:

```java
@Deprecated
public void loginWithUsername(String username) {
}
```

Maybe this is now preferred:

```java
public void loginWithEmail(String email) {
}
```

The annotation lets you keep compatibility without removing the method all at once.

---

## 10. `@Deprecated` with additional information

You can add information with `since` and `forRemoval`.

```java
@Deprecated(since = "2.0", forRemoval = true)
public void oldMethod() {
}
```

This indicates:

- which version it has been deprecated since
- whether it is scheduled for removal

Example:

```java
public class PaymentService {
    @Deprecated(since = "1.5", forRemoval = true)
    public void payWithOldSystem() {
        System.out.println("Old payment system");
    }

    public void payWithNewSystem() {
        System.out.println("New payment system");
    }
}
```

---

## 11. `@SuppressWarnings`

`@SuppressWarnings` is used to hide compiler warnings.

Example:

```java
@SuppressWarnings("unused")
public class Main {
    private String message = "Hello";
}
```

Here you're telling the compiler to ignore the warning that `message` is not used.

Another example:

```java
@SuppressWarnings("deprecation")
public class Main {
    public static void main(String[] args) {
        UserService service = new UserService();
        service.oldMethod();
    }
}
```

This suppresses the warning for using a deprecated method.

---

## 12. Using `@SuppressWarnings` carefully

`@SuppressWarnings` can be useful, but it should not be abused.

If a warning appears, it's usually a good idea to ask yourself:

- is there a real problem?
- can I improve the code?
- am I hiding something important?

An example that's not recommended:

```java
@SuppressWarnings("all")
public class Main {
}
```

This can hide too many warnings.

It is better to be specific:

```java
@SuppressWarnings("unused")
```

---

## 13. `@FunctionalInterface`

You have already seen this annotation in the lambdas topic.

It is used to mark an interface as a functional interface.

Example:

```java
@FunctionalInterface
public interface TextValidator {
    boolean isValid(String text);
}
```

A functional interface must have a single abstract method.

If you add another abstract method, Java will flag an error.

```java
@FunctionalInterface
public interface TextValidator {
    boolean isValid(String text);

    // boolean isEmpty(String text); // error
}
```

---

## 14. Why `@FunctionalInterface` is useful

This annotation:

- documents the intention
- helps the compiler detect errors
- makes it clear that the interface is intended for lambdas

Usage example:

```java
@FunctionalInterface
public interface NumberChecker {
    boolean check(int number);
}
```

```java
public class Main {
    public static void main(String[] args) {
        NumberChecker isEven = number -> number % 2 == 0;

        System.out.println(isEven.check(10));
    }
}
```

---

## 15. Where annotations can be placed

Annotations can be placed on different elements of the code.

For example:

### 15.1. On a class

```java
@Deprecated
public class OldService {
}
```

### 15.2. On a method

```java
@Override
public String toString() {
    return "Example";
}
```

### 15.3. On an attribute

```java
@Deprecated
private String oldField;
```

### 15.4. On an interface

```java
@FunctionalInterface
public interface Action {
    void execute();
}
```

### 15.5. On parameters

```java
public void print(@Deprecated String text) {
}
```

Whether an annotation can be used in one place or another depends on how it is defined.

---

## 16. Annotations in frameworks

You'll often see annotations in frameworks.

For example, in Spring:

```java
@Service
public class ProductService {
}
```

```java
@GetMapping("/products")
public List<Product> getProducts() {
    return products;
}
```

In JUnit:

```java
@Test
void shouldAddTwoNumbers() {
}
```

In Lombok:

```java
@Getter
@Setter
public class User {
    private String name;
}
```

Each framework interprets its own annotations.

---

## 17. Key idea: an annotation doesn't do any magic on its own

An annotation only adds information.

For it to take effect, someone must read that information.

It can be read by:

- the compiler
- the IDE
- a framework
- a library
- your own code, through reflection

Example:

```java
@Test
```

This annotation works because JUnit looks for it and runs that method as a test.

If there were no tool reading `@Test`, the annotation wouldn't do anything useful on its own.

---

## 18. Creating your own annotation

You can create your own annotations using `@interface`.

Example:

```java
public @interface Important {
}
```

Usage:

```java
@Important
public class UserService {
}
```

Here we have created an annotation called `Important`.

---

## 19. Basic syntax of a custom annotation

```java
public @interface AnnotationName {
}
```

Example:

```java
public @interface Review {
}
```

Usage:

```java
@Review
public class ProductService {
}
```

For now, this annotation only marks something as needing review.

---

## 20. Annotations with values

An annotation can have elements.

Example:

```java
public @interface Author {
    String name();
}
```

Usage:

```java
@Author(name = "Laura")
public class Report {
}
```

Here `name` is an element of the annotation.

---

## 21. An element named `value`

If an annotation has an element called `value`, you can use a shorter syntax.

Definition:

```java
public @interface Version {
    String value();
}
```

Full usage:

```java
@Version(value = "1.0")
public class ProductService {
}
```

Shorthand usage:

```java
@Version("1.0")
public class ProductService {
}
```

This special shorthand only works with the element called `value`.

---

## 22. Default values

You can define default values.

```java
public @interface TaskInfo {
    String author();
    int priority() default 1;
}
```

Usage:

```java
@TaskInfo(author = "Laura")
public class TaskService {
}
```

Here `priority` is `1` because it has a default value.

You can also specify a different value:

```java
@TaskInfo(author = "Laura", priority = 3)
public class TaskService {
}
```

---

## 23. Types allowed in annotation elements

The elements of an annotation can't be of just any type.

They can be, among others:

- primitive types
- `String`
- `Class`
- enums
- other annotations
- arrays of the above types

Example:

```java
public @interface Info {
    String name();
    int version();
    boolean active() default true;
}
```

---

## 24. `@Retention`

`@Retention` indicates how long an annotation is kept.

Import:

```java
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
```

Example:

```java
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
public @interface Important {
}
```

`RetentionPolicy.RUNTIME` means that the annotation will be available at runtime.

---

## 25. Types of `RetentionPolicy`

There are three main policies:

### 25.1. `SOURCE`

The annotation only exists in the source code.

```java
@Retention(RetentionPolicy.SOURCE)
```

Typical examples:

- analysis tools
- annotations that only matter during compilation

### 25.2. `CLASS`

The annotation is stored in the `.class` file, but it is not normally available at runtime through reflection.

```java
@Retention(RetentionPolicy.CLASS)
```

### 25.3. `RUNTIME`

The annotation is kept at runtime and can be read with reflection.

```java
@Retention(RetentionPolicy.RUNTIME)
```

This is the option you will use if you want your program to read the annotation while it is running.

---

## 26. `@Target`

`@Target` indicates where an annotation can be used.

Import:

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Target;
```

Example:

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Target;

@Target(ElementType.METHOD)
public @interface Run {
}
```

This means that `@Run` can only be applied to methods.

---

## 27. Common values of `ElementType`

Some common values are:

- `TYPE` → classes, interfaces, records, enums
- `METHOD` → methods
- `FIELD` → attributes
- `PARAMETER` → parameters
- `CONSTRUCTOR` → constructors
- `LOCAL_VARIABLE` → local variables
- `PACKAGE` → packages

Example:

```java
@Target(ElementType.TYPE)
public @interface Entity {
}
```

This annotation can only be used on classes, interfaces, records or enums.

---

## 28. Annotation with `@Retention` and `@Target`

Complete example:

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface Important {
}
```

Usage:

```java
@Important
public class UserService {
}
```

This annotation:

- is kept at runtime
- can only be applied to types such as classes or interfaces

---

## 29. Applying an annotation to multiple element types

You can allow multiple targets.

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Target;

@Target({ElementType.TYPE, ElementType.METHOD})
public @interface Review {
}
```

Usage:

```java
@Review
public class ProductService {
    @Review
    public void createProduct() {
    }
}
```

---

## 30. Guided example: a `@Todo` annotation
Let's create an annotation to mark pending parts of the code.

### 30.1. `Todo.java`

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD})
public @interface Todo {
    String value();
    String author() default "Unknown";
}
```

### 30.2. Usage

```java
@Todo(value = "Review validation rules", author = "Laura")
public class UserService {
    @Todo("Improve error messages")
    public void createUser() {
        System.out.println("Creating user...");
    }
}
```

---

## 31. Introduction to reflection

**Reflection** lets you inspect classes, methods and attributes at runtime.

With reflection you can ask things like:

- what methods a class has
- what attributes it has
- what annotations it has
- what constructors exist

Annotations with:

```java
@Retention(RetentionPolicy.RUNTIME)
```

can be read through reflection.

---

## 32. Reading a class annotation

Let's assume this annotation:

```java
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
public @interface Important {
}
```

Annotated class:

```java
@Important
public class UserService {
}
```

Reading:

```java
public class Main {
    public static void main(String[] args) {
        Class<UserService> clazz = UserService.class;

        boolean hasAnnotation = clazz.isAnnotationPresent(Important.class);

        System.out.println(hasAnnotation);
    }
}
```

Result:

```text
true
```

---

## 33. Reading values from an annotation

Annotation:

```java
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
public @interface Author {
    String name();
}
```

Class:

```java
@Author(name = "Laura")
public class Report {
}
```

Reading:

```java
public class Main {
    public static void main(String[] args) {
        Class<Report> clazz = Report.class;

        Author author = clazz.getAnnotation(Author.class);

        if (author != null) {
            System.out.println(author.name());
        }
    }
}
```

Result:

```text
Laura
```

---

## 34. Reading method annotations

Annotation:

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface Run {
}
```

Class:

```java
public class TaskService {
    @Run
    public void task1() {
        System.out.println("Task 1");
    }

    public void task2() {
        System.out.println("Task 2");
    }
}
```

Reading:

```java
import java.lang.reflect.Method;

public class Main {
    public static void main(String[] args) {
        Class<TaskService> clazz = TaskService.class;

        for (Method method : clazz.getDeclaredMethods()) {
            if (method.isAnnotationPresent(Run.class)) {
                System.out.println("Method with @Run: " + method.getName());
            }
        }
    }
}
```

Approximate result:

```text
Method with @Run: task1
```

---

## 35. Running methods marked with an annotation

This example is more advanced, but it helps you understand how tools like JUnit work.

```java
import java.lang.reflect.Method;

public class Main {
    public static void main(String[] args) {
        TaskService service = new TaskService();

        Class<TaskService> clazz = TaskService.class;

        for (Method method : clazz.getDeclaredMethods()) {
            if (method.isAnnotationPresent(Run.class)) {
                try {
                    method.invoke(service);
                } catch (Exception e) {
                    System.out.println("Could not execute method: " + method.getName());
                }
            }
        }
    }
}
```

Class:

```java
public class TaskService {
    @Run
    public void task1() {
        System.out.println("Running task 1");
    }

    public void task2() {
        System.out.println("Running task 2");
    }
}
```

Result:

```text
Running task 1
```

This is a very simple example of how a tool can search for annotations and act on them.

---

## 36. Repeatable annotations

Java allows the same annotation to be repeated on the same element if the annotation is designed for it.

This is done with:

```java
@Repeatable
```

Conceptual example:

```java
@Tag("java")
@Tag("backend")
public class Course {
}
```

This topic is more advanced, but it is worth knowing that it exists.

---

## 37. Meta-annotations

A meta-annotation is an annotation applied to another annotation.

You have already seen two:

```java
@Retention(...)
@Target(...)
```

These don't annotate business classes directly; instead, they configure how a custom annotation works.

Example:

```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface Entity {
}
```

Here `@Retention` and `@Target` are meta-annotations.

---

## 38. Annotations and records

You can also use annotations with records.

Example:

```java
@Deprecated
public record OldUser(String name, String email) {
}
```

You can also annotate components:

```java
public record User(@Deprecated String name, String email) {
}
```

In frameworks, this can be very useful for validation or serialization.

Conceptual example:

```java
public record UserRequest(
        @Required String name,
        @Required String email
) {
}
```

---

## 39. Annotations and modules

In modular projects, some tools that read annotations using reflection may require you to open packages with `opens`.

Example:

```java
module com.amazaing.app {
    opens com.amazaing.app.models;
}
```

This allows certain frameworks to inspect classes and annotations at runtime.

For now, just remember this idea:

- if a framework uses reflection, it may need special access in modular projects

---

## 40. Complete example: a mini task system

Let's create an annotation to mark methods that should be run.

### 40.1. `RunTask.java`

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface RunTask {
    String value() default "Unnamed task";
}
```

### 40.2. `TaskRunner.java`

```java
public class TaskRunner {
    @RunTask("Clean temporary files")
    public void cleanFiles() {
        System.out.println("Cleaning files...");
    }

    @RunTask("Send report")
    public void sendReport() {
        System.out.println("Sending report...");
    }

    public void helperMethod() {
        System.out.println("Helper method");
    }
}
```

### 40.3. `Main.java`

```java
import java.lang.reflect.Method;

public class Main {
    public static void main(String[] args) {
        TaskRunner runner = new TaskRunner();

        Class<TaskRunner> clazz = TaskRunner.class;

        for (Method method : clazz.getDeclaredMethods()) {
            RunTask annotation = method.getAnnotation(RunTask.class);

            if (annotation != null) {
                System.out.println("Running: " + annotation.value());

                try {
                    method.invoke(runner);
                } catch (Exception e) {
                    System.out.println("Error running task: " + method.getName());
                }
            }
        }
    }
}
```

Approximate result:

```text
Running: Clean temporary files
Cleaning files...
Running: Send report
Sending report...
```

---

## 41. Complete example: an annotation for roles

### 41.1. `RequiresRole.java`

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface RequiresRole {
    String value();
}
```

### 41.2. `AdminService.java`

```java
public class AdminService {
    @RequiresRole("ADMIN")
    public void deleteUser() {
        System.out.println("Deleting user...");
    }

    @RequiresRole("USER")
    public void viewProfile() {
        System.out.println("Viewing profile...");
    }
}
```

### 41.3. Reading the annotation (simple version)

```java
import java.lang.reflect.Method;

public class Main {
    public static void main(String[] args) {
        Class<AdminService> clazz = AdminService.class;

        for (Method method : clazz.getDeclaredMethods()) {
            RequiresRole role = method.getAnnotation(RequiresRole.class);

            if (role != null) {
                System.out.println(method.getName() + " requires role: " + role.value());
            }
        }
    }
}
```

This example doesn't implement real security, but it shows how an annotation can describe requirements.

---

## 42. When to create your own annotations
Creating your own annotations can make sense when you want to:

- mark classes or methods
- add readable metadata
- build small internal tools
- configure behavior
- avoid repetitive code
- design a small declarative API

Example:

```java
@RequiresRole("ADMIN")
public void deleteUser() {
}
```

This communicates intent clearly.

---

## 43. When not to create your own annotations

You don't always need your own annotations.

Avoid them if:

- a normal interface would be clearer
- a normal method would be sufficient
- you're only going to use them once
- they complicate the code without adding value
- there is no tool or code that reads them

Remember:

> an annotation is only useful if someone interprets it.

---

## 44. Annotations vs comments

A comment is just text for humans.

```java
// This method requires admin role
public void deleteUser() {
}
```

An annotation can be read by tools or by the program.

```java
@RequiresRole("ADMIN")
public void deleteUser() {
}
```

The key difference is:

- comment → informal information
- annotation → structured metadata

---

## 45. Common beginner mistakes

### 45.1. Thinking that an annotation runs code on its own

It doesn't.  
Someone must read it and interpret it.

### 45.2. Forgetting `@Retention(RetentionPolicy.RUNTIME)`

If you want to read the annotation with reflection at runtime, you need:

```java
@Retention(RetentionPolicy.RUNTIME)
```

### 45.3. Misusing `@Target`

If you define:

```java
@Target(ElementType.METHOD)
```

you will not be able to apply that annotation to a class.

### 45.4. Overusing `@SuppressWarnings`

It can hide real problems.

### 45.5. Creating unnecessary annotations

Not everything needs its own annotation.

---

## 46. Best practices

- Use `@Override` whenever you override methods.
- Use `@FunctionalInterface` on interfaces designed for lambdas.
- Use `@Deprecated` to mark code that should not be used in new versions.
- Use `@SuppressWarnings` only when you understand the warning.
- Define `@Retention` and `@Target` in your own annotations.
- Use `RetentionPolicy.RUNTIME` only if you need to read the annotation at runtime.
- Choose clear names for your annotations.
- Create your own annotations only if they provide clarity or real functionality.
- Remember that annotations are metadata, not business logic in themselves.

---

## 47. Things to keep in mind

- Annotations start with `@`.
- They add metadata to the code.
- They can be read by Java, tools, frameworks or reflection.
- `@Override` helps avoid errors when overriding methods.
- `@Deprecated` marks obsolete code.
- `@SuppressWarnings` hides specific warnings.
- `@FunctionalInterface` marks functional interfaces.
- You can create your own annotations with `@interface`.
- `@Retention` indicates how long an annotation is kept.
- `@Target` indicates where it can be used.
- To read annotations at runtime you need reflection and `RetentionPolicy.RUNTIME`.

---

## 48. Final summary

Annotations are a very important tool in modern Java.

They let you add extra information to the code in a structured way.

Some annotations help the compiler:

```java
@Override
@Deprecated
@SuppressWarnings
@FunctionalInterface
```

Others are used by frameworks:

```java
@Test
@Service
@GetMapping
@Entity
```

And you can also create your own annotations:

```java
public @interface Important {
}
```

The main idea is:
> an annotation describes something about the code, but needs some tool or logic to interpret it.

Mastering annotations will help you better understand many Java libraries and frameworks, and will let you write more expressive code when it makes sense.

---

In the next topic we'll keep moving forward with modern Java and look at **Modules and Modern Java**, where you'll learn how to organize projects with the module system and discover some current ideas from the Java ecosystem.
