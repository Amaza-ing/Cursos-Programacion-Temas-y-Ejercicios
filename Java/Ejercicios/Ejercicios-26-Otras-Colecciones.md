# Exercises - Topic 26: Other collections

Below you will find **10 practical exercises** to work with **`Set`, `HashSet`, `LinkedHashMap`, `TreeMap`, uniqueness and order**.

Try to solve them before looking at the solution.

---

## Exercise 1: Create a `HashSet`

Add repeated elements and check the size.

<details><summary>Show solution</summary>

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<String> tags = new HashSet<>();
        tags.add("java");
        tags.add("backend");
        tags.add("java");
        System.out.println(tags.size());
    }
}
```

</details>

---

## Exercise 2: Detect a duplicate

Use the boolean returned by `add`.

<details><summary>Show solution</summary>

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<String> emails = new HashSet<>();
        System.out.println(emails.add("test@example.com"));
        System.out.println(emails.add("test@example.com"));
    }
}
```

</details>

---

## Exercise 3: Use `contains`

Check whether a set contains an ID.

<details><summary>Show solution</summary>

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<Integer> ids = new HashSet<>();
        ids.add(100);
        ids.add(102);
        System.out.println(ids.contains(102));
    }
}
```

</details>

---

## Exercise 4: Remove duplicates

Convert a list into a `HashSet`.

<details><summary>Show solution</summary>

```java
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Laura");
        Set<String> uniqueNames = new HashSet<>(names);
        System.out.println(uniqueNames);
    }
}
```

</details>

---

## Exercise 5: Create a `LinkedHashMap`

Keep the insertion order.

<details><summary>Show solution</summary>

```java
import java.util.LinkedHashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, String> steps = new LinkedHashMap<>();
        steps.put("step1", "Download JDK");
        steps.put("step2", "Install IDE");
        System.out.println(steps);
    }
}
```

</details>

---

## Exercise 6: Update a `LinkedHashMap`

Update an existing value.

<details><summary>Show solution</summary>

```java
import java.util.LinkedHashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> prices = new LinkedHashMap<>();
        prices.put("Pen", 1.50);
        prices.put("Pen", 1.20);
        System.out.println(prices);
    }
}
```

</details>

---

## Exercise 7: Create a `TreeMap`

Automatically sort by key.

<details><summary>Show solution</summary>

```java
import java.util.Map;
import java.util.TreeMap;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new TreeMap<>();
        ages.put("Maria", 31);
        ages.put("Alex", 35);
        ages.put("Laura", 28);
        System.out.println(ages);
    }
}
```

</details>

---

## Exercise 8: Numeric `TreeMap`

Sort task IDs.

<details><summary>Show solution</summary>

```java
import java.util.Map;
import java.util.TreeMap;

public class Main {
    public static void main(String[] args) {
        Map<Integer, String> tasks = new TreeMap<>();
        tasks.put(3, "Review");
        tasks.put(1, "Create");
        tasks.put(2, "Test");
        System.out.println(tasks);
    }
}
```

</details>

---

## Exercise 9: Unique codes

Use a `Set` for discount codes.

<details><summary>Show solution</summary>

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<String> codes = new HashSet<>();
        codes.add("SUMMER10");
        codes.add("WELCOME");
        codes.add("SUMMER10");
        System.out.println(codes);
    }
}
```

</details>

---

## Exercise 10: Compare maps

Compare `LinkedHashMap` and `TreeMap`.

<details><summary>Show solution</summary>

```java
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.TreeMap;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> linked = new LinkedHashMap<>();
        Map<String, Integer> tree = new TreeMap<>();
        linked.put("C", 3); linked.put("A", 1); linked.put("B", 2);
        tree.putAll(linked);
        System.out.println(linked);
        System.out.println(tree);
    }
}
```

</details>

---
