# Tema 37. Anotaciones

## 1. Introducción

En Java has visto muchas veces símbolos que empiezan por `@`.

Por ejemplo:

```java
@Override
```

o:

```java
@FunctionalInterface
```

Estos elementos se llaman **anotaciones**.

Las anotaciones permiten añadir información extra al código.

Esa información puede ser usada por:

- el compilador
- el IDE
- herramientas externas
- frameworks
- librerías
- el propio programa en tiempo de ejecución

En Java moderno, las anotaciones aparecen constantemente.

Por ejemplo, se usan mucho en:

- Spring
- Jakarta EE
- JUnit
- Hibernate
- Lombok
- validaciones
- serialización JSON
- documentación
- análisis de código

En este tema aprenderás:

- Qué es una anotación
- Para qué sirven las anotaciones
- Anotaciones habituales de Java
- `@Override`
- `@Deprecated`
- `@SuppressWarnings`
- `@FunctionalInterface`
- Cómo crear anotaciones propias
- Qué son `@Retention` y `@Target`
- Cómo usar anotaciones con clases, métodos y atributos
- Introducción básica a leer anotaciones con reflexión
- Errores típicos y buenas prácticas

---

## 2. Qué es una anotación

Una anotación es una forma de añadir metadatos al código.

La palabra **metadatos** significa:

> información sobre otra información

Por ejemplo, esta anotación:

```java
@Override
```

indica que un método está sobrescribiendo un método de una superclase o interfaz.

Ejemplo:

```java
public class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("Woof");
    }
}
```

La anotación no es una instrucción normal como un `if` o un `for`.  
Es información extra que Java o una herramienta pueden interpretar.

---

## 3. Para qué sirven las anotaciones

Las anotaciones pueden servir para muchas cosas.

Algunos usos habituales son:

- avisar al compilador
- generar advertencias
- marcar código obsoleto
- configurar frameworks
- validar datos
- definir rutas web
- indicar pruebas automatizadas
- mapear clases a tablas de base de datos
- reducir código repetitivo

Ejemplo típico en frameworks:

```java
@RestController
public class ProductController {
}
```

Aquí la anotación le indica a un framework que esta clase tiene un papel especial.

---

## 4. Anotaciones integradas en Java

Java incluye varias anotaciones de uso común.

Algunas de las más importantes son:

- `@Override`
- `@Deprecated`
- `@SuppressWarnings`
- `@FunctionalInterface`
- `@SafeVarargs`

En este tema veremos las más útiles para empezar.

---

## 5. `@Override`

`@Override` indica que un método sobrescribe otro método heredado.

Ejemplo:

```java
public class Animal {
    public void makeSound() {
        System.out.println("Animal sound");
    }
}
```

```java
public class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("Woof");
    }
}
```

La anotación ayuda a detectar errores.

---

## 6. Por qué `@Override` es útil

Imagina que escribes mal el nombre del método.

```java
public class Dog extends Animal {
    @Override
    public void makeSond() {
        System.out.println("Woof");
    }
}
```

Como `makeSond` no existe en la clase padre, Java marca error.

Sin `@Override`, Java podría interpretarlo como un método nuevo y el error sería más difícil de detectar.

Por eso es buena práctica usar `@Override` siempre que sobrescribas un método.

---

## 7. `@Override` con interfaces

También se usa al implementar métodos de una interfaz.

```java
public interface Printable {
    void print();
}
```

```java
public class Report implements Printable {
    @Override
    public void print() {
        System.out.println("Printing report...");
    }
}
```

Esto deja claro que `print` viene de la interfaz.

---

## 8. `@Deprecated`

`@Deprecated` indica que un elemento ya no se recomienda.

Puede aplicarse a:

- clases
- métodos
- constructores
- atributos

Ejemplo:

```java
public class UserService {
    @Deprecated
    public void oldMethod() {
        System.out.println("Old method");
    }

    public void newMethod() {
        System.out.println("New method");
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        UserService service = new UserService();

        service.oldMethod();
        service.newMethod();
    }
}
```

El IDE normalmente mostrará una advertencia al usar `oldMethod`.

---

## 9. Para qué sirve `@Deprecated`

Sirve para avisar de que algo sigue existiendo, pero no debería usarse en código nuevo.

