# Ejercicios - Tema 30: Stream API

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **Stream API**: `filter`, `map`, `sorted`, `distinct`, `count`, `reduce`, `findFirst`, `anyMatch`, `allMatch` y conversión final con `toList`.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Filtrar palabras largas

Crea una lista `List<String> words` con estos valores:

- `"java"`
- `"stream"`
- `"api"`
- `"programming"`
- `"code"`

Usa `stream()` para quedarte solo con las palabras que tengan **más de 4 caracteres**.  
Guarda el resultado en una nueva lista e imprímela.

<details><summary>Mostrar solución</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> words = List.of("java", "stream", "api", "programming", "code");

        List<String> longWords = words.stream()
                .filter(word -> word.length() > 4)
                .toList();

        System.out.println(longWords);
    }
}
```

</details>

---

## Ejercicio 2: Convertir nombres a mayúsculas

Crea una lista `List<String> names` con:

- `"laura"`
- `"alex"`
- `"maria"`
- `"david"`

Usa `map` para crear una nueva lista con todos los nombres en mayúsculas.

<details><summary>Mostrar solución</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("laura", "alex", "maria", "david");

        List<String> upperNames = names.stream()
                .map(name -> name.toUpperCase())
                .toList();

        System.out.println(upperNames);
    }
}
```

</details>

---

## Ejercicio 3: Filtrar números pares

Crea una lista `List<Integer> numbers` con:

`3`, `8`, `12`, `5`, `7`, `20`.

Usa `filter` para obtener solo los números pares e imprime la lista resultante.

<details><summary>Mostrar solución</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(3, 8, 12, 5, 7, 20);

        List<Integer> evenNumbers = numbers.stream()
                .filter(number -> number % 2 == 0)
                .toList();

        System.out.println(evenNumbers);
    }
}
```

</details>

---

## Ejercicio 4: Ordenar precios de menor a mayor

Crea una lista `List<Double> prices` con:

`19.99`, `5.50`, `120.0`, `49.99`.

Usa `sorted` para crear una lista ordenada de menor a mayor.

<details><summary>Mostrar solución</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Double> prices = List.of(19.99, 5.50, 120.0, 49.99);

        List<Double> sortedPrices = prices.stream()
                .sorted()
                .toList();

        System.out.println(sortedPrices);
    }
}
```

</details>

---

## Ejercicio 5: Eliminar etiquetas repetidas

Crea una lista `List<String> tags` con:

- `"java"`
- `"backend"`
- `"java"`
- `"maven"`
- `"backend"`

Usa `distinct` para eliminar duplicados e imprime la lista resultante.

<details><summary>Mostrar solución</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> tags = List.of("java", "backend", "java", "maven", "backend");

        List<String> uniqueTags = tags.stream()
                .distinct()
                .toList();

        System.out.println(uniqueTags);
    }
}
```

</details>

---

## Ejercicio 6: Contar productos caros

Crea una clase `Product` con:

- `name`
- `price`

En `main`, crea una lista con varios productos.  
Usa `stream()` y `count()` para contar cuántos productos tienen precio mayor que `50`.

<details><summary>Mostrar solución</summary>

```java
import java.util.List;

public class Product {
    private String name;
    private double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public double getPrice() {
        return price;
    }
}
```

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Product> products = List.of(
                new Product("Mouse", 19.99),
                new Product("Keyboard", 49.99),
                new Product("Monitor", 199.99),
                new Product("Desk", 120.0)
        );

        long expensiveCount = products.stream()
                .filter(product -> product.getPrice() > 50)
                .count();

        System.out.println(expensiveCount);
    }
}
```

</details>

---

## Ejercicio 7: Sumar números con `reduce`

Crea una lista `List<Integer> expenses` con:

`10`, `25`, `15`, `40`.

Usa `reduce` para calcular la suma total e imprime el resultado.

<details><summary>Mostrar solución</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> expenses = List.of(10, 25, 15, 40);

        int total = expenses.stream()
                .reduce(0, (currentTotal, expense) -> currentTotal + expense);

        System.out.println(total);
    }
}
```

</details>

---

## Ejercicio 8: Buscar el primer nombre que empieza por una letra

Crea una lista `List<String> names` con:

- `"Carlos"`
- `"Ana"`
- `"Carmen"`
- `"Luis"`

Usa `stream()`, `filter` y `findFirst` para encontrar el primer nombre que empiece por `"C"`.  
Si existe, imprímelo.

<details><summary>Mostrar solución</summary>

```java
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Carlos", "Ana", "Carmen", "Luis");

        Optional<String> firstName = names.stream()
                .filter(name -> name.startsWith("C"))
                .findFirst();

        firstName.ifPresent(System.out::println);
    }
}
```

</details>

---

## Ejercicio 9: Comprobar si hay algún usuario adulto

Crea una clase `User` con:

- `name`
- `age`

En `main`, crea una lista de usuarios.  
Usa `anyMatch` para comprobar si existe al menos un usuario con edad mayor o igual que `18`.

<details><summary>Mostrar solución</summary>

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public int getAge() {
        return age;
    }
}
```

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<User> users = List.of(
                new User("Laura", 22),
                new User("Alex", 16),
                new User("Maria", 30)
        );

        boolean hasAdult = users.stream()
                .anyMatch(user -> user.getAge() >= 18);

        System.out.println(hasAdult);
    }
}
```

</details>

---

## Ejercicio 10: Filtrar, transformar y ordenar

Crea una lista `List<String> emails` con:

- `"LAURA@EXAMPLE.COM"`
- `"test@gmail.com"`
- `"ADMIN@EXAMPLE.COM"`
- `"hello@yahoo.com"`

Usa Stream API para:

1. Quedarte solo con los emails que terminen en `"@example.com"` ignorando mayúsculas/minúsculas.
2. Convertirlos a minúsculas.
3. Ordenarlos alfabéticamente.
4. Imprimir la lista final.

<details><summary>Mostrar solución</summary>

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> emails = List.of(
                "LAURA@EXAMPLE.COM",
                "test@gmail.com",
                "ADMIN@EXAMPLE.COM",
                "hello@yahoo.com"
        );

        List<String> exampleEmails = emails.stream()
                .map(email -> email.toLowerCase())
                .filter(email -> email.endsWith("@example.com"))
                .sorted()
                .toList();

        System.out.println(exampleEmails);
    }
}
```

</details>

---
