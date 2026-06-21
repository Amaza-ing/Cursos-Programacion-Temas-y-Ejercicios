# Tema 31. `Optional`

## 1. Introducción

En Java es muy habitual trabajar con valores que pueden existir o no existir.

Por ejemplo:

- buscar un usuario por su id
- obtener el primer producto de una lista
- leer una configuración opcional
- buscar una palabra en un texto
- encontrar un resultado que quizá no está disponible

Durante mucho tiempo, una forma común de representar “no hay valor” ha sido usar `null`.

Ejemplo:

```java
User user = findUserById(1);

if (user != null) {
    System.out.println(user.getName());
}
```

Esto funciona, pero tiene un problema muy conocido:

> Si olvidas comprobar si el valor es `null`, puedes provocar un `NullPointerException`.

Para ayudar a trabajar mejor con valores que pueden estar presentes o ausentes, Java incluye una clase llamada:

- `Optional`

En este tema aprenderás:

- Qué problema resuelve `Optional`
- Qué es `Optional<T>`
- Cómo crear un `Optional`
- Cómo comprobar si contiene valor
- Cómo obtener el valor de forma segura
- Métodos como `orElse`, `orElseGet`, `orElseThrow`
- Cómo usar `ifPresent`
- Cómo transformar valores con `map`
- Cómo encadenar operaciones con `flatMap`
- Cómo usar `Optional` con `Stream API`
- Errores típicos y buenas prácticas

---

## 2. El problema de `null`

`null` significa que una variable no apunta a ningún objeto.

Ejemplo:

```java
String name = null;
```

Si intentas llamar a un método sobre esa variable, el programa falla.

```java
String name = null;

System.out.println(name.length()); // NullPointerException
```

Este error es muy común en Java.

---

## 3. Ejemplo típico con `null`

Imagina un método que busca un usuario.

```java
public static User findUserById(int id) {
    if (id == 1) {
        return new User("Laura");
    }

    return null;
}
```

Uso:

```java
User user = findUserById(2);

System.out.println(user.getName()); // NullPointerException
```

El método puede devolver un usuario o puede devolver `null`.

El problema es que quien usa el método tiene que recordar comprobarlo.

---

## 4. Solución clásica: comprobar `null`

```java
User user = findUserById(2);

if (user != null) {
    System.out.println(user.getName());
} else {
    System.out.println("User not found");
}
```

Esto es correcto, pero tiene algunos inconvenientes:

- depende de que recuerdes hacer la comprobación
- puede llenar el código de `if (x != null)`
- no expresa claramente en el tipo que el valor puede faltar

Aquí entra `Optional`.

---

## 5. Qué es `Optional`

`Optional<T>` es una clase contenedora que puede tener:

- un valor de tipo `T`
- o ningún valor

Ejemplo conceptual:

```java
Optional<String>
```

Puede representar:

- un `String` presente
- o ausencia de `String`

La idea importante es:

> `Optional` hace explícito que un valor puede estar o no estar.

---

## 6. Importación necesaria

`Optional` está en el paquete `java.util`.

```java
import java.util.Optional;
```

---

## 7. Crear un `Optional` con valor: `Optional.of`

Si tienes un valor que sabes que no es `null`, puedes usar `Optional.of`.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        System.out.println(name);
    }
}
```

Resultado:

```text
Optional[Laura]
```

### 7.1. Cuidado con `Optional.of(null)`

Esto da error:

```java
// Optional<String> name = Optional.of(null); // NullPointerException
```

Usa `Optional.of` solo cuando sabes que el valor no es `null`.

---

## 8. Crear un `Optional` vacío: `Optional.empty`

Si quieres representar ausencia de valor, usa `Optional.empty`.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.empty();

        System.out.println(name);
    }
}
```

Resultado:

```text
Optional.empty
```

---

## 9. Crear un `Optional` que puede recibir `null`: `Optional.ofNullable`

Si tienes un valor que puede ser `null`, usa `Optional.ofNullable`.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        String text = null;

        Optional<String> optionalText = Optional.ofNullable(text);

        System.out.println(optionalText);
    }
}
```

Resultado:

```text
Optional.empty
```

Si el valor no es `null`:

```java
String text = "Java";

