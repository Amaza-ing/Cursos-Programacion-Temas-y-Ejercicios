# Tema 38. Módulos y Java Moderno

## 1. Introducción

Hasta ahora has trabajado con muchos elementos fundamentales de Java:

- variables
- condicionales
- bucles
- métodos
- clases
- objetos
- herencia
- interfaces
- colecciones
- generics
- lambdas
- streams
- optional
- fechas
- archivos
- records
- sealed classes
- concurrencia básica

En este tema vamos a dar un paso más y veremos dos ideas importantes:

- **el sistema de módulos de Java**
- **algunas características del Java moderno**

Los módulos permiten organizar mejor aplicaciones grandes.  
Java moderno incluye mejoras pensadas para hacer el lenguaje más claro, expresivo y cómodo.

En este tema aprenderás:

- Qué problema resuelven los módulos
- Qué es un módulo en Java
- Qué es `module-info.java`
- Cómo usar `requires`
- Cómo usar `exports`
- Cómo organizar paquetes dentro de un módulo
- Qué es `java.base`
- Qué son `requires transitive` y `opens`
- Qué son las declaraciones `import module`
- Qué son los compact source files
- Qué características modernas has ido viendo en el curso
- Cómo pensar Java como un lenguaje que sigue evolucionando

---

## 2. El problema de organizar aplicaciones grandes

En proyectos pequeños, puedes tener unas pocas clases:

```text
Main.java
User.java
Product.java
```

Pero en aplicaciones grandes puedes tener:

- decenas o cientos de clases
- muchos paquetes
- librerías externas
- capas separadas
- dependencias entre partes del proyecto
- código que no debería ser accesible desde cualquier lugar

Ejemplo:

```text
com.amazaing.app.users
com.amazaing.app.products
com.amazaing.app.orders
com.amazaing.app.database
com.amazaing.app.security
```

Los paquetes ayudan a organizar el código, pero no siempre son suficientes para controlar bien las dependencias y la visibilidad.

Ahí aparecen los módulos.

---

## 3. Qué es un módulo

Un **módulo** es una unidad de organización superior al paquete.

Un módulo puede contener:

- paquetes
- clases
- interfaces
- records
- recursos
- una declaración de dependencias
- una declaración de qué paquetes expone al exterior

La idea es que un módulo puede decir:

- qué necesita
- qué ofrece
- qué oculta

---

## 4. Paquetes vs módulos

### 4.1. Paquete

Un paquete organiza clases.

Ejemplo:

```java
package com.amazaing.users;
```

Sirve para agrupar clases relacionadas.

### 4.2. Módulo

Un módulo organiza paquetes y dependencias.

Ejemplo:

```java
module com.amazaing.app {
    exports com.amazaing.users;
}
```

Un módulo puede contener varios paquetes.

---

## 5. Qué es `module-info.java`

Un módulo se define mediante un archivo especial llamado:

```text
module-info.java
```

Este archivo se coloca en la raíz del código fuente del módulo.

Ejemplo:

```java
module com.amazaing.app {
}
```

Este sería un módulo vacío que todavía no exporta paquetes ni declara dependencias.

---

## 6. Estructura básica de un proyecto modular

Un proyecto modular puede tener una estructura como esta:

```text
src
└── com.amazaing.app
    ├── module-info.java
    └── com
        └── amazaing
            └── app
                └── Main.java
```

El archivo importante es:

```text
module-info.java
```

Y dentro se declara el módulo:

```java
module com.amazaing.app {
}
```

---

## 7. Primer ejemplo de módulo

### 7.1. `module-info.java`

```java
module com.amazaing.app {
}
```

### 7.2. `Main.java`

```java
package com.amazaing.app;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello from a Java module");
    }
}
```

Aquí tenemos:

- un módulo llamado `com.amazaing.app`
- un paquete llamado `com.amazaing.app`
- una clase `Main`

---

## 8. Nombre del módulo

Los nombres de módulos suelen seguir una convención parecida a los paquetes.

Ejemplos:

```text
com.amazaing.app
com.amazaing.users
com.amazaing.products
```

