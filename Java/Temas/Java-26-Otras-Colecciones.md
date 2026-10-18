# Topic 26. Other common Java collections: `Set`, `LinkedHashMap` and `TreeMap`

## 1. Introduction

In the previous topic you learned how to work with `Map` and `HashMap`, a very useful key-value structure when you need to associate data.

But the Java collections library offers more options, and it is important to know them because not all structures behave in the same way.

In this topic we are going to study three very common collections:

- `Set`
- `LinkedHashMap`
- `TreeMap`

They are all very useful, but each one solves a different problem:

- `Set` is used to store elements **without duplicates**
- `LinkedHashMap` is a map that **keeps the insertion order**
- `TreeMap` is a map that **automatically sorts by key**

Learning to choose the right structure is very important in real-world Java.

In this topic you will learn:

- What a `Set` is
- What the difference between `HashSet`, `LinkedHashSet` and `TreeSet` is at a conceptual level
- How to use `Set` to avoid duplicates
- What `LinkedHashMap` is and when to use it instead of `HashMap`
- What `TreeMap` is and how it sorts the keys
- How to iterate over these collections
- Which typical mistakes you should avoid

---

[![Other Collections](https://img.youtube.com/vi/BBNZmrhUKtc/0.jpg)](https://www.youtube.com/watch?v=BBNZmrhUKtc&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. The key idea: not all collections do the same thing

So far you have seen several structures:

- Arrays
- `ArrayList`
- `HashMap`

Each one has a different purpose.

### 2.1. `ArrayList`

It is used to:

- store items in sequence
- allow duplicates
- access by index
- keep the insertion order

Example:

```java
List<String> names = new ArrayList<>();
names.add("Laura");
names.add("Alex");
names.add("Laura");
```

Here the value `"Laura"` can be repeated.

### 2.2. `Set`

It is used to:

- store unique items
- avoid duplicates
- work without indexes

### 2.3. `Map`

It is used to:

- store key-value pairs
- access by key

Therefore:

- `List` = ordered collection with possible duplicates
- `Set` = collection without duplicates
- `Map` = key-value structure

---

## 3. What is a `Set`

A `Set` is a collection that **does not allow duplicate elements**.

Conceptual example:

```text
["Laura", "Alex", "Laura", "Maria"]
```

In a list that would be valid.

But in a `Set`, the result would be equivalent to:

```text
["Laura", "Alex", "Maria"]
```

because `"Laura"` cannot appear twice.

The main interface is:

```java
Set<T>
```

And a widely used implementation is:

- `HashSet`

---

## 4. Necessary imports

To work with `Set` and some common implementations, you will often use these imports:

```java
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
```

Later you will also see other implementations such as `LinkedHashSet` or `TreeSet`, but in this topic we are going to focus mainly on the general idea of `Set` and on `LinkedHashMap` and `TreeMap`.

---

## 5. Creating a `Set`

The usual way:

```java
Set<String> names = new HashSet<>();
```

Here you are saying:

- the collection will store `String` values
- it will not allow duplicates

Example:

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<String> names = new HashSet<>();

        names.add("Laura");
        names.add("Alex");
        names.add("Laura");

        System.out.println(names);
    }
}
```

Even if you try to add `"Laura"` twice, there will only be one in the set.

---

## 6. Main operation: `add`
To insert elements, you use `add`.

```java
Set<String> cities = new HashSet<>();

cities.add("Madrid");
cities.add("Berlin");
cities.add("Paris");
```

If you add a repeated item, the `Set` does not store it again.

```java
cities.add("Madrid");
```

The set will still have a single `"Madrid"`.

---

## 7. `add` returns `true` or `false`

This is very useful and often forgotten.

In a `Set`, `add(...)` returns:

- `true` if the item was added
- `false` if it was not added because it already existed

Example:

```java
Set<String> names = new HashSet<>();

boolean firstInsert = names.add("Laura");
boolean secondInsert = names.add("Laura");

System.out.println(firstInsert);  // true
System.out.println(secondInsert); // false
```

This can be useful if you want to detect duplicates.

---

## 8. `Set` does not use indexes

Unlike a list, a `Set` does not have positions like `0`, `1`, `2`...

This does not exist:

```java
// names.get(0); // NO
```

In a `Set`:

- you do not access by index
- you iterate over the elements with a loop
- you check whether an element exists
- you add and delete

This makes sense because the goal of a `Set` is not to manage positions, but uniqueness.

---

## 9. Basic `Set` methods

The most important methods when starting out are:

- `add`
- `remove`
- `contains`
- `size`
- `isEmpty`
- `clear`

---

## 10. `contains`

It is used to check whether an element is in the set.

```java
Set<String> names = new HashSet<>();
names.add("Laura");
names.add("Alex");