Optional<String> optionalText = Optional.ofNullable(text);

System.out.println(optionalText);
```

Resultado:

```text
Optional[Java]
```

---

## 10. Resumen de formas de crear `Optional`

### 10.1. Valor seguro no nulo

```java
Optional<String> name = Optional.of("Laura");
```

### 10.2. Valor vacío

```java
Optional<String> name = Optional.empty();
```

### 10.3. Valor que puede ser `null`

```java
Optional<String> name = Optional.ofNullable(possibleNullValue);
```

---

## 11. Comprobar si hay valor: `isPresent`

`isPresent` devuelve `true` si el `Optional` contiene un valor.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        if (name.isPresent()) {
            System.out.println("There is a value");
        }
    }
}
```

---

## 12. Comprobar si está vacío: `isEmpty`

`isEmpty` devuelve `true` si el `Optional` no contiene valor.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.empty();

        if (name.isEmpty()) {
            System.out.println("There is no value");
        }
    }
}
```

---

## 13. Obtener el valor con `get`

`get` devuelve el valor del `Optional`, pero solo si existe.

```java
Optional<String> name = Optional.of("Laura");

System.out.println(name.get());
```

Resultado:

```text
Laura
```

Pero si el `Optional` está vacío:

```java
Optional<String> name = Optional.empty();

// System.out.println(name.get()); // NoSuchElementException
```

Por eso `get` debe usarse con mucho cuidado.

---

## 14. Problema de usar demasiado `get`

Esto no es buena práctica:

```java
if (name.isPresent()) {
    System.out.println(name.get());
}
```

Aunque funciona, muchas veces existen formas más limpias de trabajar con `Optional`.

Por ejemplo:

- `ifPresent`
- `orElse`
- `orElseGet`
- `orElseThrow`
- `map`

---

## 15. Ejecutar una acción si hay valor: `ifPresent`

`ifPresent` ejecuta una acción solo si el valor existe.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        name.ifPresent(value -> System.out.println(value));
    }
}
```

Con method reference:

```java
name.ifPresent(System.out::println);
```

Si el `Optional` está vacío, no pasa nada.

---

## 16. Ejecutar una acción si hay valor o si está vacío: `ifPresentOrElse`

`ifPresentOrElse` permite indicar:

- qué hacer si hay valor
- qué hacer si no hay valor

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.empty();

        name.ifPresentOrElse(
                value -> System.out.println("Name: " + value),
                () -> System.out.println("No name found")
        );
    }
}
```

---

## 17. Valor por defecto: `orElse`

`orElse` devuelve:

- el valor real si existe
- un valor por defecto si no existe

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.empty();

        String result = name.orElse("Unknown");

        System.out.println(result);
    }
}
```

Resultado:

```text
Unknown
```

Si hay valor:

```java
Optional<String> name = Optional.of("Laura");

String result = name.orElse("Unknown");

System.out.println(result);
```

Resultado:

```text
Laura
```

---

## 18. Valor por defecto calculado: `orElseGet`

`orElseGet` también devuelve un valor alternativo, pero lo calcula mediante un `Supplier`.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.empty();

        String result = name.orElseGet(() -> "Generated name");

        System.out.println(result);
    }
}
```

La diferencia principal es que `orElseGet` solo ejecuta el proveedor si hace falta.

---

## 19. Diferencia entre `orElse` y `orElseGet`

Este punto es importante.

Con `orElse`, el valor alternativo se evalúa aunque el `Optional` tenga valor.

```java
String result = optionalName.orElse(createDefaultName());
```

Con `orElseGet`, la función solo se ejecuta si el `Optional` está vacío.

```java
String result = optionalName.orElseGet(() -> createDefaultName());
```

### 19.1. Regla práctica

- usa `orElse` para valores simples
- usa `orElseGet` si el valor por defecto requiere cálculo, acceso a datos o lógica más costosa

---

## 20. Lanzar excepción si no hay valor: `orElseThrow`

A veces quieres obtener el valor, pero si no existe quieres lanzar una excepción.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.empty();

        String result = name.orElseThrow();

        System.out.println(result);
    }
}
```

