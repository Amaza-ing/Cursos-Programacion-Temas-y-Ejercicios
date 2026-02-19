# Tema 20. Clases abstractas y métodos abstractos

## 1. Introducción

En el tema de herencia aprendiste que puedes crear jerarquías como:

- `Person` → `Student`
- `Employee` → `Manager`

Eso te permite reutilizar código y crear clases hijas especializadas.

Ahora aparece una necesidad muy común:

> ¿Qué pasa si quiero una clase “base” que **no debería poder instanciarse**, pero que quiero usar como plantilla para sus hijas?

Ejemplos típicos:

- `Shape` (forma) → `Circle`, `Rectangle`
- `Animal` → `Dog`, `Cat`
- `PaymentMethod` → `CardPayment`, `PaypalPayment`

En estos casos, la clase base es una idea general, pero:

- No tiene sentido crear un objeto `Shape` “genérico”
- No tiene sentido crear un objeto `Animal` “sin tipo”

Para eso existen:

- **Clases abstractas**
- **Métodos abstractos**

En este tema aprenderás:

- Qué es una clase abstracta
- Qué es un método abstracto
- Cuándo usarlos y por qué son útiles
- Cómo combinar código común + comportamiento obligatorio
- `abstract` vs herencia normal
- Polimorfismo con clases abstractas
- Errores típicos y buenas prácticas

---

## 2. Qué es una clase abstracta

Una **clase abstracta** es una clase que:

- No se puede instanciar (`new`)
- Se usa como base para otras clases

Se declara con `abstract`:

```java
public abstract class Shape {
}
```

Esto NO compila:

```java
// Shape shape = new Shape(); // error
```

Pero sí puedes hacer:

```java
Shape shape = new Circle(3.0);
```

Porque `Circle` es una subclase concreta.

---

## 3. Qué es un método abstracto

Un **método abstracto** es un método que:

- Se declara en la clase abstracta
- No tiene cuerpo (`{}`)
- Obliga a las clases hijas a implementarlo

Ejemplo:

```java
public abstract class Shape {
    public abstract double area();
}
```

Ese método se tiene que implementar en cada clase hija:

```java
public class Circle extends Shape {
    @Override
    public double area() {
        return Math.PI * radius * radius;
    }
}
```

---

## 4. ¿Para qué sirve todo esto?

Las clases abstractas sirven para:

1. Definir un **contrato parcial** (qué deben hacer las hijas)
2. Reutilizar **código común** en la clase base
3. Forzar que cada subclase implemente lo que es específico

En resumen:

- Código común en el padre
- Implementación específica en el hijo

---

## 5. Reglas importantes

### 5.1. Una clase abstracta puede tener:

- Atributos
- Métodos normales (con cuerpo)
- Métodos abstractos (sin cuerpo)
- Constructores (sí, también)

### 5.2. Un método abstracto:

- No puede ser `private` (porque la subclase debe sobrescribirlo)
- Debe implementarse en la subclase, o la subclase también será abstracta

### 5.3. Una clase abstracta:

- Puede extender otra clase abstracta o concreta
- Puede tener métodos `static` (pero esos no se heredan como abstractos)

---

## 6. Ejemplo 1: `Shape`, `Circle` y `Rectangle`

Este es el ejemplo clásico y el más claro para entender el concepto.

### 6.1. `Shape.java` (abstracta)

```java
public abstract class Shape {
    private String color;

    public Shape(String color) {
        setColor(color);
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        if (color == null || color.isBlank()) {
            this.color = "Unknown";
            return;
        }

        this.color = color;
    }

    public void printInfo() {
        System.out.println("Color: " + color + " | Area: " + area());
    }

    public abstract double area();
}
```

Observa:

- `Shape` tiene atributo `color` y métodos normales (`getColor`, `setColor`, `printInfo`)
- `area()` es abstracto: cada forma calcula el área de manera distinta
- `printInfo` usa `area()` sin saber cuál será la forma concreta → esto es polimorfismo

### 6.2. `Circle.java` (concreta)

```java
public class Circle extends Shape {
    private double radius;

    public Circle(String color, double radius) {
        super(color);
        setRadius(radius);
    }

    public double getRadius() {
        return radius;
    }

    public void setRadius(double radius) {
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

### 6.3. `Rectangle.java` (concreta)

```java
public class Rectangle extends Shape {
    private double width;
    private double height;

    public Rectangle(String color, double width, double height) {
        super(color);
        setWidth(width);
        setHeight(height);
    }

    public void setWidth(double width) {
        if (width <= 0) {
            this.width = 1.0;
            return;
        }

        this.width = width;
    }

    public void setHeight(double height) {
        if (height <= 0) {
            this.height = 1.0;
            return;
        }

        this.height = height;
    }

    @Override
    public double area() {
        return width * height;
    }
}
```

### 6.4. `Main.java` (polimorfismo)

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Shape> shapes = new ArrayList<>();

        shapes.add(new Circle("Blue", 3.0));
        shapes.add(new Rectangle("Green", 4.0, 2.0));
        shapes.add(new Circle("Orange", 1.5));

        for (Shape shape : shapes) {
            shape.printInfo();
        }
    }
}
```

