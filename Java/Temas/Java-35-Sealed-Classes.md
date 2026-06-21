# Tema 35. Sealed Classes

## 1. Introducción

En temas anteriores has aprendido conceptos importantes de Programación Orientada a Objetos:

- herencia
- clases abstractas
- interfaces
- records
- polimorfismo

Ahora vamos a estudiar una herramienta moderna de Java que permite controlar mejor las jerarquías de clases:

- **sealed classes**
- **sealed interfaces**

Una clase sellada permite indicar explícitamente qué clases pueden heredar de ella.

Esto es muy útil cuando quieres diseñar una jerarquía cerrada y controlada.

Ejemplos típicos:

- tipos de resultado: éxito o error
- tipos de pago: tarjeta, PayPal o transferencia
- figuras geométricas: círculo, rectángulo o triángulo
- estados de una operación
- respuestas posibles de una API
- tipos de eventos

En este tema aprenderás:

- Qué es una clase sellada
- Qué problema resuelve
- Cómo usar `sealed`
- Para qué sirve `permits`
- Qué significan `final`, `sealed` y `non-sealed`
- Cómo usar sealed classes con herencia
- Cómo usar sealed interfaces
- Cómo combinar sealed interfaces con records
- Cuándo usar sealed classes y cuándo no
- Errores típicos y buenas prácticas

---

## 2. El problema: jerarquías demasiado abiertas

Cuando creas una clase normal, otras clases pueden heredar de ella si no lo impides con `final`.

Ejemplo:

```java
public class PaymentMethod {
}
```

Ahora cualquier clase podría hacer esto:

```java
public class CardPayment extends PaymentMethod {
}
```

```java
public class PaypalPayment extends PaymentMethod {
}
```

Pero también podría aparecer una clase inesperada:

```java
public class StrangePayment extends PaymentMethod {
}
```

En algunos casos eso está bien.  
Pero en otros quieres controlar exactamente qué subclases son válidas.

Ahí aparecen las sealed classes.

---

## 3. Qué es una sealed class

Una **sealed class** es una clase que limita qué otras clases pueden heredar de ella.

Se declara con la palabra clave:

```java
sealed
```

Ejemplo:

```java
public sealed class PaymentMethod permits CardPayment, PaypalPayment {
}
```

Esto significa:

- `PaymentMethod` es una clase sellada
- solo `CardPayment` y `PaypalPayment` pueden heredar de ella

---

## 4. Primer ejemplo básico

### 4.1. Clase padre sellada

```java
public sealed class PaymentMethod permits CardPayment, PaypalPayment {
}
```

### 4.2. Subclase permitida

```java
public final class CardPayment extends PaymentMethod {
}
```

### 4.3. Otra subclase permitida

```java
public final class PaypalPayment extends PaymentMethod {
}
```

### 4.4. Clase no permitida

Esto no compila:

```java
// public final class CashPayment extends PaymentMethod {
// }
```

¿Por qué?

Porque `CashPayment` no aparece en la lista de `permits`.

---

## 5. Para qué sirve `permits`

La palabra clave `permits` indica qué clases tienen permiso para heredar.

```java
public sealed class Shape permits Circle, Rectangle, Triangle {
}
```

Aquí solo pueden heredar directamente de `Shape`:

- `Circle`
- `Rectangle`
- `Triangle`

Ninguna otra clase puede extender `Shape`.

---

## 6. Las subclases deben declarar su intención

Cuando una clase hereda de una clase sellada, debe indicar una de estas tres opciones:

- `final`
- `sealed`
- `non-sealed`

Ejemplo:

```java
public final class Circle extends Shape {
}
```

Esto es obligatorio.

Java quiere que cada subclase diga claramente si la jerarquía termina ahí o continúa.

---

## 7. Opción 1: `final`

Una subclase `final` no permite más herencia.

```java
public final class Circle extends Shape {
}
```

Esto significa:

