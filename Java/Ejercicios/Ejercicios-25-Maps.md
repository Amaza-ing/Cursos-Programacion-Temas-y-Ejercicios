# Exercises - Topic 25: `Map` and `HashMap`

Below you will find **10 practical exercises** to work with **`Map`, `HashMap`, `put`, `get`, `remove`, `containsKey`, `getOrDefault`, `putIfAbsent` and `entrySet`**.

Try to solve them before consulting the solution.

---

## Exercise 1: Create map

Create a map of countries and capitals.

<details><summary>Show solution</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, String> capitals = new HashMap<>();
        capitals.put("Spain", "Madrid");
        capitals.put("Italy", "Rome");
        capitals.put("Portugal", "Lisbon");
        System.out.println(capitals);
    }
}
```

</details>

---

## Exercise 2: Read with `get`

Retrieves the price of `P02`.

<details><summary>Show solution</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> prices = new HashMap<>();
        prices.put("P01", 9.99);
        prices.put("P02", 24.50);
        System.out.println(prices.get("P02"));
    }
}
```

</details>

---

## Exercise 3: Update value

Update the stock of `Mouse`.

<details><summary>Show solution</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> stock = new HashMap<>();
        stock.put("Mouse", 10);
        stock.put("Mouse", 15);
        System.out.println(stock.get("Mouse"));
    }
}
```

</details>

---

## Exercise 4: Use `containsKey`

Checks if `admin` exists.

<details><summary>Show solution</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, String> emails = new HashMap<>();
        emails.put("admin", "admin@example.com");
        System.out.println(emails.containsKey("admin"));
    }
}
```

</details>

---

## Exercise 5: Use `getOrDefault`

Get default score if it doesn't exist.

<details><summary>Show solution</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> scores = new HashMap<>();
        scores.put("Laura", 120);
        System.out.println(scores.getOrDefault("Maria", 0));
    }
}
```

</details>

---

## Exercise 6: Use `putIfAbsent`

Try changing `theme` without overwriting it.

<details><summary>Show solution</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, String> settings = new HashMap<>();
        settings.put("theme", "dark");
        settings.putIfAbsent("theme", "light");
        System.out.println(settings.get("theme"));
    }
}
```

</details>

---

## Exercise 7: Delete entry

Remove `Cable` from the map.

<details><summary>Show solution</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> prices = new HashMap<>();
        prices.put("Mouse", 19.99);
        prices.put("Cable", 4.99);
        prices.remove("Cable");
        System.out.println(prices);
    }
}
```

</details>

---

## Exercise 8: Loop through `entrySet`

Print students and notes.

<details><summary>Show solution</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> grades = new HashMap<>();
        grades.put("Laura", 8.5);
        grades.put("Alex", 6.7);
        for (Map.Entry<String, Double> entry : grades.entrySet()) {
            System.out.println(entry.getKey() + " -> " + entry.getValue());
        }
    }
}
```

</details>

---

## Exercise 9: Count repetitions

Count repeated letters.

<details><summary>Show solution</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        String[] letters = {"a", "b", "a", "c", "b", "a"};
        Map<String, Integer> counts = new HashMap<>();
        for (String letter : letters) {
            counts.put(letter, counts.getOrDefault(letter, 0) + 1);
        }
        System.out.println(counts);
    }
}
```

</details>

---

## Exercise 10: Map with objects

Save students by ID.

<details><summary>Show solution</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Student {
    private String name;

    public Student(String name) {
        this.name = name;
    }
}

public class Main {
    public static void main(String[] args) {
        Map<String, Student> students = new HashMap<>();
        students.put("S01", new Student("Laura"));
    }
}
```

</details>

---
