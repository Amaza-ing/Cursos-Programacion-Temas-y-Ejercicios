# Tema 34. Records

## 1. Introducción

En temas anteriores has aprendido a crear clases con:

- atributos
- constructores
- getters
- setters
- métodos
- `equals`
- `hashCode`
- `toString`

Muchas veces creamos clases cuyo objetivo principal es simplemente **guardar datos**.

Por ejemplo:

- un usuario con `name` y `email`
- un producto con `name` y `price`
- una coordenada con `x` e `y`
- una respuesta de una API
- un objeto para transportar datos entre partes del programa

Para estos casos, Java incluye una herramienta moderna llamada:

- **record**

Un `record` permite declarar de forma muy compacta una clase pensada principalmente para almacenar datos inmutables.

En este tema aprenderás:

- Qué es un `record`
- Qué problema resuelve
- Cómo declarar records
- Qué código genera Java automáticamente
- Cómo acceder a sus valores
- Por qué son inmutables
- Cómo crear constructores compactos
- Cómo validar datos en un record
- Cómo añadir métodos propios
- Cómo usar records con listas, mapas y streams
- Cuándo usar records y cuándo usar clases normales
- Errores típicos y buenas prácticas

---

## 2. El problema: clases con mucho código repetitivo

Imagina una clase sencilla para representar un producto.

```java
public class Product {
    private final String name;
    private final double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    @Override
    public String toString() {
        return "Product{name='" + name + "', price=" + price + "}";
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (!(obj instanceof Product other)) {
            return false;
        }

        return Double.compare(price, other.price) == 0
                && name.equals(other.name);
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }
}
```

Esta clase solo guarda datos, pero tiene bastante código.

En Java moderno, un `record` permite expresar esta misma idea de forma mucho más corta.

---

## 3. Primer ejemplo de `record`

```java
public record Product(String name, double price) {
}
```

Con una sola línea, Java genera automáticamente:

- atributos privados y finales
- constructor
- métodos de acceso
- `toString`
- `equals`
- `hashCode`

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Product product = new Product("Mouse", 19.99);

        System.out.println(product.name());
        System.out.println(product.price());
        System.out.println(product);
    }
}
```

Resultado aproximado:

```text
Mouse
19.99
Product[name=Mouse, price=19.99]
```

---

## 4. Sintaxis básica de un record

La sintaxis general es:

```java
public record RecordName(Type fieldName, Type fieldName2) {
}
```

Ejemplo:

```java
public record User(String name, String email) {
}
```

Los elementos declarados entre paréntesis se llaman **componentes del record**.

En este ejemplo, los componentes son:

- `name`
- `email`

---

## 5. Métodos de acceso

En una clase normal, normalmente creamos getters:

```java
getName()
getEmail()
```

En un `record`, Java crea métodos de acceso con el mismo nombre del componente:

```java
name()
email()
```

Ejemplo:

```java
public record User(String name, String email) {
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        User user = new User("Laura", "laura@example.com");

        System.out.println(user.name());
        System.out.println(user.email());
    }
}
```

Importante:

- en records no se usa `getName()`
- se usa `name()`

---

## 6. Los records son inmutables

Los componentes de un record son:

- `private`
- `final`

Eso significa que, una vez creado el objeto, no puedes cambiar sus valores.

Ejemplo:

```java
User user = new User("Laura", "laura@example.com");

// user.name = "Alex"; // no se puede
// user.setName("Alex"); // no existe
```

Si quieres otro valor, creas otro objeto.

```java
User user = new User("Laura", "laura@example.com");
User updatedUser = new User("Alex", user.email());
```

Esto conecta con una idea muy importante:

> Un record representa datos inmutables.

---

## 7. Diferencia entre clase normal y record

### 7.1. Clase normal

Una clase normal es mejor cuando necesitas:

- estado mutable
- setters
- lógica compleja
- herencia de otra clase
- comportamiento con identidad propia

### 7.2. Record

Un record es mejor cuando necesitas:

- guardar datos
- transportar información
- representar valores inmutables
- reducir código repetitivo
- tener `equals`, `hashCode` y `toString` automáticamente

---

## 8. `toString` automático

Java genera automáticamente un `toString`.

```java
public record Product(String name, double price) {
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Product product = new Product("Keyboard", 49.99);

