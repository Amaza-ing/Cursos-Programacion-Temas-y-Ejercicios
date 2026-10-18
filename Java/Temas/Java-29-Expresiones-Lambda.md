# Topic 29. Lambdas and Functional Interfaces

## 1. Introduction

In the previous topic you learned what **generics** are, how they allow you to work with types more safely and how they constantly appear in modern Java collections and APIs.

Now we are going to enter a fundamental part of current Java:

- **lambda expressions**
- **functional interfaces**

These tools made it possible for Java to write code that was more compact, more expressive, and more comfortable to work with:

- collections
- orders
- callbacks
- validations
- `Stream API`

At first glance, lambdas may seem like a strange syntax, but they actually solve a very simple idea:

> be able to pass behavior as if it were data

In this topic you will learn:

- What is a functional interface
- What relationship does it have with lambdas?
- How to write a lambda
- How to replace anonymous classes with lambdas
- Common Java functional interfaces
- Annotation `@FunctionalInterface`
- Variables captured in lambdas
- What is a method reference
- Typical errors and good practices

---

## 2. The problem before lambdas

Before lambdas, if you wanted to pass a “behavior” to a method, you typically needed:

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

Lambdas were created to simplify these types of situations.

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

That makes it perfect for using lambdas.

---

## 4. Simple functional interface example

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

But with lambdas we will see that this can be written much shorter.

---

## 5. What is a lambda expression

A **lambda** is a compact way to provide the implementation of a functional interface.

Example:

```java
() -> System.out.println("Hello!")
```

This means, in a simplified way:

- does not receive parameters
- execute that instruction

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

### 7.2. with a parameter

```java
name -> System.out.println(name)
```

### 7.3. With two parameters

```java
(a, b) -> a + b
```

### 7.4. With code block

```java
(name) -> {
    String message = "Hello, " + name;
    System.out.println(message);
}
```

---

## 8. Replace an anonymous class with a lambda
This is one of the most important steps to understand them.

### 8.1. Version with anonymous class

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

### 8.2. Version with lambda

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

## 9. When an interface can be used with lambda

Only when it is a **functional interface**, that is, when it has **a single abstract method**.

This yes:

```java
public interface Printer {
    void print(String text);
}
```

Not this:

```java
public interface InvalidInterface {
    void method1();
    void method2();
}
```

The second cannot be represented with a single lambda because there are two abstract methods.

---

## 10. The `@FunctionalInterface` annotation

Java has a very useful annotation to mark that an interface is intended as functional:

```java
@FunctionalInterface
public interface Printer {
    void print(String text);
}
```

### 10.1. What is it for?

Serves for:

- make the intention clear
- make the code more readable
- ask the compiler to warn you if you break the only abstract method rule

Example:

```java
@FunctionalInterface
public interface Printer {
    void print(String text);

    // void otherMethod(); // esto daría error
}
```

If you add a second abstract method, Java will flag an error.

### 10.2. Good practice

Although not required, it is highly recommended to use `@FunctionalInterface` when an interface is intended for lambdas.

---

## 11. Own functional interfaces

You can create your own functional interfaces when it makes sense.

### 11.1. Example: `TextValidator`

```java
@FunctionalInterface
public interface TextValidator {
    boolean isValid(String text);
}
```

Usage with lambda:

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

### 12.1. A parameter without an explicit type

```java
name -> System.out.println(name)
```

### 12.2. An explicit type parameter

```java
(String name) -> System.out.println(name)
```

Both options are valid many times.

### 12.3. Various parameters

```java
(a, b) -> a + b
```

or with explicit types:

```java
(int a, int b) -> a + b
```

In most cases Java can infer the type, so there is no need to write it.

---

## 13. Body of a lambda

### 13.1. simple expression

If the body is a single expression, you can write it without curly braces:

```java
(a, b) -> a + b
```

### 13.2. Block with several instructions

If you need multiple lines, use curly braces:

```java
(a, b) -> {
    int result = a + b;
    return result;
}
```

### 13.3. Important rule

If you use braces and the lambda returns something, you should use `return`.

---

## 14. Java Standard Functional Interfaces

Java already comes with many functional interfaces out of the box, especially in the package:

```java
java.util.function
```

The most common are:

