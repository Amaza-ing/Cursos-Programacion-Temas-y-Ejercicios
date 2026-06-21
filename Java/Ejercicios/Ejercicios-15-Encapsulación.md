# Ejercicios - Tema 15: Encapsulación, getters & setters y modificadores de acceso

A continuación encontrarás **10 ejercicios prácticos** sobre **encapsulación**, **getters & setters** y **modificadores de acceso**: uso de `private`, control del estado, validación en setters, `public` vs _package-private_, `protected` (introducción) y casos típicos.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Encapsular atributos básicos

Crea una clase `Profile` con los atributos `private`:

- `username` (String)
- `age` (int)

Crea:

- Constructor con ambos parámetros
- `getUsername()`, `getAge()`
- `setAge(int age)` que no permita valores negativos (si es negativo, no cambies el valor)

En `main`, crea un objeto, imprime la edad, intenta poner `-5` y vuelve a imprimir.

<details><summary>Mostrar solución</summary>

```java
public class Profile {
    private String username;
    private int age;

    public Profile(String username, int age) {
        this.username = username;
        this.age = age;
    }

    public String getUsername() {
        return username;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        if (age < 0) {
            return;
        }

        this.age = age;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Profile profile = new Profile("laura", 28);

        System.out.println(profile.getAge());
        profile.setAge(-5);
        System.out.println(profile.getAge());
    }
}
```

</details>

---

## Ejercicio 2: Setter con validación de `String`

Crea una clase `Account` con:

- `private String email`

Crea:

- Constructor
- `getEmail()`
- `setEmail(String email)` que ignore `null` o cadenas vacías/blancas (`isBlank()`)

Prueba en `main` asignando `"   "` y luego un email válido.

<details><summary>Mostrar solución</summary>

```java
public class Account {
    private String email;

    public Account(String email) {
        setEmail(email);
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        if (email == null || email.isBlank()) {
            return;
        }

        this.email = email;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Account account = new Account("laura@example.com");

        account.setEmail("   "); // se ignora
        System.out.println(account.getEmail());

        account.setEmail("new@example.com");
        System.out.println(account.getEmail());
    }
}
```

</details>

---

## Ejercicio 3: Evitar setters peligrosos

Crea una clase `BankAccount` con:

- `private double balance`

Requisitos:

- NO crees `setBalance`
- Crea `getBalance()`
- Crea `deposit(double amount)` (solo si amount > 0)
- Crea `withdraw(double amount)` (solo si amount > 0 y <= balance, devuelve boolean)

<details><summary>Mostrar solución</summary>

```java
public class BankAccount {
    private double balance;

    public BankAccount(double balance) {
        this.balance = Math.max(0, balance);
    }

    public double getBalance() {
        return balance;
    }

    public void deposit(double amount) {
        if (amount <= 0) {
            return;
        }

        balance += amount;
    }

    public boolean withdraw(double amount) {
        if (amount <= 0) {
            return false;
        }

        if (amount > balance) {
            return false;
        }

        balance -= amount;
        return true;
    }
}
```

</details>

---

## Ejercicio 4: Getter boolean con convención `is...`

Crea una clase `FeatureFlag` con:

- `private boolean enabled`

Crea:

- Constructor que reciba `enabled`
- Getter llamado `isEnabled()`
- Método `enable()` y `disable()`

<details><summary>Mostrar solución</summary>

```java
public class FeatureFlag {
    private boolean enabled;

    public FeatureFlag(boolean enabled) {
        this.enabled = enabled;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void enable() {
        enabled = true;
    }

    public void disable() {
        enabled = false;
    }
}
```

</details>

---

## Ejercicio 5: Constructor reutilizando setters

Crea una clase `User` con:

- `private String name`
- `private int age`

Crea setters con validación:

- `setName`: si `null` o `isBlank()`, asigna `"Unknown"`
- `setAge`: si `< 0`, asigna `0`

En el constructor, en vez de asignar directamente, llama a los setters.

