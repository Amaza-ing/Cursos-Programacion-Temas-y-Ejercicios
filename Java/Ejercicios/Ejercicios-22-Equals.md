# Ejercicios - Tema 22: `equals`, `hashCode` y `toString`

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **`equals`, `hashCode`, `toString`, comparación de objetos y uso en colecciones**.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Comparar con `==`

Crea dos objetos `Customer` con el mismo nombre y compáralos con `==`.

<details><summary>Mostrar solución</summary>

```java
public class Customer {
    private String name;

    public Customer(String name) {
        this.name = name;
    }
}

public class Main {
    public static void main(String[] args) {
        Customer c1 = new Customer("Laura");
        Customer c2 = new Customer("Laura");

        System.out.println(c1 == c2);
    }
}
```

</details>

---

## Ejercicio 2: Sobrescribir `equals`

Crea una clase `Customer` con `email`. Dos clientes deben ser iguales si tienen el mismo email.

<details><summary>Mostrar solución</summary>

```java
import java.util.Objects;

public class Customer {
    private String email;

    public Customer(String email) {
        this.email = email;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        Customer other = (Customer) obj;
        return Objects.equals(email, other.email);
    }
}
```

</details>

---

## Ejercicio 3: Añadir `hashCode`

Añade `hashCode()` a la clase anterior usando `Objects.hash(email)`.

<details><summary>Mostrar solución</summary>

```java
import java.util.Objects;

public class Customer {
    private String email;

    public Customer(String email) {
        this.email = email;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        Customer other = (Customer) obj;
        return Objects.equals(email, other.email);
    }

    @Override
    public int hashCode() {
        return Objects.hash(email);
    }
}
```

</details>

---

## Ejercicio 4: Duplicados en `HashSet`

Crea una clase `Course` con `code`, sobrescribe `equals` y `hashCode`, y comprueba que un `HashSet` no duplica cursos con el mismo código.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

public class Course {
    private String code;

    public Course(String code) {
        this.code = code;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        Course other = (Course) obj;
        return Objects.equals(code, other.code);
    }

    @Override
    public int hashCode() {
        return Objects.hash(code);
    }
}

public class Main {
    public static void main(String[] args) {
        Set<Course> courses = new HashSet<>();
        courses.add(new Course("JAVA-01"));
        courses.add(new Course("JAVA-01"));

        System.out.println(courses.size());
    }
}
```

</details>

---

## Ejercicio 5: Sobrescribir `toString`

Crea una clase `Movie` con `title` y `year`. Sobrescribe `toString()`.

<details><summary>Mostrar solución</summary>

```java
public class Movie {
    private String title;
    private int year;

    public Movie(String title, int year) {
        this.title = title;
        this.year = year;
    }

    @Override
    public String toString() {
        return "Movie{title='" + title + "', year=" + year + "}";
    }
}
```

</details>

---

## Ejercicio 6: Comparar valores `null`

Crea una clase `Tag` con `name` y usa `Objects.equals` en `equals`.

<details><summary>Mostrar solución</summary>

```java
import java.util.Objects;

public class Tag {
    private String name;

    public Tag(String name) {
        this.name = name;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        Tag other = (Tag) obj;
        return Objects.equals(name, other.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }
}
```

</details>

---

## Ejercicio 7: Comparar `double`

Crea una clase `Measurement` con `double value` y compara el valor con `Double.compare`.

<details><summary>Mostrar solución</summary>

```java
import java.util.Objects;

public class Measurement {
    private double value;

    public Measurement(double value) {
        this.value = value;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        Measurement other = (Measurement) obj;
        return Double.compare(value, other.value) == 0;
    }

    @Override
    public int hashCode() {
        return Objects.hash(value);
    }
}
```

</details>

---

## Ejercicio 8: Igualdad por id

Crea una clase `Employee` con `id`, `name` y `department`. Usa solo `id` para `equals` y `hashCode`.

<details><summary>Mostrar solución</summary>

```java
import java.util.Objects;

public class Employee {
    private String id;
    private String name;
    private String department;

    public Employee(String id, String name, String department) {
        this.id = id;
        this.name = name;
        this.department = department;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        Employee other = (Employee) obj;
        return Objects.equals(id, other.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
```

</details>

---

## Ejercicio 9: Lista con `toString`

Crea una clase `Task` con `toString`, añade objetos a una lista e imprime la lista.

<details><summary>Mostrar solución</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Task {
    private String title;
    private boolean done;

    public Task(String title, boolean done) {
        this.title = title;
        this.done = done;
    }

    @Override
    public String toString() {
        return "Task{title='" + title + "', done=" + done + "}";
    }
}

public class Main {
    public static void main(String[] args) {
        List<Task> tasks = new ArrayList<>();
        tasks.add(new Task("Study Java", false));
        tasks.add(new Task("Practice equals", true));

        System.out.println(tasks);
    }
}
```

</details>

---

## Ejercicio 10: Clase completa

Crea una clase `LibraryCard` con `equals`, `hashCode` y `toString`.

<details><summary>Mostrar solución</summary>

```java
import java.util.Objects;

public class LibraryCard {
    private String number;
    private String owner;

    public LibraryCard(String number, String owner) {
        this.number = number;
        this.owner = owner;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        LibraryCard other = (LibraryCard) obj;
        return Objects.equals(number, other.number)
                && Objects.equals(owner, other.owner);
    }

    @Override
    public int hashCode() {
        return Objects.hash(number, owner);
    }

    @Override
    public String toString() {
        return "LibraryCard{number='" + number + "', owner='" + owner + "'}";
    }
}
```

</details>

---
