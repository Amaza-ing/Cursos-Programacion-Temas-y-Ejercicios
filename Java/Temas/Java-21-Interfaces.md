# Tema 21. Interfaces

## 1. Introducción

En el tema anterior viste las **clases abstractas** y los **métodos abstractos**, que permiten crear una base común para varias clases hijas.

Ahora vamos a estudiar otro concepto fundamental de Java y de la Programación Orientada a Objetos:

- **Interfaces**

Las interfaces sirven para definir un **contrato**: indican qué métodos debe tener una clase, sin obligar a compartir estado ni una implementación común completa.

Esto es muy útil cuando varias clases distintas:

- no comparten una jerarquía clara de herencia
- pero sí comparten un comportamiento esperado

Ejemplos típicos:

- `Printable`
- `Payable`
- `Comparable`
- `Runnable`

Una interfaz permite decir:

> “Cualquier clase que implemente esto debe saber hacer estas operaciones”.

En este tema aprenderás:

- Qué es una interfaz
- Cómo se declara y cómo se implementa
- Diferencias entre interfaz y clase abstracta
- Qué son los métodos `default` y `static` en interfaces
- Qué significa que una clase pueda implementar varias interfaces
- Cómo usar interfaces con polimorfismo
- Ejemplos reales y buenas prácticas

---

## 2. Qué es una interfaz

Una **interfaz** es un tipo especial de Java que define un contrato.

Ese contrato indica:

- qué métodos deben existir
- pero no obliga a una implementación concreta clásica en todos los casos

Sintaxis básica:

```java
public interface Printable {
    void print();
}
```

Esto significa:

- cualquier clase que implemente `Printable`
- deberá tener un método `print()`

---

## 3. Cómo implementar una interfaz

Una clase implementa una interfaz usando `implements`.

Ejemplo:

```java
public interface Printable {
    void print();
}
```

```java
public class Invoice implements Printable {
    @Override
    public void print() {
        System.out.println("Printing invoice...");
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Invoice invoice = new Invoice();
        invoice.print();
    }
}
```

---

## 4. Interfaz como contrato, no como objeto “normal”

Igual que una clase abstracta, una interfaz no se instancia directamente.

Esto no se puede hacer:

```java
// Printable p = new Printable(); // error
```

Pero sí puedes hacer:

```java
Printable p = new Invoice();
p.print();
```

Esto es polimorfismo: trabajas con la interfaz, no con la clase concreta.

---

## 5. Qué pueden contener las interfaces

En Java moderno, una interfaz puede contener:

- métodos abstractos
- métodos `default`
- métodos `static`
- constantes (`public static final`)

### 5.1. Método abstracto

Es el caso clásico:

```java
public interface Payable {
    double calculatePayment();
}
```

### 5.2. Constantes

Todo atributo declarado en una interfaz es, implícitamente:

- `public`
- `static`
- `final`

Ejemplo:

```java
public interface AppConfig {
    int MAX_USERS = 100;
}
```

Uso:

```java
System.out.println(AppConfig.MAX_USERS);
```

---

## 6. Primer ejemplo completo: `Playable`

Queremos que distintas clases sepan “reproducirse”.

### 6.1. Interfaz

```java
public interface Playable {
    void play();
}
```

### 6.2. Clases que implementan la interfaz

```java
public class Song implements Playable {
    private String title;

    public Song(String title) {
        this.title = title;
    }

    @Override
    public void play() {
        System.out.println("Playing song: " + title);
    }
}
```

```java
public class Video implements Playable {
    private String name;

    public Video(String name) {
        this.name = name;
    }

    @Override
    public void play() {
        System.out.println("Playing video: " + name);
    }
}
```

### 6.3. Uso polimórfico

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Playable> items = new ArrayList<>();

        items.add(new Song("Imagine"));
        items.add(new Video("Java Course Intro"));

        for (Playable item : items) {
            item.play();
        }
    }
}
```

Observa lo potente que es esto:

- `Song` y `Video` no tienen por qué heredar de una misma clase concreta
- pero ambas cumplen el contrato `Playable`
- así puedes tratarlas de forma uniforme

---

## 7. Diferencia entre `extends` e `implements`

- `extends` se usa para heredar de una clase o extender otra interfaz
- `implements` se usa cuando una clase implementa una interfaz

Ejemplo:

```java
public class Dog extends Animal implements Playable {
}
```

Aquí:

- `Dog` hereda de `Animal`
- `Dog` implementa `Playable`

---

## 8. Interfaz vs clase abstracta

Esta comparación es muy importante.

### 8.1. Usa una clase abstracta cuando

- quieres compartir estado común (atributos)
- quieres reutilizar implementación común
- existe una relación clara de herencia (_is-a_)

Ejemplo:

- `Animal`
- `Employee`
- `Shape`

### 8.2. Usa una interfaz cuando

- quieres definir capacidades o comportamientos
- varias clases no relacionadas deben cumplir el mismo contrato
- no necesitas compartir estado común obligatorio

Ejemplo:

- `Printable`
- `Payable`
- `Sortable`

### 8.3. Regla práctica simple

- Clase abstracta = base común
- Interfaz = capacidad o contrato

---

## 9. Una clase puede implementar varias interfaces

Aquí está una gran diferencia respecto a la herencia de clases.

En Java:

- una clase solo puede heredar de una clase
- pero puede implementar varias interfaces

Ejemplo:

```java
public interface Printable {
    void print();
}
```

```java
public interface Exportable {
    void export();
}
```

```java
public class Report implements Printable, Exportable {
    @Override
    public void print() {
        System.out.println("Printing report...");
    }

