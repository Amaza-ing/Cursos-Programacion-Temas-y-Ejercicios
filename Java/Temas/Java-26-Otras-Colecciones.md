# Topic 26. Other common Java collections: `Set`, `LinkedHashMap` and `TreeMap`

## 1. Introduction

In the previous topic you learned how to work with `Map` and `HashMap`, a very useful key-value structure when you need to associate data.

But the Java collections library offers more options, and it is important to know them because not all structures behave the same.

In this topic we are going to study three very common collections:

- `Set`
- `LinkedHashMap`
- `TreeMap`

They are all very useful, but each one solves a different problem:

- `Set` is used to save elements **without duplicates**
- `LinkedHashMap` is a map that **maintains insertion order**
- `TreeMap` is a map that **automatically sorts by key**

Learning to choose the right structure is very important in real Java.

In this topic you will learn:

- What is an `Set`
- What is the difference between `HashSet`, `LinkedHashSet` and `TreeSet` at a conceptual level?
- How to use `Set` to avoid duplicates
- What is `LinkedHashMap` and when to use it instead of `HashMap`
- What is `TreeMap` and how it sorts the keys
- How to browse these collections
- What typical mistakes you should avoid

---

[![Other Collections](https://img.youtube.com/vi/BBNZmrhUKtc/0.jpg)](https://www.youtube.com/watch?v=BBNZmrhUKtc&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. The key idea: not all collections do the same

So far you have seen several structures:

- Arrays
- `ArrayList`
- `HashMap`

Each one has a different purpose.

### 2.1. `ArrayList`

Serves for:

- save items in sequence
- allow duplicates
- access by index
- maintain insertion order

Example:

```java
List<String> names = new ArrayList<>();
names.add("Laura");
names.add("Alex");
names.add("Laura");
```

Here the value `"Laura"` can be repeated.

### 2.2. `Set`

Serves for:

- save unique items
- avoid duplicates
- do not work by index

### 23. `Map`

Serves for:

- save key-value pairs
- access by password

Therefore:

- `List` = sorted collection with possible duplicates
- `Set` = collection without duplicates
- `Map` = key-value structure

---

## 3. What is an `Set`

An `Set` is a collection that **does not allow duplicate elements**.

Conceptual example:

```text
["Laura", "Alex", "Laura", "Maria"]
```

In a list that would be valid.

But in an `Set`, the result would be something equivalent to:

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

To work with `Set` and some common implementations, these imports are often used:

```java
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
```

Later you will also see other implementations such as `LinkedHashSet` or `TreeSet`, but in this topic we are going to focus mainly on the general idea of `Set` and on `LinkedHashMap` and `TreeMap`.

---

## 5. Create an `Set`

Usual form:

```java
Set<String> names = new HashSet<>();
```

Here you are saying:

- the collection will save `String`
- will not allow duplicates

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
To insert elements, `add` is used.

```java
Set<String> cities = new HashSet<>();

cities.add("Madrid");
cities.add("Berlin");
cities.add("Paris");
```

If you add a repeated item, `Set` does not save it again.

```java
cities.add("Madrid");
```

The set will still have a single `"Madrid"`.

---

## 7. `add` returns `true` or `false`

This is very useful and is often forgotten.

On an `Set`, `add(...)` returns:

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

Unlike a list, an `Set` does not have positions like `0`, `1`, `2`...

This does not exist:

```java
// names.get(0); // NO
```

On an `Set`:

- you do not access by index
- you loop through the elements
- you check if an element exists
- you add and delete

This makes sense because the goal of an `Set` is not to manage positions, but rather uniqueness.

---

## 9. Basic methods of `Set`

The most important methods when starting out are:

- `add`
- `remove`
- `contains`
- `size`
- `isEmpty`
- `clear`

---

## 10. `contains`

It is used to check if an element is in the set.

```java
Set<String> names = new HashSet<>();
names.add("Laura");
names.add("Alex");

System.out.println(names.contains("Laura")); // true
System.out.println(names.contains("Maria")); // false
```

---

## 11. `remove`

Used to delete an element.

```java
Set<String> names = new HashSet<>();
names.add("Laura");
names.add("Alex");

names.remove("Laura");

System.out.println(names.contains("Laura")); // false
```

Also returns `true` or `false`:

- `true` if removed
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

## 13. Loop through an `Set`

Since there are no indexes, it is usually traversed with `for-each`.

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

## 14. Order on `HashSet`

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

- don't assume insertion order
- do not use `HashSet` if you need a specific order

---

## 15. When to use an `Set`

An `Set` is ideal when you want:

- avoid duplicates
- quickly check if something already exists
- work with a collection of unique items

Typical examples:

- unique logged in users
- unrepeated product categories
- unique words in a text
- registered emails without duplicates

---

## 16. Guided Example: Remove Duplicates from a List

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
- `Set` removes duplicates automatically

---

## 17. Guided Example: Detect if a value has already appeared

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

## 18. Important Variants of `Set`

Although `Set` is the interface, there are several implementations.

At an initial level, it is advisable that you have this mental idea:

- `HashSet` → does not guarantee order
- `LinkedHashSet` → maintains insertion order
- `TreeSet` → order automatically
In this topic we are not going to delve into all of them, but it is important that you know that they exist because they follow the same logic that you will see now with `LinkedHashMap` and `TreeMap`.

---

## 19. What is `LinkedHashMap`

In the previous topic you saw `HashMap`, which:

- saves key-value pairs
- allows quick search by key
- **does not guarantee order**

`LinkedHashMap` is very similar to `HashMap`, but with one key difference:

> `LinkedHashMap` maintains the insertion order.

That is, if you insert:

```text
"Laura" -> 28
"Alex"  -> 35
"Maria" -> 31
```

When you go around the map, they will appear in that same order.

---

## 20. Create an `LinkedHashMap`

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

## 21. `LinkedHashMap` has almost the same usage as `HashMap`

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

The big difference is not in the methods, but in the behavior of the order.

---

## 22. When to use `LinkedHashMap`

Use `LinkedHashMap` when you need to:

- associate key and value
- maintain the order in which you inserted the entries

Typical examples:

- display data in the same order it was loaded
- generate menus or ordered settings
- store insert history
- have more predictable behavior when printing or scrolling

---

## 23. `HashMap` vs `LinkedHashMap`

### 23.1. `HashMap`

- key-value structure
- does not guarantee order

### 23.2. `LinkedHashMap`

- key-value structure
- maintains insertion order

Comparative example:

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

At `hashMap`, you should not assume anything.

---

## 24. What is `TreeMap`

`TreeMap` is another implementation of `Map`, but with a very important difference:

> `TreeMap` automatically sorts entries by key.

Not by the insertion order, but by the **natural order of the keys**.

Example with `String` keys:

- `"A"`
- `"B"`
- `"C"`

Example with `Integer` keys:

- `1`
- `2`
- `3`

---

## 25. Create an `TreeMap`

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

Although you inserted in a different order, `TreeMap` organizes by key.

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

The main methods are the same as other maps:

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

The difference is still the order by key.

---

## 28. When to use `TreeMap`

Use `TreeMap` when you need to:

- store key-value pairs
- have the keys sorted automatically

Typical examples:

- alphabetical list of products
- ranking by numerical identifier
- show data sorted by key without manually sorting after
- structures where order by key is important

---

## 29. `LinkedHashMap` vs `TreeMap`

This comparison is very important.

### 29.1. `LinkedHashMap`

Maintains:

- the order in which you inserted the entries

Example:

```text
C -> 3
A -> 1
B -> 2
```

It goes like this:

```text
C, A, B
```

### 29.2. `TreeMap`

Maintains:

- the natural order of the keys

With those same keys, it goes like this:

```text
A, B, C
```

### 29.3. Rule of thumb

- If you want to keep the insertion order → `LinkedHashMap`
- If you want to sort by key automatically → `TreeMap`

---

## 30. What happens with duplicate keys in `LinkedHashMap` and `TreeMap`

As with any `Map`, the keys are unique.

If you repeat a key, the previous value is overwritten.

Example:

```java
Map<String, Integer> ages = new TreeMap<>();

ages.put("Laura", 28);
ages.put("Laura", 29);

System.out.println(ages.get("Laura")); // 29
```

Two entries are not created. There's only one left.

---

## 31. `null` in these collections

### 31.1. `LinkedHashMap`

It behaves similar to `HashMap` in many cases and allows working with `null` in key and values.

### 31.2. `TreeMap`

You have to be more careful here.

Since `TreeMap` needs to order keys, using `null` as a key can cause problems because it cannot be compared correctly in the natural order.

At an initial level, the best recommendation is:

- avoid using `null` as key in `TreeMap`
- use comparable and well-defined keys

---

## 32. Loop through `LinkedHashMap` and `TreeMap`

As with `HashMap`, the most useful form is usually `entrySet()`.

### 32.1. `LinkedHashMap` Walkthrough

```java
Map<String, Integer> ages = new LinkedHashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);
ages.put("Maria", 31);

for (Map.Entry<String, Integer> entry : ages.entrySet()) {
    System.out.println(entry.getKey() + " -> " + entry.getValue());
}
```

### 32.2. `TreeMap` Walkthrough

```java
Map<String, Integer> ages = new TreeMap<>();
ages.put("Maria", 31);
ages.put("Alex", 35);
ages.put("Laura", 28);

for (Map.Entry<String, Integer> entry : ages.entrySet()) {
    System.out.println(entry.getKey() + " -> " + entry.getValue());
}
```

The syntax is the same, but the traversal order changes.

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

## 34. Complete Example: Push History with `LinkedHashMap`

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

This example maintains the order:

1. Spain
2. France
3.Germany

---

## 35. Complete example: map sorted with `TreeMap`

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

Even if you insert in another order, the result will be ordered by product name.

---

## 36. How to choose the right structure

Here you have a very useful mental guide.

### 36.1. Use `Set` when

- you don't want duplicates
- you don't mind working by index
- you want to check existence of unique elements

### 36.2. Use `HashMap` when

- you want key-value pairs
- you don't need order

### 36.3. Use `LinkedHashMap` when

- you want key-value pairs
- you want to maintain the insertion order

### 36.4. Use `TreeMap` when

- you want key-value pairs
- you want the keys to be sorted automatically

---

## 37. Typical mistakes when starting

### 37.1. Trying to use indexes on an `Set`

This does not exist:

```java
// set.get(0); // error
```

### 37.2. Thinking that `HashSet` maintains order

You shouldn't assume it.

### 37.3. Thinking that `LinkedHashMap` sorts alphabetically

It doesn't sort alphabetically by itself.  
It only maintains the insertion order.
### 37.4. Thinking that `TreeMap` preserves insertion order

No.  
`TreeMap` sort by key.

### 37.5. Forgetting that the keys in an `Map` are unique

If you repeat the key, you replace the previous value.

---

## 38. Good initial practices

- Use interface as a reference type when it makes sense:
  - `Set<String> names = new HashSet<>();`
  -`Map<String, Integer> ages = new LinkedHashMap<>();`
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

## 39. To take into account

- `Set` saves unique items.
- `HashSet` does not guarantee order.
- `LinkedHashMap` maintains insertion order.
- `TreeMap` automatically sorts by key.
- `Map` still uses key-value pairs with unique keys.
- Choosing the collection well makes the code clearer and more useful.

---

## 40. Final summary

In Java there is no single “best” collection for everything.

Each structure is designed for a type of problem.

- `Set` helps you work with unique securities
- `LinkedHashMap` helps you keep the order in which you added entries
- `TreeMap` helps you have keys automatically sorted

Knowing how to distinguish these cases is very important because, in real projects, choosing the appropriate collection greatly simplifies the code and avoids unnecessary errors.

---
