# Tema 23. Excepciones en Java: `try`, `catch`, `finally`, `throw` y `throws`

## 1. Introducción

Cuando un programa Java se ejecuta, no todo sale siempre bien.

Pueden ocurrir problemas como:

- dividir entre cero
- acceder a una posición inválida de un array
- convertir un texto no numérico a entero
- trabajar con un valor `null`
- intentar leer un archivo que no existe

A estos problemas Java los representa con **excepciones**.

Las excepciones permiten:

- detectar errores en tiempo de ejecución
- separar la lógica normal de la lógica de error
- reaccionar de forma controlada ante problemas
- evitar que el programa falle de forma brusca sin explicación

En este tema aprenderás:

- qué es una excepción
- qué diferencia hay entre error y excepción
- cómo usar `try`, `catch` y `finally`
- qué hacen `throw` y `throws`
- qué son las excepciones comprobadas y no comprobadas
- cómo crear tus propias excepciones
- buenas prácticas y errores típicos

---

## 2. Qué es una excepción

Una **excepción** es un objeto que representa una situación anómala o un error que ocurre durante la ejecución del programa.

En lugar de seguir ejecutándose normalmente, Java:

1. crea una excepción
2. “lanza” esa excepción
3. busca un lugar donde capturarla y gestionarla

Si nadie la captura, el programa termina con error.

---

## 3. Ejemplo simple de excepción

```java
public class Main {
    public static void main(String[] args) {
        int result = 10 / 0;
        System.out.println(result);
    }
}
```

Esto produce una excepción:

```java
ArithmeticException
```

¿Por qué?

Porque no se puede dividir entre cero.

---

## 4. Jerarquía básica de excepciones

En Java, las excepciones forman parte de una jerarquía de clases.

A muy alto nivel:

- `Throwable`
  - `Error`
  - `Exception`
    - `RuntimeException`

### 4.1. `Error`

Representa problemas graves del sistema o de la JVM.

Ejemplos:

- `OutOfMemoryError`
- `StackOverflowError`

Normalmente no se capturan ni se intentan manejar como parte normal del programa.

### 4.2. `Exception`

Representa problemas que una aplicación puede manejar.

Dentro de `Exception`, las más importantes son:

- **checked exceptions**
- **unchecked exceptions** (`RuntimeException`)

---

## 5. Checked vs unchecked exceptions

Esta diferencia es muy importante.

### 5.1. Unchecked exceptions

Son excepciones que heredan de `RuntimeException`.

Ejemplos:

- `ArithmeticException`
- `NullPointerException`
- `ArrayIndexOutOfBoundsException`
- `NumberFormatException`

Java **no obliga** a capturarlas o declararlas.

Ejemplo:

```java
int value = Integer.parseInt("abc"); // NumberFormatException
```

### 5.2. Checked exceptions

Son excepciones que heredan de `Exception`, pero no de `RuntimeException`.

Ejemplos típicos:

- `IOException`
- `SQLException`
- `FileNotFoundException`

Java **sí obliga** a:

- capturarlas con `try-catch`
- o declararlas con `throws`

---

## 6. `try` y `catch`

La forma básica de manejar excepciones es con `try-catch`.

Sintaxis:

```java
try {
    // código que puede lanzar una excepción
} catch (ExceptionType e) {
    // código para manejar la excepción
}
```

### 6.1. Ejemplo: capturar división entre cero

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

Salida:

```java
Cannot divide by zero
```

El programa no se rompe abruptamente, porque hemos manejado la excepción.

---

## 7. Qué hace exactamente `catch`

El bloque `catch`:

- recibe la excepción lanzada
- permite reaccionar ante ella
- evita que la ejecución termine de forma descontrolada

En:

```java
catch (ArithmeticException e)
```

- `ArithmeticException` es el tipo de excepción que quieres capturar
- `e` es la variable que contiene la excepción

Puedes usar `e` para obtener información adicional.

Ejemplo:

```java
catch (ArithmeticException e) {
    System.out.println("Error: " + e.getMessage());
}
```

---

## 8. `getMessage()` y otras utilidades

Una excepción tiene métodos útiles, por ejemplo:

- `getMessage()`
- `printStackTrace()`

### 8.1. `getMessage()`

Devuelve un mensaje descriptivo.

```java
try {
    int value = Integer.parseInt("abc");
} catch (NumberFormatException e) {
    System.out.println(e.getMessage());
}
```

### 8.2. `printStackTrace()`

Imprime la traza del error, muy útil al depurar.

```java
catch (NumberFormatException e) {
    e.printStackTrace();
}
```

En aplicaciones reales se usa mucho para investigar problemas.

---

## 9. Varios `catch`

Un bloque `try` puede tener varios `catch`.

Ejemplo:

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

Java ejecutará solo el `catch` que corresponda a la excepción real.

---

## 10. Orden de los `catch`

Si capturas tipos relacionados por herencia, debes poner primero los más específicos.

Incorrecto:

```java
try {
    ...
} catch (Exception e) {
    ...
} catch (NumberFormatException e) {
    ...
}
```

Esto no compila, porque `Exception` capturaría también `NumberFormatException`.

Correcto:

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

El bloque `finally` se ejecuta siempre, ocurra o no una excepción.

Sintaxis:

```java
try {
    ...
} catch (Exception e) {
    ...
} finally {
    ...
}
```

### 11.1. Ejemplo simple

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

Salida:

```java
Inside try
Caught exception
Finally always runs
```

### 11.2. ¿Para qué se usa `finally`?

Se usa mucho para:

- cerrar recursos
- liberar conexiones
- dejar el programa en un estado consistente
- registrar que una operación terminó

---

## 12. `try-catch-finally` completo

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

## 13. `throw`: lanzar una excepción manualmente