Esto lanza una excepción si está vacío.

También puedes lanzar una excepción personalizada:

```java
String result = name.orElseThrow(() -> new IllegalArgumentException("Name not found"));
```

---

## 21. Transformar un valor con `map`

`map` permite transformar el valor contenido dentro de un `Optional`.

Ejemplo:

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        Optional<Integer> length = name.map(value -> value.length());

        System.out.println(length);
    }
}
```

Resultado:

```text
Optional[5]
```

Aquí:

- tenías un `Optional<String>`
- lo transformas en `Optional<Integer>`

---

## 22. `map` con `Optional` vacío

Si el `Optional` está vacío, `map` no ejecuta la transformación.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.empty();

        Optional<Integer> length = name.map(value -> value.length());

        System.out.println(length);
    }
}
```

Resultado:

```text
Optional.empty
```

Esto permite encadenar operaciones sin comprobar `null` manualmente.

---

## 23. Ejemplo con `map` y `orElse`

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        int length = name
                .map(value -> value.length())
                .orElse(0);

        System.out.println(length);
    }
}
```

Si hay nombre, devuelve su longitud.  
Si no hay nombre, devuelve `0`.

---

## 24. Filtrar un `Optional` con `filter`

`filter` permite mantener el valor solo si cumple una condición.

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        Optional<String> result = name.filter(value -> value.length() > 3);

        System.out.println(result);
    }
}
```

Resultado:

```text
Optional[Laura]
```

Si no cumple la condición:

```java
Optional<String> result = name.filter(value -> value.length() > 10);
```

Resultado:

```text
Optional.empty
```

---

## 25. Encadenar `filter`, `map` y `orElse`

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        String result = name
                .filter(value -> value.length() >= 5)
                .map(value -> value.toUpperCase())
                .orElse("UNKNOWN");

        System.out.println(result);
    }
}
```

Proceso:

1. si hay valor, comprueba la condición
2. si la cumple, lo transforma
3. si no hay valor o no cumple, devuelve `"UNKNOWN"`

---

## 26. `flatMap`

`flatMap` se usa cuando la transformación ya devuelve un `Optional`.

Primero veamos el problema.

```java
Optional<String> name = Optional.of("Laura");

Optional<Optional<String>> result = name.map(value -> findEmailByName(value));
```

Si `findEmailByName` devuelve `Optional<String>`, entonces `map` produce un `Optional` dentro de otro `Optional`.

Para evitar eso se usa `flatMap`.

```java
Optional<String> result = name.flatMap(value -> findEmailByName(value));
```

---

## 27. Ejemplo guiado con `flatMap`

```java
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        Optional<String> name = Optional.of("Laura");

        Optional<String> email = name.flatMap(value -> findEmailByName(value));

        email.ifPresent(System.out::println);
    }

    public static Optional<String> findEmailByName(String name) {
        if (name.equals("Laura")) {
            return Optional.of("laura@example.com");
        }

        return Optional.empty();
    }
}
```

Aquí `flatMap` evita tener un `Optional<Optional<String>>`.

---

## 28. Ejemplo completo: buscar usuario por id

### 28.1. `User.java`

```java
public class User {
    private int id;
    private String name;
    private String email;

    public User(int id, String name, String email) {
        this.id = id;
        this.name = name;
        this.email = email;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }
}
```

### 28.2. `Main.java`

```java
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<User> users = List.of(
                new User(1, "Laura", "laura@example.com"),
                new User(2, "Alex", "alex@example.com")
        );

        Optional<User> result = findUserById(users, 1);

        result.ifPresent(user -> System.out.println(user.getName()));
    }

    public static Optional<User> findUserById(List<User> users, int id) {
        for (User user : users) {
            if (user.getId() == id) {
                return Optional.of(user);
            }
        }

        return Optional.empty();
    }
}
```

El método deja claro que puede encontrar o no encontrar un usuario.

---

## 29. Mejorar el ejemplo con `orElse`

```java
Optional<User> result = findUserById(users, 3);