- `Circle` hereda de `Shape`
- nadie puede heredar de `Circle`

Ejemplo inválido:

```java
// public class SmallCircle extends Circle {
// }
```

---

## 8. Opción 2: `sealed`

Una subclase también puede ser sellada.

```java
public sealed class Rectangle extends Shape permits Square {
}
```

Esto significa:

- `Rectangle` hereda de `Shape`
- `Rectangle` permite que herede de ella solo `Square`

Subclase:

```java
public final class Square extends Rectangle {
}
```

La jerarquía sigue controlada.

---

## 9. Opción 3: `non-sealed`

Una subclase `non-sealed` vuelve a abrir la herencia.

```java
public non-sealed class Triangle extends Shape {
}
```

Esto significa:

- `Triangle` puede heredar de `Shape`
- pero otras clases sí pueden heredar de `Triangle`

Ejemplo:

```java
public class RightTriangle extends Triangle {
}
```

`non-sealed` rompe la restricción a partir de esa clase.

---

## 10. Resumen de `final`, `sealed` y `non-sealed`

Cuando una clase hereda de una sealed class, debe elegir:

### 10.1. `final`

La herencia termina.

```java
public final class Circle extends Shape {
}
```

### 10.2. `sealed`

La herencia continúa, pero sigue controlada.

```java
public sealed class Rectangle extends Shape permits Square {
}
```

### 10.3. `non-sealed`

La herencia se vuelve a abrir.

```java
public non-sealed class Triangle extends Shape {
}
```

---

## 11. Ejemplo completo: figuras geométricas

### 11.1. `Shape.java`

```java
public sealed abstract class Shape permits Circle, Rectangle {
    public abstract double area();
}
```

### 11.2. `Circle.java`

```java
public final class Circle extends Shape {
    private double radius;

    public Circle(double radius) {
        if (radius <= 0) {
            this.radius = 1.0;
            return;
        }

        this.radius = radius;
    }

    @Override
    public double area() {
        return Math.PI * radius * radius;
    }
}
```

### 11.3. `Rectangle.java`

```java
public final class Rectangle extends Shape {
    private double width;
    private double height;

    public Rectangle(double width, double height) {
        if (width <= 0) {
            this.width = 1.0;
        } else {
            this.width = width;
        }

        if (height <= 0) {
            this.height = 1.0;
        } else {
            this.height = height;
        }
    }

    @Override
    public double area() {
        return width * height;
    }
}
```

### 11.4. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        Shape shape1 = new Circle(3.0);
        Shape shape2 = new Rectangle(4.0, 2.0);

        System.out.println(shape1.area());
        System.out.println(shape2.area());
    }
}
```

Aquí `Shape` es una clase abstracta y sellada.

Eso significa:

- no se puede instanciar directamente
- solo pueden heredar las clases permitidas

---

## 12. Sealed class abstracta

Una sealed class puede ser abstracta.

Esto es muy habitual.

```java
public sealed abstract class Animal permits Dog, Cat {
    private String name;

    public Animal(String name) {
        this.name = name;
    }

    public String name() {
        return name;
    }

    public abstract void makeSound();
}
```

Subclases:

```java
public final class Dog extends Animal {
    public Dog(String name) {
        super(name);
    }

    @Override
    public void makeSound() {
        System.out.println("Woof");
    }
}
```

```java
public final class Cat extends Animal {
    public Cat(String name) {
        super(name);
    }

    @Override
    public void makeSound() {
        System.out.println("Meow");
    }
}
```

---

## 13. Sealed interfaces

No solo las clases pueden ser selladas.  
También puedes crear interfaces selladas.

Ejemplo:

```java
public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

Esto significa que solo las clases o records permitidos pueden implementar esa interfaz.

---

## 14. Sealed interfaces con records

Una combinación muy moderna y útil es:

- sealed interface
- records

Ejemplo:

