# Ejercicios - Tema 18: Herencia y Polimorfismo

A continuación encontrarás **10 ejercicios prácticos** sobre **herencia** y **polimorfismo**: `extends`, `super(...)`, sobrescritura con `@Override`, uso de referencias del padre para instancias del hijo, listas polimórficas, y un primer contacto con `instanceof`.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: `Person` y `Student`

Crea una clase `Person` con:

- `private String name`
- Constructor `Person(String name)`
- Método `printInfo()` que muestre `Name: ...`

Crea una clase `Student extends Person` con:

- `private String studentId`
- Constructor `Student(String name, String studentId)` que llame a `super(name)`
- Método `printStudentId()`

En `main`, crea un `Student` y llama a ambos métodos.

<details><summary>Mostrar solución</summary>

```java
public class Person {
    private String name;

    public Person(String name) {
        this.name = name;
    }

    public void printInfo() {
        System.out.println("Name: " + name);
    }
}
```

```java
public class Student extends Person {
    private String studentId;

    public Student(String name, String studentId) {
        super(name);
        this.studentId = studentId;
    }

    public void printStudentId() {
        System.out.println("StudentId: " + studentId);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Student student = new Student("Laura", "S-100");
        student.printInfo();
        student.printStudentId();
    }
}
```

</details>

---

## Ejercicio 2: Sobrescribir `printInfo()` con `@Override`

Partiendo del ejercicio anterior, sobrescribe `printInfo()` en `Student` para que muestre:

```
Name: ... | StudentId: ...
```

Reutiliza el `printInfo()` del padre con `super.printInfo()` o imprime todo tú (elige una opción).

<details><summary>Mostrar solución</summary>

```java
public class Student extends Person {
    private String studentId;

    public Student(String name, String studentId) {
        super(name);
        this.studentId = studentId;
    }

    @Override
    public void printInfo() {
        super.printInfo();
        System.out.println("StudentId: " + studentId);
    }
}
```

</details>

---

## Ejercicio 3: `Vehicle`, `Car` y `Bike`

Crea una clase `Vehicle` con un método `move()` que imprima:

```
Moving...
```

Crea:

- `Car extends Vehicle` → sobrescribe `move()` para imprimir `Driving...`
- `Bike extends Vehicle` → sobrescribe `move()` para imprimir `Cycling...`

En `main`, crea un `Vehicle` que sea un `Car` y otro que sea una `Bike` y llama a `move()`.

<details><summary>Mostrar solución</summary>

```java
public class Vehicle {
    public void move() {
        System.out.println("Moving...");
    }
}
```

```java
public class Car extends Vehicle {
    @Override
    public void move() {
        System.out.println("Driving...");
    }
}
```

```java
public class Bike extends Vehicle {
    @Override
    public void move() {
        System.out.println("Cycling...");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Vehicle v1 = new Car();
        Vehicle v2 = new Bike();

        v1.move();
        v2.move();
    }
}
```

</details>

---

## Ejercicio 4: Lista polimórfica de vehículos

Usando las clases del ejercicio anterior, crea una lista `List<Vehicle>` y añade:

- 2 coches
- 1 bici

Recorre la lista y llama a `move()` en cada elemento.

<details><summary>Mostrar solución</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Vehicle> vehicles = new ArrayList<>();

        vehicles.add(new Car());
        vehicles.add(new Car());
        vehicles.add(new Bike());

        for (Vehicle vehicle : vehicles) {
            vehicle.move();
        }
    }
}
```

</details>

---

## Ejercicio 5: `Animal` con método sobrescrito

Crea una clase `Animal` con método `sound()` que imprima:

```
Animal sound...
```

Crea:

- `Dog extends Animal` → `sound()` imprime `Woof`
- `Cat extends Animal` → `sound()` imprime `Meow`

En `main`, guarda un `Dog` y un `Cat` en variables de tipo `Animal` y llama a `sound()`.

<details><summary>Mostrar solución</summary>

```java
public class Animal {
    public void sound() {
        System.out.println("Animal sound...");
    }
}
```

```java
public class Dog extends Animal {
    @Override
    public void sound() {
        System.out.println("Woof");
    }
}
```

```java
public class Cat extends Animal {
    @Override
    public void sound() {
        System.out.println("Meow");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Animal a1 = new Dog();
        Animal a2 = new Cat();

        a1.sound();
        a2.sound();
    }
}
```

</details>

---

## Ejercicio 6: Acceso a métodos exclusivos del hijo

Crea una clase `Employee` con método `work()` que imprima:

```
Working...
```

Crea una clase `Manager extends Employee` con método adicional `approveVacation()`.

En `main`:

1. Crea un `Employee` que sea un `Manager` (referencia del padre)
2. Llama a `work()`
3. Para llamar a `approveVacation()`, haz un _cast_ a `Manager`

<details><summary>Mostrar solución</summary>

```java
public class Employee {
    public void work() {
        System.out.println("Working...");
    }
}
```

```java
public class Manager extends Employee {
    public void approveVacation() {
        System.out.println("Vacation approved");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Employee employee = new Manager();
        employee.work();

        Manager manager = (Manager) employee;
        manager.approveVacation();
    }
}
```

</details>

---

## Ejercicio 7: `instanceof` para evitar un cast inseguro

Usa las clases del ejercicio 6.

En `main`, crea:

- `Employee e1 = new Employee();`
- `Employee e2 = new Manager();`

Escribe un método estático:

```java
public static void tryApprove(Employee employee)
```

Que:

- Si `employee` es `Manager`, llame a `approveVacation()`
- Si no, imprima `Not a manager`

<details><summary>Mostrar solución</summary>

```java
public class Employee {
    public void work() {
        System.out.println("Working...");
    }
}
```

```java
public class Manager extends Employee {
    public void approveVacation() {
        System.out.println("Vacation approved");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Employee e1 = new Employee();
        Employee e2 = new Manager();

        tryApprove(e1);
        tryApprove(e2);
    }

