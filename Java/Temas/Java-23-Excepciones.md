# Topic 23. Exceptions in Java: `try`, `catch`, `finally`, `throw` and `throws`

## 1. Introduction

When a Java program runs, not everything always goes well.

Problems may occur such as:

- dividing by zero
- accessing an invalid position in an array
- converting non-numeric text to an integer
- working with a `null` value
- trying to read a file that does not exist

Java represents these problems with **exceptions**.

Exceptions allow you to:

- detect runtime errors
- separate normal logic from error-handling logic
- react to problems in a controlled way
- prevent the program from crashing suddenly without explanation

In this topic you will learn:

- what an exception is
- what the difference between an error and an exception is
- how to use `try`, `catch` and `finally`
- what `throw` and `throws` do
- what checked and unchecked exceptions are
- how to create your own exceptions
- good practices and typical mistakes

---

[![Exceptions](https://img.youtube.com/vi/GEq5_Uuza_8/0.jpg)](https://www.youtube.com/watch?v=GEq5_Uuza_8&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What is an exception

An **exception** is an object that represents an abnormal situation or an error that occurs during program execution.

Instead of continuing to run normally, Java:

1. creates an exception
2. “throws” that exception
3. looks for a place to catch and handle it

If no one catches it, the program ends with an error.

---

## 3. Simple exception example

```java
public class Main {
    public static void main(String[] args) {
        int result = 10 / 0;
        System.out.println(result);
    }
}
```

This throws an exception:

```java
ArithmeticException
```

Why?

Because you cannot divide by zero.

---

## 4. Basic exception hierarchy

In Java, exceptions are part of a class hierarchy.

At a very high level:

- `Throwable`
  - `Error`
  - `Exception`
    - `RuntimeException`

### 4.1. `Error`

Represents serious system or JVM problems.

Examples:

- `OutOfMemoryError`
- `StackOverflowError`

They are not normally caught or handled as a regular part of the program.

### 4.2. `Exception`

Represents problems that an application can handle.

Within `Exception`, the most important ones are:

- **checked exceptions**
- **unchecked exceptions** (`RuntimeException`)

---

## 5. Checked vs unchecked exceptions

This difference is very important.

### 5.1. Unchecked exceptions

These are exceptions that inherit from `RuntimeException`.

Examples:

- `ArithmeticException`
- `NullPointerException`
- `ArrayIndexOutOfBoundsException`
- `NumberFormatException`

Java **does not force** you to catch or declare them.

Example:

```java
int value = Integer.parseInt("abc"); // NumberFormatException
```

### 5.2. Checked exceptions

These are exceptions that inherit from `Exception`, but not from `RuntimeException`.

Typical examples:

- `IOException`
- `SQLException`
- `FileNotFoundException`

Java **does require** you to:

- catch them with `try-catch`
- or declare them with `throws`

---

## 6. `try` and `catch`

The basic way to handle exceptions is with `try-catch`.

Syntax:

```java
try {
    // código que puede lanzar una excepción
} catch (ExceptionType e) {
    // código para manejar la excepción
}
```

### 6.1. Example: catching a division by zero

```java
public class Main {
    public static void main(String[] args) {
        try {
            int result = 10 / 0;
            System.out.println(result);
        } catch (ArithmeticException e) {
            System.out.println("Cannot divide by zero");
        }
    }
}
```

Output:

```java
Cannot divide by zero
```

The program does not crash abruptly, because we have handled the exception.

---

## 7. What exactly `catch` does

The `catch` block:
- receives the thrown exception
- allows you to react to it
- prevents the execution from ending in an uncontrolled way

In:

```java
catch (ArithmeticException e)
```

- `ArithmeticException` is the type of exception you want to catch
- `e` is the variable that contains the exception

You can use `e` to get additional information.

Example:

```java
catch (ArithmeticException e) {
    System.out.println("Error: " + e.getMessage());
}
```

---

## 8. `getMessage()` and other useful methods

An exception has useful methods, for example:

- `getMessage()`
- `printStackTrace()`

### 8.1. `getMessage()`

Returns a descriptive message.

```java
try {
    int value = Integer.parseInt("abc");
} catch (NumberFormatException e) {
    System.out.println(e.getMessage());
}
```

### 8.2. `printStackTrace()`

Prints the stack trace of the error, which is very useful when debugging.

```java
catch (NumberFormatException e) {
    e.printStackTrace();
}
```

In real applications it is widely used to investigate problems.

---

## 9. Multiple `catch` blocks

A `try` block can have several `catch` blocks.

Example:

```java
public class Main {
    public static void main(String[] args) {
        try {
            String text = null;
            System.out.println(text.length());
        } catch (ArithmeticException e) {
            System.out.println("Math error");
        } catch (NullPointerException e) {
            System.out.println("Text is null");
        }
    }
}
```

Java will run only the `catch` that matches the actual exception.

---

## 10. Order of `catch` blocks

If you catch types related by inheritance, you should put the most specific ones first.

Incorrect:

```java
try {
    ...
} catch (Exception e) {
    ...
} catch (NumberFormatException e) {
    ...
}
```

This does not compile, because `Exception` would also catch `NumberFormatException`.

Correct:

```java
try {
    ...
} catch (NumberFormatException e) {
    ...
} catch (Exception e) {
    ...
}
```

---

## 11. `finally`

The `finally` block always runs, whether an exception occurs or not.

Syntax:

```java
try {
    ...
} catch (Exception e) {
    ...
} finally {
    ...
}
```

### 11.1. Simple example

```java
public class Main {
    public static void main(String[] args) {
        try {
            System.out.println("Inside try");
            int result = 10 / 0;
        } catch (ArithmeticException e) {
            System.out.println("Caught exception");
        } finally {
            System.out.println("Finally always runs");
        }
    }
}
```

Output:

```java
Inside try
Caught exception
Finally always runs
```

### 11.2. What is `finally` used for?

It is widely used to:

- close resources
- release connections
- leave the program in a consistent state
- record that an operation finished

---

## 12. Complete `try-catch-finally`

```java
public class Main {
    public static void main(String[] args) {
        try {
            String text = "123";
            int value = Integer.parseInt(text);
            System.out.println("Value: " + value);
        } catch (NumberFormatException e) {
            System.out.println("Invalid number");
        } finally {
            System.out.println("Execution finished");
        }
    }
}
```

---

## 13. `throw`: throwing an exception manually

Sometimes you don't want to wait for Java to throw the exception automatically.  
You want to throw it yourself when you detect an invalid situation.

That is what `throw` is for.

Syntax:

```java
throw new ExceptionType("message");
```

### 13.1. Example with `IllegalArgumentException`

```java
public class Main {
    public static void main(String[] args) {
        validateAge(-5);
    }

    public static void validateAge(int age) {
        if (age < 0) {
            throw new IllegalArgumentException("Age cannot be negative");
        }

        System.out.println("Valid age");
    }
}
```

Here the exception is thrown by the programmer.

---

## 14. When to use `throw`

Use `throw` when you detect that:

- an argument is invalid
- the state of an object is inconsistent
- a situation has arisen in which execution should not continue

Common examples:

- negative age
- negative price
- empty name
- operation not allowed

---

## 15. `throws`: declaring that a method can throw an exception

`throws` goes in the method signature and is a way of saying:

> “This method may throw this exception.”

Syntax:

```java
public void method() throws ExceptionType {
    ...
}
```

### 15.1. Simple example

```java
public class Main {
    public static void main(String[] args) {
        try {
            validateAge(-5);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public static void validateAge(int age) throws Exception {
        if (age < 0) {
            throw new Exception("Age cannot be negative");
        }
    }
}
```

In this example:

- `validateAge` declares `throws Exception`
- whoever calls it must handle that possibility

---

## 16. Difference between `throw` and `throws`

This difference is key:

- `throw` → throws a specific exception inside the method
- `throws` → declares in the signature that the method can throw exceptions

Example:

```java
public void example() throws Exception {
    throw new Exception("Something went wrong");
}
```

Here they both appear:

- `throws Exception` in the signature
- `throw new Exception(...)` inside the method

---

## 17. Example with a checked exception

Let's simulate a method that can throw a checked exception.

```java
public class Main {
    public static void main(String[] args) {
        try {
            processFile("");
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public static void processFile(String fileName) throws Exception {
        if (fileName == null || fileName.isBlank()) {
            throw new Exception("File name cannot be empty");
        }

        System.out.println("Processing file: " + fileName);
    }
}
```

---

## 18. Creating your own exceptions

You can also create custom exceptions.
This is useful when you want to represent errors specific to your domain.

Example: `InvalidAgeException`

```java
public class InvalidAgeException extends Exception {
    public InvalidAgeException(String message) {
        super(message);
    }
}
```

Usage:

```java
public class Main {
    public static void main(String[] args) {
        try {
            registerUser(-1);
        } catch (InvalidAgeException e) {
            System.out.println("Custom error: " + e.getMessage());
        }
    }

    public static void registerUser(int age) throws InvalidAgeException {
        if (age < 0) {
            throw new InvalidAgeException("Age must be 0 or greater");
        }

        System.out.println("User registered");
    }
}
```

---

## 19. Exceptions of type `RuntimeException`

If you want to create an exception that does not force you to use `throws` or `try-catch`, you can extend `RuntimeException`.

Example:

```java
public class InvalidPriceException extends RuntimeException {
    public InvalidPriceException(String message) {
        super(message);
    }
}
```

Usage:

```java
public class Product {
    private double price;

    public void setPrice(double price) {
        if (price < 0) {
            throw new InvalidPriceException("Price cannot be negative");
        }

        this.price = price;
    }
}
```

---

## 20. `throw` in getters, setters and business methods

Exceptions are very useful for protecting the state of objects.

Example:

```java
public class BankAccount {
    private double balance;

    public BankAccount(double balance) {
        if (balance < 0) {
            throw new IllegalArgumentException("Initial balance cannot be negative");
        }

        this.balance = balance;
    }

    public void withdraw(double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be greater than 0");
        }

        if (amount > balance) {
            throw new IllegalStateException("Insufficient balance");
        }

        balance -= amount;
    }
}
```

Here we use different exceptions depending on the type of problem:

- `IllegalArgumentException` → invalid argument
- `IllegalStateException` → the object's state does not allow the operation

---

## 21. Catching several exceptions on a single line

Java lets you catch several exceptions in the same `catch` if you want to handle them in the same way.

Example:

```java
public class Main {
    public static void main(String[] args) {
        try {
            String text = null;
            int value = Integer.parseInt(text);
            System.out.println(value);
        } catch (NumberFormatException | NullPointerException e) {
            System.out.println("Invalid input");
        }
    }
}
```

This simplifies the code when the reaction is the same.

---

## 22. Complete example: age and balance validation

### 22.1. Custom exception

```java
public class InvalidBalanceException extends Exception {
    public InvalidBalanceException(String message) {
        super(message);
    }
}
```

### 22.2. `BankAccount` class

```java
public class BankAccount {
    private double balance;

    public BankAccount(double balance) throws InvalidBalanceException {
        if (balance < 0) {
            throw new InvalidBalanceException("Balance cannot be negative");
        }

        this.balance = balance;
    }

    public void deposit(double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Deposit must be greater than 0");
        }

        balance += amount;
    }

    public void withdraw(double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Withdraw amount must be greater than 0");
        }

        if (amount > balance) {
            throw new IllegalStateException("Not enough balance");
        }

        balance -= amount;
    }

    public double getBalance() {
        return balance;
    }
}
```

### 22.3. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        try {
            BankAccount account = new BankAccount(100);

            account.deposit(50);
            account.withdraw(30);

            System.out.println("Balance: " + account.getBalance());

            account.withdraw(500); // lanzará excepción
        } catch (InvalidBalanceException e) {
            System.out.println("Custom checked exception: " + e.getMessage());
        } catch (IllegalArgumentException | IllegalStateException e) {
            System.out.println("Runtime problem: " + e.getMessage());
        } finally {
            System.out.println("Program finished");
        }
    }
}
```

---

## 23. When to catch and when to propagate

You shouldn't always catch an exception right where it occurs.

Sometimes it is better to:

- let it bubble up to a higher level with `throws`
- and catch it where it really makes sense to decide what to do

Rule of thumb:

- **catch** where you can handle the problem in a useful way
- **propagate** when that level does not know how to solve it

---

## 24. Good practices

- Do not use exceptions for normal program logic.
- Catch specific exceptions before general ones.
- If you override `throws`, be clear about what the method can throw.
- Use clear error messages.
- Create custom exceptions when the domain justifies it.
- Don't catch exceptions just to silently ignore them.

Bad example:

```java
try {
    ...
} catch (Exception e) {
}
```

This hides errors and makes maintenance very difficult.

---

## 25. Common beginner mistakes

### 25.1. Confusing `throw` with `throws`

- `throw` throws
- `throws` declares

### 25.2. Always catching `Exception`

Sometimes it is valid, but if you can catch a specific exception, so much the better.

### 25.3. Using exceptions to control normal cases

Bad example: using an exception to break out of a loop or to check whether some data exists when you could validate it first.

### 25.4. Ignoring exceptions with an empty `catch`

That makes the program harder to debug.

---

## 26. Things to keep in mind

- An exception represents a runtime problem.
- `try` contains the code that may fail.
- `catch` catches and handles the exception.
- `finally` always runs.
- `throw` throws an exception manually.
- `throws` declares that a method can throw exceptions.
- Checked exceptions must be caught or declared.
- Unchecked exceptions don't force you to do either, but they are still important.
- You can create your own exceptions.

---

## 27. Final summary

- **`try`**: the area where an error can occur
- **`catch`**: handling the error
- **`finally`**: guaranteed cleanup or closing
- **`throw`**: throwing a specific exception
- **`throws`**: announcing that the method can throw exceptions
- **checked**: Java forces you to handle them
- **unchecked**: Java does not force you, but you should use them properly
- **custom**: very useful for representing domain errors

Exceptions are a fundamental tool for writing robust programs and keeping a clear separation between normal logic and error-handling logic.

---

In the next topic we will keep digging deeper into Java with new structures such as `enum`.