```java
public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

```java
public record PaymentSuccess(String transactionId) implements PaymentResult {
}
```

```java
public record PaymentError(String message) implements PaymentResult {
}
```

Aquí tenemos dos posibles resultados:

- pago exitoso
- pago con error

Y la jerarquía está cerrada.

---

## 15. Por qué records encajan bien con sealed interfaces

Los records son inmutables y representan datos.

Las sealed interfaces permiten cerrar una familia de tipos.

Juntos son muy útiles para representar resultados posibles.

Ejemplo conceptual:

```text
PaymentResult
    PaymentSuccess
    PaymentError
```

El resultado de un pago solo puede ser uno de esos tipos.

---

## 16. Ejemplo completo: resultado de pago

### 16.1. `PaymentResult.java`

```java
public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

### 16.2. `PaymentSuccess.java`

```java
public record PaymentSuccess(String transactionId) implements PaymentResult {
}
```

### 16.3. `PaymentError.java`

```java
public record PaymentError(String message) implements PaymentResult {
}
```

### 16.4. `PaymentService.java`

```java
public class PaymentService {
    public PaymentResult processPayment(double amount) {
        if (amount <= 0) {
            return new PaymentError("Amount must be positive");
        }

        return new PaymentSuccess("TX-12345");
    }
}
```