System.out.println(names.contains("Laura")); // true
System.out.println(names.contains("Maria")); // false
```

---

## 11. `remove`

It is used to delete an element.

```java
Set<String> names = new HashSet<>();
names.add("Laura");
names.add("Alex");

names.remove("Laura");

System.out.println(names.contains("Laura")); // false
```

It also returns `true` or `false`:

- `true` if it was removed
- `false` if it did not exist

---

## 12. `size`, `isEmpty` and `clear`

### 12.1. `size`

```java
Set<String> names = new HashSet<>();
names.add("Laura");
names.add("Alex");

System.out.println(names.size()); // 2
```

### 12.2. `isEmpty`

```java
Set<String> names = new HashSet<>();

System.out.println(names.isEmpty()); // true
```

### 12.3. `clear`

```java
Set<String> names = new HashSet<>();
names.add("Laura");
names.add("Alex");

names.clear();

System.out.println(names.size()); // 0
```

---

## 13. Iterating over a `Set`

Since there are no indexes, you usually iterate over it with `for-each`.

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<String> names = new HashSet<>();

        names.add("Laura");
        names.add("Alex");
        names.add("Maria");

        for (String name : names) {
            System.out.println(name);
        }
    }
}
```

---

## 14. Order in `HashSet`

As with `HashMap`, **`HashSet` does not guarantee order**.

Example:

```java
Set<String> names = new HashSet<>();
names.add("Laura");
names.add("Alex");
names.add("Maria");

System.out.println(names);
```

The printing order may not match the order in which you added the items.

Therefore:

- don't assume the insertion order
- do not use `HashSet` if you need a specific order

---

## 15. When to use a `Set`

A `Set` is ideal when you want to:

- avoid duplicates
- quickly check whether something already exists
- work with a collection of unique items

Typical examples:

- unique logged-in users
- product categories without repetitions
- unique words in a text
- registered emails without duplicates

---

## 16. Guided example: removing duplicates from a list

This is one of the most typical uses of `Set`.

```java
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        List<String> names = new ArrayList<>();
        names.add("Laura");
        names.add("Alex");
        names.add("Laura");
        names.add("Maria");
        names.add("Alex");

        Set<String> uniqueNames = new HashSet<>(names);

        System.out.println(names);
        System.out.println(uniqueNames);
    }
}
```

Here:

- the original list has duplicates
- the `Set` removes duplicates automatically

---

## 17. Guided example: detecting whether a value has already appeared

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        String[] words = {"java", "code", "map", "java", "set"};

        Set<String> seenWords = new HashSet<>();

        for (String word : words) {
            if (seenWords.add(word)) {
                System.out.println("New word: " + word);
            } else {
                System.out.println("Repeated word: " + word);
            }
        }
    }
}
```

Here we take advantage of the fact that `add(...)` returns `false` if the element already existed.

---

## 18. Important variants of `Set`

Although `Set` is the interface, there are several implementations.

At this early stage, it is a good idea to keep this mental picture:

- `HashSet` → does not guarantee order
- `LinkedHashSet` → keeps the insertion order
- `TreeSet` → sorts automatically

In this topic we are not going to go deep into all of them, but it is important that you know they exist, because they follow the same logic that you will now see with `LinkedHashMap` and `TreeMap`.

---

## 19. What is `LinkedHashMap`

In the previous topic you saw `HashMap`, which:

- stores key-value pairs
- allows fast lookups by key
- **does not guarantee order**

`LinkedHashMap` is very similar to `HashMap`, but with one key difference:

> `LinkedHashMap` keeps the insertion order.

In other words, if you insert:

```text
"Laura" -> 28
"Alex"  -> 35
"Maria" -> 31
```

when you iterate over the map, they will appear in that same order.

---

## 20. Creating a `LinkedHashMap`

```java
import java.util.LinkedHashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new LinkedHashMap<>();

        ages.put("Laura", 28);
        ages.put("Alex", 35);
        ages.put("Maria", 31);

        System.out.println(ages);
    }
}
```

Expected result:

```text
{Laura=28, Alex=35, Maria=31}
```

Here the insertion order is preserved.

---

## 21. `LinkedHashMap` is used almost exactly like `HashMap`

The basic methods are the same:

- `put`
- `get`
- `remove`
- `containsKey`
- `containsValue`
- `size`
- `isEmpty`
- `clear`
- `entrySet`
- `keySet`
- `values`

Example:

```java
import java.util.LinkedHashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> prices = new LinkedHashMap<>();

        prices.put("Mouse", 19.99);
        prices.put("Keyboard", 49.99);
        prices.put("Monitor", 199.99);

        System.out.println(prices.get("Keyboard"));
        System.out.println(prices.containsKey("Mouse"));

        prices.remove("Monitor");

        for (Map.Entry<String, Double> entry : prices.entrySet()) {
            System.out.println(entry.getKey() + " -> " + entry.getValue());
        }
    }
}
```

The big difference is not in the methods, but in how the order behaves.

---

## 22. When to use `LinkedHashMap`

Use `LinkedHashMap` when you need to:

- associate keys and values
- keep the order in which you inserted the entries

Typical examples:

- displaying data in the same order it was loaded
- generating menus or ordered settings
- storing an insertion history
- having more predictable behavior when printing or iterating

---

## 23. `HashMap` vs `LinkedHashMap`

### 23.1. `HashMap`

- key-value structure
- does not guarantee order

### 23.2. `LinkedHashMap`

- key-value structure
- keeps the insertion order

Comparison example:

```java
Map<String, Integer> hashMap = new HashMap<>();
Map<String, Integer> linkedHashMap = new LinkedHashMap<>();

