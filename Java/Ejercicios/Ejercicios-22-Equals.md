# Exercises - Topic 22: equals, hashCode and toString

Below you will find **10 practical exercises** to work with **`equals`, `hashCode`, `toString`, comparing objects and using them in collections**.

Try to solve them before looking at the solution.

---

## Exercise 1: Compare with `==`

Create two `Customer` objects with the same name and compare them with `==`.

<details><summary>Show solution</summary>

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

## Exercise 2: Override `equals`

Create a class `Customer` with `email`. Two customers must be equal if they have the same email.

<details><summary>Show solution</summary>

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

## Exercise 3: Add `hashCode`

Add `hashCode()` to the previous class using `Objects.hash(email)`.

<details><summary>Show solution</summary>

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

## Exercise 4: Duplicates in `HashSet`

Create a class `Course` with `code`, override `equals` and `hashCode`, and check that a `HashSet` does not duplicate courses with the same code.

<details><summary>Show solution</summary>

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

## Exercise 5: Override `toString`

Create a class `Movie` with `title` and `year`. Override `toString()`.

<details><summary>Show solution</summary>

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

## Exercise 6: Compare `null` values

Create a class `Tag` with `name` and use `Objects.equals` in `equals`.

<details><summary>Show solution</summary>

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

## Exercise 7: Compare `double`

Create a class `Measurement` with `double value` and compare the value with `Double.compare`.

<details><summary>Show solution</summary>

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

## Exercise 8: Equality by id

Create a class `Employee` with `id`, `name`, and `department`. Use only `id` for `equals` and `hashCode`.

<details><summary>Show solution</summary>

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

## Exercise 9: List with `toString`

Create a class `Task` with `toString`, add objects to a list, and print the list.

<details><summary>Show solution</summary>

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

## Exercise 10: Complete class

Create a class `LibraryCard` with `equals`, `hashCode`, and `toString`.

<details><summary>Show solution</summary>

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
