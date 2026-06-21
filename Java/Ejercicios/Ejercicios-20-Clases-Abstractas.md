# Ejercicios - Tema 20: Clases abstractas y métodos abstractos

A continuación encontrarás **10 ejercicios prácticos** sobre **clases abstractas** y **métodos abstractos**: declaración `abstract`, métodos sin cuerpo, implementación obligatoria en subclases, constructores en clases abstractas, `@Override`, polimorfismo con listas, y una primera comparación con clases “normales”.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: `Shape` abstracta con `area()`

Crea una clase abstracta `Shape` con un método abstracto:

```java
public abstract double area();
```

Crea una clase `Square extends Shape` con atributo `side` y que implemente `area()`.

En `main`, crea un `Shape` que sea un `Square` y muestra el área.

<details><summary>Mostrar solución</summary>

```java
public abstract class Shape {
    public abstract double area();
}
```

```java
public class Square extends Shape {
    private double side;

    public Square(double side) {
        this.side = side;
    }

    @Override
    public double area() {
        return side * side;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Shape shape = new Square(4);
        System.out.println(shape.area());
    }
}
```

</details>

---

## Ejercicio 2: Clase abstracta con constructor

Crea una clase abstracta `Animal` con:

- `private String name`
- Constructor `Animal(String name)`
- Getter `getName()`
- Método abstracto `sound()`

Crea `Dog extends Animal` e implementa `sound()` para imprimir `Woof`.

En `main`, crea un `Dog` y muestra el nombre y el sonido.

<details><summary>Mostrar solución</summary>

```java
public abstract class Animal {
    private String name;

    public Animal(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public abstract void sound();
}
```

```java
public class Dog extends Animal {
    public Dog(String name) {
        super(name);
    }

    @Override
    public void sound() {
        System.out.println("Woof");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Dog dog = new Dog("Rex");
        System.out.println(dog.getName());
        dog.sound();
    }
}
```

</details>

---

## Ejercicio 3: Método normal que llama a uno abstracto

Crea una clase abstracta `Employee` con:

- `private String name`
- Constructor
- Método normal `printPayslip()` que imprima:
  - `Employee: name | Pay: X`
- Método abstracto `calculatePay()`

Crea `HourlyEmployee` con `hourlyRate` y `hoursWorked` e implementa `calculatePay()`.

En `main`, crea un `HourlyEmployee` y llama a `printPayslip()`.

<details><summary>Mostrar solución</summary>

```java
public abstract class Employee {
    private String name;

    public Employee(String name) {
        this.name = name;
    }

    public void printPayslip() {
        System.out.println("Employee: " + name + " | Pay: " + calculatePay());
    }

    public abstract double calculatePay();
}
```

```java
public class HourlyEmployee extends Employee {
    private double hourlyRate;
    private int hoursWorked;

    public HourlyEmployee(String name, double hourlyRate, int hoursWorked) {
        super(name);
        this.hourlyRate = hourlyRate;
        this.hoursWorked = hoursWorked;
    }

    @Override
    public double calculatePay() {
        return hourlyRate * hoursWorked;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Employee employee = new HourlyEmployee("Laura", 15, 120);
        employee.printPayslip();
    }
}
```

</details>

---

## Ejercicio 4: Subclase que no implementa un abstracto

Crea una clase abstracta `Device` con método abstracto `start()`.

Crea una clase `SmartDevice extends Device` que NO implemente `start()`.

¿Qué debe pasar con `SmartDevice`?  
Haz que compile.

<details><summary>Mostrar solución</summary>

```java
public abstract class Device {
    public abstract void start();
}
```

```java
public abstract class SmartDevice extends Device {
    // no implementa start() => debe ser abstracta también
}
```

</details>

---

## Ejercicio 5: Polimorfismo con `List<Shape>`

Crea una clase abstracta `Shape` con `area()`.

Crea dos clases concretas:

- `Circle` con `radius`
- `Rectangle` con `width` y `height`

En `main`, crea una lista `List<Shape>` con 3 formas (mezcla de Circle/Rectangle) y suma todas las áreas.

<details><summary>Mostrar solución</summary>

```java
public abstract class Shape {
    public abstract double area();
}
```

```java
public class Circle extends Shape {
    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    @Override
    public double area() {
        return Math.PI * radius * radius;
    }
}
```

```java
public class Rectangle extends Shape {
    private double width;
    private double height;

    public Rectangle(double width, double height) {
        this.width = width;
        this.height = height;
    }

    @Override
    public double area() {
        return width * height;
    }
}
```

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Shape> shapes = new ArrayList<>();
        shapes.add(new Circle(2));
        shapes.add(new Rectangle(3, 4));
        shapes.add(new Circle(1.5));

        double total = 0;

        for (Shape shape : shapes) {
            total += shape.area();
        }

        System.out.println(total);
    }
}
```

</details>

---

## Ejercicio 6: Clase abstracta con estado común y validación

Crea una clase abstracta `Document` con:

- `private String title`
- Constructor `Document(String title)` que use un setter `setTitle`
- `getTitle()`
- `setTitle(String title)` que si es `null` o `isBlank()` use `"Untitled"`
- Método abstracto `printContent()`

Crea `Note extends Document` con atributo `text` y que imprima el contenido.

<details><summary>Mostrar solución</summary>

```java
public abstract class Document {
    private String title;