Se recomienda usar nombres únicos y descriptivos.

Evita nombres demasiado genéricos como:

```text
app
users
core
```

Mejor:

```text
com.amazaing.app
com.amazaing.users
com.amazaing.core
```

---

## 9. `java.base`

Todos los módulos de Java dependen automáticamente de un módulo llamado:

```java
java.base
```

Este módulo contiene clases fundamentales como:

- `String`
- `Object`
- `Integer`
- `System`
- `Math`
- muchas clases básicas de Java

No necesitas escribir esto:

```java
requires java.base;
```

porque Java lo añade automáticamente.

---

## 10. Usar `requires`

Cuando un módulo necesita usar otro módulo, se declara con `requires`.

Ejemplo:

```java
module com.amazaing.app {
    requires java.sql;
}
```

Esto significa:

> el módulo `com.amazaing.app` necesita el módulo `java.sql`

`java.sql` contiene clases relacionadas con bases de datos, como JDBC.

---

## 11. Ejemplo con `requires java.sql`

### 11.1. `module-info.java`

```java
module com.amazaing.app {
    requires java.sql;
}
```

### 11.2. Clase usando `java.sql`

```java
package com.amazaing.app;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Main {
    public static void main(String[] args) {
        System.out.println("This module can use java.sql");
    }
}
```

Si el módulo no declara `requires java.sql`, no podría acceder correctamente a esas clases en un proyecto modular.

---

## 12. Usar `exports`

Por defecto, los paquetes de un módulo no quedan expuestos para otros módulos.

Si quieres que un paquete pueda ser usado desde fuera, debes exportarlo.

```java
module com.amazaing.users {
    exports com.amazaing.users;
}
```

Esto significa:

> otros módulos pueden usar las clases públicas del paquete `com.amazaing.users`

---

## 13. Ejemplo con dos módulos

Imagina dos módulos:

```text
com.amazaing.users
com.amazaing.app
```

El módulo `users` contiene la clase `User`.

### 13.1. `com.amazaing.users/module-info.java`

```java
module com.amazaing.users {
    exports com.amazaing.users;
}
```

### 13.2. `User.java`

```java
package com.amazaing.users;

public class User {
    private String name;

    public User(String name) {
        this.name = name;
    }

    public String name() {
        return name;
    }
}
```

### 13.3. `com.amazaing.app/module-info.java`

```java
module com.amazaing.app {
    requires com.amazaing.users;
}
```

### 13.4. `Main.java`

```java
package com.amazaing.app;

import com.amazaing.users.User;

public class Main {
    public static void main(String[] args) {
        User user = new User("Laura");

        System.out.println(user.name());
    }
}
```

Aquí:

- `com.amazaing.users` exporta su paquete
- `com.amazaing.app` requiere el módulo de usuarios
- `Main` puede usar `User`

---

## 14. Paquetes no exportados

Un módulo puede tener paquetes internos que no exporta.

Ejemplo:

```java
module com.amazaing.users {
    exports com.amazaing.users.api;
}
```

Estructura:

```text
com.amazaing.users.api
com.amazaing.users.internal
```

Solo se exporta:

```text
com.amazaing.users.api
```

El paquete interno queda oculto para otros módulos.

Esto ayuda a separar:

- API pública
- implementación interna

---

## 15. Ejemplo de API pública e implementación interna

```text
com.amazaing.users.api.UserService
com.amazaing.users.internal.FileUserRepository
```

`module-info.java`:

```java
module com.amazaing.users {
    exports com.amazaing.users.api;
}
```

Otros módulos pueden usar:

```java
com.amazaing.users.api.UserService
```

Pero no deberían acceder directamente a:

```java
com.amazaing.users.internal.FileUserRepository
```

---

## 16. Ventaja principal de los módulos

Los módulos permiten un nivel de encapsulación más fuerte que los paquetes.

Con paquetes puedes organizar.  
Con módulos puedes controlar qué partes del código son realmente accesibles desde fuera.

Esto ayuda a:

- reducir acoplamiento
- proteger detalles internos
- mejorar el mantenimiento
- hacer más claras las dependencias
- diseñar APIs más limpias

