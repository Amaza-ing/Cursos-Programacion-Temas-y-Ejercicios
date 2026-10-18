# Topic 29. Lambdas and Functional Interfaces

## 1. Introduction

In the previous topic you learned what **generics** are, how they allow you to work with types more safely and how they constantly appear in modern Java collections and APIs.

Now we are going to dive into a fundamental part of today's Java:

- **lambda expressions**
- **functional interfaces**

These tools made it possible to write Java code that is more compact, more expressive and more convenient for working with:

- collections
- sorting
- callbacks
- validations
- `Stream API`

At first glance, lambdas may look like strange syntax, but they actually express a very simple idea:

> being able to pass behavior around as if it were data

In this topic you will learn:

- What a functional interface is
- How it relates to lambdas
- How to write a lambda
- How to replace anonymous classes with lambdas
- Common Java functional interfaces
- The `@FunctionalInterface` annotation
- Variables captured in lambdas
- What a method reference is
- Typical mistakes and good practices

---

## 2. The problem before lambdas

Before lambdas, if you wanted to pass a “behavior” to a method, you typically needed to:

- create a class
- or use an anonymous class

That worked, but sometimes it made the code longer than necessary.

For example, imagine you want to define a simple action:

```java
public interface Action {
    void execute();
}
```

Without lambdas, you could do something like this:

```java
public class Main {
    public static void main(String[] args) {
        Action action = new Action() {
            @Override
            public void execute() {
                System.out.println("Running action...");
            }
        };

        action.execute();
    }
}
```

This works, but for such a small operation the code is quite verbose.

Lambdas were created to simplify this kind of situation.

---

## 3. What is a functional interface

A **functional interface** is an interface that has **a single abstract method**.

Example:

```java
public interface Action {
    void execute();
}
```

This interface has a single abstract method:

- `execute()`

That's why it is a functional interface.

### 3.1. Key idea

A functional interface represents an action or behavior that can be implemented in a specific way.

That makes it perfect for lambdas.

---

## 4. A simple functional interface example

```java
public interface Greeter {
    void greet();
}
```

Since it only has one abstract method, it is functional.

We can implement it in a classic way:

```java
public class FriendlyGreeter implements Greeter {
    @Override
    public void greet() {
        System.out.println("Hello!");
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        Greeter greeter = new FriendlyGreeter();
        greeter.greet();
    }
}
```

But with lambdas we will see that this can be written in a much shorter way.

---

## 5. What is a lambda expression

A **lambda** is a compact way to provide the implementation of a functional interface.

Example:

```java
() -> System.out.println("Hello!")
```

This means, in a simplified way:

- it takes no parameters
- it runs that statement

If we assign it to the `Greeter` interface, it would look like this:

```java
public class Main {
    public static void main(String[] args) {
        Greeter greeter = () -> System.out.println("Hello!");

        greeter.greet();
    }
}
```

This does the same thing as the classic implementation, but with much less code.

---

## 6. Basic syntax of a lambda

The general form is this:

```java
(parameters) -> expression
```

or:

```java
(parameters) -> {
    // block of code
}
```

The lambda has two parts:

- on the left, the parameters
- on the right, the body

---

## 7. First examples of lambdas

### 7.1. No parameters

```java
() -> System.out.println("Hello")
```

### 7.2. With one parameter

```java
name -> System.out.println(name)
```

### 7.3. With two parameters

```java
(a, b) -> a + b
```

### 7.4. With a code block

```java
(name) -> {
    String message = "Hello, " + name;
    System.out.println(message);
}
```

---

## 8. Replacing an anonymous class with a lambda

This is one of the most important steps to understanding them.

### 8.1. Version with an anonymous class

```java
public interface Calculator {
    int calculate(int a, int b);
}

public class Main {
    public static void main(String[] args) {
        Calculator add = new Calculator() {
            @Override
            public int calculate(int a, int b) {
                return a + b;
            }
        };

        System.out.println(add.calculate(10, 20));
    }
}
```

### 8.2. Version with a lambda

```java
public interface Calculator {
    int calculate(int a, int b);
}

public class Main {
    public static void main(String[] args) {
        Calculator add = (a, b) -> a + b;

        System.out.println(add.calculate(10, 20));
    }
}
```

Now the code is much clearer.

---

## 9. When an interface can be used with a lambda

Only when it is a **functional interface**, that is, when it has **a single abstract method**.

This one works:

```java
public interface Printer {
    void print(String text);
}
```

This one doesn't:

```java
public interface InvalidInterface {
    void method1();
    void method2();
}
```

