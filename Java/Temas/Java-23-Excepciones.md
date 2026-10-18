# Topic 23. Exceptions in Java: `try`, `catch`, `finally`, `throw` and `throws`

## 1. Introduction

When a Java program runs, not everything always goes well.

Problems may occur such as:

- divide by zero
- access an invalid position in an array
- convert non-numeric text to integer
- work with an `null` value
- try to read a file that does not exist

Java represents these problems with **exceptions**.

Exceptions allow:

- detect runtime errors
- separate normal logic from error logic
- react in a controlled way to problems
- prevent the program from crashing suddenly without explanation

In this topic you will learn:

- what is an exception
- what is the difference between error and exception
- how to use `try`, `catch` and `finally`
- what `throw` and `throws` do
- what are checked and unchecked exceptions
- how to create your own exceptions
- good practices and typical mistakes

---

[![Exceptions](https://img.youtube.com/vi/GEq5_Uuza_8/0.jpg)](https://www.youtube.com/watch?v=GEq5_Uuza_8&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. What is an exception

An **exception** is an object that represents an abnormal situation or an error that occurs during program execution.

Instead of continuing to run normally, Java:

1. create an exception
2. “throw” that exception
3. Find a place to capture and manage it

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

Because it cannot be divided by zero.

---

## 4. Basic hierarchy of exceptions

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

They are not normally captured or attempted to be handled as a normal part of the program.

### 4.2. `Exception`

Represents problems that an application can handle.

Within `Exception`, the most important ones are:

- **checked exceptions**
- **unchecked exceptions** (`RuntimeException`)

---

## 5. Checked vs unchecked exceptions

This difference is very important.

### 5.1. Unchecked exceptions

They are exceptions that inherit from `RuntimeException`.

Examples:

- `ArithmeticException`
- `NullPointerException`
- `ArrayIndexOutOfBoundsException`
- `NumberFormatException`

Java **does not force** you to capture or declare them.

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

Java **does require**:

- capture them with `try-catch`
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

### 6.1. Example: capture division by zero

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

The program does not break abruptly, because we have handled the exception.

---

## 7. What exactly `catch` does

The `catch` block:
- receives the thrown exception
- allows you to react to it
- prevents execution from ending uncontrollably

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

## 8. `getMessage()` and other utilities

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

Prints the error trace, very useful when debugging.

```java
catch (NumberFormatException e) {
    e.printStackTrace();
}
```

In real applications it is widely used to investigate problems.

---

## 9. Various `catch`

An `try` block can have multiple `catch`s.

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

Java will execute only the `catch` that corresponds to the actual exception.

---

## 10. Order of `catch`

If you capture types related by inheritance, you should put the most specific ones first.

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

This does not compile, because `Exception` would also capture `NumberFormatException`.

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

The `finally` block is always executed whether an exception occurs or not.

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

It is widely used for:

- close resources
- release connections
- leave the program in a consistent state
- record that an operation finished

---

## 12. `try-catch-finally` complete

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

## 13. `throw`: Throw an exception manually

Sometimes you don't want to wait for Java to throw the exception automatically.  
You want to launch it when you detect an invalid situation.

`throw` is used for that.

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

Here the exception is thrown by the programmer himself.

---

## 14. When to use `throw`

Use `throw` when you detect that:

- an argument is invalid
- the state of an object is inconsistent
- a situation has occurred that should not continue

Common examples:

- negative age
- negative price
- empty name
- operation not allowed

---

## 15. `throws`: declare that a method can throw an exception

`throws` is placed in the method signature and serves to say:

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
- whoever calls you must handle that possibility

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

## 17. Example with checked exception

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

## 18. Create your own exceptions

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

If you want to create an exception that does not force `throws` or `try-catch`, you can extend `RuntimeException`.

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

Exceptions are very useful to protect the state of objects.

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
- `IllegalStateException` → object state does not allow operation

---

## 21. Catch multiple exceptions on a single line

Java allows you to catch multiple exceptions in the same `catch` if you want to treat them the same.

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

## 23. When to capture and when to propagate

You shouldn't always catch an exception right where it occurs.

Sometimes it is better:

- let it rise to a higher level with `throws`
- and capture it where it really makes sense to decide what to do

Rule of thumb:

- **capture** where you can usefully manage the problem
- **propagates** when that level does not know how to solve it

---

## 24. Good practices

- Do not use exceptions for normal program logic.
- Catch specific exceptions before general ones.
- If you override `throws`, be clear with what you can launch the method with.
- Use clear error messages.
- Create custom exceptions when the domain warrants it.
- Don't catch exceptions to silently ignore them.

Bad example:

```java
try {
    ...
} catch (Exception e) {
}
```

This hides errors and makes maintenance very difficult.

---

## 25. Typical mistakes when starting

### 25.1. Confusing `throw` with `throws`

- `throw` launches
- `throws` declares

### 25.2. Capture `Exception` always

Sometimes it is valid, but if you can catch a specific exception, the better.

### 25.3. Use exceptions to control normal cases

Bad example: using an exception to break out of a loop or to check if data exists when you could validate it first.

### 25.4. Ignore exceptions by emptying the `catch`

That makes the program more difficult to debug.

---

## 26. To take into account

- An exception represents a runtime problem.
- `try` contains the code that may fail.
- `catch` catches and handles the exception.
- `finally` is always executed.
- `throw` throws an exception manually.
- `throws` declares that a method can throw exceptions.
- Checked exceptions require capture or declaration.
- Unchecked exceptions are not mandatory, but they are still important.
- You can create your own exceptions.

---

## 27. Final summary

- **`try`**: area where an error can occur
- **`catch`**: error handling
- **`finally`**: guaranteed cleanup or shutdown
- **`throw`**: throw a specific exception
- **`throws`**: announce that the method can throw exceptions
- **checked**: Java forces you to manage them
- **unchecked**: Java does not require, but you must use them well
- **custom**: very useful for representing domain errors

Exceptions are a fundamental tool for writing robust programs and maintaining a clear separation between normal logic and error logic.

---

In the next topic we will continue delving into Java with new structures such as `enum`.
