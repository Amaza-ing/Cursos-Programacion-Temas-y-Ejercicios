# Ejercicios - Tema 14: Clases y Objetos

A continuación encontrarás **10 ejercicios prácticos** sobre **Clases y Objetos**: definición de clases, atributos, métodos, constructores, uso de `this`, getters y setters.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear una clase simple

Crea una clase `Book` con:

- `title` (String)
- `pages` (int)

Crea un constructor que reciba ambos valores y un método `printInfo()` que muestre:

```
Title: X | Pages: Y
```

En `main`, crea un objeto y llama a `printInfo()`.

<details><summary>Mostrar solución</summary>

```java
public class Book {
    private String title;
    private int pages;

    public Book(String title, int pages) {
        this.title = title;
        this.pages = pages;
    }

    public void printInfo() {
        System.out.println("Title: " + title + " | Pages: " + pages);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Book book = new Book("Java Basics", 250);
        book.printInfo();
    }
}
```

</details>

---

## Ejercicio 2: Usar `this` correctamente

Crea una clase `Car` con:

- `brand`
- `year`

En el constructor, usa `this` para diferenciar atributos y parámetros.

Crea un método `printInfo()`.

<details><summary>Mostrar solución</summary>

```java
public class Car {
    private String brand;
    private int year;

    public Car(String brand, int year) {
        this.brand = brand;
        this.year = year;
    }

    public void printInfo() {
        System.out.println("Brand: " + brand + " | Year: " + year);
    }
}
```

</details>

---

## Ejercicio 3: Getters y setters

Crea una clase `Student` con:

- `name`
- `grade`

Haz los atributos `private` y crea:

- Constructor
- Getter para ambos
- Setter para `grade` que valide que esté entre 0 y 10

<details><summary>Mostrar solución</summary>

```java
public class Student {
    private String name;
    private double grade;

    public Student(String name, double grade) {
        this.name = name;
        setGrade(grade);
    }

    public String getName() {
        return name;
    }

    public double getGrade() {
        return grade;
    }

    public void setGrade(double grade) {
        if (grade < 0 || grade > 10) {
            this.grade = 0;
        } else {
            this.grade = grade;
        }
    }
}
```

</details>

---

## Ejercicio 4: Método que modifica estado

Crea una clase `BankAccount` con:

- `balance`

Incluye:

- Constructor que inicialice el saldo
- Método `deposit(double amount)`
- Método `withdraw(double amount)` (no permitir saldo negativo)

<details><summary>Mostrar solución</summary>

```java
public class BankAccount {
    private double balance;

    public BankAccount(double balance) {
        this.balance = balance;
    }

    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }

    public boolean withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            return true;
        }
        return false;
    }

    public double getBalance() {
        return balance;
    }
}
```

</details>

---

## Ejercicio 5: Constructor con valores por defecto

Crea una clase `User` con:

- `username`
- `active`

El constructor debe recibir solo `username` y establecer `active = true` por defecto.

<details><summary>Mostrar solución</summary>

```java
public class User {
    private String username;
    private boolean active;

    public User(String username) {
        this.username = username;
        this.active = true;
    }

    public boolean isActive() {
        return active;
    }
}
```

</details>

---

## Ejercicio 6: Método que devuelve información formateada

Crea una clase `Product` con:

- `name`
- `price`

Añade un método `getFormattedPrice()` que devuelva:

```
Product: X | Price: Y
```

<details><summary>Mostrar solución</summary>

```java
public class Product {
    private String name;
    private double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public String getFormattedPrice() {
        return "Product: " + name + " | Price: " + price;
    }
}
```

</details>

---

## Ejercicio 7: Crear varios objetos

Crea una clase `Rectangle` con:

- `width`
- `height`

Incluye método `area()`.

En `main`, crea 3 objetos distintos y muestra sus áreas.

<details><summary>Mostrar solución</summary>

```java
public class Rectangle {
    private double width;
    private double height;

    public Rectangle(double width, double height) {
        this.width = width;
        this.height = height;
    }

    public double area() {
        return width * height;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Rectangle r1 = new Rectangle(2, 3);
        Rectangle r2 = new Rectangle(4, 5);
        Rectangle r3 = new Rectangle(6, 7);

        System.out.println(r1.area());
        System.out.println(r2.area());
        System.out.println(r3.area());
    }
}
```

</details>

---

## Ejercicio 8: Método que cambia un atributo boolean

Crea una clase `Light` con:

- `isOn` (boolean)

Incluye:

- Método `turnOn()`
- Método `turnOff()`
- Método `toggle()`

<details><summary>Mostrar solución</summary>

```java
public class Light {
    private boolean isOn;

    public void turnOn() {
        isOn = true;
    }

    public void turnOff() {
        isOn = false;
    }

    public void toggle() {
        isOn = !isOn;
    }

    public boolean isOn() {
        return isOn;
    }
}
```

</details>

---

## Ejercicio 9: Método que usa atributos para calcular resultado

Crea una clase `Circle` con:

- `radius`

Incluye método `area()` usando `Math.PI`.

<details><summary>Mostrar solución</summary>

```java
public class Circle {
    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    public double area() {
        return Math.PI * radius * radius;
    }
}
```

</details>

---

## Ejercicio 10: Clase con método que usa otro método

Crea una clase `Employee` con:

- `name`
- `salary`

Incluye:

- Método `increaseSalary(double percentage)`
- Método `getAnnualSalary()`

`increaseSalary` debe aumentar el salario según el porcentaje recibido.

<details><summary>Mostrar solución</summary>

```java
public class Employee {
    private String name;
    private double salary;

    public Employee(String name, double salary) {
        this.name = name;
        this.salary = salary;
    }

    public void increaseSalary(double percentage) {
        if (percentage > 0) {
            salary += salary * (percentage / 100);
        }
    }

    public double getAnnualSalary() {
        return salary * 12;
    }
}
```

</details>

---