The second one cannot be represented with a single lambda because it has two abstract methods.

---

## 10. The `@FunctionalInterface` annotation

Java has a very useful annotation to indicate that an interface is meant to be functional:

```java
@FunctionalInterface
public interface Printer {
    void print(String text);
}
```

### 10.1. What is it for?

It is used to:

- make the intention clear
- make the code more readable
- ask the compiler to warn you if you break the single-abstract-method rule

Example:

```java
@FunctionalInterface
public interface Printer {
    void print(String text);

    // void otherMethod(); // esto daría error
}
```

If you add a second abstract method, Java will report an error.

### 10.2. Good practice

Although it is not required, it is highly recommended to use `@FunctionalInterface` when an interface is meant to be used with lambdas.

---

## 11. Your own functional interfaces

You can create your own functional interfaces when it makes sense.

### 11.1. Example: `TextValidator`

```java
@FunctionalInterface
public interface TextValidator {
    boolean isValid(String text);
}
```

Usage with a lambda:

```java
public class Main {
    public static void main(String[] args) {
        TextValidator notBlank = text -> text != null && !text.isBlank();

        System.out.println(notBlank.isValid("Java"));
        System.out.println(notBlank.isValid("   "));
    }
}
```

---

## 12. Parameters in lambdas

### 12.1. One parameter without an explicit type

```java
name -> System.out.println(name)
```

### 12.2. One parameter with an explicit type

```java
(String name) -> System.out.println(name)
```

Both options are often valid.

### 12.3. Several parameters

```java
(a, b) -> a + b
```

or with explicit types:

```java
(int a, int b) -> a + b
```

In most cases Java can infer the type, so there is no need to write it.

---

## 13. The body of a lambda

### 13.1. A simple expression

If the body is a single expression, you can write it without curly braces:

```java
(a, b) -> a + b
```

### 13.2. A block with several statements

If you need multiple lines, use curly braces:

```java
(a, b) -> {
    int result = a + b;
    return result;
}
```

### 13.3. Important rule

If you use curly braces and the lambda returns something, you must use `return`.

---

## 14. Java's standard functional interfaces

Java already comes with many functional interfaces out of the box, especially in the package:

```java
java.util.function
```

The most common ones are:

- `Predicate<T>`
- `Function<T, R>`
- `Consumer<T>`
- `Supplier<T>`
- `UnaryOperator<T>`
- `BinaryOperator<T>`

These interfaces are widely used with `Stream API`, collections and modern code in general.

---

## 15. `Predicate<T>`

`Predicate<T>` represents a function that:

- receives a value of type `T`
- returns a `boolean`

It is ideal for validations and filters.

Example:

```java
import java.util.function.Predicate;

public class Main {
    public static void main(String[] args) {
        Predicate<String> isLongText = text -> text.length() > 5;

        System.out.println(isLongText.test("Java"));
        System.out.println(isLongText.test("Programming"));
    }
}
```

Main method:

- `test(T value)`

---

## 16. `Function<T, R>`

`Function<T, R>` represents a function that:

- receives a value of type `T`
- returns a value of type `R`

Example:

```java
import java.util.function.Function;

public class Main {
    public static void main(String[] args) {
        Function<String, Integer> textLength = text -> text.length();

        System.out.println(textLength.apply("Java"));
    }
}
```

Main method:

- `apply(T value)`

---

## 17. `Consumer<T>`

`Consumer<T>` represents an operation that:

- receives a value of type `T`
- does not return anything

It is widely used for printing, saving, processing, etc.

Example:

```java
import java.util.function.Consumer;

public class Main {
    public static void main(String[] args) {
        Consumer<String> printer = text -> System.out.println("Text: " + text);

        printer.accept("Hello");
    }
}
```

Main method:

- `accept(T value)`

---

## 18. `Supplier<T>`

`Supplier<T>` represents an operation that:

- takes no parameters
- returns a value of type `T`

Example:

```java
import java.util.function.Supplier;

public class Main {
    public static void main(String[] args) {
        Supplier<Double> randomValue = () -> Math.random();

        System.out.println(randomValue.get());
    }
}
```

Main method:

- `get()`

---

## 19. `UnaryOperator<T>` and `BinaryOperator<T>`

These are useful variants of `Function`.

### 19.1. `UnaryOperator<T>`

Receives a value of type `T` and returns another `T`.

```java
import java.util.function.UnaryOperator;

public class Main {
    public static void main(String[] args) {
        UnaryOperator<String> toUpperCase = text -> text.toUpperCase();

        System.out.println(toUpperCase.apply("java"));
    }
}
```