---

## 17. `requires transitive`

A veces un módulo expone tipos que pertenecen a otro módulo.

En ese caso puede tener sentido usar:

```java
requires transitive
```

Ejemplo:

```java
module com.amazaing.orders {
    requires transitive com.amazaing.users;
    exports com.amazaing.orders;
}
```

Esto significa que quien requiera `com.amazaing.orders` también tendrá acceso a `com.amazaing.users`.

Es un concepto más avanzado, pero conviene conocerlo.

---

## 18. Ejemplo conceptual de `requires transitive`

Imagina que tienes:

```java
public class Order {
    private User user;

    public User getUser() {
        return user;
    }
}
```

Si `Order` forma parte de la API pública del módulo `orders`, entonces los usuarios de ese módulo también necesitan conocer el tipo `User`.

En ese caso, `requires transitive` puede tener sentido.

---

## 19. `exports ... to`

Puedes exportar un paquete solo a módulos concretos.

```java
module com.amazaing.users {
    exports com.amazaing.users.internal to com.amazaing.app;
}
```

Esto significa:

- el paquete se exporta
- pero solo al módulo `com.amazaing.app`

No suele ser necesario al empezar, pero es útil en diseños más controlados.

---

## 20. `opens`

`opens` permite abrir un paquete para reflexión.

La reflexión es una técnica que permite inspeccionar clases, métodos y atributos en tiempo de ejecución.

Algunas herramientas y frameworks la usan.

Ejemplo:

```java
module com.amazaing.app {
    opens com.amazaing.app.models;
}
```

Esto no es lo mismo que `exports`.

### 20.1. Diferencia sencilla

- `exports` permite usar clases públicas desde otros módulos
- `opens` permite acceso por reflexión

Para cursos introductorios, lo importante es conocer la diferencia general.

---

## 21. `opens ... to`

También puedes abrir un paquete solo a un módulo concreto.

```java
module com.amazaing.app {
    opens com.amazaing.app.models to com.fasterxml.jackson.databind;
}
```

Esto puede ser útil con librerías que convierten objetos a JSON o trabajan con reflexión.

---

## 22. `requires static`

`requires static` indica una dependencia necesaria en compilación, pero no obligatoria en tiempo de ejecución.

Ejemplo:

```java
module com.amazaing.app {
    requires static org.jetbrains.annotations;
}
```

Es un caso más avanzado.

Puede aparecer con librerías de anotaciones o herramientas de análisis.

---

## 23. `uses` y `provides`

El sistema de módulos también puede trabajar con servicios.

Ejemplo:

```java
uses com.amazaing.notifications.NotificationSender;
```

Y otro módulo puede proporcionar una implementación:

```java
provides com.amazaing.notifications.NotificationSender
        with com.amazaing.email.EmailNotificationSender;
```

Esto permite diseñar aplicaciones extensibles.

No necesitas dominarlo todavía, pero conviene saber que existe.

---

## 24. Resumen de palabras clave en `module-info.java`

Las más importantes son:

```java
requires
exports
opens
uses
provides
```

Y algunas variantes:

```java
requires transitive
requires static
exports ... to
opens ... to
```

Para empezar, las más importantes son:

```java
requires
exports
```

---

## 25. Ejemplo completo: módulo de productos

### 25.1. Estructura

```text
src
├── com.amazaing.products
│   ├── module-info.java
│   └── com
│       └── amazaing
│           └── products
│               └── Product.java
└── com.amazaing.app
    ├── module-info.java
    └── com
        └── amazaing
            └── app
                └── Main.java
```

### 25.2. `com.amazaing.products/module-info.java`

```java
module com.amazaing.products {
    exports com.amazaing.products;
}
```

### 25.3. `Product.java`

```java
package com.amazaing.products;

import java.math.BigDecimal;

public record Product(String name, BigDecimal price) {
}
```

### 25.4. `com.amazaing.app/module-info.java`

```java
module com.amazaing.app {
    requires com.amazaing.products;
}
```

### 25.5. `Main.java`