### 16.5. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        PaymentService service = new PaymentService();

        PaymentResult result = service.processPayment(49.99);

        System.out.println(result);
    }
}
```

Este diseño es más expresivo que devolver `null`, `boolean` o un texto suelto.

---

## 17. Trabajar con `instanceof`

Como `PaymentResult` puede ser varios tipos, puedes usar `instanceof` para distinguirlos.

```java
public class Main {
    public static void main(String[] args) {
        PaymentResult result = new PaymentSuccess("TX-12345");

        if (result instanceof PaymentSuccess success) {
            System.out.println("Payment completed: " + success.transactionId());
        } else if (result instanceof PaymentError error) {
            System.out.println("Payment failed: " + error.message());
        }
    }
}
```

Aquí usamos pattern matching con `instanceof`, que permite declarar la variable directamente:

```java
result instanceof PaymentSuccess success
```

---

## 18. Sealed classes y `switch`

Las sealed classes encajan muy bien con `switch`, porque Java puede conocer todos los tipos posibles de una jerarquía cerrada.

Ejemplo:

```java
public static String getMessage(PaymentResult result) {
    return switch (result) {
        case PaymentSuccess success -> "Payment completed: " + success.transactionId();
        case PaymentError error -> "Payment failed: " + error.message();
    };
}
```

Como `PaymentResult` es sellada y solo permite dos tipos, el `switch` puede cubrir todos los casos.

---

## 19. Ejemplo completo con `switch`

```java
public class Main {
    public static void main(String[] args) {
        PaymentResult result = new PaymentError("Invalid card");

        String message = switch (result) {
            case PaymentSuccess success -> "Payment completed: " + success.transactionId();
            case PaymentError error -> "Payment failed: " + error.message();
        };

        System.out.println(message);
    }
}
```

Este estilo es muy expresivo para jerarquías cerradas.

---

## 20. Ejemplo: estados de una tarea

Imagina que una tarea puede estar en uno de varios estados:

- pendiente
- en progreso
- completada
- cancelada

Podemos modelarlo con una sealed interface.

### 20.1. `TaskStatus.java`

```java
public sealed interface TaskStatus permits Pending, InProgress, Completed, Cancelled {
}
```

### 20.2. Records de estado

```java
public record Pending() implements TaskStatus {
}
```

```java
public record InProgress(String assignedTo) implements TaskStatus {
}
```

```java
public record Completed(String completedBy) implements TaskStatus {
}
```

```java
public record Cancelled(String reason) implements TaskStatus {
}
```

### 20.3. Uso

```java
public class Main {
    public static void main(String[] args) {
        TaskStatus status = new InProgress("Laura");

        String text = switch (status) {
            case Pending pending -> "Task is pending";
            case InProgress inProgress -> "Assigned to: " + inProgress.assignedTo();
            case Completed completed -> "Completed by: " + completed.completedBy();
            case Cancelled cancelled -> "Cancelled: " + cancelled.reason();
        };

        System.out.println(text);
    }
}
```

Este diseño permite que cada estado tenga sus propios datos.

---

## 21. Diferencia entre enum y sealed classes

A veces un `enum` también sirve para representar opciones cerradas.

Ejemplo:

```java
public enum Status {
    PENDING,
    IN_PROGRESS,
    COMPLETED,
    CANCELLED
}
```

Esto es sencillo y muy útil.

Pero un enum tiene una limitación:

- cada constante no suele llevar una estructura de datos distinta de forma tan flexible

Con sealed classes o sealed interfaces, cada caso puede tener sus propios datos.

Ejemplo:

```java
public record InProgress(String assignedTo) implements TaskStatus {
}
```

```java
public record Cancelled(String reason) implements TaskStatus {
}
```

Cada estado puede tener información específica.

---

## 22. Cuándo usar enum

Usa `enum` cuando:

- tienes un conjunto fijo de constantes simples
- los casos no necesitan datos distintos
- quieres algo directo y fácil de leer

Ejemplo:

```java
public enum UserRole {
    ADMIN,
    USER,
    GUEST
}
```

---

## 23. Cuándo usar sealed classes

Usa sealed classes o sealed interfaces cuando:

- tienes un conjunto cerrado de tipos
- cada tipo puede tener datos diferentes
- quieres aprovechar polimorfismo
- quieres controlar la jerarquía
- quieres modelar resultados o estados complejos

Ejemplo:

```java
public sealed interface LoginResult permits LoginSuccess, LoginError {
}
```

```java
public record LoginSuccess(String username) implements LoginResult {
}
```

```java
public record LoginError(String message) implements LoginResult {
}
```

---

## 24. Ejemplo completo: resultado de login

### 24.1. `LoginResult.java`

```java
public sealed interface LoginResult permits LoginSuccess, LoginError {
}
```

### 24.2. `LoginSuccess.java`

```java
public record LoginSuccess(String username) implements LoginResult {
}
```

### 24.3. `LoginError.java`

```java
public record LoginError(String message) implements LoginResult {
}
```

### 24.4. `LoginService.java`

```java
public class LoginService {
    public LoginResult login(String username, String password) {
        if (username == null || username.isBlank()) {
            return new LoginError("Username is required");
        }

        if (password == null || password.length() < 4) {
            return new LoginError("Password is too short");
        }

        if (username.equals("admin") && password.equals("1234")) {
            return new LoginSuccess(username);
        }

        return new LoginError("Invalid credentials");
    }
}
```

### 24.5. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        LoginService service = new LoginService();

        LoginResult result = service.login("admin", "1234");

        String message = switch (result) {
            case LoginSuccess success -> "Welcome, " + success.username();
            case LoginError error -> "Login failed: " + error.message();
        };

        System.out.println(message);
    }
}
```

---

## 25. Ejemplo con clase sellada y subclase `non-sealed`

A veces quieres controlar una parte de la jerarquía, pero dejar abierta una rama.

```java
public sealed class Notification permits EmailNotification, CustomNotification {
}
```

```java
public final class EmailNotification extends Notification {
}
```

```java
public non-sealed class CustomNotification extends Notification {
}
```

Ahora esto sí es válido:

```java
public class SmsNotification extends CustomNotification {
}
```

Porque `CustomNotification` es `non-sealed`.

---

## 26. Ejemplo con subclase sellada

También puedes crear una jerarquía por niveles.

```java
public sealed class Vehicle permits Car, Motorcycle {
}
```

```java
public sealed class Car extends Vehicle permits ElectricCar, GasCar {
}
```

```java
public final class ElectricCar extends Car {
}
```