Esto es muy común cuando una API evoluciona.

Ejemplo:

```java
@Deprecated
public void loginWithUsername(String username) {
}
```

Quizá ahora se prefiere:

```java
public void loginWithEmail(String email) {
}
```

La anotación permite mantener compatibilidad sin eliminar el método de golpe.

---

## 10. `@Deprecated` con información adicional

Puedes añadir información con `since` y `forRemoval`.

```java
@Deprecated(since = "2.0", forRemoval = true)
public void oldMethod() {
}
```

Esto indica:

- desde qué versión está obsoleto
- si está previsto eliminarlo

Ejemplo:

```java
public class PaymentService {
    @Deprecated(since = "1.5", forRemoval = true)
    public void payWithOldSystem() {
        System.out.println("Old payment system");
    }

    public void payWithNewSystem() {
        System.out.println("New payment system");
    }
}
```

---

## 11. `@SuppressWarnings`

`@SuppressWarnings` sirve para ocultar advertencias del compilador.

Ejemplo:

```java
@SuppressWarnings("unused")
public class Main {
    private String message = "Hello";
}
```

Aquí se está indicando que se ignore la advertencia de que `message` no se usa.

Otro ejemplo:

```java
@SuppressWarnings("deprecation")
public class Main {
    public static void main(String[] args) {
        UserService service = new UserService();
        service.oldMethod();
    }
}
```

Esto suprime la advertencia por usar un método obsoleto.

---

## 12. Usar `@SuppressWarnings` con cuidado

`@SuppressWarnings` puede ser útil, pero no conviene abusar.

Si una advertencia aparece, normalmente conviene preguntarse:

- ¿hay un problema real?
- ¿puedo mejorar el código?
- ¿estoy ocultando algo importante?

Ejemplo poco recomendable:

```java
@SuppressWarnings("all")
public class Main {
}
```

Esto puede ocultar demasiadas advertencias.

Es mejor ser específico:

```java
@SuppressWarnings("unused")
```

---

## 13. `@FunctionalInterface`

Ya has visto esta anotación en el tema de lambdas.

Sirve para marcar una interfaz como interfaz funcional.

Ejemplo:

```java
@FunctionalInterface
public interface TextValidator {
    boolean isValid(String text);
}
```

Una interfaz funcional debe tener un único método abstracto.

Si añades otro método abstracto, Java marcará error.

```java
@FunctionalInterface
public interface TextValidator {
    boolean isValid(String text);

    // boolean isEmpty(String text); // error
}
```

---

## 14. Por qué `@FunctionalInterface` es útil

Esta anotación:

- documenta la intención
- ayuda al compilador a detectar errores
- deja claro que la interfaz está pensada para lambdas

Ejemplo de uso:

```java
@FunctionalInterface
public interface NumberChecker {
    boolean check(int number);
}
```

```java
public class Main {
    public static void main(String[] args) {
        NumberChecker isEven = number -> number % 2 == 0;

        System.out.println(isEven.check(10));
    }
}
```

---

## 15. Dónde se pueden colocar anotaciones

Las anotaciones pueden colocarse en diferentes elementos del código.

Por ejemplo:

### 15.1. En una clase

```java
@Deprecated
public class OldService {
}
```

### 15.2. En un método

```java
@Override
public String toString() {
    return "Example";
}
```

### 15.3. En un atributo

```java
@Deprecated
private String oldField;
```

### 15.4. En una interfaz

```java
@FunctionalInterface
public interface Action {
    void execute();
}
```

### 15.5. En parámetros

```java
public void print(@Deprecated String text) {
}
```

Que una anotación pueda usarse en un sitio u otro depende de cómo esté definida.

---

## 16. Anotaciones en frameworks

Muchas veces verás anotaciones en frameworks.

Por ejemplo, en Spring:

```java
@Service
public class ProductService {
}
```

```java
@GetMapping("/products")
public List<Product> getProducts() {
    return products;
}
```

En JUnit:

```java
@Test
void shouldAddTwoNumbers() {
}
```

En Lombok:

```java
@Getter
@Setter
public class User {
    private String name;
}
```

Cada framework interpreta sus propias anotaciones.

---