        System.out.println(product);
    }
}
```

Resultado:

```text
Product[name=Keyboard, price=49.99]
```

Esto es muy útil para depurar y mostrar información.

---

## 9. `equals` automático

Java también genera `equals`.

Dos records son iguales si:

- son del mismo tipo
- tienen los mismos valores en sus componentes

Ejemplo:

```java
public record Product(String name, double price) {
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Product p1 = new Product("Mouse", 19.99);
        Product p2 = new Product("Mouse", 19.99);
        Product p3 = new Product("Keyboard", 49.99);

        System.out.println(p1.equals(p2)); // true
        System.out.println(p1.equals(p3)); // false
    }
}
```

Esto evita tener que escribir `equals` manualmente.

---

## 10. `hashCode` automático

Java también genera `hashCode`.

Esto es importante cuando usas records en estructuras como:

- `HashSet`
- `HashMap`

Ejemplo:

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<Product> products = new HashSet<>();

        products.add(new Product("Mouse", 19.99));
        products.add(new Product("Mouse", 19.99));
        products.add(new Product("Keyboard", 49.99));

        System.out.println(products.size());
    }
}
```

Resultado:

```text
2
```

El producto repetido no se añade dos veces porque `equals` y `hashCode` funcionan automáticamente.

---

## 11. Constructor canónico

Cada record tiene un constructor con todos sus componentes.

Ejemplo:

```java
public record User(String name, String email) {
}
```

Java genera automáticamente algo equivalente a:

```java
public User(String name, String email) {
    this.name = name;
    this.email = email;
}
```

Uso:

```java
User user = new User("Laura", "laura@example.com");
```

Ese constructor se llama **constructor canónico**.

---

## 12. Constructor compacto

Puedes definir un constructor compacto para validar o ajustar valores.

Ejemplo:

```java
public record User(String name, String email) {
    public User {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Name cannot be blank");
        }

        if (email == null || email.isBlank()) {
            throw new IllegalArgumentException("Email cannot be blank");
        }
    }
}
```

Fíjate en la sintaxis:

```java
public User {
    ...
}
```

No se escriben los parámetros porque ya están definidos en el record.

---

## 13. Validación en un constructor compacto

Ejemplo completo:

```java
public record Product(String name, double price) {
    public Product {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Name cannot be blank");
        }

        if (price < 0) {
            throw new IllegalArgumentException("Price cannot be negative");
        }
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Product product = new Product("Mouse", 19.99);

        System.out.println(product);

        // Product invalid = new Product("", -10); // excepción
    }
}
```

---

## 14. Normalizar valores en un constructor compacto

Además de validar, también puedes normalizar datos.

Ejemplo:

```java
public record User(String name, String email) {
    public User {
        name = name.trim();
        email = email.trim().toLowerCase();
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        User user = new User("  Laura  ", "  LAURA@EXAMPLE.COM  ");

        System.out.println(user.name());
        System.out.println(user.email());
    }
}
```

Resultado:

```text
Laura
laura@example.com
```

Importante:

- en un constructor compacto puedes reasignar los parámetros
- Java asignará después esos valores normalizados a los componentes

---

## 15. Constructor explícito completo

También puedes escribir el constructor completo, aunque normalmente no hace falta.

```java
public record Product(String name, double price) {
    public Product(String name, double price) {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Name cannot be blank");
        }

        if (price < 0) {
            throw new IllegalArgumentException("Price cannot be negative");
        }

        this.name = name;
        this.price = price;
    }
}
```

En muchos casos, el constructor compacto es más limpio.

---

## 16. Añadir métodos propios a un record

Un record puede tener métodos propios.

Ejemplo:

```java
public record Product(String name, double price) {
    public boolean isExpensive() {
        return price > 100;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Product product = new Product("Monitor", 199.99);

        System.out.println(product.isExpensive());
    }
}
```

Los records no son solo “datos sin métodos”.  
Pueden tener comportamiento relacionado con esos datos.

---

## 17. Ejemplo con método calculado