A veces no quieres esperar a que Java lance la excepción automáticamente.  
Quieres lanzarla tú cuando detectas una situación inválida.

Para eso se usa `throw`.

Sintaxis:

```java
throw new ExceptionType("message");
```

### 13.1. Ejemplo con `IllegalArgumentException`

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

Aquí la excepción la lanza el propio programador.

---

## 14. Cuándo usar `throw`

Usa `throw` cuando detectas que:

- un argumento es inválido
- el estado de un objeto es incoherente
- se ha producido una situación que no debería continuar

Ejemplos comunes:

- edad negativa
- precio negativo
- nombre vacío
- operación no permitida

---

## 15. `throws`: declarar que un método puede lanzar una excepción

`throws` se pone en la firma del método y sirve para decir:

> “Este método puede lanzar esta excepción”.

Sintaxis:

```java
public void method() throws ExceptionType {
    ...
}
```

### 15.1. Ejemplo simple

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

En este ejemplo:

- `validateAge` declara `throws Exception`
- quien lo llama debe manejar esa posibilidad

---

## 16. Diferencia entre `throw` y `throws`

Esta diferencia es clave:

- `throw` → lanza una excepción concreta dentro del método
- `throws` → declara en la firma que el método puede lanzar excepciones

Ejemplo:

```java
public void example() throws Exception {
    throw new Exception("Something went wrong");
}
```

Aquí aparecen los dos:

- `throws Exception` en la firma
- `throw new Exception(...)` dentro del método

---

## 17. Ejemplo con checked exception

Vamos a simular un método que puede lanzar una excepción comprobada.

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

## 18. Crear tus propias excepciones

También puedes crear excepciones personalizadas.

Esto es útil cuando quieres representar errores específicos de tu dominio.

Ejemplo: `InvalidAgeException`

```java
public class InvalidAgeException extends Exception {
    public InvalidAgeException(String message) {
        super(message);
    }
}
```

Uso:

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

## 19. Excepciones de tipo `RuntimeException`

Si quieres crear una excepción que no obligue a usar `throws` o `try-catch`, puedes extender `RuntimeException`.

Ejemplo:

```java
public class InvalidPriceException extends RuntimeException {
    public InvalidPriceException(String message) {
        super(message);
    }
}
```

Uso:

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

## 20. `throw` en getters, setters y métodos de negocio

Las excepciones son muy útiles para proteger el estado de los objetos.

Ejemplo:

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

Aquí usamos distintas excepciones según el tipo de problema:

- `IllegalArgumentException` → argumento inválido
- `IllegalStateException` → estado del objeto no permite la operación

---

## 21. Capturar varias excepciones en una sola línea

Java permite capturar varias excepciones en el mismo `catch` si quieres tratarlas igual.

Ejemplo:

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

Esto simplifica el código cuando la reacción es la misma.

---

## 22. Ejemplo completo: validación de edad y saldo

### 22.1. Excepción personalizada

```java
public class InvalidBalanceException extends Exception {
    public InvalidBalanceException(String message) {
        super(message);
    }
}
```

### 22.2. Clase `BankAccount`

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

## 23. Cuándo capturar y cuándo propagar

No siempre debes capturar una excepción justo donde ocurre.

A veces es mejor:

- dejar que suba a un nivel superior con `throws`
- y capturarla donde realmente tenga sentido decidir qué hacer

Regla práctica:

- **captura** donde puedas gestionar el problema de forma útil
- **propaga** cuando ese nivel no sabe resolverlo

---

## 24. Buenas prácticas

- No uses excepciones para lógica normal del programa.
- Captura excepciones específicas antes que generales.
- Si sobrescribes `throws`, sé claro con qué puede lanzar el método.
- Usa mensajes de error claros.
- Crea excepciones personalizadas cuando el dominio lo justifique.
- No captures excepciones para ignorarlas silenciosamente.

Ejemplo malo:

```java
try {
    ...
} catch (Exception e) {
}
```

Eso oculta errores y dificulta muchísimo el mantenimiento.

---

## 25. Errores típicos al empezar

### 25.1. Confundir `throw` con `throws`

- `throw` lanza
- `throws` declara

### 25.2. Capturar `Exception` siempre

A veces es válido, pero si puedes capturar una excepción concreta, mejor.

### 25.3. Usar excepciones para controlar casos normales

Ejemplo malo: usar una excepción para salir de un bucle o para comprobar si un dato existe cuando podrías validarlo antes.

### 25.4. Ignorar excepciones vaciando el `catch`

Eso hace el programa más difícil de depurar.

---

## 26. A tener en cuenta

- Una excepción representa un problema en tiempo de ejecución.
- `try` contiene el código que puede fallar.
- `catch` captura y maneja la excepción.
- `finally` se ejecuta siempre.
- `throw` lanza una excepción manualmente.
- `throws` declara que un método puede lanzar excepciones.
- Las checked exceptions obligan a capturar o declarar.
- Las unchecked exceptions no obligan, pero siguen siendo importantes.
- Puedes crear tus propias excepciones.

---

## 27. Resumen final

- **`try`**: zona donde puede ocurrir un error
- **`catch`**: manejo del error
- **`finally`**: limpieza o cierre garantizado
- **`throw`**: lanzar una excepción concreta
- **`throws`**: anunciar que el método puede lanzar excepciones
- **checked**: Java obliga a gestionarlas
- **unchecked**: Java no obliga, pero debes usarlas bien
- **personalizadas**: muy útiles para representar errores del dominio

Las excepciones son una herramienta fundamental para escribir programas robustos y mantener una separación clara entre la lógica normal y la lógica de error.

---

En el siguiente tema seguiremos profundizando en Java con nuevas estructuras como los `enum`.