## 17. Idea importante: una anotación no hace magia por sí sola

Una anotación solo añade información.

Para que tenga efecto, alguien debe leer esa información.

Puede leerla:

- el compilador
- el IDE
- un framework
- una librería
- código propio mediante reflexión

Ejemplo:

```java
@Test
```

Esta anotación funciona porque JUnit la busca y ejecuta ese método como prueba.

Si no hubiera una herramienta que leyera `@Test`, la anotación no haría nada útil por sí sola.

---

## 18. Crear una anotación propia

Puedes crear tus propias anotaciones usando `@interface`.

Ejemplo:

```java
public @interface Important {
}
```

Uso:

```java
@Important
public class UserService {
}
```

Aquí hemos creado una anotación llamada `Important`.

---

## 19. Sintaxis básica de una anotación propia

```java
public @interface AnnotationName {
}
```

Ejemplo:

```java
public @interface Review {
}
```

Uso:

```java
@Review
public class ProductService {
}
```

De momento, esta anotación solo marca algo como revisable.

---

## 20. Anotaciones con valores

Una anotación puede tener elementos.

Ejemplo:

```java
public @interface Author {
    String name();
}
```

Uso:

```java
@Author(name = "Laura")
public class Report {
}
```

Aquí `name` es un elemento de la anotación.

---

## 21. Elemento llamado `value`

Si una anotación tiene un elemento llamado `value`, puedes usar una sintaxis más corta.

Definición:

```java
public @interface Version {
    String value();
}
```

Uso completo:

```java
@Version(value = "1.0")
public class ProductService {
}
```

Uso abreviado:

```java
@Version("1.0")
public class ProductService {
}
```

Esto solo funciona de forma especial con el elemento llamado `value`.

---

## 22. Valores por defecto

Puedes definir valores por defecto.

```java
public @interface TaskInfo {
    String author();
    int priority() default 1;
}
```

Uso:

```java
@TaskInfo(author = "Laura")
public class TaskService {
}
```

Aquí `priority` vale `1` porque tiene valor por defecto.

También puedes indicar otro valor:

```java
@TaskInfo(author = "Laura", priority = 3)
public class TaskService {
}
```

---

## 23. Tipos permitidos en elementos de anotaciones

Los elementos de una anotación no pueden ser cualquier tipo.

Pueden ser, entre otros:

- tipos primitivos
- `String`
- `Class`
- enums
- otras anotaciones
- arrays de los tipos anteriores

Ejemplo:

```java
public @interface Info {
    String name();
    int version();
    boolean active() default true;
}
```

---

## 24. `@Retention`

`@Retention` indica hasta cuándo se conserva una anotación.

Importación:

```java
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
```

Ejemplo:

```java
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
public @interface Important {
}
```

`RetentionPolicy.RUNTIME` significa que la anotación estará disponible en tiempo de ejecución.

---

## 25. Tipos de `RetentionPolicy`

Hay tres políticas principales:

### 25.1. `SOURCE`

La anotación solo existe en el código fuente.

```java
@Retention(RetentionPolicy.SOURCE)
```

Ejemplo típico:

- herramientas de análisis
- anotaciones que solo importan durante compilación

### 25.2. `CLASS`

La anotación se guarda en el `.class`, pero no está disponible normalmente en tiempo de ejecución por reflexión.

```java
@Retention(RetentionPolicy.CLASS)
```

### 25.3. `RUNTIME`

La anotación se conserva en tiempo de ejecución y puede leerse con reflexión.

```java
@Retention(RetentionPolicy.RUNTIME)
```

Es la opción que usarás si quieres que tu programa lea la anotación mientras se ejecuta.

---

## 26. `@Target`

`@Target` indica dónde puede usarse una anotación.

Importación:

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Target;
```

Ejemplo:

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Target;

@Target(ElementType.METHOD)
public @interface Run {
}
```

Esto significa que `@Run` solo puede aplicarse a métodos.

---

## 27. Valores habituales de `ElementType`

Algunos valores comunes son:

- `TYPE` → clases, interfaces, records, enums
- `METHOD` → métodos
- `FIELD` → atributos
- `PARAMETER` → parámetros
- `CONSTRUCTOR` → constructores
- `LOCAL_VARIABLE` → variables locales
- `PACKAGE` → paquetes