- `Predicate<T>`
- `Function<T, R>`
- `Consumer<T>`
- `Supplier<T>`
- `UnaryOperator<T>`
- `BinaryOperator<T>`

These interfaces are widely used with `Stream API`, collections, and modern code.

---

## 15. `Predicate<T>`

`Predicate<T>` represents a function that:

- receives a value of type `T`
- returns `boolean`

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

- does not receive parameters
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

One of the great advantages of lambdas is that you can pass them as an argument to a method.

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

## 22. Guided Example: Method that receives an `Predicate`

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

Even if you haven't seen `Stream API` yet, lambdas can already be used with collections in several modern methods.

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

Another very useful method is `removeIf`, which receives an `Predicate`.

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

> the variable must be final or actually final

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

This works because `prefix` does not change after being assigned.

### 26.1. What does “effectively final” mean?

It means that it is not necessary to write `final`, but in practice the variable does not change.

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

You don't need to memorize it thoroughly yet, but it's good to know that lambdas and anonymous classes are not exactly the same internally.

---

## 28. What is a method reference

A **method reference** is an even shorter way to write certain lambdas.

Example with lambda:

```java
name -> System.out.println(name)
```

Method reference equivalent:

```java
System.out::println
```

Full use:

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

### 29.1. static method

```java
Integer::parseInt
```

### 29.2. Instance method of a concrete object

```java
System.out::println
```

### 29.3. Instance method of a type

```java
String::toUpperCase
```

### 29.4. Builder

```java
ArrayList::new
```

It is not necessary to master all of them right now, but you do need to recognize the syntax.

---

## 30. Guided example with method reference

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

## 31. Guided Example: Validator with `Predicate`

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
## 32. Guided Example: Transformer with `Function`

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

## 33. Guided Example: Consumer with `Consumer`

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

## 34. Guided Example: Provider with `Supplier`

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

- the case fits well on `Predicate`, `Function`, `Consumer`, `Supplier`, etc.
- want to take advantage of standard APIs
- want code more familiar to other Java programmers

### 35.2. Use your own interfaces when

- the name of the behavior is important to the domain
- want a more expressive interface
- the case does not fit well into standard interfaces

For example, `TextValidator` or `OrderCalculator` may make sense as project names.

---

## 36. Typical mistakes when starting

### 36.1. Think that any interface works for lambda

No.  
Just a functional interface.

### 36.2. Forget that with several instructions you need keys

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

### 36.3. Forget `return` in a lambda with block

If you use braces and the lambda returns value, you need `return`.

### 36.4. Try to modify captured variables

The external variables used by the lambda must be final or actually final.

### 36.5. Using lambdas when a normal class would be clearer

Not everything should be written with lambdas.  
There are cases where a clearly named class or method is better.

---

## 37. Good practices

- Use `@FunctionalInterface` when designing your own functional interface.
- Prefer standard interfaces (`Predicate`, `Function`, `Consumer`, `Supplier`) when they fit well.
- Use lambdas for short and clear behaviors.
- If the lambda starts to get complex, consider moving the logic to a named method.
- Use method references when they improve readability.
- Don't complicate the code just by using modern syntax.

---

## 38. To take into account

- A functional interface has a single abstract method.
- Lambdas are a compact way to implement functional interfaces.
- Java includes very useful standard functional interfaces in `java.util.function`.
- `Predicate` validates, `Function` transforms, `Consumer` consumes and `Supplier` produces.
- Lambdas allow behavior to be passed to methods.
- Method references are a shortened version of some lambdas.
- Lambdas are used a lot with collections and `Stream API`.

---

## 39. Final summary

Lambdas and functional interfaces are an essential part of modern Java.

Thanks to them you can write code:

- more compact
- more expressive
- more flexible
- better prepared to work with collections and streams

At first they may seem like a new syntax that is difficult to read, but once you understand that a lambda is nothing more than a short implementation of a functional interface, everything starts to fall into place.

Mastering this part will help you a lot in topics such as:

- orders
- filters
- transformations
- `forEach`
- `removeIf`
- `Stream API`

---
In the next topic we will continue advancing with modern Java and we will see **Stream API**, a very powerful tool that constantly works together with lambdas and functional interfaces.