```java
public final class GasCar extends Car {
}
```

```java
public final class Motorcycle extends Vehicle {
}
```

Aquí:

- `Vehicle` controla sus subclases directas
- `Car` también controla sus propias subclases

---

## 27. Reglas importantes

Para trabajar con sealed classes, recuerda estas reglas:

- una clase sellada usa `sealed`
- debe indicar qué clases permite con `permits`
- cada subclase directa debe ser `final`, `sealed` o `non-sealed`
- una clase no permitida no puede heredar de la sellada
- los records pueden implementar sealed interfaces
- una sealed interface puede ser implementada por clases, records o enums permitidos

---

## 28. Organización de archivos

Normalmente cada clase estará en su propio archivo.

Ejemplo:

```text
PaymentResult.java
PaymentSuccess.java
PaymentError.java
PaymentService.java
Main.java
```

Si usas packages, todas estas clases deberán estar correctamente organizadas e importadas.

Ejemplo:

```java
package com.amazaing.java25.payment;
```

---

## 29. Sealed classes y packages

Cuando trabajas sin módulos, las subclases permitidas suelen estar en el mismo paquete que la clase sellada.

Ejemplo:

```java
package com.amazaing.java25.payment;

public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

```java
package com.amazaing.java25.payment;

public record PaymentSuccess(String transactionId) implements PaymentResult {
}
```

```java
package com.amazaing.java25.payment;

public record PaymentError(String message) implements PaymentResult {
}
```

Para un curso inicial, lo importante es mantener la jerarquía clara y en el mismo paquete.

---

## 30. Sealed classes y diseño de dominio

Las sealed classes son muy útiles para modelar dominios donde conoces todos los casos posibles.

Ejemplos:

- resultado de pago
- resultado de login
- estados de una tarea
- eventos de una aplicación
- comandos de usuario
- respuestas de validación
- tipos de mensaje

Ejemplo conceptual:

```text
ValidationResult
    Valid
    Invalid
```

Esto comunica mucho mejor la intención del código.

---

## 31. Ejemplo completo: validación

### 31.1. `ValidationResult.java`

```java
public sealed interface ValidationResult permits Valid, Invalid {
}
```

### 31.2. `Valid.java`

```java
public record Valid() implements ValidationResult {
}
```

### 31.3. `Invalid.java`

```java
public record Invalid(String message) implements ValidationResult {
}
```

### 31.4. `UserValidator.java`

```java
public class UserValidator {
    public ValidationResult validateUsername(String username) {
        if (username == null || username.isBlank()) {
            return new Invalid("Username cannot be blank");
        }

        if (username.length() < 3) {
            return new Invalid("Username is too short");
        }

        return new Valid();
    }
}
```

### 31.5. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        UserValidator validator = new UserValidator();

        ValidationResult result = validator.validateUsername("Al");

        String message = switch (result) {
            case Valid valid -> "Valid username";
            case Invalid invalid -> "Invalid username: " + invalid.message();
        };

        System.out.println(message);
    }
}
```

---

## 32. Ventajas de sealed classes

Las principales ventajas son:

- controlas quién puede heredar
- haces más claro el diseño
- evitas subclases inesperadas
- mejoras el uso de `switch`
- modelas mejor resultados y estados
- combinas muy bien con records
- haces más explícita la intención del código

---

## 33. Limitaciones de sealed classes

También tienen limitaciones:

- pueden añadir complejidad si se usan sin necesidad
- requieren pensar bien la jerarquía
- no son ideales para sistemas donde cualquiera debe poder extender
- pueden ser excesivas para casos muy simples

Como siempre, la herramienta debe usarse cuando encaja con el problema.

---

## 34. Sealed class vs clase abstracta normal

### 34.1. Clase abstracta normal

Permite herencia abierta.

```java
public abstract class Shape {
}
```

Cualquier clase puede extenderla, si tiene acceso.

### 34.2. Sealed abstract class