### 19.2. `BinaryOperator<T>`

Receives two values of type `T` and returns another `T`.

```java
import java.util.function.BinaryOperator;

public class Main {
    public static void main(String[] args) {
        BinaryOperator<Integer> add = (a, b) -> a + b;

        System.out.println(add.apply(10, 20));
    }
}
```

---

## 20. Guided example: using your own functional interface

```java
@FunctionalInterface
public interface NumberChecker {
    boolean check(int number);
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        NumberChecker isEven = number -> number % 2 == 0;
        NumberChecker isPositive = number -> number > 0;

        System.out.println(isEven.check(10));
        System.out.println(isEven.check(7));

        System.out.println(isPositive.check(5));
        System.out.println(isPositive.check(-3));
    }
}
```

---

## 21. Lambdas and passing behavior to methods

One of the great advantages of lambdas is that you can pass them as arguments to a method.

Example:

```java
import java.util.function.Consumer;

public class Main {
    public static void main(String[] args) {
        executeAction(() -> System.out.println("Running action..."));
    }

    public static void executeAction(Action action) {
        action.execute();
    }
}

@FunctionalInterface
interface Action {
    void execute();
}
```

Here you are passing an implementation directly to the method.

---

## 22. Guided example: a method that receives a `Predicate`

```java
import java.util.function.Predicate;

public class Main {
    public static void main(String[] args) {
        System.out.println(checkText("Java", text -> text.length() > 3));
        System.out.println(checkText("Hi", text -> text.length() > 3));
    }

    public static boolean checkText(String text, Predicate<String> validator) {
        return validator.test(text);
    }
}
```

This makes the method more flexible, because the validation criterion is not fixed.

---

## 23. Lambdas with collections

Even though you haven't seen `Stream API` yet, you can already use lambdas with several modern collection methods.

For example, with `forEach`.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        names.forEach(name -> System.out.println(name));
    }
}
```

Here each item in the list is processed with a lambda.

---

## 24. Example with `removeIf`

Another very useful method is `removeIf`, which receives a `Predicate`.

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = new ArrayList<>(List.of("Laura", "Al", "Maria", "Jo"));

        names.removeIf(name -> name.length() < 4);

        System.out.println(names);
    }
}
```

The lambda indicates which elements should be removed.

---

## 25. Example with `sort`

You can also use lambdas to define how to sort.

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = new ArrayList<>(List.of("Laura", "Alex", "Maria"));

        names.sort((a, b) -> a.compareTo(b));

        System.out.println(names);
    }
}
```

And you could also sort by length:

```java
names.sort((a, b) -> Integer.compare(a.length(), b.length()));
```

---

## 26. Variables captured in lambdas

A lambda can use variables from its outer context, but with an important rule:

> the variable must be final or effectively final

Valid example:

```java
public class Main {
    public static void main(String[] args) {
        String prefix = "Hello ";

        Consumer<String> greeter = name -> System.out.println(prefix + name);

        greeter.accept("Laura");
    }
}
```

This works because `prefix` does not change after it is assigned.

### 26.1. What does “effectively final” mean?

It means that you don't need to write `final`, but in practice the variable never changes.

This would be incorrect:

```java
public class Main {
    public static void main(String[] args) {
        String prefix = "Hello ";

        // prefix = "Hi "; // si cambias esto, ya no sería efectivamente final

        Consumer<String> greeter = name -> System.out.println(prefix + name);
    }
}
```

---

## 27. `this` in lambdas and anonymous classes

This is a more advanced detail, but useful:

- in an **anonymous class**, `this` refers to the object of the anonymous class
- in a **lambda**, `this` refers to the outer object

You don't need to learn it in depth yet, but it's good to know that lambdas and anonymous classes are not exactly the same internally.

---

## 28. What is a method reference

A **method reference** is an even shorter way to write certain lambdas.

Example with a lambda:

```java
name -> System.out.println(name)
```

Equivalent method reference:

```java
System.out::println
```

Full example:

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        names.forEach(System.out::println);
    }
}
```

This does the same thing, but with a more compact syntax.

---

## 29. Common types of method references

### 29.1. Static method

```java
Integer::parseInt
```

### 29.2. Instance method of a specific object

```java
System.out::println
```

### 29.3. Instance method of a type

```java
String::toUpperCase
```

### 29.4. Constructor

```java
ArrayList::new
```

You don't need to master all of them right now, but you do need to recognize the syntax.