    public Document(String title) {
        setTitle(title);
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        if (title == null || title.isBlank()) {
            this.title = "Untitled";
            return;
        }

        this.title = title;
    }

    public abstract void printContent();
}
```

```java
public class Note extends Document {
    private String text;

    public Note(String title, String text) {
        super(title);
        this.text = text;
    }

    @Override
    public void printContent() {
        System.out.println("Title: " + getTitle());
        System.out.println(text);
    }
}
```

</details>

---

## Ejercicio 7: Método abstracto con retorno boolean

Crea una clase abstracta `Validator` con método abstracto:

```java
public abstract boolean isValid(String value);
```

Crea:

- `EmailValidator` que devuelva `true` si `value` contiene `"@"` y `"."`
- `MinLengthValidator` que reciba `minLength` en el constructor y valide por longitud

En `main`, prueba ambos validadores.

<details><summary>Mostrar solución</summary>

```java
public abstract class Validator {
    public abstract boolean isValid(String value);
}
```

```java
public class EmailValidator extends Validator {
    @Override
    public boolean isValid(String value) {
        if (value == null) {
            return false;
        }

        return value.contains("@") && value.contains(".");
    }
}
```

```java
public class MinLengthValidator extends Validator {
    private int minLength;

    public MinLengthValidator(int minLength) {
        this.minLength = minLength;
    }

    @Override
    public boolean isValid(String value) {
        if (value == null) {
            return false;
        }

        return value.length() >= minLength;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Validator v1 = new EmailValidator();
        Validator v2 = new MinLengthValidator(5);

        System.out.println(v1.isValid("laura@example.com"));
        System.out.println(v1.isValid("invalid"));

        System.out.println(v2.isValid("Java"));
        System.out.println(v2.isValid("ArrayList"));
    }
}
```

</details>

---

## Ejercicio 8: Clase abstracta con método “plantilla”

Crea una clase abstracta `Report` con método normal:

```java
public void printReport()
```

Que:

1. Imprima `"=== Report ==="`
2. Llame a un método abstracto `printBody()`
3. Imprima `"=== End ==="`

Crea `SalesReport` que implemente `printBody()`.

<details><summary>Mostrar solución</summary>

```java
public abstract class Report {
    public void printReport() {
        System.out.println("=== Report ===");
        printBody();
        System.out.println("=== End ===");
    }

    public abstract void printBody();
}
```

```java
public class SalesReport extends Report {
    @Override
    public void printBody() {
        System.out.println("Total sales: 1200");
        System.out.println("Top product: Book");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Report report = new SalesReport();
        report.printReport();
    }
}
```

</details>

---

## Ejercicio 9: Comparar clase abstracta vs clase “normal”

Crea una clase `Printer` (normal) con método `print()` que imprima `"Printing..."`.

Luego crea una clase abstracta `AbstractPrinter` con método abstracto `print()`.

Crea una clase `ConsolePrinter extends AbstractPrinter` que implemente `print()`.

En `main`, usa `Printer` y `AbstractPrinter` (con `ConsolePrinter`).

<details><summary>Mostrar solución</summary>

```java
public class Printer {
    public void print() {
        System.out.println("Printing...");
    }
}
```

```java
public abstract class AbstractPrinter {
    public abstract void print();
}
```

```java
public class ConsolePrinter extends AbstractPrinter {
    @Override
    public void print() {
        System.out.println("Printing...");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Printer p = new Printer();
        p.print();

        AbstractPrinter ap = new ConsolePrinter();
        ap.print();
    }
}
```

</details>

---

## Ejercicio 10: Jerarquía abstracta con validación en el constructor

Crea una clase abstracta `Payment` con:

- `private double amount`
- Constructor `Payment(double amount)` que use `setAmount`
- `getAmount()`
- `setAmount(double amount)` que si es negativo use `0.0`
- Método abstracto `process()`

Crea:

- `CardPayment extends Payment` con atributo `cardNumber` y `process()` imprimiendo:
  - `Processing card payment: amount`
- `CashPayment extends Payment` con `process()` imprimiendo:
  - `Processing cash payment: amount`

En `main`, crea ambos pagos y llama a `process()` con referencias de tipo `Payment`.

<details><summary>Mostrar solución</summary>

```java
public abstract class Payment {
    private double amount;

    public Payment(double amount) {
        setAmount(amount);
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        if (amount < 0) {
            this.amount = 0.0;
            return;
        }

        this.amount = amount;
    }

    public abstract void process();
}
```

```java
public class CardPayment extends Payment {
    private String cardNumber;

    public CardPayment(double amount, String cardNumber) {
        super(amount);
        this.cardNumber = cardNumber;
    }

    @Override
    public void process() {
        System.out.println("Processing card payment: " + getAmount());
    }
}
```

```java
public class CashPayment extends Payment {
    public CashPayment(double amount) {
        super(amount);
    }

    @Override
    public void process() {
        System.out.println("Processing cash payment: " + getAmount());
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Payment p1 = new CardPayment(49.99, "1234-0000-9999-8888");
        Payment p2 = new CashPayment(10);

        p1.process();
        p2.process();
    }
}
```

</details>

---