```java
package com.amazaing.app;

import com.amazaing.products.Product;
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        Product product = new Product("Mouse", new BigDecimal("19.99"));

        System.out.println(product);
    }
}
```

---

## 26. Compilar módulos desde terminal

Este apartado es más avanzado, pero ayuda a entender cómo funciona.

Supongamos esta estructura:

```text
src/com.amazaing.app/module-info.java
src/com.amazaing.app/com/amazing/app/Main.java
```

Podrías compilar con:

```bash
javac -d out --module-source-path src -m com.amazaing.app
```

Y ejecutar con:

```bash
java --module-path out -m com.amazaing.app/com.amazaing.app.Main
```

En proyectos reales normalmente usarás un IDE o herramientas como Maven o Gradle, pero conocer estos comandos ayuda a entender la base.

---

## 27. Classpath vs module path

Antes del sistema de módulos, Java usaba principalmente el **classpath**.

El classpath indica dónde buscar clases y librerías.

Con módulos aparece el **module path**.

### 27.1. Classpath

```text
Busca clases y librerías de forma tradicional.
```

### 27.2. Module path

```text
Busca módulos con información declarada en module-info.java.
```

A nivel inicial, puedes pensar así:

- proyectos tradicionales → classpath
- proyectos modulares → module path

---

## 28. ¿Todos los proyectos Java necesitan módulos?

No.

Muchísimos proyectos Java no usan módulos explícitamente.

Por ejemplo, muchos proyectos con:

- Spring
- Jakarta EE
- Maven
- Gradle

pueden funcionar sin que tú escribas un `module-info.java`.

Esto no significa que los módulos no sean útiles, sino que no siempre son necesarios en cursos iniciales o proyectos sencillos.

---

## 29. Cuándo usar módulos

Los módulos pueden ser útiles cuando:

- tienes una aplicación grande
- quieres separar partes claramente
- quieres controlar dependencias
- quieres ocultar paquetes internos
- estás creando librerías
- quieres diseñar APIs bien encapsuladas
- quieres aprovechar el sistema modular de Java

---

## 30. Cuándo no usar módulos todavía

Puede que no merezca la pena usarlos si:

- el proyecto es pequeño
- estás aprendiendo lo básico
- usas frameworks que ya gestionan la estructura
- añadir módulos complica más de lo que ayuda
- todavía no tienes una arquitectura clara

Para empezar, es suficiente con entenderlos y saber reconocer un `module-info.java`.

---

## 31. Java moderno: una visión general

Java ha evolucionado mucho en los últimos años.

Aunque durante mucho tiempo tuvo fama de ser muy verboso, las versiones modernas han añadido muchas mejoras.

En este curso ya has visto varias:

- lambdas
- interfaces funcionales
- Stream API
- Optional
- Date/Time API
- records
- sealed classes
- virtual threads
- mejoras en `switch`
- pattern matching
- módulos

Java moderno busca ser:

- más expresivo
- más seguro
- más claro
- más cómodo para aprender
- más preparado para aplicaciones grandes

---

## 32. Module Import Declarations

En Java moderno existe una forma de importar todos los paquetes exportados por un módulo con una sola declaración:

```java
import module java.base;
```

Esto se llama:

- **Module Import Declaration**

La idea es reducir muchos imports individuales cuando estás usando clases de un mismo módulo.

Por ejemplo, en lugar de importar varias clases concretas:

```java
import java.util.List;
import java.util.Map;
import java.util.Optional;
```

puedes importar las clases públicas exportadas por un módulo:

```java
import module java.base;
```

### 32.1. Importante

Esto no sustituye el sistema de módulos completo.

No es lo mismo que `requires`.

- `requires` se escribe en `module-info.java`
- `import module` se escribe en un archivo `.java`

---

## 33. Ejemplo conceptual con `import module`

```java
import module java.base;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex");

        Optional<String> firstName = names.stream()
                .findFirst();

        firstName.ifPresent(System.out::println);
    }
}
```

Con `import module java.base`, las clases exportadas por `java.base` pueden estar disponibles sin importarlas una a una.

Aun así, en muchos proyectos se siguen usando imports clásicos porque son explícitos y conocidos por todo el mundo.

