# Ejercicios - Tema 12: Arrays

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **arrays**: creación, acceso por índice, modificación, `length` y recorridos con bucles.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear un array y mostrar su tamaño

Crea un array `int[] numbers` con tamaño `5`.  
Imprime el valor de `numbers.length`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] numbers = new int[5];
        System.out.println(numbers.length);
    }
}
```

</details>

---

## Ejercicio 2: Inicialización literal y acceso a elementos

Crea un array `String[] colors` con estos valores:

- `"Blue"`, `"Orange"`, `"Purple"`

Imprime el primer y el último elemento.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String[] colors = {"Blue", "Orange", "Purple"};

        System.out.println(colors[0]);
        System.out.println(colors[colors.length - 1]);
    }
}
```

</details>

---

## Ejercicio 3: Modificar un elemento del array

Crea un array `int[] scores` con valores `{10, 20, 30, 40}`.

Cambia el valor de la segunda posición (índice 1) a `25` e imprime el array completo usando un bucle.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] scores = {10, 20, 30, 40};

        scores[1] = 25;

        for (int i = 0; i < scores.length; i++) {
            System.out.println(scores[i]);
        }
    }
}
```

</details>

---

## Ejercicio 4: Sumar todos los elementos de un array

Declara `int[] values = {3, 6, 2, 9}` y calcula la suma total con un bucle.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] values = {3, 6, 2, 9};
        int sum = 0;

        for (int i = 0; i < values.length; i++) {
            sum += values[i];
        }

        System.out.println(sum);
    }
}
```

</details>

---

## Ejercicio 5: Encontrar el valor máximo

Declara `int[] values = {7, 3, 11, 2, 9}`.

Encuentra el valor máximo usando un bucle y muestra el resultado.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] values = {7, 3, 11, 2, 9};

        int max = values[0];

        for (int i = 1; i < values.length; i++) {
            if (values[i] > max) {
                max = values[i];
            }
        }

        System.out.println(max);
    }
}
```

</details>

---

## Ejercicio 6: Contar valores mayores que un número

Declara `int[] values = {5, 12, 3, 18, 9}` y cuenta cuántos valores son mayores que `10`.

Imprime el contador final.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] values = {5, 12, 3, 18, 9};
        int count = 0;

        for (int i = 0; i < values.length; i++) {
            if (values[i] > 10) {
                count++;
            }
        }

        System.out.println(count);
    }
}
```

</details>

---

## Ejercicio 7: Crear un array y rellenarlo con un patrón

Crea un array `int[] numbers` de tamaño `6`.

Rellénalo con los valores:

```
2, 4, 6, 8, 10, 12
```

Imprime todos los valores con un bucle.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] numbers = new int[6];

        for (int i = 0; i < numbers.length; i++) {
            numbers[i] = (i + 1) * 2;
        }

        for (int i = 0; i < numbers.length; i++) {
            System.out.println(numbers[i]);
        }
    }
}
```

</details>

---

## Ejercicio 8: Buscar un valor y detenerse al encontrarlo

Declara `int[] values = {4, 8, 15, 16, 23, 42}` y una variable `target` con valor `16`.

Recorre el array y cuando encuentres el valor, imprime `"Found"` y detén el bucle.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] values = {4, 8, 15, 16, 23, 42};
        int target = 16;

        for (int i = 0; i < values.length; i++) {
            if (values[i] == target) {
                System.out.println("Found");
                break;
            }
        }
    }
}
```

</details>

---

## Ejercicio 9: Método que recibe un array

Crea un método `printFirstAndLast` que reciba `int[] values` e imprima:

- El primer elemento
- El último elemento

Llama al método desde `main` con un array de ejemplo.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] values = {10, 20, 30, 40};
        printFirstAndLast(values);
    }

    public static void printFirstAndLast(int[] values) {
        int first = values[0];
        int last = values[values.length - 1];

        System.out.println(first);
        System.out.println(last);
    }
}
```

</details>

---

## Ejercicio 10: Copiar valores a otro array

Declara `int[] source = {2, 4, 6, 8}` y crea un array `int[] copy` del mismo tamaño.

Copia todos los valores de `source` a `copy` usando un bucle.

Imprime `copy` para comprobarlo.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] source = {2, 4, 6, 8};
        int[] copy = new int[source.length];

        for (int i = 0; i < source.length; i++) {
            copy[i] = source[i];
        }

        for (int i = 0; i < copy.length; i++) {
            System.out.println(copy[i]);
        }
    }
}
```

</details>

---