    @Override
    public void export() {
        System.out.println("Exporting report...");
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Report report = new Report();

        report.print();
        report.export();
    }
}
```

Esto es muy útil porque una clase puede tener varias “capacidades”.

---

## 10. Polimorfismo con interfaces

Igual que en herencia, las interfaces permiten polimorfismo.

Ejemplo:

```java
Printable p1 = new Report();
Printable p2 = new Invoice();
```

Si ambas clases implementan `Printable`, puedes tratarlas como `Printable`.

### 10.1. Ejemplo completo

```java
public interface Printable {
    void print();
}
```

```java
public class Invoice implements Printable {
    @Override
    public void print() {
        System.out.println("Printing invoice...");
    }
}
```

```java
public class Ticket implements Printable {
    @Override
    public void print() {
        System.out.println("Printing ticket...");
    }
}
```

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Printable> documents = new ArrayList<>();

        documents.add(new Invoice());
        documents.add(new Ticket());

        for (Printable document : documents) {
            document.print();
        }
    }
}
```

---

## 11. Métodos `default` en interfaces

Desde Java 8, una interfaz puede tener métodos `default`, es decir, métodos con implementación por defecto.

Esto permite añadir comportamiento común sin obligar a que todas las clases lo reescriban.

Ejemplo:

```java
public interface Greeter {
    void greet();

    default void sayGoodbye() {
        System.out.println("Goodbye!");
    }
}
```

Clase que implementa:

```java
public class Person implements Greeter {
    @Override
    public void greet() {
        System.out.println("Hello!");
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Person person = new Person();

        person.greet();
        person.sayGoodbye();
    }
}
```

Aquí:

- `greet()` debe implementarse
- `sayGoodbye()` ya viene “regalado” por la interfaz

### 11.1. Sobrescribir un método `default`

También puedes sobrescribirlo:

```java
public class FriendlyPerson implements Greeter {
    @Override
    public void greet() {
        System.out.println("Hi!");
    }

    @Override
    public void sayGoodbye() {
        System.out.println("See you soon!");
    }
}
```

---

## 12. Métodos `static` en interfaces

Una interfaz también puede tener métodos estáticos.

Se llaman con el nombre de la interfaz, no con el objeto.

Ejemplo:

```java
public interface TemperatureConverter {
    static double celsiusToFahrenheit(double celsius) {
        return celsius * 9 / 5 + 32;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        double result = TemperatureConverter.celsiusToFahrenheit(25);
        System.out.println(result);
    }
}
```

No necesitas crear ninguna clase que implemente la interfaz para usar ese método estático.

---

## 13. Interfaces que extienden otras interfaces

Una interfaz también puede heredar de otra interfaz usando `extends`.

Ejemplo:

```java
public interface Printable {
    void print();
}
```

```java
public interface AdvancedPrintable extends Printable {
    void preview();
}
```

Cualquier clase que implemente `AdvancedPrintable` deberá implementar:

- `print()`
- `preview()`

Ejemplo:

```java
public class Report implements AdvancedPrintable {
    @Override
    public void print() {
        System.out.println("Printing report...");
    }

    @Override
    public void preview() {
        System.out.println("Previewing report...");
    }
}
```

---

## 14. Ejemplo completo: sistema de pagos con interfaz

Este es un ejemplo muy realista.

Queremos que distintos métodos de pago compartan un mismo contrato.

### 14.1. Interfaz `Payable`

```java
public interface Payable {
    double calculatePayment();
    void processPayment();
}
```

### 14.2. `CardPayment`

```java
public class CardPayment implements Payable {
    private double amount;

    public CardPayment(double amount) {
        this.amount = amount;
    }

    @Override
    public double calculatePayment() {
        return amount;
    }

    @Override
    public void processPayment() {
        System.out.println("Processing card payment: " + amount);
    }
}
```