---

## 34. Imports clásicos vs `import module`

### 34.1. Imports clásicos

```java
import java.util.List;
import java.util.Optional;
```

Ventajas:

- son muy explícitos
- funcionan en todas las versiones modernas anteriores
- son familiares

### 34.2. `import module`

```java
import module java.base;
```

Ventajas:

- puede reducir imports repetitivos
- encaja con la organización modular de Java
- puede ser cómodo en ejemplos o programas pequeños

Para un curso inicial, es buena idea conocerlo, pero no es obligatorio usarlo siempre.

---

## 35. Compact Source Files

Java moderno también ha mejorado la forma de escribir programas pequeños.

Tradicionalmente, el primer programa en Java era así:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, Java");
    }
}
```

En Java moderno, para programas sencillos se puede escribir código más compacto.

Ejemplo:

```java
void main() {
    System.out.println("Hello, Java");
}
```

Esto reduce la cantidad de código necesario para empezar.

Es especialmente útil para:

- aprendizaje
- scripts pequeños
- ejemplos sencillos
- primeros programas

---

## 36. ¿Significa esto que ya no necesitamos clases?

No.

En proyectos reales seguirás usando clases, paquetes y estructuras completas.

Los compact source files están pensados para hacer más fácil escribir programas pequeños.

Ejemplo de aprendizaje:

```java
void main() {
    System.out.println("Learning Java");
}
```

Ejemplo de proyecto más estructurado:

```java
public class Main {
    public static void main(String[] args) {
        Application app = new Application();
        app.run();
    }
}
```

Ambos estilos pueden convivir.

---

## 37. Instance main methods

Relacionado con lo anterior, Java moderno permite métodos `main` más sencillos en ciertos contextos.

Forma clásica:

```java
public static void main(String[] args) {
}
```

Forma más simple:

```java
void main() {
}
```

Esto facilita empezar sin explicar desde el minuto uno conceptos como:

- `public`
- `static`
- `String[] args`

En un curso completo, sigue siendo importante entender la forma clásica, porque la verás constantemente en proyectos y documentación.

---

## 38. Pattern matching con `instanceof`

Ya has visto una forma moderna de usar `instanceof`.

Antes:

```java
if (value instanceof String) {
    String text = (String) value;
    System.out.println(text.length());
}
```

Ahora:

```java
if (value instanceof String text) {
    System.out.println(text.length());
}
```

Java declara automáticamente la variable `text` si la condición se cumple.

Esto reduce código repetitivo y hace el programa más claro.

---

## 39. `switch` moderno

Java moderno también ha mejorado `switch`.

Ejemplo tradicional:

```java
switch (status) {
    case "open":
        System.out.println("Open");
        break;
    case "closed":
        System.out.println("Closed");
        break;
    default:
        System.out.println("Unknown");
}
```

Forma moderna:

```java
String message = switch (status) {
    case "open" -> "Open";
    case "closed" -> "Closed";
    default -> "Unknown";
};
```

Ventajas:

- menos código
- menos `break`
- puede devolver un valor
- más expresivo

---

## 40. `switch` con sealed classes

Una de las combinaciones más potentes es:

- sealed interfaces
- records
- switch moderno

Ejemplo:

```java
public sealed interface Result permits Success, Error {
}
```

```java
public record Success(String message) implements Result {
}
```

```java
public record Error(String reason) implements Result {
}
```

Uso:

```java
String text = switch (result) {
    case Success success -> success.message();
    case Error error -> error.reason();
};
```

Como la jerarquía está cerrada, Java puede saber qué casos existen.

---

## 41. Records como parte de Java moderno

Los records reducen muchísimo el código repetitivo para clases de datos.

Antes:

```java
public class User {
    private final String name;
    private final String email;

    public User(String name, String email) {
        this.name = name;
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }
}
```

Ahora:

```java
public record User(String name, String email) {
}
```

Esto no significa que todas las clases deban ser records.  
Significa que Java ofrece una herramienta mejor para ciertos casos.

---

## 42. Sealed classes como parte de Java moderno

Las sealed classes permiten controlar jerarquías.

Ejemplo:

```java
public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

