# Topic 13. `List` and `ArrayList`

## 1. Introduction

Until now you have worked with **arrays**, which are a fundamental structure in Java. However, arrays have several important limitations:

- Its size is **fixed** (it cannot grow or shrink)
- They do not have “high-level” methods to insert, delete, search, etc.
- When managing insertions or deletions, you have to move elements manually

To solve this, Java provides **collections**, and one of the most used is:

- `List` (interface)
- `ArrayList` (implementation)

**Key idea:**

- **`List`** defines “what operations I can do” (contract).
- **`ArrayList`** is a concrete class that implements that contract and works with an internal array that grows automatically.

In this topic you will learn:

- What is `List` and what is `ArrayList`
- Why you need **wrappers** (`Integer`, `Double`, etc.) in collections
- How to create, add, get, modify and delete items
- How to loop through lists
- Useful methods (`contains`, `indexOf`, `isEmpty`, `clear`…)
- Conversion between arrays and lists
- Typical errors (indexes, `null`, `ConcurrentModificationException`, etc.)

---

[![ArrayList](https://img.youtube.com/vi/y3uzK_ilVwM/0.jpg)](https://www.youtube.com/watch?v=y3uzK_ilVwM&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. `List` vs `ArrayList`

### 2.1. What is `List`?

`List` is a Java **interface** that represents an ordered collection of elements.

Features of an `List`:

- It has **order** (there is position 0, 1, 2...)
- Allows **duplicates**
- Accessed by **index** (same as in arrays)

### 2.2. What is `ArrayList`?

`ArrayList` is a class that implements `List` and stores the elements internally in an array that can grow.

In general, `ArrayList` is the default option when you need:

- Add elements dynamically
- Quick access by index (`get(i)`)
- Scroll through the list with ease

---

## 3. Import required

`List` and `ArrayList` are not in `java.lang`, so they must be imported:

```java
import java.util.ArrayList;
import java.util.List;
```

---

## 4. Generics: `List<T>`

In Java, collections are defined with **generic**, indicating the type of elements they can contain.

Example:

```java
List<String> names = new ArrayList<>();
```

Here you are saying:

- “`names` is a list of `String`”
- You will not be able to enter `int`, `double`, etc. (unless they are wrappers)

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

## 6. Create an `ArrayList`

Recommended way:

```java
List<String> names = new ArrayList<>();
```

Why so:

- You declare with the interface (`List`) for flexible programming
- You use a concrete implementation (`ArrayList`) to create the object

You can also declare directly as `ArrayList`, but it is less recommended:

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

Add at the end:

```java
cities.add("Rome");
```

### 7.2. `add(index, element)`

Insert in a specific position (move the rest to the right):

```java
cities.add(1, "Lisbon");
```

### 7.3. `get(index)`

Gets the element at position:

```java
String first = cities.get(0);
```

### 7.4. `set(index, element)`

Replaces the element at one position (does not change the size):

```java
cities.set(0, "Valencia");
```

### 7.5. `remove(index)` and `remove(object)`

- Delete by index:

```java
cities.remove(1);
```

- Delete by value (if exists, deletes the first match):

```java
cities.remove("Paris");
```

---

## 8. Size and checks: `size`, `isEmpty`

### 8.1. `size()`

Equivalent to `length` in arrays, but here is a method:

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

## 9. Loop through a list

### 9.1. `for` loop with indices

```java
for (int i = 0; i < cities.size(); i++) {
    System.out.println(cities.get(i));
}
```

### 9.2. `for-each` Loop

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

An `List`:

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

In a list you can save `null` (depends on your design, but it is possible):

```java
List<String> names = new ArrayList<>();
names.add("Laura");
names.add(null);
names.add("Alex");
```

Be careful: if you call methods on an `null` element, you will have `NullPointerException`.

---

## 13. `remove` and the special case of `List<Integer>`

With `List<Integer>`, `remove` can be confusing because there is:

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

## 15. Sort a list: `Collections.sort` and `List.sort`

```java
import java.util.Collections;

Collections.sort(cities);
cities.sort(null); // orden natural
```

---

## 16. Convert between arrays and lists

### 16.1. Array → List

`List.of(...)` is immutable:

```java
List<String> fixed = List.of("A", "B", "C");
// fixed.add("D"); // UnsupportedOperationException
```

Modifiable list from another list:

```java
List<String> names = new ArrayList<>(List.of("A", "B", "C"));
names.add("D");
```

### 16.2. List → Array

```java
String[] array = names.toArray(new String[0]);
```

---

## 17. Complete Guided Examples

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

### 17.2. Add values in `List<Integer>`

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

## 18. Typical mistakes and how to avoid them

- `IndexOutOfBoundsException`: valid indexes from `0` to `size() - 1`
- Avoid deleting items on an `for-each` (may cause `ConcurrentModificationException`)
- With `List<Integer>`, use `remove(Integer.valueOf(x))` if you want to clear by value

Modern example for delete by condition:

```java
items.removeIf(item -> item.equals("A"));
```

---

## 19. To take into account

- `List` is the interface; `ArrayList` is a common implementation.
- Lists have dynamic size.
- Wrappers (`Integer`, `Double`, etc.) are used in collections, not primitives.
- Essential methods: `add`, `get`, `set`, `remove`, `size`, `contains`, `indexOf`.
- Be careful with `null`, with indices out of range and with `remove` in `List<Integer>`.

---

In the next topic we will learn what **classes and objects** are, and we will delve into the world of object-oriented programming (**OOP**).