User user = result.orElse(new User(0, "Unknown", "unknown@example.com"));

System.out.println(user.getName());
```

Aquí si no se encuentra el usuario, se usa uno por defecto.

---

## 30. Mejorar el ejemplo con `orElseThrow`

En muchas aplicaciones, si no existe el usuario, quizá quieres lanzar una excepción.

```java
User user = findUserById(users, 3)
        .orElseThrow(() -> new IllegalArgumentException("User not found"));
```

Esto es más claro que devolver `null`.

---

## 31. `Optional` y `Stream API`

`Optional` aparece mucho con streams.

Por ejemplo, `findFirst` devuelve un `Optional`.

```java
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        Optional<String> result = names.stream()
                .filter(name -> name.startsWith("A"))
                .findFirst();

        result.ifPresent(System.out::println);
    }
}
```

¿Por qué devuelve `Optional`?

Porque puede existir un primer elemento que cumpla la condición o puede no existir ninguno.

---

## 32. Ejemplo con `max` y `Optional`

Algunos métodos de streams también devuelven `Optional`.

```java
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(4, 10, 2, 8);

        Optional<Integer> max = numbers.stream()
                .max(Comparator.naturalOrder());

        max.ifPresent(System.out::println);
    }
}
```

Si la lista estuviera vacía, no habría máximo.  
Por eso el resultado es `Optional<Integer>`.

---

## 33. Ejemplo con lista vacía

```java
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of();

        Optional<Integer> max = numbers.stream()
                .max(Comparator.naturalOrder());

        System.out.println(max.orElse(0));
    }
}
```

Resultado:

```text
0
```

---

## 34. `Optional` con objetos

Ejemplo: queremos buscar el email de un usuario, pero puede que el usuario no exista.

```java
Optional<User> user = findUserById(users, 1);

String email = user
        .map(value -> value.getEmail())
        .orElse("No email");

System.out.println(email);
```

Aquí:

- si el usuario existe, obtenemos su email
- si no existe, usamos `"No email"`

---

## 35. `Optional` no sustituye todas las comprobaciones

`Optional` es útil, pero no significa que debas usarlo en todas partes.

No hace falta usar `Optional` para cualquier variable local.

Ejemplo innecesario:

```java
Optional<String> name = Optional.of("Laura");
System.out.println(name.orElse("Unknown"));
```

Si sabes que el nombre existe, usa simplemente:

```java
String name = "Laura";
```

---

## 36. Cuándo usar `Optional`

Usa `Optional` especialmente como valor de retorno de métodos que pueden no encontrar un resultado.

Ejemplos adecuados:

```java
Optional<User> findUserById(int id)
Optional<Product> findProductByCode(String code)
Optional<String> findEmailByUsername(String username)
```

Esto comunica claramente:

> este método puede devolver un valor o puede no devolver nada.

---

## 37. Cuándo evitar `Optional`

Como regla inicial, evita usar `Optional`:

- como atributo de una clase
- como parámetro de método
- en exceso para variables locales simples
- para colecciones

Ejemplo poco recomendable:

```java
public class User {
    private Optional<String> email;
}
```

Normalmente es mejor:

```java
public class User {
    private String email;
}
```

y controlar la ausencia en los métodos que lo necesiten.

---

## 38. `Optional` y colecciones

No suele tener sentido devolver esto:

```java
Optional<List<User>>
```

Normalmente es mejor devolver una lista vacía:

```java
List<User>
```

Porque una lista vacía ya expresa que no hay resultados.

Ejemplo:

```java
public static List<User> findActiveUsers() {
    return List.of();
}
```

Esto suele ser más simple que envolver la lista en `Optional`.

---

## 39. Ejemplo guiado: buscar producto por código

### 39.1. `Product.java`

```java
public class Product {
    private String code;
    private String name;
    private double price;

    public Product(String code, String name, double price) {
        this.code = code;
        this.name = name;
        this.price = price;
    }