Esto comunica claramente:

> un resultado de pago solo puede ser éxito o error

Son especialmente útiles cuando se combinan con records.

---

## 43. Virtual threads como parte de Java moderno

Los virtual threads permiten crear tareas concurrentes ligeras.

Ejemplo:

```java
public class Main {
    public static void main(String[] args) throws InterruptedException {
        Thread thread = Thread.startVirtualThread(() -> {
            System.out.println("Running in a virtual thread");
        });

        thread.join();
    }
}
```

No sustituyen todo lo que existe sobre concurrencia, pero simplifican muchos escenarios donde hay muchas tareas esperando.

---

## 44. Text blocks

Los text blocks permiten escribir textos de varias líneas de forma más cómoda.

Ejemplo:

```java
String html = """
        <html>
            <body>
                <h1>Hello</h1>
            </body>
        </html>
        """;
```

Son útiles para:

- HTML
- JSON
- SQL
- mensajes largos
- plantillas

Ejemplo con JSON:

```java
String json = """
        {
            "name": "Laura",
            "email": "laura@example.com"
        }
        """;
```

---

## 45. `var`

Java permite inferir el tipo de variables locales con `var`.

Ejemplo:

```java
var name = "Laura";
var age = 28;
var users = List.of("Laura", "Alex");
```

Java deduce el tipo a partir del valor.

### 45.1. Cuándo usar `var`

Puede ser útil cuando el tipo es evidente:

```java
var message = "Hello";
```

### 45.2. Cuándo evitarlo

Evítalo si hace el código menos claro:

```java
var result = service.process();
```

Si no se entiende qué tipo devuelve, puede ser mejor escribir el tipo explícito.

---

## 46. APIs modernas que ya has visto

En este curso también has trabajado con APIs modernas como:

```java
java.time
java.nio.file
java.util.stream
java.util.Optional
java.math.BigDecimal
```

Estas APIs hacen que Java sea más cómodo y seguro.

Ejemplos:

```java
LocalDate.now()
Path.of("data", "notes.txt")
Optional.empty()
List.of("A", "B", "C")
```

---

## 47. Java moderno no significa usar todo siempre

Aprender Java moderno no significa usar todas las novedades en cada archivo.

La idea es elegir bien.

Ejemplos:

- usa records para datos inmutables
- usa clases normales para objetos con estado cambiante
- usa sealed classes para jerarquías cerradas
- usa enums para constantes simples
- usa streams cuando mejoren la claridad
- usa bucles cuando sean más simples
- usa módulos si el proyecto lo necesita

La buena programación no consiste en usar lo más nuevo, sino en usar la herramienta adecuada.

---

## 48. Ejemplo completo: aplicación moderna sencilla

### 48.1. `module-info.java`

```java
module com.amazaing.app {
    exports com.amazaing.app;
}
```

### 48.2. `Product.java`

```java
package com.amazaing.app;

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

### 48.3. `ProductResult.java`

```java
package com.amazaing.app;

public sealed interface ProductResult permits ProductFound, ProductNotFound {
}
```

### 48.4. `ProductFound.java`

```java
package com.amazaing.app;

public record ProductFound(Product product) implements ProductResult {
}
```

### 48.5. `ProductNotFound.java`

```java
package com.amazaing.app;

public record ProductNotFound(String code) implements ProductResult {
}
```

### 48.6. `ProductService.java`

```java
package com.amazaing.app;

import java.math.BigDecimal;
import java.util.List;

public class ProductService {
    private List<Product> products = List.of(
            new Product("Mouse", new BigDecimal("19.99")),
            new Product("Keyboard", new BigDecimal("49.99")),
            new Product("Monitor", new BigDecimal("199.99"))
    );

    public ProductResult findByName(String name) {
        return products.stream()
                .filter(product -> product.name().equalsIgnoreCase(name))
                .findFirst()
                .<ProductResult>map(ProductFound::new)
                .orElse(new ProductNotFound(name));
    }
}
```

### 48.7. `Main.java`

```java
package com.amazaing.app;