<details><summary>Mostrar solución</summary>

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        setName(name);
        setAge(age);
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public void setName(String name) {
        if (name == null || name.isBlank()) {
            this.name = "Unknown";
            return;
        }

        this.name = name;
    }

    public void setAge(int age) {
        if (age < 0) {
            this.age = 0;
            return;
        }

        this.age = age;
    }
}
```

</details>

---

## Ejercicio 6: Campo “solo lectura” (sin setter)

Crea una clase `Ticket` con:

- `private String id`
- `private String description`

Requisitos:

- `id` se asigna en el constructor y NO tiene setter
- `description` sí puede cambiar con `setDescription(String description)` con validación `isBlank()`

<details><summary>Mostrar solución</summary>

```java
public class Ticket {
    private String id;
    private String description;

    public Ticket(String id, String description) {
        this.id = id;
        setDescription(description);
    }

    public String getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        if (description == null || description.isBlank()) {
            return;
        }

        this.description = description;
    }
}
```

</details>

---

## Ejercicio 7: _Package-private_ (sin modificador) en una clase auxiliar

Crea un package `app.model` con:

- Clase `User` (`public`)
- Clase `InternalLogger` (sin modificador, _package-private_)

`InternalLogger` debe tener un método `log(String message)`.

En `User`, crea un método `printInfo()` que use `InternalLogger`.

Comprueba que desde un `Main` en otro package NO puedes usar `InternalLogger`.

<details><summary>Mostrar solución</summary>

```java
package app.model;

class InternalLogger {
    void log(String message) {
        System.out.println("LOG: " + message);
    }
}
```

```java
package app.model;

public class User {
    private String name;

    public User(String name) {
        this.name = name;
    }

    public void printInfo() {
        InternalLogger logger = new InternalLogger();
        logger.log("Printing user");

        System.out.println("Name: " + name);
    }
}
```

```java
package app;

import app.model.User;

public class Main {
    public static void main(String[] args) {
        User user = new User("Laura");
        user.printInfo();

        // InternalLogger logger = new InternalLogger(); // no compila
    }
}
```

</details>

---

## Ejercicio 8: `private` en atributos y control de rango

Crea una clase `Temperature` con:

- `private double celsius`

Crea:

- Getter
- Setter que solo permita valores entre `-100` y `100` (si no, no cambies el valor)

<details><summary>Mostrar solución</summary>

```java
public class Temperature {
    private double celsius;

    public Temperature(double celsius) {
        setCelsius(celsius);
    }

    public double getCelsius() {
        return celsius;
    }

    public void setCelsius(double celsius) {
        if (celsius < -100 || celsius > 100) {
            return;
        }

        this.celsius = celsius;
    }
}
```

</details>

---

## Ejercicio 9: `protected` (introducción) con herencia

Crea una clase `BaseMessage` con:

- `protected String prefix`

Crea un constructor que inicialice el prefijo y un método `print(String text)` que imprima:

```
prefix + text
```

Crea una clase `ErrorMessage extends BaseMessage` que use el mismo prefijo pero añada `"ERROR: "` al constructor.

<details><summary>Mostrar solución</summary>

```java
public class BaseMessage {
    protected String prefix;

    public BaseMessage(String prefix) {
        this.prefix = prefix;
    }

    public void print(String text) {
        System.out.println(prefix + text);
    }
}
```

```java
public class ErrorMessage extends BaseMessage {
    public ErrorMessage(String prefix) {
        super("ERROR: " + prefix);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        ErrorMessage msg = new ErrorMessage("[App] ");
        msg.print("Something went wrong");
    }
}
```

</details>

---

## Ejercicio 10: Diseñar un objeto “seguro” con métodos de intención

Crea una clase `InventoryItem` con:

- `private String name`
- `private int stock`

Requisitos:

- Constructor con `name` y `stock` (si stock < 0, usar 0)
- Getter para ambos
- NO crear `setStock`
- Crear métodos:
  - `addStock(int amount)` (solo si amount > 0)
  - `removeStock(int amount)` (solo si amount > 0 y <= stock, devuelve boolean)

<details><summary>Mostrar solución</summary>

```java
public class InventoryItem {
    private String name;
    private int stock;

    public InventoryItem(String name, int stock) {
        this.name = name;
        this.stock = Math.max(0, stock);
    }

    public String getName() {
        return name;
    }

    public int getStock() {
        return stock;
    }

    public void addStock(int amount) {
        if (amount <= 0) {
            return;
        }

        stock += amount;
    }

    public boolean removeStock(int amount) {
        if (amount <= 0) {
            return false;
        }

        if (amount > stock) {
            return false;
        }

        stock -= amount;
        return true;
    }
}
```

</details>

---