    public static void tryApprove(Employee employee) {
        if (employee instanceof Manager) {
            Manager manager = (Manager) employee;
            manager.approveVacation();
        } else {
            System.out.println("Not a manager");
        }
    }
}
```

</details>

---

## Ejercicio 8: Sobrescritura y llamada a `super.method()`

Crea una clase `BaseLogger` con un método `log(String message)` que imprima:

```
LOG: message
```

Crea una clase `FileLogger extends BaseLogger` que sobrescriba `log` para imprimir primero:

```
Saving to file...
```

Y luego llame a `super.log(message)`.

<details><summary>Mostrar solución</summary>

```java
public class BaseLogger {
    public void log(String message) {
        System.out.println("LOG: " + message);
    }
}
```

```java
public class FileLogger extends BaseLogger {
    @Override
    public void log(String message) {
        System.out.println("Saving to file...");
        super.log(message);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        BaseLogger logger = new FileLogger();
        logger.log("Hello");
    }
}
```

</details>

---

## Ejercicio 9: Jerarquía con constructor del padre

Crea una clase `Account` con:

- `private String id`
- Constructor `Account(String id)`
- Método `printInfo()` que imprima `Account id: ...`

Crea `PremiumAccount extends Account` con:

- `private int points`
- Constructor `PremiumAccount(String id, int points)` que llame a `super(id)`

Sobrescribe `printInfo()` para incluir también los puntos.

<details><summary>Mostrar solución</summary>

```java
public class Account {
    private String id;

    public Account(String id) {
        this.id = id;
    }

    public void printInfo() {
        System.out.println("Account id: " + id);
    }
}
```

```java
public class PremiumAccount extends Account {
    private int points;

    public PremiumAccount(String id, int points) {
        super(id);
        this.points = points;
    }

    @Override
    public void printInfo() {
        super.printInfo();
        System.out.println("Points: " + points);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Account a = new PremiumAccount("A-10", 120);
        a.printInfo();
    }
}
```

</details>

---

## Ejercicio 10: Polimorfismo con cálculo en un método sobrescrito

Crea una clase `Discount` con método:

```java
public double apply(double price)
```

Por defecto, devuelve el mismo `price` (sin descuento).

Crea:

- `PercentageDiscount extends Discount` con atributo `percent` y `apply` que reste el porcentaje.
- `FixedDiscount extends Discount` con atributo `amount` y `apply` que reste una cantidad fija (sin bajar de 0).

En `main`, crea una lista `List<Discount>` con:

- un descuento porcentual del 10%
- un descuento fijo de 5

Aplica ambos a `price = 50` y muestra el resultado de cada uno.

<details><summary>Mostrar solución</summary>

```java
public class Discount {
    public double apply(double price) {
        return price;
    }
}
```

```java
public class PercentageDiscount extends Discount {
    private double percent;

    public PercentageDiscount(double percent) {
        this.percent = percent;
    }

    @Override
    public double apply(double price) {
        return price - price * (percent / 100.0);
    }
}
```

```java
public class FixedDiscount extends Discount {
    private double amount;

    public FixedDiscount(double amount) {
        this.amount = amount;
    }

    @Override
    public double apply(double price) {
        return Math.max(0.0, price - amount);
    }
}
```

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Discount> discounts = new ArrayList<>();
        discounts.add(new PercentageDiscount(10));
        discounts.add(new FixedDiscount(5));

        double price = 50;

        for (Discount discount : discounts) {
            System.out.println(discount.apply(price));
        }
    }
}
```

</details>

---
