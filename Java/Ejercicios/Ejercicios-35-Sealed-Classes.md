# Exercises - Topic 35: Sealed Classes

Below you will find **10 practical exercises** to work with **sealed classes** and **sealed interfaces**: `sealed`, `permits`, `final`, `non-sealed`, records, `switch`, `instanceof` and closed hierarchies.

Try to solve them before consulting the solution.

---

## Exercise 1: Create a basic sealed interface

Create a sealed interface `Notification` that only allows these implementations:

- `EmailNotification`
- `SmsNotification`

Make both implementations records.

<details><summary>Show solution</summary>

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

## Exercise 2: Process a sealed interface with `instanceof`

Use the sealed interface `Notification` from the previous exercise.

Create a method:

```java
public static void printNotification(Notification notification)
```

You must print different information if you receive an `EmailNotification` or an `SmsNotification`.

<details><summary>Show solution</summary>

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

## Exercise 3: Sealed class with subclasses `final`

Create a sealed abstract class `Document` that allows:

- `PdfDocument`
- `WordDocument`

Each subclass must be `final` and have an `printType()` method.

<details><summary>Show solution</summary>

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

## Exercise 4: Use `non-sealed`

Create a sealed class `Device` that allows:

- `Computer`
- `CustomDevice`

`Computer` must be `final`.  
`CustomDevice` must be `non-sealed`.

Then create a class `SmartWatch` that inherits from `CustomDevice`.

<details><summary>Show solution</summary>

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

## Exercise 5: Search result with records

Create a sealed interface `SearchResult` that allows:

- `Found`
- `NotFound`

`Found` must save `title`.  
`NotFound` should save `query`.

Create a method that returns `Found` if the search is `"java"` and `NotFound` otherwise.

<details><summary>Show solution</summary>

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

## Exercise 6: Use `switch` with sealed interface

Use `SearchResult` from the previous exercise.

In `main`, create a result and use `switch` to generate a message:

- if it is `Found`: `"Found: title"`
- if it is `NotFound`: `"No results for: query"`

<details><summary>Show solution</summary>

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

## Exercise 7: Payment hierarchy

Create a sealed interface `PaymentMethod` that allows:

- `Card`
- `BankTransfer`
- `Cash`

Each one must be a record with different data:

- `Card(String lastDigits)`
- `BankTransfer(String iban)`
- `Cash()`

<details><summary>Show solution</summary>

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

## Exercise 8: Method for describing payments

Use the hierarchy from the previous exercise.

Create a method:

```java
public static String describe(PaymentMethod method)
```

You should return different text for each payment type using `switch`.

<details><summary>Show solution</summary>

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

## Exercise 9: Sealed class with second sealed level

Create a sealed class `Vehicle` that allows:

- `Car`
- `Bike`

`Bike` must be `final`.  
`Car` must be sealed and allow:

- `ElectricCar`
- `GasCar`

<details><summary>Show solution</summary>

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

## Exercise 10: Choose between enum and sealed interface

Create a sealed interface `UploadResult` with:

- `UploadSuccess(String fileName)`
- `UploadError(String reason)`

Then, in `main`, create an error output and use `switch` to print the message.

<details><summary>Show solution</summary>

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