Permite herencia controlada.

```java
public sealed abstract class Shape permits Circle, Rectangle {
}
```

Solo las clases permitidas pueden extenderla.

---

## 35. Sealed interface vs interface normal

### 35.1. Interface normal

```java
public interface PaymentResult {
}
```

Cualquier clase puede implementarla.

### 35.2. Sealed interface

```java
public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

Solo las clases o records permitidos pueden implementarla.

---

## 36. Cuándo no usar sealed classes

No uses sealed classes si:

- quieres que otros desarrolladores puedan extender libremente
- la jerarquía puede crecer sin control previsto
- un `enum` simple resuelve el problema
- una clase normal es más clara
- estás modelando objetos con comportamiento muy abierto

Ejemplo:

```java
public interface Plugin {
    void execute();
}
```

Si quieres que cualquiera pueda crear nuevos plugins, no conviene sellar la interfaz.

---

## 37. Errores típicos al empezar

### 37.1. Olvidar `permits`

```java
public sealed class Shape {
}
```

En muchos casos deberás indicar qué subclases están permitidas.

```java
public sealed class Shape permits Circle, Rectangle {
}
```

### 37.2. Olvidar `final`, `sealed` o `non-sealed`

Esto no compila:

```java
public class Circle extends Shape {
}
```

Debe ser:

```java
public final class Circle extends Shape {
}
```

### 37.3. Intentar extender una clase sellada sin permiso

```java
// public final class Triangle extends Shape { } // error si no aparece en permits
```

### 37.4. Usar sealed classes cuando un enum sería suficiente

Si solo tienes constantes simples, probablemente un `enum` sea más claro.

### 37.5. Confundir `sealed` con `final`

- `final` no permite ninguna subclase
- `sealed` permite solo algunas subclases
- `non-sealed` vuelve a abrir la herencia

---

## 38. Buenas prácticas

- Usa sealed classes para jerarquías cerradas y conocidas.
- Usa sealed interfaces con records para representar resultados o estados.
- Mantén las subclases directas claras y bien nombradas.
- Usa `final` cuando no quieras que la herencia continúe.
- Usa `sealed` si quieres controlar otro nivel de herencia.
- Usa `non-sealed` solo cuando realmente quieras abrir una rama.
- Si los casos son simples y sin datos propios, considera usar `enum`.
- No selles interfaces que estén pensadas para extensiones abiertas.

---

## 39. A tener en cuenta

- `sealed` limita quién puede heredar o implementar.
- `permits` indica las clases permitidas.
- Las subclases directas deben ser `final`, `sealed` o `non-sealed`.
- `final` cierra la herencia.
- `sealed` mantiene la herencia controlada.
- `non-sealed` vuelve a abrir la herencia.
- Las sealed interfaces combinan muy bien con records.
- Son útiles para resultados, estados y jerarquías cerradas.
- Ayudan a escribir `switch` más seguros y expresivos.

---

## 40. Resumen final

Las sealed classes permiten controlar mejor las jerarquías de tipos en Java.

Con una clase normal o una interfaz normal, la herencia puede quedar demasiado abierta.  
Con `sealed`, puedes decir exactamente qué clases forman parte de la familia.

Ejemplo:

```java
public sealed interface PaymentResult permits PaymentSuccess, PaymentError {
}
```

Esto hace que el diseño sea más claro y seguro.

La idea principal es:

- usa `sealed` cuando conozcas todos los casos posibles
- usa `final` para cerrar una rama
- usa `sealed` para seguir controlando otra rama
- usa `non-sealed` para abrir una rama concreta

Combinadas con records, las sealed interfaces son una herramienta muy potente para modelar datos modernos en Java.

---

En el siguiente tema seguiremos avanzando con Java moderno y veremos **Concurrencia Básica**, una introducción a cómo ejecutar tareas de forma paralela o en segundo plano con herramientas como `Thread`, `Runnable` y `ExecutorService`.