```java
public record Rectangle(double width, double height) {
    public double area() {
        return width * height;
    }

    public double perimeter() {
        return 2 * (width + height);
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Rectangle rectangle = new Rectangle(4, 3);

        System.out.println(rectangle.area());
        System.out.println(rectangle.perimeter());
    }
}
```

---

## 18. Records y `BigDecimal`

Cuando un record representa datos financieros, puedes usar `BigDecimal`.

```java
import java.math.BigDecimal;

public record Product(String name, BigDecimal price) {
    public Product {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Name cannot be blank");
        }

        if (price == null || price.compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("Price cannot be negative");
        }
    }
}
```

Uso:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        Product product = new Product("Mouse", new BigDecimal("19.99"));

        System.out.println(product);
    }
}
```

---

## 19. Records y listas

Los records encajan muy bien con colecciones.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<User> users = List.of(
                new User("Laura", "laura@example.com"),
                new User("Alex", "alex@example.com"),
                new User("Maria", "maria@example.com")
        );

        for (User user : users) {
            System.out.println(user.name() + " -> " + user.email());
        }
    }
}
```

Record:

```java
public record User(String name, String email) {
}
```

---

## 20. Records y `Map`

También son útiles como valores en mapas.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<Integer, User> usersById = new HashMap<>();

        usersById.put(1, new User("Laura", "laura@example.com"));
        usersById.put(2, new User("Alex", "alex@example.com"));

        User user = usersById.get(1);

        System.out.println(user);
    }
}
```

Record:

```java
public record User(String name, String email) {
}
```

---

## 21. Records y `Stream API`

Los records se usan muy bien con streams porque son ligeros y expresivos.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Product> products = List.of(
                new Product("Mouse", 19.99),
                new Product("Keyboard", 49.99),
                new Product("Monitor", 199.99)
        );

        List<String> expensiveNames = products.stream()
                .filter(product -> product.price() > 50)
                .map(product -> product.name())
                .toList();

        System.out.println(expensiveNames);
    }
}
```

Record:

```java
public record Product(String name, double price) {
}
```

---

## 22. Records como DTOs

Un uso muy común de records es crear DTOs.

DTO significa:

- **Data Transfer Object**

Es decir, un objeto usado para transportar datos entre partes del programa.

Ejemplo:

```java
public record UserResponse(String name, String email) {
}
```

Este record puede representar los datos que una aplicación devuelve, muestra o transfiere.

Los records encajan bien como DTOs porque:

- son compactos
- son inmutables
- tienen `toString`, `equals` y `hashCode`
- expresan claramente que son datos

---

## 23. Records como resultados de métodos

Un método puede devolver un record para agrupar datos.

Ejemplo:

```java
public record SearchResult(String keyword, int totalResults) {
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        SearchResult result = search("java");

        System.out.println(result.keyword());
        System.out.println(result.totalResults());
    }

    public static SearchResult search(String keyword) {
        return new SearchResult(keyword, 25);
    }
}
```

Esto es más claro que devolver varios valores separados.

---

## 24. Records anidados

Puedes declarar un record dentro de una clase.

```java
public class Main {
    public static void main(String[] args) {
        Point point = new Point(10, 20);

        System.out.println(point);
    }

    public record Point(int x, int y) {
    }
}
```

Esto puede ser útil en ejemplos pequeños o cuando el record solo se usa dentro de una clase.

En proyectos reales, normalmente crearás records en sus propios archivos.

---

## 25. Records y atributos adicionales

Un record no puede tener atributos de instancia adicionales que no formen parte de sus componentes.

Esto no es válido:

```java
public record User(String name, String email) {
    // private int age; // error
}
```

¿Por qué?

Porque el estado principal de un record debe estar definido en su cabecera:

```java
public record User(String name, String email, int age) {
}
```

---

## 26. Records y atributos estáticos

Un record sí puede tener atributos estáticos.

```java
public record User(String name, String email) {
    public static final String DEFAULT_EMAIL = "unknown@example.com";
}
```

También puede tener métodos estáticos.

```java
public record User(String name, String email) {
    public static User unknown() {
        return new User("Unknown", "unknown@example.com");
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        User user = User.unknown();

        System.out.println(user);
    }
}
```

---

## 27. Records y herencia

Los records tienen una limitación importante:

> Un record no puede extender otra clase.

Esto no se puede:

```java
// public record User(String name) extends Person { } // error
```

Todos los records ya extienden internamente de `java.lang.Record`.

Pero sí pueden implementar interfaces.

---

## 28. Records e interfaces

Un record puede implementar una interfaz.

Ejemplo:

```java
public interface Printable {
    void print();
}
```

Record:

```java
public record User(String name, String email) implements Printable {
    @Override
    public void print() {
        System.out.println(name + " -> " + email);
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Printable user = new User("Laura", "laura@example.com");

        user.print();
    }
}
```

---

## 29. Records y clases selladas

Los records pueden combinarse con interfaces selladas.

Este tema se verá más adelante en **Sealed Classes**, pero conviene verlo de forma sencilla.

```java
public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

Records:

```java
public record PaymentSuccess(String transactionId) implements PaymentResult {
}
```

```java
public record PaymentError(String message) implements PaymentResult {
}
```

La idea es que los records son muy útiles para representar diferentes tipos de resultados inmutables.

---

## 30. Records y validación con objetos nulos

Como los records no validan automáticamente `null`, debes hacerlo tú si lo necesitas.

Ejemplo:

```java
public record User(String name, String email) {
    public User {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Name cannot be blank");
        }

        if (email == null || email.isBlank()) {
            throw new IllegalArgumentException("Email cannot be blank");
        }
    }
}
```

Si no añades esta validación, esto sería posible:

```java
User user = new User(null, null);
```

Por eso la validación depende de tu diseño.

---

## 31. Sobrescribir métodos en un record

Aunque Java genera `toString`, `equals` y `hashCode`, puedes sobrescribirlos.

Por ejemplo, personalizar `toString`:

```java
public record User(String name, String email) {
    @Override
    public String toString() {
        return name + " <" + email + ">";
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        User user = new User("Laura", "laura@example.com");

        System.out.println(user);
    }
}
```

Resultado:

```text
Laura <laura@example.com>
```

Aun así, en muchos casos es mejor mantener el comportamiento automático.

---

## 32. Ejemplo completo: `Course`

### 32.1. `Course.java`

```java
public record Course(String title, int durationHours) {
    public Course {
        if (title == null || title.isBlank()) {
            throw new IllegalArgumentException("Title cannot be blank");
        }

        if (durationHours <= 0) {
            throw new IllegalArgumentException("Duration must be positive");
        }
    }

    public boolean isLongCourse() {
        return durationHours >= 20;
    }
}
```

### 32.2. `Main.java`

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Course> courses = List.of(
                new Course("Java Basics", 15),
                new Course("Spring MVC", 25),
                new Course("SQL Fundamentals", 12)
        );

        for (Course course : courses) {
            System.out.println(course.title() + " | Long: " + course.isLongCourse());
        }
    }
}
```

---

## 33. Ejemplo completo: carrito con records

### 33.1. `Product.java`

```java
import java.math.BigDecimal;

public record Product(String name, BigDecimal price) {
    public Product {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Name cannot be blank");
        }

        if (price == null || price.compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("Price cannot be negative");
        }
    }
}
```

### 33.2. `CartItem.java`

```java
public record CartItem(Product product, int quantity) {
    public CartItem {
        if (product == null) {
            throw new IllegalArgumentException("Product cannot be null");
        }

        if (quantity <= 0) {
            throw new IllegalArgumentException("Quantity must be positive");
        }
    }
}
```

### 33.3. `Main.java`

```java
import java.math.BigDecimal;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<CartItem> cart = List.of(
                new CartItem(new Product("Mouse", new BigDecimal("19.99")), 2),
                new CartItem(new Product("Keyboard", new BigDecimal("49.99")), 1)
        );

        BigDecimal total = BigDecimal.ZERO;

        for (CartItem item : cart) {
            BigDecimal itemTotal = item.product()
                    .price()
                    .multiply(BigDecimal.valueOf(item.quantity()));

            total = total.add(itemTotal);
        }

        System.out.println("Total: " + total);
    }
}
```

---

## 34. Records frente a clases con setters

Un record no tiene setters.

Esto es intencionado.

