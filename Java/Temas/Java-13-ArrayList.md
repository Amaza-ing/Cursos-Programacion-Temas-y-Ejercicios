# Topic 13. `List` and `ArrayList`

## 1. Introduction

So far you've worked with **arrays**, which are a fundamental structure in Java. However, arrays have several important limitations:

- Their size is **fixed** (it can't grow or shrink)
- They don't have “high-level” methods to insert, delete, search, etc.
- When handling insertions or deletions, you have to move elements around manually

To solve this, Java provides **collections**, and one of the most widely used is:

- `List` (interface)
- `ArrayList` (implementation)

**Key idea:**

- **`List`** defines “what operations I can do” (a contract).
- **`ArrayList`** is a concrete class that implements that contract and works with an internal array that grows automatically.

In this topic you will learn:

- What `List` is and what `ArrayList` is
- Why you need **wrappers** (`Integer`, `Double`, etc.) in collections
- How to create, add, get, modify and delete elements
- How to loop through lists
- Useful methods (`contains`, `indexOf`, `isEmpty`, `clear`…)
- Conversion between arrays and lists
- Typical mistakes (indices, `null`, `ConcurrentModificationException`, etc.)

---

[![ArrayList](https://img.youtube.com/vi/y3uzK_ilVwM/0.jpg)](https://www.youtube.com/watch?v=y3uzK_ilVwM&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. `List` vs `ArrayList`

### 2.1. What is `List`?

`List` is a Java **interface** that represents an ordered collection of elements.

Characteristics of a `List`:

- It has **order** (there's a position 0, 1, 2...)
- It allows **duplicates**
- It's accessed by **index** (just like arrays)

### 2.2. What is `ArrayList`?

`ArrayList` is a class that implements `List` and stores the elements internally in an array that can grow.

In general, `ArrayList` is the default option when you need:

- To add elements dynamically
- Fast access by index (`get(i)`)
- To loop through the list easily

---

## 3. Required import

`List` and `ArrayList` are not in `java.lang`, so you have to import them:

```java
import java.util.ArrayList;
import java.util.List;
```

---

## 4. Generics: `List<T>`

In Java, collections are defined with **generics**, indicating the type of elements they can contain.

Example:

```java
List<String> names = new ArrayList<>();
```

Here you are saying:

- “`names` is a list of `String`”
- You won't be able to put `int`, `double`, etc. in it (unless they're wrappers)

---

## 5. Why do we use wrappers in lists?

Collections hold **objects**, not primitive types.

That's why this doesn't exist:

```java
// List<int> numbers = new ArrayList<>(); // NO
```

The correct way:

```java
List<Integer> numbers = new ArrayList<>();
List<Double> prices = new ArrayList<>();
List<Boolean> flags = new ArrayList<>();
```

This connects directly to **Topic 10: Wrappers**.

---

## 6. Creating an `ArrayList`

Recommended way:

```java
List<String> names = new ArrayList<>();
```

Why do it this way:

- You declare it with the interface (`List`) so your code stays flexible
- You use a concrete implementation (`ArrayList`) to create the object

You can also declare it directly as an `ArrayList`, but it's less recommended:

```java
ArrayList<String> names = new ArrayList<>();
```

---

## 7. Basic operations: `add`, `get`, `set`, `remove`

Let's build a list and work with its elements.

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> cities = new ArrayList<>();

        cities.add("Madrid");
        cities.add("Berlin");
        cities.add("Paris");

        System.out.println(cities.get(0)); // Madrid
        System.out.println(cities.get(2)); // Paris
    }
}
```

### 7.1. `add(element)`

Adds to the end:

```java
cities.add("Rome");
```

### 7.2. `add(index, element)`

Inserts at a specific position (shifts the rest to the right):

```java
cities.add(1, "Lisbon");
```

### 7.3. `get(index)`

Gets the element at a position:

```java
String first = cities.get(0);
```

### 7.4. `set(index, element)`

Replaces the element at a position (doesn't change the size):

```java
cities.set(0, "Valencia");
```

### 7.5. `remove(index)` and `remove(object)`

- Remove by index:

```java
cities.remove(1);
```

- Remove by value (if it exists, it removes the first match):

```java
cities.remove("Paris");
```

---

## 8. Size and checks: `size`, `isEmpty`

### 8.1. `size()`

Equivalent to `length` in arrays, but here it's a method:

```java
System.out.println(cities.size());
```

### 8.2. `isEmpty()`

```java
if (cities.isEmpty()) {
    System.out.println("No cities");
}
```

---

## 9. Looping through a list

### 9.1. `for` loop with indices

```java
for (int i = 0; i < cities.size(); i++) {
    System.out.println(cities.get(i));
}
```

### 9.2. `for-each` loop

```java
for (String city : cities) {
    System.out.println(city);
}
```

---

## 10. Useful methods: `contains`, `indexOf`, `lastIndexOf`

```java
boolean hasBerlin = cities.contains("Berlin");
int pos = cities.indexOf("Paris");

cities.add("Berlin");
int firstBerlin = cities.indexOf("Berlin");
int lastBerlin = cities.lastIndexOf("Berlin");

System.out.println(hasBerlin);
System.out.println(pos);
System.out.println(firstBerlin);
System.out.println(lastBerlin);
```

---

## 11. Duplicates and order

A `List`:

- Allows duplicates
- Maintains insertion order

```java
List<Integer> values = new ArrayList<>();
values.add(5);
values.add(5);
values.add(2);

System.out.println(values); // [5, 5, 2]
```

---

## 12. `null` in lists

You can store `null` in a list (it depends on your design, but it's possible):

```java
List<String> names = new ArrayList<>();
names.add("Laura");
names.add(null);
names.add("Alex");
```

Be careful: if you call methods on a `null` element, you'll get a `NullPointerException`.

---

## 13. `remove` and the special case of `List<Integer>`

With `List<Integer>`, `remove` can be confusing because both of these exist:

- `remove(int index)`
- `remove(Object o)`

If you want to remove the value 20:

```java
numbers.remove(Integer.valueOf(20));
```

---

## 14. `clear()`

```java
cities.clear();
System.out.println(cities.size()); // 0
```

---

## 15. Sorting a list: `Collections.sort` and `List.sort`

```java
import java.util.Collections;

Collections.sort(cities);
cities.sort(null); // orden natural
```

---

## 16. Converting between arrays and lists

### 16.1. Array → List

`List.of(...)` is immutable:

```java
List<String> fixed = List.of("A", "B", "C");
// fixed.add("D"); // UnsupportedOperationException
```

A modifiable list from another list:

```java
List<String> names = new ArrayList<>(List.of("A", "B", "C"));
names.add("D");
```

### 16.2. List → Array

```java
String[] array = names.toArray(new String[0]);
```

---

## 17. Complete guided examples

### 17.1. Task management

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> tasks = new ArrayList<>();

        tasks.add("Study Java");
        tasks.add("Practice loops");
        tasks.add("Read about ArrayList");

        tasks.set(1, "Practice for and while loops");
        tasks.remove("Study Java");

        System.out.println(tasks);
    }
}
```

### 17.2. Adding up values in a `List<Integer>`

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> values = new ArrayList<>();
        values.add(10);
        values.add(20);
        values.add(5);

        int sum = 0;

        for (Integer value : values) {
            sum += value; // unboxing automático
        }

        System.out.println(sum); // 35
    }
}
```

---

## 18. Common mistakes and how to avoid them

- `IndexOutOfBoundsException`: valid indices go from `0` to `size() - 1`
- Avoid removing elements inside a `for-each` (it can cause `ConcurrentModificationException`)
- With `List<Integer>`, use `remove(Integer.valueOf(x))` if you want to remove by value

A modern way to remove by condition:

```java
items.removeIf(item -> item.equals("A"));
```

---

## 19. Things to keep in mind

- `List` is the interface; `ArrayList` is a common implementation.
- Lists have dynamic size.
- Wrappers (`Integer`, `Double`, etc.) are used in collections, not primitives.
- Essential methods: `add`, `get`, `set`, `remove`, `size`, `contains`, `indexOf`.
- Be careful with `null`, with out-of-range indices and with `remove` in `List<Integer>`.

---

In the next topic we'll learn what **classes and objects** are, and we'll dive into the world of object-oriented programming (**OOP**).
