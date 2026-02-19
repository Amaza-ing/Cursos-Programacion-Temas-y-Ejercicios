# Ejercicios - Tema 13: `List` y `ArrayList`

A continuación encontrarás **10 ejercicios prácticos** sobre **`List` y `ArrayList`**: creación, genéricos, `add/get/set/remove`, búsquedas, recorridos, `size`, `isEmpty`, `contains/indexOf`, conversiones y casos típicos con `List<Integer>`.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear una lista y añadir elementos

Crea una lista `List<String> animals`.

1. Añade `"Dog"`, `"Cat"`, `"Bird"` (en ese orden).
2. Imprime la lista completa.
3. Imprime el tamaño de la lista.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 2: Acceso por índice con `get`

Crea una lista `List<Integer> numbers` y añade estos valores:

`12`, `5`, `30`, `7`.

Imprime:

- El primer elemento
- El último elemento (sin escribir el índice a mano)

<details><summary>Mostrar solución</summary>

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

## Ejercicio 3: Insertar en una posición concreta (`add(index, value)`)

Crea una lista `List<String> cities` con:

- `"Madrid"`
- `"Paris"`
- `"Rome"`

Inserta `"Berlin"` en la posición 1.  
Imprime la lista para comprobar el orden final.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 4: Reemplazar un elemento con `set`

Crea una lista `List<String> tasks` con:

- `"Study"`
- `"Train"`
- `"Cook"`

Reemplaza `"Train"` por `"Practice Java"` usando `set`.  
Imprime la lista final.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 5: Eliminar por índice y por valor

Crea una lista `List<String> fruits` con:

- `"Apple"`
- `"Banana"`
- `"Orange"`
- `"Banana"`

1. Elimina el elemento de índice 2.
2. Elimina la **primera** aparición de `"Banana"` por valor.
3. Imprime la lista final.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 6: Recorrer una lista y sumar valores

Crea una lista `List<Integer> values` con:

`3`, `8`, `2`, `10`.

Recórrela con un `for-each` y calcula la suma total.  
Imprime el resultado.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 7: Buscar con `contains` e `indexOf`

Crea una lista `List<String> names` con:

- `"laura"`
- `"alex"`
- `"maria"`

Crea una variable `String input = "Alex"` y comprueba si existe en la lista ignorando mayúsculas/minúsculas.

Si existe, imprime `"Found at: X"` donde X es su índice.  
Si no existe, imprime `"Not found"`.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 8: `List<Integer>` y `remove` (caso especial)

Crea una lista `List<Integer> numbers` con:

`10`, `20`, `30`, `20`.

Elimina el valor `20` **por valor** (no por índice) y muestra la lista final.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 9: Convertir un array a `ArrayList` modificable

Declara un array:

```java
String[] data = {"A", "B", "C"};
```

Convierte ese array en una lista **modificable** (no inmutable).

1. Añade `"D"` a la lista.
2. Imprime la lista.

<details><summary>Mostrar solución</summary>

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

## Ejercicio 10: Método que trabaja con `List<String>`

Crea un método:

```java
public static int countLongWords(List<String> words, int minLength)
```

Debe contar cuántas palabras tienen longitud **mayor o igual** que `minLength`.

En `main`, crea una lista con:

- `"java"`
- `"collections"`
- `"list"`
- `"arraylist"`

Llama al método con `minLength = 5` e imprime el resultado.

<details><summary>Mostrar solución</summary>

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