    public String getCode() {
        return code;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }
}
```

### 39.2. `Main.java`

```java
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<Product> products = List.of(
                new Product("M01", "Mouse", 19.99),
                new Product("K01", "Keyboard", 49.99),
                new Product("C01", "Cable", 5.99)
        );

        Optional<Product> result = findProductByCode(products, "K01");

        String productName = result
                .map(product -> product.getName())
                .orElse("Product not found");

        System.out.println(productName);
    }

    public static Optional<Product> findProductByCode(List<Product> products, String code) {
        for (Product product : products) {
            if (product.getCode().equals(code)) {
                return Optional.of(product);
            }
        }

        return Optional.empty();
    }
}
```

---

## 40. Ejemplo guiado con streams

El método anterior también puede escribirse con `Stream API`.

```java
public static Optional<Product> findProductByCode(List<Product> products, String code) {
    return products.stream()
            .filter(product -> product.getCode().equals(code))
            .findFirst();
}
```

Esta versión es más compacta y devuelve naturalmente un `Optional<Product>`.

---

## 41. Errores típicos al empezar

### 41.1. Usar `get` sin comprobar

Evita:

```java
Optional<String> name = Optional.empty();
System.out.println(name.get());
```

Mejor:

```java
System.out.println(name.orElse("Unknown"));
```

### 41.2. Usar `Optional.of` con valores que pueden ser `null`

Evita:

```java
Optional<String> name = Optional.of(possibleNullName);
```

Mejor:

```java
Optional<String> name = Optional.ofNullable(possibleNullName);
```

### 41.3. Usar `Optional` en todas partes

`Optional` es útil, pero no debe envolver cualquier variable.

### 41.4. Devolver `null` desde un método que devuelve `Optional`

Esto es un error de diseño:

```java
public static Optional<String> findName() {
    return null; // mal
}
```

Debe ser:

```java
public static Optional<String> findName() {
    return Optional.empty();
}
```

### 41.5. Usar `Optional<List<T>>` cuando basta una lista vacía

En muchos casos, una lista vacía es más simple.

---

## 42. Buenas prácticas

- Usa `Optional` principalmente como tipo de retorno.
- Usa `Optional.empty()` para representar ausencia de valor.
- Usa `Optional.ofNullable` si el valor puede ser `null`.
- Evita llamar a `get` directamente.
- Prefiere `orElse`, `orElseGet`, `orElseThrow`, `ifPresent`, `map` y `flatMap`.
- No devuelvas `null` desde un método que promete devolver `Optional`.
- No uses `Optional` para colecciones si una colección vacía expresa bien el caso.
- Usa `Optional` para hacer más explícita la posibilidad de ausencia.

---

## 43. A tener en cuenta

- `Optional<T>` representa un valor que puede existir o no existir.
- Ayuda a evitar errores por `null`.
- `Optional.of` requiere un valor no nulo.
- `Optional.empty` representa ausencia.
- `Optional.ofNullable` acepta valores que pueden ser `null`.
- `ifPresent` ejecuta una acción si hay valor.
- `orElse` y `orElseGet` proporcionan valores por defecto.
- `orElseThrow` lanza excepción si no hay valor.
- `map` transforma el valor interno.
- `flatMap` evita `Optional` anidados.
- Muchos métodos de `Stream API` devuelven `Optional`.

---

## 44. Resumen final

`Optional` es una herramienta muy útil para representar de forma explícita que un valor puede faltar.

Su objetivo no es eliminar completamente `null` de Java, sino ayudarte a diseñar métodos más claros y seguros.

En vez de devolver `null`, puedes devolver:

```java
Optional.empty()
```

Y en vez de obligar a quien usa el método a recordar una comprobación manual, el propio tipo ya comunica:

> este valor puede estar presente o puede no estarlo.

Dominar `Optional` te ayudará a escribir código más claro, especialmente cuando trabajes con:

- búsquedas
- repositorios
- streams
- valores opcionales
- APIs modernas de Java

---

En el siguiente tema seguiremos avanzando con Java moderno y veremos la **Date/Time API**, que permite trabajar correctamente con fechas, horas, duraciones y zonas horarias.