### 14.3. `PaypalPayment`

```java
public class PaypalPayment implements Payable {
    private double amount;
    private double fee;

    public PaypalPayment(double amount, double fee) {
        this.amount = amount;
        this.fee = fee;
    }

    @Override
    public double calculatePayment() {
        return amount + fee;
    }

    @Override
    public void processPayment() {
        System.out.println("Processing PayPal payment: " + calculatePayment());
    }
}
```

### 14.4. Uso

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Payable> payments = new ArrayList<>();

        payments.add(new CardPayment(49.99));
        payments.add(new PaypalPayment(49.99, 1.50));

        for (Payable payment : payments) {
            System.out.println("Total: " + payment.calculatePayment());
            payment.processPayment();
        }
    }
}
```

Lo importante aquí no es la clase concreta, sino que todas cumplen `Payable`.

---

## 15. Ejemplo completo: `Comparable` como interfaz real de Java

Una de las interfaces más famosas de Java es `Comparable<T>`.

Sirve para indicar que los objetos de una clase pueden compararse entre sí.

Ejemplo simple:

```java
public class Product implements Comparable<Product> {
    private String name;
    private double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    @Override
    public int compareTo(Product other) {
        return Double.compare(this.price, other.price);
    }

    @Override
    public String toString() {
        return "Product{name='" + name + "', price=" + price + "}";
    }
}
```

Uso:

```java
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Product> products = new ArrayList<>();
        products.add(new Product("Mouse", 19.99));
        products.add(new Product("Keyboard", 49.99));
        products.add(new Product("USB Cable", 5.99));

        Collections.sort(products);

        System.out.println(products);
    }
}
```

Esto demuestra que las interfaces están por todas partes en Java real.

---

## 16. Errores típicos al empezar

### 16.1. Pensar que una interfaz es una clase normal

No puedes hacer:

```java
// Printable p = new Printable(); // error
```

### 16.2. Olvidar implementar todos los métodos

Si una clase implementa una interfaz, debe implementar todos sus métodos abstractos, o entonces la clase también debe ser abstracta.

### 16.3. Usar interfaz cuando en realidad necesitas una clase base con estado común

Si muchas clases comparten atributos y mucha lógica, quizá una clase abstracta sea mejor opción.

### 16.4. Confundir `extends` e `implements`

- clase + interfaz → `implements`
- interfaz + interfaz → `extends`

---

## 17. Buenas prácticas

- Usa interfaces para definir contratos claros.
- Nombra las interfaces según la capacidad o responsabilidad (`Printable`, `Payable`, `Sortable`).
- Programa contra la interfaz cuando tenga sentido:

```java
List<Printable> items = new ArrayList<>();
```

en lugar de trabajar siempre con clases concretas.

- Usa métodos `default` con moderación: ayudan, pero no deberían convertir la interfaz en una “clase disfrazada”.
- Si varias clases comparten mucho estado, valora si una clase abstracta encaja mejor.

---

## 18. Interfaces y diseño limpio

Las interfaces favorecen un diseño más flexible porque desacoplan:

- el **qué** se hace
- del **cómo** se hace

Por ejemplo, si tienes un método que recibe `Payable`, no le importa si el pago viene de:

- tarjeta
- PayPal
- transferencia
- otro método futuro

Solo necesita que cumpla el contrato.

Ejemplo:

```java
public static void executePayment(Payable payment) {
    payment.processPayment();
}
```

Este estilo hace el código más mantenible y extensible.

---

## 19. A tener en cuenta

- Una interfaz define un contrato.
- Una clase la implementa con `implements`.
- Las interfaces permiten polimorfismo.
- Una clase puede implementar varias interfaces.
- Una interfaz puede tener métodos abstractos, `default`, `static` y constantes.
- Una interfaz no sustituye siempre a una clase abstracta: ambas herramientas tienen propósitos distintos.
- En Java real, las interfaces se usan constantemente.

---

## 20. Resumen final

- **Clase abstracta**: buena para compartir base común y estado.
- **Interfaz**: buena para definir capacidades y contratos.
- **`implements`**: se usa para implementar interfaces.
- **Polimorfismo**: puedes trabajar con referencias de la interfaz.
- **Múltiples interfaces**: una clase puede tener varias capacidades.
- **`default` y `static`**: amplían lo que una interfaz puede ofrecer.
- **Diseño flexible**: las interfaces ayudan a escribir código más reutilizable y limpio.

---

En el siguiente tema seguiremos avanzando en Java con nuevas herramientas del lenguaje y veremos como comparar objetos correctamente con `equals`.