hashMap.put("C", 3);
hashMap.put("A", 1);
hashMap.put("B", 2);

linkedHashMap.put("C", 3);
linkedHashMap.put("A", 1);
linkedHashMap.put("B", 2);

System.out.println(hashMap);
System.out.println(linkedHashMap);
```

In `linkedHashMap`, the order will be:

```text
{C=3, A=1, B=2}
```

In `hashMap`, you should not assume anything.

---

## 24. What is `TreeMap`

`TreeMap` is another implementation of `Map`, but with a very important difference:

> `TreeMap` automatically sorts entries by key.

Not by insertion order, but by the **natural order of the keys**.

Example with `String` keys:

- `"A"`
- `"B"`
- `"C"`

Example with `Integer` keys:

- `1`
- `2`
- `3`

---

## 25. Creating a `TreeMap`

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

Expected result:

```text
{Alex=35, Laura=28, Maria=31}
```

Although you inserted them in a different order, `TreeMap` sorts them by key.

---

## 26. Example with numeric keys in `TreeMap`

```java
import java.util.Map;
import java.util.TreeMap;

public class Main {
    public static void main(String[] args) {
        Map<Integer, String> students = new TreeMap<>();

        students.put(3, "Laura");
        students.put(1, "Alex");
        students.put(2, "Maria");

        System.out.println(students);
    }
}
```

Expected result:

```text
{1=Alex, 2=Maria, 3=Laura}
```

---

## 27. `TreeMap` also uses the same basic methods

The main methods are the same as in other maps:

- `put`
- `get`
- `remove`
- `containsKey`
- `size`
- `entrySet`

Example:

```java
import java.util.Map;
import java.util.TreeMap;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> prices = new TreeMap<>();

        prices.put("Keyboard", 49.99);
        prices.put("Mouse", 19.99);
        prices.put("Monitor", 199.99);

        System.out.println(prices.get("Mouse"));

        for (Map.Entry<String, Double> entry : prices.entrySet()) {
            System.out.println(entry.getKey() + " -> " + entry.getValue());
        }
    }
}
```

The difference, once again, is the ordering by key.

---

## 28. When to use `TreeMap`

Use `TreeMap` when you need to:

- store key-value pairs
- have the keys sorted automatically

Typical examples:

- an alphabetical list of products
- a ranking by numeric identifier
- showing data sorted by key without sorting it manually afterwards
- structures where the order by key matters

---

## 29. `LinkedHashMap` vs `TreeMap`

This comparison is very important.

### 29.1. `LinkedHashMap`

Keeps:

- the order in which you inserted the entries

Example:

```text
C -> 3
A -> 1
B -> 2
```

It is iterated like this:

```text
C, A, B
```

### 29.2. `TreeMap`

Keeps:

- the natural order of the keys

With those same keys, it is iterated like this:

```text
A, B, C
```

### 29.3. Rule of thumb

- If you want to keep the insertion order → `LinkedHashMap`
- If you want to sort by key automatically → `TreeMap`

---

## 30. What happens with duplicate keys in `LinkedHashMap` and `TreeMap`

As with any `Map`, keys are unique.

If you repeat a key, the previous value is overwritten.

Example:

```java
Map<String, Integer> ages = new TreeMap<>();

ages.put("Laura", 28);
ages.put("Laura", 29);

System.out.println(ages.get("Laura")); // 29
```

Two entries are not created. Only one remains.

---

## 31. `null` in these collections

### 31.1. `LinkedHashMap`

In many cases it behaves like `HashMap` and lets you work with `null` keys and values.

### 31.2. `TreeMap`

You have to be more careful here.

Since `TreeMap` needs to sort its keys, using `null` as a key can cause problems because it cannot be compared correctly in the natural order.

At this early stage, the best recommendation is:

- avoid using `null` as a key in `TreeMap`
- use comparable, well-defined keys

---

## 32. Iterating over `LinkedHashMap` and `TreeMap`

As with `HashMap`, the most useful way is usually `entrySet()`.

### 32.1. Iterating over a `LinkedHashMap`

```java
Map<String, Integer> ages = new LinkedHashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);
ages.put("Maria", 31);

