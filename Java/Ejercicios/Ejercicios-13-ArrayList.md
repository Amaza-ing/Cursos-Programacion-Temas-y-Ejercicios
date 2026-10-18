# Exercises - Topic 13: `List` and `ArrayList`

Below you will find **10 practical exercises** on **`List` and `ArrayList`**: creation, generics, `add/get/set/remove`, searches, tours, `size`, `isEmpty`, `contains/indexOf`, conversions and typical cases with `List<Integer>`.

Try to solve them before consulting the solution.

---

## Exercise 1: Create a list and add items

Create an `List<String> animals` list.

1. Add `"Dog"`, `"Cat"`, `"Bird"` (in that order).
2. Print the entire list.
3. Print the size of the list.

<details><summary>Show solution</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> animals = new ArrayList<>();

        animals.add("Dog");
        animals.add("Cat");
        animals.add("Bird");

        System.out.println(animals);
        System.out.println(animals.size());
    }
}
```


</details>

---

## Exercise 2: Index access with `get`

Create an `List<Integer> numbers` list and add these values:

`12`, `5`, `30`, `7`.

Print:

- The first element
- The last element (without writing the index by hand)

<details><summary>Show solution</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = new ArrayList<>();
        numbers.add(12);
        numbers.add(5);
        numbers.add(30);
        numbers.add(7);

        System.out.println(numbers.get(0));
        System.out.println(numbers.get(numbers.size() - 1));
    }
}
```


</details>

---

## Exercise 3: Insert at a specific position (`add(index, value)`)

Create an `List<String> cities` list with:

- `"Madrid"`
- `"Paris"`
- `"Rome"`

Insert `"Berlin"` in position 1.  
Print the list to check the final order.

<details><summary>Show solution</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> cities = new ArrayList<>();
        cities.add("Madrid");
        cities.add("Paris");
        cities.add("Rome");

        cities.add(1, "Berlin");

        System.out.println(cities);
    }
}
```


</details>

---

## Exercise 4: Replace an element with `set`

Create an `List<String> tasks` list with:

- `"Study"`
- `"Train"`
- `"Cook"`

Replace `"Train"` with `"Practice Java"` using `set`.  
Print the final list.

<details><summary>Show solution</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> tasks = new ArrayList<>();
        tasks.add("Study");
        tasks.add("Train");
        tasks.add("Cook");

        tasks.set(1, "Practice Java");

        System.out.println(tasks);
    }
}
```


</details>

---

## Exercise 5: Delete by index and by value

Create an `List<String> fruits` list with:

- `"Apple"`
- `"Banana"`
- `"Orange"`
- `"Banana"`

1. Delete index element 2.
2. Remove the **first** occurrence of `"Banana"` by value.
3. Print the final list.

<details><summary>Show solution</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> fruits = new ArrayList<>();
        fruits.add("Apple");
        fruits.add("Banana");
        fruits.add("Orange");
        fruits.add("Banana");

        fruits.remove(2);
        fruits.remove("Banana");

        System.out.println(fruits);
    }
}
```


</details>

---

## Exercise 6: Loop through a list and add values

Create an `List<Integer> values` list with:

`3`, `8`, `2`, `10`.

Scan it with an `for-each` and calculate the total sum.  
Print the result.

<details><summary>Show solution</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> values = new ArrayList<>();
        values.add(3);
        values.add(8);
        values.add(2);
        values.add(10);

        int sum = 0;

        for (Integer value : values) {
            sum += value;
        }

        System.out.println(sum);
    }
}
```


</details>

---

## Exercise 7: Search with `contains` and `indexOf`

Create an `List<String> names` list with:

- `"laura"`
- `"alex"`
- `"maria"`

Create a variable `String input = "Alex"` and check if it exists in the list ignoring case.

If it exists, it prints `"Found at: X"` where X is its index.  
If it does not exist, print `"Not found"`.

<details><summary>Show solution</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = new ArrayList<>();
        names.add("laura");
        names.add("alex");
        names.add("maria");

        String input = "Alex";
        String normalized = input.toLowerCase();

        if (names.contains(normalized)) {
            int index = names.indexOf(normalized);
            System.out.println("Found at: " + index);
        } else {
            System.out.println("Not found");
        }
    }
}
```


</details>

---

## Exercise 8: `List<Integer>` and `remove` (special case)

Create an `List<Integer> numbers` list with:

`10`, `20`, `30`, `20`.

Removes the `20` value **by value** (not by index) and displays the final list.

<details><summary>Show solution</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = new ArrayList<>();
        numbers.add(10);
        numbers.add(20);
        numbers.add(30);
        numbers.add(20);

        numbers.remove(Integer.valueOf(20));

        System.out.println(numbers);
    }
}
```


</details>

---

## Exercise 9: Convert an array to modifiable `ArrayList`

Declare an array:

```java
String[] data = {"A", "B", "C"};
```


Converts that array into a **modifiable** list (not immutable).

1. Add `"D"` to the list.
2. Print the list.

<details><summary>Show solution</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        String[] data = {"A", "B", "C"};

        List<String> list = new ArrayList<>(List.of(data));
        list.add("D");

        System.out.println(list);
    }
}
```


</details>

---

## Exercise 10: Method that works with `List<String>`

Create a method:

```java
public static int countLongWords(List<String> words, int minLength)
```


You must count how many words are **greater than or equal to** length than `minLength`.

In `main`, create a list with:

- `"java"`
- `"collections"`
- `"list"`
- `"arraylist"`

Call the method with `minLength = 5` and print the result.

<details><summary>Show solution</summary>

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> words = new ArrayList<>();
        words.add("java");
        words.add("collections");
        words.add("list");
        words.add("arraylist");

        int result = countLongWords(words, 5);
        System.out.println(result);
    }

    public static int countLongWords(List<String> words, int minLength) {
        int count = 0;

        for (String word : words) {
            if (word.length() >= minLength) {
                count++;
            }
        }

        return count;
    }
}
```


</details>

---