---

## 30. Guided example with a method reference

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        names.forEach(System.out::println);
    }
}
```

This is equivalent to:

```java
names.forEach(name -> System.out.println(name));
```

---

## 31. Guided example: a validator with `Predicate`

```java
import java.util.function.Predicate;

public class Main {
    public static void main(String[] args) {
        Predicate<String> notBlank = text -> text != null && !text.isBlank();
        Predicate<String> longEnough = text -> text.length() >= 5;

        System.out.println(notBlank.test("Java"));
        System.out.println(notBlank.test("   "));

        System.out.println(longEnough.test("Hi"));
        System.out.println(longEnough.test("Programming"));
    }
}
```

---
## 32. Guided example: a transformer with `Function`

```java
import java.util.function.Function;

public class Main {
    public static void main(String[] args) {
        Function<String, String> toUpperCase = text -> text.toUpperCase();
        Function<String, Integer> textLength = text -> text.length();

        System.out.println(toUpperCase.apply("java"));
        System.out.println(textLength.apply("Programming"));
    }
}
```

---

## 33. Guided example: a consumer with `Consumer`

```java
import java.util.List;
import java.util.function.Consumer;

public class Main {
    public static void main(String[] args) {
        Consumer<String> printer = text -> System.out.println("Value: " + text);

        List<String> names = List.of("Laura", "Alex", "Maria");

        names.forEach(printer);
    }
}
```

---

## 34. Guided example: a supplier with `Supplier`

```java
import java.util.function.Supplier;

public class Main {
    public static void main(String[] args) {
        Supplier<String> fixedMessage = () -> "Welcome to Java";
        Supplier<Integer> randomNumber = () -> (int) (Math.random() * 100);

        System.out.println(fixedMessage.get());
        System.out.println(randomNumber.get());
    }
}
```

---

## 35. When to use your own interfaces and when to use those of `java.util.function`

### 35.1. Use standard interfaces when

- the case fits well into `Predicate`, `Function`, `Consumer`, `Supplier`, etc.
- you want to take advantage of standard APIs
- you want code that is more familiar to other Java programmers

### 35.2. Use your own interfaces when

- the name of the behavior is important for the domain
- you want a more expressive interface
- the case does not fit well into the standard interfaces

For example, `TextValidator` or `OrderCalculator` may make sense as names in a project.

---

## 36. Common beginner mistakes

### 36.1. Thinking that any interface works with a lambda

No.  
Only a functional interface does.

### 36.2. Forgetting that you need curly braces for several statements

Not this:

```java
// (a, b) -> int result = a + b; return result; // no
```

It must be:

```java
(a, b) -> {
    int result = a + b;
    return result;
}
```

### 36.3. Forgetting `return` in a lambda with a block

If you use curly braces and the lambda returns a value, you need `return`.

### 36.4. Trying to modify captured variables

The outer variables used by the lambda must be final or effectively final.

### 36.5. Using lambdas when a normal class would be clearer

Not everything should be written with lambdas.  
There are cases where a clearly named class or method is better.

---

## 37. Good practices

- Use `@FunctionalInterface` when designing your own functional interface.
- Prefer standard interfaces (`Predicate`, `Function`, `Consumer`, `Supplier`) when they fit well.
- Use lambdas for short, clear behaviors.
- If the lambda starts to get complex, consider moving the logic to a named method.
- Use method references when they improve readability.
- Don't complicate the code just for the sake of using modern syntax.

---

## 38. Things to keep in mind

- A functional interface has a single abstract method.
- Lambdas are a compact way to implement functional interfaces.
- Java includes very useful standard functional interfaces in `java.util.function`.
- `Predicate` validates, `Function` transforms, `Consumer` consumes and `Supplier` produces.
- Lambdas let you pass behavior to methods.
- Method references are a shorter version of some lambdas.
- Lambdas are used a lot with collections and `Stream API`.

---

## 39. Final summary

Lambdas and functional interfaces are an essential part of modern Java.

Thanks to them you can write code that is:

- more compact
- more expressive
- more flexible
- better prepared to work with collections and streams

At first they may seem like a new syntax that is hard to read, but once you understand that a lambda is nothing more than a short implementation of a functional interface, everything starts to fall into place.

Mastering this part will help you a lot in topics such as:

- sorting
- filters
- transformations
- `forEach`
- `removeIf`
- `Stream API`

---
In the next topic we will keep moving forward with modern Java and we will see **Stream API**, a very powerful tool that is constantly used together with lambdas and functional interfaces.
