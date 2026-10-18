# Exercises - Topic 28: Generics

Below you will find **10 practical exercises** to work with **generic classes, generic methods, wildcards, `extends`, `super` and type safety**.

Try to solve them before looking at the solution.

---

## Exercise 1: Generic class

Create `Container<T>`.

<details><summary>Show solution</summary>

```java
public class Container<T> {
    private T value;

    public Container(T value) {
        this.value = value;
    }

    public T getValue() {
        return value;
    }

    public void setValue(T value) {
        this.value = value;
    }
}
```

</details>

---

## Exercise 2: Use several types

Use `Container` with different types.

<details><summary>Show solution</summary>

```java
public class Main {
    public static void main(String[] args) {
        Container<String> text = new Container<>("Hello");
        Container<Integer> number = new Container<>(42);
        System.out.println(text.getValue());
        System.out.println(number.getValue());
    }
}
```

</details>

---

## Exercise 3: Two parameters

Create `Entry<K, V>`.

<details><summary>Show solution</summary>

```java
public class Entry<K, V> {
    private K key;
    private V value;

    public Entry(K key, V value) {
        this.key = key;
        this.value = value;
    }

    public K getKey() { return key; }
    public V getValue() { return value; }
}
```

</details>

---

## Exercise 4: Generic method

Create `printTwice(T value)`.

<details><summary>Show solution</summary>

```java
public class Main {
    public static <T> void printTwice(T value) {
        System.out.println(value);
        System.out.println(value);
    }
}
```

</details>

---

## Exercise 5: Last element

Create `getLast(List<T> values)`.

<details><summary>Show solution</summary>

```java
import java.util.List;

public class Main {
    public static <T> T getLast(List<T> values) {
        return values.get(values.size() - 1);
    }
}
```

</details>

---

## Exercise 6: The `?` wildcard

Create `printItems(List<?> items)`.

<details><summary>Show solution</summary>

```java
import java.util.List;

public class Main {
    public static void printItems(List<?> items) {
        for (Object item : items) {
            System.out.println(item);
        }
    }
}
```

</details>

---

## Exercise 7: `extends Number`

Create `average(List<? extends Number>)`.

<details><summary>Show solution</summary>

```java
import java.util.List;

public class Main {
    public static double average(List<? extends Number> numbers) {
        double sum = 0;
        for (Number number : numbers) {
            sum += number.doubleValue();
        }
        return sum / numbers.size();
    }
}
```

</details>

---

## Exercise 8: `super Integer`

Add integers to a `List<? super Integer>` list.

<details><summary>Show solution</summary>

```java
import java.util.List;

public class Main {
    public static void addDefaultNumbers(List<? super Integer> values) {
        values.add(1);
        values.add(2);
        values.add(3);
    }
}
```

</details>

---

## Exercise 9: Generic bound

Create `NumberBox<T extends Number>`.

<details><summary>Show solution</summary>

```java
public class NumberBox<T extends Number> {
    private T value;

    public NumberBox(T value) {
        this.value = value;
    }

    public double doubleValue() {
        return value.doubleValue();
    }
}
```

</details>

---

## Exercise 10: `swap` method

Swap two positions of a generic array.

<details><summary>Show solution</summary>

```java
public class Main {
    public static <T> void swap(T[] array, int firstIndex, int secondIndex) {
        T temp = array[firstIndex];
        array[firstIndex] = array[secondIndex];
        array[secondIndex] = temp;
    }
}
```

</details>

---