for (Map.Entry<String, Integer> entry : ages.entrySet()) {
    System.out.println(entry.getKey() + " -> " + entry.getValue());
}
```

### 32.2. Iterating over a `TreeMap`

```java
Map<String, Integer> ages = new TreeMap<>();
ages.put("Maria", 31);
ages.put("Alex", 35);
ages.put("Laura", 28);

for (Map.Entry<String, Integer> entry : ages.entrySet()) {
    System.out.println(entry.getKey() + " -> " + entry.getValue());
}
```

The syntax is the same, but the iteration order changes.

---

## 33. Complete example: unique categories with `Set`

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<String> categories = new HashSet<>();

        categories.add("Technology");
        categories.add("Books");
        categories.add("Technology");
        categories.add("Sports");

        System.out.println("Total categories: " + categories.size());

        for (String category : categories) {
            System.out.println(category);
        }
    }
}
```

Here:

- `"Technology"` only appears once
- the set automatically avoids duplicates

---

## 34. Complete example: insertion history with `LinkedHashMap`

```java
import java.util.LinkedHashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, String> capitals = new LinkedHashMap<>();

        capitals.put("Spain", "Madrid");
        capitals.put("France", "Paris");
        capitals.put("Germany", "Berlin");

        for (Map.Entry<String, String> entry : capitals.entrySet()) {
            System.out.println(entry.getKey() + " -> " + entry.getValue());
        }
    }
}
```

This example keeps the order:

1. Spain
2. France
3. Germany

---

## 35. Complete example: a sorted map with `TreeMap`

```java
import java.util.Map;
import java.util.TreeMap;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> products = new TreeMap<>();

        products.put("Keyboard", 49.99);
        products.put("Mouse", 19.99);
        products.put("Cable", 5.99);
        products.put("Monitor", 199.99);

        for (Map.Entry<String, Double> entry : products.entrySet()) {
            System.out.println("Product: " + entry.getKey() + " | Price: " + entry.getValue());
        }
    }
}
```

Even if you insert them in another order, the result will be sorted by product name.

---

## 36. How to choose the right structure

Here is a very useful rule of thumb.

### 36.1. Use `Set` when

- you don't want duplicates
- you don't need to work by index
- you want to check whether unique elements exist

### 36.2. Use `HashMap` when

- you want key-value pairs
- you don't need order

### 36.3. Use `LinkedHashMap` when

- you want key-value pairs
- you want to keep the insertion order

### 36.4. Use `TreeMap` when

- you want key-value pairs
- you want the keys to be sorted automatically

---

## 37. Common beginner mistakes

### 37.1. Trying to use indexes on a `Set`

This does not exist:

```java
// set.get(0); // error
```

### 37.2. Thinking that `HashSet` keeps the order

You shouldn't assume it does.

### 37.3. Thinking that `LinkedHashMap` sorts alphabetically

It doesn't sort alphabetically by itself.  
It only keeps the insertion order.

### 37.4. Thinking that `TreeMap` preserves the insertion order

No.  
`TreeMap` sorts by key.

### 37.5. Forgetting that the keys in a `Map` are unique

If you repeat the key, you replace the previous value.

---

## 38. Good practices to start with

- Use the interface as the reference type when it makes sense:
  - `Set<String> names = new HashSet<>();`
  - `Map<String, Integer> ages = new LinkedHashMap<>();`
- Choose the collection based on the behavior you need, not out of habit.
- If you need uniqueness, think about `Set`.
- If you need insertion order in a map, think about `LinkedHashMap`.
- If you need order by key, think about `TreeMap`.
- Use clear names like:
  - `uniqueNames`
  - `pricesByProduct`
  - `usersById`
  - `capitalsByCountry`

---

## 39. Things to keep in mind

- `Set` stores unique items.
- `HashSet` does not guarantee order.
- `LinkedHashMap` keeps the insertion order.
- `TreeMap` automatically sorts by key.
- `Map` still uses key-value pairs with unique keys.
- Choosing the right collection makes the code clearer and more useful.

---

## 40. Final summary

In Java there is no single “best” collection for everything.

Each structure is designed for a type of problem.

- `Set` helps you work with unique values
- `LinkedHashMap` helps you keep the order in which you added entries
- `TreeMap` helps you keep the keys sorted automatically

Knowing how to tell these cases apart is very important because, in real projects, choosing the right collection greatly simplifies the code and avoids unnecessary errors.

---