Aquí pasa algo muy importante:

- La lista es de `Shape`
- Pero dentro guardas `Circle` y `Rectangle`
- Cuando llamas a `shape.area()` se ejecuta la versión correcta según el objeto real

---

## 7. Constructores en clases abstractas

Aunque no puedas instanciar una abstracta directamente, **sí puede tener constructor**.

¿Para qué?

- Para inicializar la parte común del objeto que pertenece a la clase base

Ejemplo: en `Shape`, el constructor inicializa `color` y se llama desde `Circle` y `Rectangle` con `super(color)`.

---

## 8. Métodos abstractos vs métodos “normales” en el padre

Un patrón muy común es:

- El padre define un método normal que llama a uno abstracto

Ejemplo: `printInfo()` en `Shape` llama a `area()`.

Esto permite:

- Código común en el padre
- Personalización obligatoria en el hijo

---

## 9. Ejemplo 2: plantilla de “empleado” con cálculo de salario

Vamos a usar un ejemplo más cercano a un caso real.

Objetivo:

- `Employee` es una idea general, no tiene sentido crear un `Employee` sin tipo
- Cada tipo de empleado calcula su pago de forma distinta

### 9.1. `Employee.java` (abstracta)

```java
public abstract class Employee {
    private String name;

    public Employee(String name) {
        setName(name);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        if (name == null || name.isBlank()) {
            this.name = "Unknown";
            return;
        }

        this.name = name;
    }

    public void printPayslip() {
        System.out.println("Employee: " + name + " | Pay: " + calculatePay());
    }

    public abstract double calculatePay();
}
```

### 9.2. `SalariedEmployee.java` (salario fijo)

```java
public class SalariedEmployee extends Employee {
    private double monthlySalary;

    public SalariedEmployee(String name, double monthlySalary) {
        super(name);
        setMonthlySalary(monthlySalary);
    }

    public void setMonthlySalary(double monthlySalary) {
        if (monthlySalary < 0) {
            this.monthlySalary = 0.0;
            return;
        }

        this.monthlySalary = monthlySalary;
    }

    @Override
    public double calculatePay() {
        return monthlySalary;
    }
}
```

### 9.3. `HourlyEmployee.java` (pago por horas)

```java
public class HourlyEmployee extends Employee {
    private double hourlyRate;
    private int hoursWorked;

    public HourlyEmployee(String name, double hourlyRate, int hoursWorked) {
        super(name);
        setHourlyRate(hourlyRate);
        setHoursWorked(hoursWorked);
    }

    public void setHourlyRate(double hourlyRate) {
        if (hourlyRate < 0) {
            this.hourlyRate = 0.0;
            return;
        }

        this.hourlyRate = hourlyRate;
    }

    public void setHoursWorked(int hoursWorked) {
        if (hoursWorked < 0) {
            this.hoursWorked = 0;
            return;
        }

        this.hoursWorked = hoursWorked;
    }

    @Override
    public double calculatePay() {
        return hourlyRate * hoursWorked;
    }
}
```

### 9.4. `Main.java`

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Employee> employees = new ArrayList<>();

        employees.add(new SalariedEmployee("Laura", 2200));
        employees.add(new HourlyEmployee("Alex", 15, 120));
        employees.add(new HourlyEmployee("Maria", 18, 90));

        for (Employee employee : employees) {
            employee.printPayslip();
        }
    }
}
```

---

## 10. ¿Qué pasa si una subclase NO implementa un método abstracto?

Si una subclase no implementa todos los métodos abstractos del padre, entonces:

- La subclase debe ser `abstract` también

Ejemplo:

```java
public abstract class SpecialShape extends Shape {
    public SpecialShape(String color) {
        super(color);
    }

    // no implementa area() => debe ser abstract
}
```

---

## 11. Errores típicos al empezar

### 11.1. Intentar instanciar una clase abstracta

```java
// Employee e = new Employee("Laura"); // error
```

### 11.2. Olvidar `@Override`

No es obligatorio, pero te ayuda a detectar errores si te equivocas con la firma.

### 11.3. Declarar métodos abstractos como `private`

No se puede, porque una subclase no puede sobrescribir algo privado.

---

## 12. Buenas prácticas

- Usa clases abstractas cuando tengas una base común y quieras evitar instancias genéricas.
- Coloca en la clase base lo que todas las subclases comparten (atributos, métodos comunes).
- Declara como abstracto lo que es obligatorio implementar.
- Usa métodos normales en el padre que llamen a métodos abstractos para reutilizar comportamiento.
- Mantén las clases pequeñas y con responsabilidad clara.

---

## 13. A tener en cuenta

- Una clase abstracta **no se puede instanciar**.
- Puede tener atributos, métodos normales, métodos abstractos y constructores.
- Un método abstracto **no tiene cuerpo** y obliga a las subclases a implementarlo.
- Si una subclase no implementa todos los abstractos, también debe ser abstracta.
- Permite polimorfismo limpio: `List<Shape>` puede contener `Circle`, `Rectangle`, etc.

---

En el siguiente tema veremos **interfaces**, que son otra forma (muy común en Java) de definir contratos, y compararemos cuándo conviene usar interfaces vs clases abstractas.