Ejemplo:

```java
@Target(ElementType.TYPE)
public @interface Entity {
}
```

Esta anotación solo puede usarse sobre clases, interfaces, records o enums.

---

## 28. Anotación con `@Retention` y `@Target`

Ejemplo completo:

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface Important {
}
```

Uso:

```java
@Important
public class UserService {
}
```

Esta anotación:

- se conserva en tiempo de ejecución
- solo puede aplicarse a tipos como clases o interfaces

---

## 29. Aplicar una anotación a varios tipos de elementos

Puedes permitir varios destinos.

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Target;

@Target({ElementType.TYPE, ElementType.METHOD})
public @interface Review {
}
```

Uso:

```java
@Review
public class ProductService {
    @Review
    public void createProduct() {
    }
}
```

---

## 30. Ejemplo guiado: anotación `@Todo`

Vamos a crear una anotación para marcar partes del código pendientes.

### 30.1. `Todo.java`

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD})
public @interface Todo {
    String value();
    String author() default "Unknown";
}
```

### 30.2. Uso

```java
@Todo(value = "Review validation rules", author = "Laura")
public class UserService {
    @Todo("Improve error messages")
    public void createUser() {
        System.out.println("Creating user...");
    }
}
```

---

## 31. Introducción a reflexión

La **reflexión** permite inspeccionar clases, métodos y atributos en tiempo de ejecución.

Con reflexión puedes preguntar cosas como:

- qué métodos tiene una clase
- qué atributos tiene
- qué anotaciones tiene
- qué constructores existen

Las anotaciones con:

```java
@Retention(RetentionPolicy.RUNTIME)
```

pueden leerse mediante reflexión.

---

## 32. Leer una anotación de una clase

Supongamos esta anotación:

```java
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
public @interface Important {
}
```

Clase anotada:

```java
@Important
public class UserService {
}
```

Lectura:

```java
public class Main {
    public static void main(String[] args) {
        Class<UserService> clazz = UserService.class;

        boolean hasAnnotation = clazz.isAnnotationPresent(Important.class);

        System.out.println(hasAnnotation);
    }
}
```

Resultado:

```text
true
```

---

## 33. Leer valores de una anotación

Anotación:

```java
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
public @interface Author {
    String name();
}
```

Clase:

```java
@Author(name = "Laura")
public class Report {
}
```

Lectura:

```java
public class Main {
    public static void main(String[] args) {
        Class<Report> clazz = Report.class;

        Author author = clazz.getAnnotation(Author.class);

        if (author != null) {
            System.out.println(author.name());
        }
    }
}
```

Resultado:

```text
Laura
```

---

## 34. Leer anotaciones de métodos

Anotación:

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface Run {
}
```

Clase:

```java
public class TaskService {
    @Run
    public void task1() {
        System.out.println("Task 1");
    }

    public void task2() {
        System.out.println("Task 2");
    }
}
```

Lectura:

```java
import java.lang.reflect.Method;

public class Main {
    public static void main(String[] args) {
        Class<TaskService> clazz = TaskService.class;

        for (Method method : clazz.getDeclaredMethods()) {
            if (method.isAnnotationPresent(Run.class)) {
                System.out.println("Method with @Run: " + method.getName());
            }
        }
    }
}
```

Resultado aproximado:

```text
Method with @Run: task1
```

---

## 35. Ejecutar métodos marcados con una anotación

Este ejemplo es más avanzado, pero ayuda a entender cómo funcionan herramientas como JUnit.

```java
import java.lang.reflect.Method;

public class Main {
    public static void main(String[] args) {
        TaskService service = new TaskService();

        Class<TaskService> clazz = TaskService.class;

        for (Method method : clazz.getDeclaredMethods()) {
            if (method.isAnnotationPresent(Run.class)) {
                try {
                    method.invoke(service);
                } catch (Exception e) {
                    System.out.println("Could not execute method: " + method.getName());
                }
            }
        }
    }
}
```

Clase:

```java
public class TaskService {
    @Run
    public void task1() {
        System.out.println("Running task 1");
    }

    public void task2() {
        System.out.println("Running task 2");
    }
}
```

Resultado:

```text
Running task 1
```

