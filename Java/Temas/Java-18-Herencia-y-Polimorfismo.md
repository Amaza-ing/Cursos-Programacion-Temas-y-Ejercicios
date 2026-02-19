# Tema 18. Herencia de clases

## 1. Introducción

En temas anteriores has aprendido a crear clases con:

- Atributos y métodos
- Encapsulación (atributos `private`, getters y setters)
- Constructores y sobrecarga
- Miembros estáticos (`static`)

Ahora vas a aprender un concepto central de la Programación Orientada a Objetos (POO):

- **Herencia**

La herencia permite crear una clase nueva a partir de otra, **reutilizando** código y ampliando comportamiento.

Ejemplo mental:

- `Animal` (clase base)
- `Dog` y `Cat` (clases derivadas)

Todas las mascotas comparten cosas (nombre, edad), pero cada una tiene comportamientos especiales.

En este tema aprenderás:

- Qué es herencia y cuándo tiene sentido usarla
- `extends` y la relación _is-a_ (es-un)
- Qué es `super` y para qué sirve
- Cómo funcionan los constructores en herencia
- `protected` vs `private`
- Sobrescritura de métodos (`@Override`)
- Polimorfismo básico (usar una referencia del padre para un hijo)
- Ejemplos completos listos para ejecutar

---

## 2. Qué es herencia

Herencia significa:

- Una clase “hija” (subclase) hereda los atributos y métodos de una clase “padre” (superclase).
- La clase hija puede:
  - Añadir nuevos atributos y métodos
  - Reutilizar lo heredado
  - Modificar comportamientos (sobrescribir métodos)

La sintaxis es:

```java
public class Child extends Parent {
}
```

---

## 3. Relación _is-a_ (es-un)

Una regla práctica muy importante:

> Usa herencia cuando la clase hija **es un** tipo de la clase padre.

Ejemplos correctos (_is-a_):

- `Car` es un `Vehicle`
- `Student` es una `Person`
- `Dog` es un `Animal`

Ejemplos incorrectos (no es _is-a_):

- `Engine` es un `Car` (no, un motor **no es** un coche)
- `Address` es un `User` (no)

Si la relación es más bien “tiene un” (_has-a_), suele ser composición (lo verás más adelante).

---

## 4. Primer ejemplo simple: `Person` y `Student`

### 4.1. Clase padre: `Person`

```java
public class Person {
    private String name;
    private int age;

    public Person(String name, int age) {
        setName(name);
        setAge(age);
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public void setName(String name) {
        if (name == null || name.isBlank()) {
            this.name = "Unknown";
            return;
        }

        this.name = name;
    }

    public void setAge(int age) {
        if (age < 0) {
            this.age = 0;
            return;
        }

        this.age = age;
    }

    public void printInfo() {
        System.out.println("Name: " + name + " | Age: " + age);
    }
}
```

### 4.2. Clase hija: `Student`

`Student` hereda `name`, `age` y `printInfo()`, y añade `grade`.

```java
public class Student extends Person {
    private double grade;

    public Student(String name, int age, double grade) {
        super(name, age);
        setGrade(grade);
    }

    public double getGrade() {
        return grade;
    }

    public void setGrade(double grade) {
        if (grade < 0 || grade > 10) {
            this.grade = 0.0;
            return;
        }

        this.grade = grade;
    }
}
```

### 4.3. Uso

```java
public class Main {
    public static void main(String[] args) {
        Person p = new Person("Laura", 28);
        p.printInfo();

        Student s = new Student("Alex", 21, 8.5);
        s.printInfo(); // heredado
        System.out.println(s.getGrade()); // propio de Student
    }
}
```

Puntos clave:

- `Student extends Person`
- `Student` llama al constructor del padre con `super(name, age)`
- `Student` hereda métodos públicos del padre

---

## 5. `super`: acceder al padre

`super` se usa para dos cosas principales:

1. Llamar al constructor del padre: `super(...)`
2. Llamar a un método del padre desde un método sobrescrito: `super.method()`

---

## 6. Constructores en herencia

Cuando creas un objeto de una clase hija:

- Primero se construye la parte “padre”
- Luego la parte “hija”

Por eso Java exige que el constructor de la hija llame a `super(...)`.

Ejemplo:

```java
public class Student extends Person {
    public Student(String name, int age) {
        super(name, age);
    }
}
```

### 6.1. `super(...)` debe ser la primera línea

Esto es obligatorio.

```java
public Student(String name, int age) {
    // System.out.println("Hi"); // no puede ir antes de super
    super(name, age);
}
```

---

## 7. `private` vs `protected` en herencia

