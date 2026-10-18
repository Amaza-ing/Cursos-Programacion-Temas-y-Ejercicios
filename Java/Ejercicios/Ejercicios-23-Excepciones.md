# Exercises - Topic 23: Exceptions

Below you will find **10 practical exercises** to work with **`try`, `catch`, `finally`, `throw`, `throws` and custom exceptions**.

Try to solve them before consulting the solution.

---

## Exercise 1: Capture `NumberFormatException`

Converts the text `"12x"` to integer and captures the error.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        String text = "12x";

        try {
            int number = Integer.parseInt(text);
            System.out.println(number);
        } catch (NumberFormatException e) {
            System.out.println("Invalid number");
        }
    }
}
```

</details>

---

## Exercise 2: Capture division by zero

Splits `20 / 0` inside an `try` and captures `ArithmeticException`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        try {
            int result = 20 / 0;
            System.out.println(result);
        } catch (ArithmeticException e) {
            System.out.println("Cannot divide by zero");
        }
    }
}
```

</details>

---

## Exercise 3: Various `catch`

Accesses an invalid position in an array and uses several `catch` blocks.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        try {
            int[] values = {10, 20, 30};
            System.out.println(values[5]);
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Invalid array position");
        } catch (Exception e) {
            System.out.println("General error");
        }
    }
}
```

</details>

---

## Exercise 4: Use `finally`

Try converting `"abc"` to integer. In `finally`, print `"Validation finished"`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        try {
            int value = Integer.parseInt("abc");
            System.out.println(value);
        } catch (NumberFormatException e) {
            System.out.println("Could not parse number");
        } finally {
            System.out.println("Validation finished");
        }
    }
}
```

</details>

---

## Exercise 5: Launch with `throw`

Create `validateUsername` and cast `IllegalArgumentException` if the user is empty.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        validateUsername("   ");
    }

    public static void validateUsername(String username) {
        if (username == null || username.isBlank()) {
            throw new IllegalArgumentException("Username cannot be blank");
        }

        System.out.println("Valid username");
    }
}
```

</details>

---

## Exercise 6: Declare `throws`

Create `readConfig(String fileName) throws Exception` and throw exception if name is empty.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        try {
            readConfig("");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public static void readConfig(String fileName) throws Exception {
        if (fileName == null || fileName.isBlank()) {
            throw new Exception("Config file name is required");
        }

        System.out.println("Reading config: " + fileName);
    }
}
```

</details>

---

## Exercise 7: Custom checked exception

Create `InvalidCodeException extends Exception` and use it to validate codes that must start with `A-`.

<details><summary>Show solution</summary>

```java
public class InvalidCodeException extends Exception {
    public InvalidCodeException(String message) {
        super(message);
    }
}

public class Main {
    public static void main(String[] args) {
        try {
            validateCode("B-100");
        } catch (InvalidCodeException e) {
            System.out.println(e.getMessage());
        }
    }

    public static void validateCode(String code) throws InvalidCodeException {
        if (code == null || !code.startsWith("A-")) {
            throw new InvalidCodeException("Code must start with A-");
        }

        System.out.println("Valid code");
    }
}
```

</details>

---

## Exercise 8: Custom unchecked exception

Create `InvalidStockException extends RuntimeException` and use it to prevent negative stock.

<details><summary>Show solution</summary>

```java
public class InvalidStockException extends RuntimeException {
    public InvalidStockException(String message) {
        super(message);
    }
}

public class Product {
    private int stock;

    public void setStock(int stock) {
        if (stock < 0) {
            throw new InvalidStockException("Stock cannot be negative");
        }

        this.stock = stock;
    }
}
```

</details>

---

## Exercise 9: Multi-catch

Captures `NullPointerException` and `NumberFormatException` in the same `catch`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        try {
            String text = null;
            int number = Integer.parseInt(text);
            System.out.println(number);
        } catch (NullPointerException | NumberFormatException e) {
            System.out.println("Invalid input");
        }
    }
}
```

</details>

---

## Exercise 10: Validate withdrawal

Create a class `Wallet` and throw exceptions if the withdrawal is invalid.

<details><summary>Show solution</summary>

```java
public class Wallet {
    private double balance;

    public Wallet(double balance) {
        this.balance = balance;
    }

    public void withdraw(double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be positive");
        }

        if (amount > balance) {
            throw new IllegalStateException("Not enough balance");
        }

        balance -= amount;
    }
}
```

</details>

---