Este es un ejemplo muy sencillo de cómo una herramienta puede buscar anotaciones y actuar según ellas.

---

## 36. Anotaciones repetibles

Java permite que una misma anotación pueda repetirse sobre el mismo elemento si está preparada para ello.

Esto se hace con:

```java
@Repeatable
```

Ejemplo conceptual:

```java
@Tag("java")
@Tag("backend")
public class Course {
}
```

Este tema es más avanzado, pero conviene saber que existe.

---

## 37. Meta-anotaciones

Una meta-anotación es una anotación aplicada a otra anotación.

Ya has visto dos:

```java
@Retention(...)
@Target(...)
```

Estas no anotan clases de negocio directamente, sino que configuran cómo funciona una anotación propia.

Ejemplo:

```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface Entity {
}
```

Aquí `@Retention` y `@Target` son meta-anotaciones.

---

## 38. Anotaciones y records

También puedes usar anotaciones con records.

Ejemplo:

```java
@Deprecated
public record OldUser(String name, String email) {
}
```

También puedes anotar componentes:

```java
public record User(@Deprecated String name, String email) {
}
```

En frameworks, esto puede ser muy útil para validaciones o serialización.

Ejemplo conceptual:

```java
public record UserRequest(
        @Required String name,
        @Required String email
) {
}
```

---

## 39. Anotaciones y módulos

En proyectos modulares, algunas herramientas que leen anotaciones mediante reflexión pueden necesitar que abras paquetes con `opens`.

Ejemplo:

```java
module com.amazaing.app {
    opens com.amazaing.app.models;
}
```

Esto permite que ciertos frameworks puedan inspeccionar clases y anotaciones en tiempo de ejecución.

A nivel inicial, recuerda esta idea:

- si un framework usa reflexión, puede necesitar acceso especial en proyectos modulares

---

## 40. Ejemplo completo: mini sistema de tareas

Vamos a crear una anotación para marcar métodos que deben ejecutarse.

### 40.1. `RunTask.java`

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface RunTask {
    String value() default "Unnamed task";
}
```

### 40.2. `TaskRunner.java`

```java
public class TaskRunner {
    @RunTask("Clean temporary files")
    public void cleanFiles() {
        System.out.println("Cleaning files...");
    }

    @RunTask("Send report")
    public void sendReport() {
        System.out.println("Sending report...");
    }

    public void helperMethod() {
        System.out.println("Helper method");
    }
}
```

### 40.3. `Main.java`

```java
import java.lang.reflect.Method;

public class Main {
    public static void main(String[] args) {
        TaskRunner runner = new TaskRunner();

        Class<TaskRunner> clazz = TaskRunner.class;

        for (Method method : clazz.getDeclaredMethods()) {
            RunTask annotation = method.getAnnotation(RunTask.class);

            if (annotation != null) {
                System.out.println("Running: " + annotation.value());

                try {
                    method.invoke(runner);
                } catch (Exception e) {
                    System.out.println("Error running task: " + method.getName());
                }
            }
        }
    }
}
```

Resultado aproximado:

```text
Running: Clean temporary files
Cleaning files...
Running: Send report
Sending report...
```

---

## 41. Ejemplo completo: anotación para roles

### 41.1. `RequiresRole.java`

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface RequiresRole {
    String value();
}
```

### 41.2. `AdminService.java`

```java
public class AdminService {
    @RequiresRole("ADMIN")
    public void deleteUser() {
        System.out.println("Deleting user...");
    }

    @RequiresRole("USER")
    public void viewProfile() {
        System.out.println("Viewing profile...");
    }
}
```

### 41.3. Lectura simple

```java
import java.lang.reflect.Method;

public class Main {
    public static void main(String[] args) {
        Class<AdminService> clazz = AdminService.class;

        for (Method method : clazz.getDeclaredMethods()) {
            RequiresRole role = method.getAnnotation(RequiresRole.class);

            if (role != null) {
                System.out.println(method.getName() + " requires role: " + role.value());
            }
        }
    }
}
```

Este ejemplo no implementa seguridad real, pero muestra cómo una anotación puede describir requisitos.

---

## 42. Cuándo crear anotaciones propias

Crear anotaciones propias puede tener sentido cuando quieres:

- marcar clases o métodos
- añadir metadatos legibles
- crear mini herramientas internas
- configurar comportamiento
- evitar código repetitivo
- diseñar una pequeña API declarativa

Ejemplo:

```java
@RequiresRole("ADMIN")
public void deleteUser() {
}
```

Esto comunica intención de forma clara.

---

## 43. Cuándo no crear anotaciones propias

No siempre necesitas anotaciones propias.

Evítalas si:

- una interfaz normal sería más clara
- un método normal sería suficiente
- solo vas a usarlas una vez
- complican el código sin aportar valor
- no hay ninguna herramienta o código que las lea

Recuerda:

> una anotación solo es útil si alguien la interpreta.

---

## 44. Anotaciones vs comentarios

Un comentario es solo texto para humanos.

```java
// This method requires admin role
public void deleteUser() {
}
```

Una anotación puede ser leída por herramientas o por el programa.

```java
@RequiresRole("ADMIN")
public void deleteUser() {
}
```

La diferencia clave es:

- comentario → información informal
- anotación → metadato estructurado

---

## 45. Errores típicos al empezar

### 45.1. Pensar que una anotación ejecuta código por sí sola

No lo hace.  
Alguien debe leerla e interpretarla.

### 45.2. Olvidar `@Retention(RetentionPolicy.RUNTIME)`

Si quieres leer la anotación con reflexión en ejecución, necesitas:

```java
@Retention(RetentionPolicy.RUNTIME)
```

### 45.3. Usar mal `@Target`

Si defines:

```java
@Target(ElementType.METHOD)
```

no podrás aplicar esa anotación a una clase.

### 45.4. Abusar de `@SuppressWarnings`

Puede ocultar problemas reales.

### 45.5. Crear anotaciones innecesarias

No todo necesita una anotación propia.

---

## 46. Buenas prácticas

- Usa `@Override` siempre que sobrescribas métodos.
- Usa `@FunctionalInterface` en interfaces pensadas para lambdas.
- Usa `@Deprecated` para marcar código que no debería usarse en nuevas versiones.
- Usa `@SuppressWarnings` solo cuando entiendas la advertencia.
- Define `@Retention` y `@Target` en tus anotaciones propias.
- Usa `RetentionPolicy.RUNTIME` solo si necesitas leer la anotación en ejecución.
- Elige nombres claros para tus anotaciones.
- Crea anotaciones propias solo si aportan claridad o funcionalidad real.
- Recuerda que las anotaciones son metadatos, no lógica de negocio por sí solas.

---

## 47. A tener en cuenta

- Las anotaciones empiezan por `@`.
- Añaden metadatos al código.
- Pueden ser leídas por Java, herramientas, frameworks o reflexión.
- `@Override` ayuda a evitar errores al sobrescribir métodos.
- `@Deprecated` marca código obsoleto.
- `@SuppressWarnings` oculta advertencias concretas.
- `@FunctionalInterface` marca interfaces funcionales.
- Puedes crear anotaciones propias con `@interface`.
- `@Retention` indica cuánto tiempo se conserva una anotación.
- `@Target` indica dónde puede usarse.
- Para leer anotaciones en ejecución necesitas reflexión y `RetentionPolicy.RUNTIME`.

---

## 48. Resumen final

Las anotaciones son una herramienta muy importante en Java moderno.

Permiten añadir información extra al código de una forma estructurada.

Algunas anotaciones ayudan al compilador:

```java
@Override
@Deprecated
@SuppressWarnings
@FunctionalInterface
```

Otras son usadas por frameworks:

```java
@Test
@Service
@GetMapping
@Entity
```

Y también puedes crear tus propias anotaciones:

```java
public @interface Important {
}
```

La idea principal es:

> una anotación describe algo sobre el código, pero necesita que alguna herramienta o lógica la interprete.

Dominar las anotaciones te ayudará a entender mejor muchas librerías y frameworks de Java, además de permitirte crear código más expresivo cuando tenga sentido.

---

En el siguiente tema seguiremos avanzando con Java moderno y veremos **Módulos y Java Moderno**, donde aprenderás cómo organizar proyectos con el sistema de módulos y conocerás algunas ideas actuales del ecosistema Java.