- `private`: solo accesible dentro de la clase padre
- `protected`: accesible dentro del padre y también dentro de las clases hijas

En este curso, como estás empezando, lo más común es:

- Atributos `private`
- Acceso desde la hija usando getters y setters del padre (recomendado)

Si `name` es `private` en `Person`, no puedes hacer:

```java
// this.name = "Laura"; // no se puede si es private
```

Pero sí puedes hacer:

```java
setName("Laura"); // método heredado
```

---

## 8. Sobrescritura de métodos (`@Override`)

Una clase hija puede **sobrescribir** un método del padre para cambiar su comportamiento.

Ejemplo: queremos que `Student.printInfo()` muestre también la nota.

```java
public class Student extends Person {
    private double grade;

    public Student(String name, int age, double grade) {
        super(name, age);
        setGrade(grade);
    }

    public void setGrade(double grade) {
        if (grade < 0 || grade > 10) {
            this.grade = 0.0;
            return;
        }

        this.grade = grade;
    }

    @Override
    public void printInfo() {
        super.printInfo();
        System.out.println("Grade: " + grade);
    }
}
```

- `@Override` le dice a Java: “esto sobrescribe un método del padre”.
- `super.printInfo()` reutiliza la impresión del padre y luego añadimos información.

---

## 9. Polimorfismo básico

Puedes tratar un objeto hijo como si fuera del tipo padre.

```java
Person p = new Student("Alex", 21, 8.5);
p.printInfo();
```

Esto es útil para colecciones:

```java
import java.util.ArrayList;
import java.util.List;

List<Person> people = new ArrayList<>();
people.add(new Person("Laura", 28));
people.add(new Student("Alex", 21, 8.5));

for (Person person : people) {
    person.printInfo();
}
```

Si `Student` sobrescribe `printInfo`, se ejecutará la versión correcta.

---

## 10. Ejemplo completo: `Employee` y `Manager`

### 10.1. `Employee.java` (padre)

```java
public class Employee {
    private String name;
    private double salary;

    public Employee(String name, double salary) {
        setName(name);
        setSalary(salary);
    }

    public String getName() {
        return name;
    }

    public double getSalary() {
        return salary;
    }

    public void setName(String name) {
        if (name == null || name.isBlank()) {
            this.name = "Unknown";
            return;
        }

        this.name = name;
    }

    public void setSalary(double salary) {
        if (salary < 0) {
            this.salary = 0.0;
            return;
        }

        this.salary = salary;
    }

    public void printInfo() {
        System.out.println("Name: " + name + " | Salary: " + salary);
    }
}
```

### 10.2. `Manager.java` (hija)

```java
public class Manager extends Employee {
    private double bonus;

    public Manager(String name, double salary, double bonus) {
        super(name, salary);
        setBonus(bonus);
    }

    public double getBonus() {
        return bonus;
    }

    public void setBonus(double bonus) {
        if (bonus < 0) {
            this.bonus = 0.0;
            return;
        }

        this.bonus = bonus;
    }

    public double getTotalCompensation() {
        return getSalary() + bonus;
    }

    @Override
    public void printInfo() {
        System.out.println(
                "Name: " + getName() +
                " | Salary: " + getSalary() +
                " | Bonus: " + bonus +
                " | Total: " + getTotalCompensation()
        );
    }
}
```

### 10.3. `Main.java`

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        Employee e = new Employee("Laura", 2500);
        Manager m = new Manager("Alex", 3000, 500);

        e.printInfo();
        m.printInfo();

        List<Employee> staff = new ArrayList<>();
        staff.add(e);
        staff.add(m);

        for (Employee employee : staff) {
            employee.printInfo();
        }
    }
}
```

---

## 11. Errores típicos

- Olvidar llamar a `super(...)` cuando el padre no tiene constructor vacío
- Intentar acceder a atributos `private` del padre desde la hija
- Usar herencia donde no existe una relación _is-a_

---

## 12. Buenas prácticas iniciales

- Usa herencia para relaciones claras _is-a_.
- Mantén atributos `private` y expón métodos.
- Usa `@Override` siempre que sobrescribas.
- Reutiliza lógica con `super.method()` cuando tenga sentido.

---

## 13. A tener en cuenta

- `extends` crea una relación de herencia.
- `super(...)` llama al constructor del padre y debe ser la primera línea.
- `private` no es accesible en la hija; `protected` sí.
- `@Override` ayuda a escribir código correcto.
- Polimorfismo: puedes guardar un hijo como un padre y se ejecuta el método correcto.

---

En el siguiente tema aprenderemos a organizar el proyecto en **Packages** o paquetes, que te ayudan a diseñar jerarquías más robustas y a organizar el código.
