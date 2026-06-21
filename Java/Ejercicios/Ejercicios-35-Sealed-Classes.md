# Ejercicios - Tema 35: Sealed Classes

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **sealed classes** y **sealed interfaces**: `sealed`, `permits`, `final`, `non-sealed`, records, `switch`, `instanceof` y jerarquías cerradas.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear una sealed interface básica

Crea una sealed interface `Notification` que solo permita estas implementaciones:

- `EmailNotification`
- `SmsNotification`

Haz que ambas implementaciones sean records.

<details><summary>Mostrar solución</summary>

```java
public sealed interface Notification permits EmailNotification, SmsNotification {
}
```

```java
public record EmailNotification(String email, String message) implements Notification {
}
```

```java
public record SmsNotification(String phoneNumber, String message) implements Notification {
}
```

</details>

---

## Ejercicio 2: Procesar una sealed interface con `instanceof`

Usa la sealed interface `Notification` del ejercicio anterior.

Crea un método:

```java
public static void printNotification(Notification notification)
```

Debe imprimir información diferente si recibe un `EmailNotification` o un `SmsNotification`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        Notification notification = new EmailNotification("user@example.com", "Welcome");

        printNotification(notification);
    }

    public static void printNotification(Notification notification) {
        if (notification instanceof EmailNotification email) {
            System.out.println("Email to: " + email.email());
            System.out.println(email.message());
        } else if (notification instanceof SmsNotification sms) {
            System.out.println("SMS to: " + sms.phoneNumber());
            System.out.println(sms.message());
        }
    }
}
```

</details>

---

## Ejercicio 3: Sealed class con subclases `final`

Crea una clase abstracta sellada `Document` que permita:

- `PdfDocument`
- `WordDocument`

Cada subclase debe ser `final` y tener un método `printType()`.

<details><summary>Mostrar solución</summary>

```java
public sealed abstract class Document permits PdfDocument, WordDocument {
    public abstract void printType();
}
```

```java
public final class PdfDocument extends Document {
    @Override
    public void printType() {
        System.out.println("PDF document");
    }
}
```

```java
public final class WordDocument extends Document {
    @Override
    public void printType() {
        System.out.println("Word document");
    }
}
```

</details>

---

## Ejercicio 4: Usar `non-sealed`

Crea una sealed class `Device` que permita:

- `Computer`
- `CustomDevice`

`Computer` debe ser `final`.  
`CustomDevice` debe ser `non-sealed`.

Después crea una clase `SmartWatch` que herede de `CustomDevice`.

<details><summary>Mostrar solución</summary>

```java
public sealed class Device permits Computer, CustomDevice {
}
```

```java
public final class Computer extends Device {
}
```

```java
public non-sealed class CustomDevice extends Device {
}
```

```java
public class SmartWatch extends CustomDevice {
}
```

</details>

---

## Ejercicio 5: Resultado de búsqueda con records

Crea una sealed interface `SearchResult` que permita:

- `Found`
- `NotFound`

`Found` debe guardar `title`.  
`NotFound` debe guardar `query`.

Crea un método que devuelva `Found` si la búsqueda es `"java"` y `NotFound` en otro caso.

<details><summary>Mostrar solución</summary>

```java
public sealed interface SearchResult permits Found, NotFound {
}
```

```java
public record Found(String title) implements SearchResult {
}
```

```java
public record NotFound(String query) implements SearchResult {
}
```

```java
public class SearchService {
    public SearchResult search(String query) {
        if ("java".equalsIgnoreCase(query)) {
            return new Found("Java Course");
        }

        return new NotFound(query);
    }
}
```

</details>

---

## Ejercicio 6: Usar `switch` con sealed interface

Usa `SearchResult` del ejercicio anterior.

En `main`, crea un resultado y usa `switch` para generar un mensaje:

- si es `Found`: `"Found: title"`
- si es `NotFound`: `"No results for: query"`

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        SearchService service = new SearchService();

        SearchResult result = service.search("python");

        String message = switch (result) {
            case Found found -> "Found: " + found.title();
            case NotFound notFound -> "No results for: " + notFound.query();
        };

        System.out.println(message);
    }
}
```

</details>

---

## Ejercicio 7: Jerarquía de pagos

Crea una sealed interface `PaymentMethod` que permita:

- `Card`
- `BankTransfer`
- `Cash`

Cada una debe ser un record con datos diferentes:

- `Card(String lastDigits)`
- `BankTransfer(String iban)`
- `Cash()`

<details><summary>Mostrar solución</summary>

```java
public sealed interface PaymentMethod permits Card, BankTransfer, Cash {
}
```

```java
public record Card(String lastDigits) implements PaymentMethod {
}
```

```java
public record BankTransfer(String iban) implements PaymentMethod {
}
```

```java
public record Cash() implements PaymentMethod {
}
```

</details>

---

## Ejercicio 8: Método para describir pagos

Usa la jerarquía del ejercicio anterior.

Crea un método:

```java
public static String describe(PaymentMethod method)
```

Debe devolver un texto diferente para cada tipo de pago usando `switch`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        PaymentMethod method = new Card("1234");

        System.out.println(describe(method));
    }

    public static String describe(PaymentMethod method) {
        return switch (method) {
            case Card card -> "Card ending in " + card.lastDigits();
            case BankTransfer transfer -> "Bank transfer: " + transfer.iban();
            case Cash cash -> "Cash payment";
        };
    }
}
```

</details>

---

## Ejercicio 9: Sealed class con segundo nivel sellado

Crea una sealed class `Vehicle` que permita:

- `Car`
- `Bike`

`Bike` debe ser `final`.  
`Car` debe ser sealed y permitir:

- `ElectricCar`
- `GasCar`

<details><summary>Mostrar solución</summary>

```java
public sealed class Vehicle permits Car, Bike {
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
public final class Bike extends Vehicle {
}
```

</details>

---

## Ejercicio 10: Elegir entre enum y sealed interface

Crea una sealed interface `UploadResult` con:

- `UploadSuccess(String fileName)`
- `UploadError(String reason)`

Después, en `main`, crea un resultado de error y usa `switch` para imprimir el mensaje.

<details><summary>Mostrar solución</summary>

```java
public sealed interface UploadResult permits UploadSuccess, UploadError {
}
```

```java
public record UploadSuccess(String fileName) implements UploadResult {
}
```

```java
public record UploadError(String reason) implements UploadResult {
}
```

```java
public class Main {
    public static void main(String[] args) {
        UploadResult result = new UploadError("File is too large");

        String message = switch (result) {
            case UploadSuccess success -> "Uploaded: " + success.fileName();
            case UploadError error -> "Upload failed: " + error.reason();
        };

        System.out.println(message);
    }
}
```

</details>

---