Si necesitas modificar mucho el estado de un objeto después de crearlo, probablemente una clase normal sea mejor.

Ejemplo donde una clase normal puede tener más sentido:

```java
public class BankAccount {
    private BigDecimal balance;

    public void deposit(BigDecimal amount) {
        balance = balance.add(amount);
    }

    public void withdraw(BigDecimal amount) {
        balance = balance.subtract(amount);
    }
}
```

Aquí el objeto tiene un estado que cambia con el tiempo.  
Un record no sería la mejor opción.

---

## 35. Cuándo usar records

Usa records cuando quieras representar:

- datos simples
- valores inmutables
- resultados de métodos
- DTOs
- coordenadas
- configuraciones
- pares de valores
- respuestas simples
- objetos que se comparan por contenido

Ejemplos:

```java
public record Point(int x, int y) {
}
```

```java
public record UserResponse(String name, String email) {
}
```

```java
public record ProductSummary(String name, double price) {
}
```

---

## 36. Cuándo no usar records

Evita records cuando necesites:

- setters
- estado mutable
- herencia de clases
- lógica compleja de ciclo de vida
- identidad propia más allá de sus datos
- objetos que cambian constantemente

Ejemplos donde una clase normal puede ser mejor:

- `BankAccount`
- `ShoppingCart`
- `GameCharacter`
- `ConnectionManager`
- `UserSession`

---

## 37. Records y nombres de componentes

Los nombres de los componentes son importantes porque se convierten en métodos.

Ejemplo:

```java
public record User(String name, String email) {
}
```

Genera:

```java
name()
email()
```

Por eso conviene usar nombres claros y expresivos.

Evita:

```java
public record User(String n, String e) {
}
```

Mejor:

```java
public record User(String name, String email) {
}
```

---

## 38. Errores típicos al empezar

### 38.1. Intentar usar getters clásicos

Esto no existe automáticamente:

```java
// user.getName(); // error
```

Debes usar:

```java
user.name();
```

### 38.2. Esperar setters

Los records son inmutables:

```java
// user.setName("Alex"); // error
```

### 38.3. Pensar que validan `null` automáticamente

No lo hacen.  
Si necesitas validar, usa un constructor compacto.

### 38.4. Intentar añadir atributos de instancia extra

El estado del record debe estar en la cabecera.

### 38.5. Usar record para objetos con estado cambiante

Si el objeto cambia mucho durante su vida, probablemente necesitas una clase normal.

---

## 39. Buenas prácticas

- Usa records para datos simples e inmutables.
- Usa nombres claros para los componentes.
- Añade validación en un constructor compacto si el dominio lo requiere.
- No uses records como sustituto automático de todas las clases.
- Aprovecha `toString`, `equals` y `hashCode` automáticos.
- Usa records para DTOs, resultados y valores.
- Si necesitas setters o estado mutable, usa una clase normal.

---

## 40. A tener en cuenta

- Un record es una forma compacta de declarar una clase de datos.
- Sus componentes son privados y finales.
- Java genera constructor, accesores, `toString`, `equals` y `hashCode`.
- Los accesores se llaman como los componentes: `name()`, `price()`, etc.
- Los records son inmutables.
- Pueden tener métodos propios.
- Pueden tener constructores compactos.
- Pueden implementar interfaces.
- No pueden extender otras clases.
- Son ideales para datos simples, DTOs y resultados.

---

## 41. Resumen final

Los records son una herramienta muy útil del Java moderno.

Permiten escribir menos código cuando necesitas representar datos inmutables.

En vez de crear una clase larga con:

- atributos privados
- constructor
- getters
- `toString`
- `equals`
- `hashCode`

puedes escribir:

```java
public record Product(String name, double price) {
}
```

Esto hace que el código sea más breve, más claro y menos repetitivo.

La idea principal es:

- usa records para datos inmutables
- usa clases normales para objetos con estado mutable o comportamiento complejo

Dominar records te ayudará a escribir código moderno, especialmente en aplicaciones que manejan DTOs, resultados, configuraciones y estructuras de datos simples.

---

En el siguiente tema seguiremos avanzando con Java moderno y veremos **Sealed Classes**, una herramienta que permite controlar qué clases pueden heredar o implementar una jerarquía.
