# Ejercicios - Tema 23: Excepciones

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **`try`, `catch`, `finally`, `throw`, `throws` y excepciones personalizadas**.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Capturar `NumberFormatException`

Convierte el texto `"12x"` a entero y captura el error.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 2: Capturar división entre cero

Divide `20 / 0` dentro de un `try` y captura `ArithmeticException`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 3: Varios `catch`

Accede a una posición inválida de un array y usa varios bloques `catch`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 4: Usar `finally`

Intenta convertir `"abc"` a entero. En `finally`, imprime `"Validation finished"`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 5: Lanzar con `throw`

Crea `validateUsername` y lanza `IllegalArgumentException` si el usuario está vacío.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 6: Declarar `throws`

Crea `readConfig(String fileName) throws Exception` y lanza excepción si el nombre está vacío.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 7: Excepción checked personalizada

Crea `InvalidCodeException extends Exception` y úsala para validar códigos que deben empezar por `A-`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 8: Excepción unchecked personalizada

Crea `InvalidStockException extends RuntimeException` y úsala para impedir stock negativo.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 9: Multi-catch

Captura `NullPointerException` y `NumberFormatException` en un mismo `catch`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 10: Validar retirada

Crea una clase `Wallet` y lanza excepciones si la retirada no es válida.

<details><summary>Mostrar solución</summary>

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
