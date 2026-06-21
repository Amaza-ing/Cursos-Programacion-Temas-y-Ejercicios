# Ejercicios - Tema 28: Genéricos

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **clases genéricas, métodos genéricos, comodines, `extends`, `super` y seguridad de tipos**.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Clase genérica

Crea `Container<T>`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 2: Usar varios tipos

Usa `Container` con distintos tipos.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 3: Dos parámetros

Crea `Entry<K, V>`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 4: Método genérico

Crea `printTwice(T value)`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 5: Último elemento

Crea `getLast(List<T> values)`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 6: Comodín `?`

Crea `printItems(List<?> items)`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 7: `extends Number`

Crea `average(List<? extends Number>)`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 8: `super Integer`

Añade enteros a una lista `List<? super Integer>`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 9: Límite genérico

Crea `NumberBox<T extends Number>`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 10: Método `swap`

Intercambia dos posiciones de un array genérico.

<details><summary>Mostrar solución</summary>

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
