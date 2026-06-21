# Ejercicios - Tema 31: Optional

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **Optional**: `ofNullable`, `empty`, `isPresent`, `ifPresent`, `orElse`, `orElseGet`, `orElseThrow`, `map`, `filter` y búsquedas que pueden no devolver resultado.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear un `Optional` con `ofNullable`

Declara una variable `String username = null`.

Crea un `Optional<String>` usando `Optional.ofNullable(username)` e imprime un valor por defecto usando `orElse`.

El valor por defecto debe ser `"Guest"`.

<details><summary>Mostrar solución</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        String username = null;

        Optional<String> optionalUsername = Optional.ofNullable(username);

        System.out.println(optionalUsername.orElse("Guest"));
    }
}
```

</details>

---

## Ejercicio 2: Usar `ifPresent`

Crea un `Optional<String>` con el valor `"Java"`.

Usa `ifPresent` para imprimir:

```text
Course: Java
```

<details><summary>Mostrar solución</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> course = Optional.of("Java");

        course.ifPresent(value -> System.out.println("Course: " + value));
    }
}
```

</details>

---

## Ejercicio 3: Método que devuelve `Optional`

Crea un método:

```java
public static Optional<String> findEmail(String username)
```

Debe devolver:

- `Optional.of("admin@example.com")` si `username` es `"admin"`
- `Optional.empty()` en cualquier otro caso

Prueba el método desde `main`.

<details><summary>Mostrar solución</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> email = findEmail("admin");

        System.out.println(email.orElse("Email not found"));
    }

    public static Optional<String> findEmail(String username) {
        if ("admin".equals(username)) {
            return Optional.of("admin@example.com");
        }

        return Optional.empty();
    }
}
```

</details>

---

## Ejercicio 4: Transformar un valor con `map`

Crea un `Optional<String>` con el valor `"java"`.

Usa `map` para convertir el texto a mayúsculas e imprime el resultado con `orElse`.

<details><summary>Mostrar solución</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> text = Optional.of("java");

        String result = text.map(value -> value.toUpperCase())
                .orElse("EMPTY");

        System.out.println(result);
    }
}
```

</details>

---

## Ejercicio 5: Filtrar un `Optional<Integer>`

Crea un `Optional<Integer>` con el valor `17`.

Usa `filter` para quedarte solo con el valor si es mayor o igual que `18`.

Después imprime:

- `"Adult"` si queda valor
- `"Minor"` si queda vacío

<details><summary>Mostrar solución</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<Integer> age = Optional.of(17);

        String result = age.filter(value -> value >= 18)
                .map(value -> "Adult")
                .orElse("Minor");

        System.out.println(result);
    }
}
```

</details>

---

## Ejercicio 6: `orElseGet`

Crea un `Optional<String>` vacío.

Usa `orElseGet` para devolver `"Generated value"` como valor por defecto.

<details><summary>Mostrar solución</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> value = Optional.empty();

        String result = value.orElseGet(() -> "Generated value");

        System.out.println(result);
    }
}
```

</details>

---

## Ejercicio 7: `orElseThrow`

Crea un método:

```java
public static Optional<String> findToken()
```

Debe devolver `Optional.empty()`.

Desde `main`, llama al método y usa `orElseThrow` para lanzar una excepción con el mensaje `"Token not found"`.

<details><summary>Mostrar solución</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        String token = findToken()
                .orElseThrow(() -> new IllegalArgumentException("Token not found"));

        System.out.println(token);
    }

    public static Optional<String> findToken() {
        return Optional.empty();
    }
}
```

</details>

---

## Ejercicio 8: Buscar producto por código

Crea una clase `Product` con:

- `code`
- `name`

Crea una lista de productos y un método:

```java
public static Optional<Product> findByCode(List<Product> products, String code)
```

Debe devolver el primer producto con ese código.

<details><summary>Mostrar solución</summary>

```java
public class Product {
    private String code;
    private String name;

    public Product(String code, String name) {
        this.code = code;
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public String getName() {
        return name;
    }
}
```

```java
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<Product> products = List.of(
                new Product("P-1", "Mouse"),
                new Product("P-2", "Keyboard")
        );

        Optional<Product> product = findByCode(products, "P-2");

        product.ifPresent(value -> System.out.println(value.getName()));
    }

    public static Optional<Product> findByCode(List<Product> products, String code) {
        return products.stream()
                .filter(product -> product.getCode().equals(code))
                .findFirst();
    }
}
```

</details>

---

## Ejercicio 9: Encadenar `map`

Crea una clase `User` con:

- `name`
- `email`

Crea un `Optional<User>` con un usuario.  
Usa `map` para obtener el email en minúsculas.

<details><summary>Mostrar solución</summary>

```java
public class User {
    private String name;
    private String email;

    public User(String name, String email) {
        this.name = name;
        this.email = email;
    }

    public String getEmail() {
        return email;
    }
}
```

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<User> user = Optional.of(new User("Laura", "LAURA@EXAMPLE.COM"));

        String email = user.map(value -> value.getEmail())
                .map(value -> value.toLowerCase())
                .orElse("no-email");

        System.out.println(email);
    }
}
```

</details>

---

## Ejercicio 10: Evitar `get()` inseguro

Crea un `Optional<String>` vacío.

No uses `get()` directamente.  
Comprueba si tiene valor con `isPresent()` y:

- si tiene valor, imprímelo
- si no tiene valor, imprime `"No value"`

<details><summary>Mostrar solución</summary>

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> value = Optional.empty();

        if (value.isPresent()) {
            System.out.println(value.get());
        } else {
            System.out.println("No value");
        }
    }
}
```

</details>

---