public class Main {
    public static void main(String[] args) {
        ProductService service = new ProductService();

        ProductResult result = service.findByName("Mouse");

        String message = switch (result) {
            case ProductFound found -> "Product found: " + found.product();
            case ProductNotFound notFound -> "Product not found: " + notFound.code();
        };

        System.out.println(message);
    }
}
```

Este ejemplo mezcla varias ideas modernas:

- módulos
- records
- sealed interfaces
- streams
- optional
- switch moderno
- BigDecimal

---

## 49. Cómo aprender Java moderno sin abrumarse

Java tiene muchas herramientas, pero no necesitas dominarlas todas a la vez.

Una progresión razonable sería:

1. dominar clases, objetos, colecciones y excepciones
2. entender generics
3. aprender lambdas y streams
4. usar Optional correctamente
5. usar APIs modernas como Date/Time y Files
6. aprender records y sealed classes
7. entender concurrencia básica
8. conocer módulos y herramientas modernas
9. practicar con proyectos completos

El objetivo no es memorizar sintaxis, sino entender qué problema resuelve cada herramienta.

---

## 50. Errores típicos al empezar con módulos y Java moderno

### 50.1. Pensar que un paquete y un módulo son lo mismo

No lo son.

- paquete: organiza clases
- módulo: organiza paquetes y dependencias

### 50.2. Olvidar `exports`

Si un módulo no exporta un paquete, otros módulos no podrán usarlo directamente.

### 50.3. Confundir `requires` con `import`

- `requires` declara dependencia entre módulos
- `import` permite usar clases con nombres más cortos dentro del código

### 50.4. Usar módulos en proyectos demasiado simples

Para proyectos pequeños, pueden añadir complejidad innecesaria.

### 50.5. Usar novedades modernas sin que mejoren el código

No uses records, streams, sealed classes o `var` solo porque existen.  
Úsalos cuando hagan el código más claro.

### 50.6. Abusar de `var`

Si el tipo no es evidente, escribirlo explícitamente puede ser mejor.

---

## 51. Buenas prácticas

- Usa paquetes para organizar clases.
- Usa módulos cuando necesites controlar dependencias y visibilidad.
- Exporta solo los paquetes que forman parte de tu API pública.
- Mantén los paquetes internos sin exportar.
- Usa `requires` para declarar dependencias reales.
- Usa records para datos inmutables.
- Usa sealed classes para jerarquías cerradas.
- Usa `switch` moderno cuando mejore la claridad.
- Usa streams para flujos de datos claros.
- Usa bucles tradicionales cuando sean más legibles.
- Aprende las novedades como herramientas, no como obligaciones.

---

## 52. A tener en cuenta

- `module-info.java` define un módulo.
- `requires` declara dependencias.
- `exports` expone paquetes.
- `opens` permite acceso por reflexión.
- `java.base` está disponible automáticamente.
- `import module` permite importar paquetes exportados por un módulo.
- Los compact source files simplifican programas pequeños.
- Java moderno incluye records, sealed classes, streams, optional, virtual threads y mejoras en `switch`.
- No todos los proyectos necesitan módulos.
- Lo importante es elegir la herramienta adecuada para cada caso.

---

## 53. Resumen final

Los módulos permiten organizar aplicaciones Java de forma más clara y controlada.

Con un archivo:

```java
module-info.java
```

puedes declarar:

```java
module com.amazaing.app {
    requires com.amazaing.products;
    exports com.amazaing.app;
}
```

Esto ayuda a definir qué necesita tu módulo y qué partes expone.

Además, Java moderno ha añadido muchas mejoras que hacen el lenguaje más cómodo y expresivo:

- records
- sealed classes
- switch moderno
- pattern matching
- virtual threads
- compact source files
- module import declarations
- APIs modernas como `java.time`, `java.nio.file` y `Stream API`

La idea principal es que Java sigue evolucionando, pero mantiene una base sólida.

Para programar bien en Java moderno no necesitas usar todas las características nuevas a la vez.  
Lo importante es entender qué problema resuelve cada una y aplicarla cuando mejore tu código.

---

En el siguiente tema veremos como trabajar con **Maven**.
