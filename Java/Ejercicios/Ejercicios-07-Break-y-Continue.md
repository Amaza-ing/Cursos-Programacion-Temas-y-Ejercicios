# Ejercicios - Tema 7: Control del flujo en bucles (`break` y `continue`)

A continuación encontrarás **10 ejercicios prácticos** para aprender a usar `break` y `continue` dentro de bucles `for` y `while`.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Detener un bucle al llegar a un valor

Usa un bucle `for` del 1 al 20.  
Cuando el contador llegue a `13`, muestra `"Found 13"` y detén el bucle.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 20; i++) {
            if (i == 13) {
                System.out.println("Found 13");
                break;
            }
        }
    }
}
```

</details>

---

## Ejercicio 2: Saltar números múltiplos de 4

Usa un bucle `for` del 1 al 30.  
No debes imprimir los números que sean múltiplos de `4`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 30; i++) {
            if (i % 4 == 0) {
                continue;
            }

            System.out.println(i);
        }
    }
}
```

</details>

---

## Ejercicio 3: Buscar el primer múltiplo de 7

Usa un bucle `for` del 1 al 100.  
Encuentra el **primer** múltiplo de `7`, imprímelo y sal del bucle.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 100; i++) {
            if (i % 7 == 0) {
                System.out.println(i);
                break;
            }
        }
    }
}
```

</details>

---

## Ejercicio 4: Ignorar el cero para evitar división entre cero

Usa un bucle `for` desde `-5` hasta `5`.  
Imprime el resultado de `50 / i`, pero **no** debes dividir entre 0.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        for (int i = -5; i <= 5; i++) {
            if (i == 0) {
                continue;
            }

            System.out.println("50 / " + i + " = " + (50 / i));
        }
    }
}
```

</details>

---

## Ejercicio 5: Contar solo números que cumplen condición (usando `continue`)

Usa un bucle del 1 al 50 y cuenta cuántos números son:

- múltiplos de 3
- pero NO múltiplos de 6

Imprime el contador final.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int count = 0;

        for (int i = 1; i <= 50; i++) {
            if (i % 3 != 0) {
                continue;
            }

            if (i % 6 == 0) {
                continue;
            }

            count++;
        }

        System.out.println(count);
    }
}
```

</details>

---

## Ejercicio 6: Bucle `while (true)` con salida controlada

Crea un bucle infinito (`while (true)`) que aumente una variable `attempts` desde 1.  
Cuando `attempts` llegue a `5`, muestra `"Stop"` y termina el bucle.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int attempts = 0;

        while (true) {
            attempts++;

            if (attempts == 5) {
                System.out.println("Stop");
                break;
            }
        }
    }
}
```

</details>

---

## Ejercicio 7: Saltar una iteración con `continue` en `while`

Usa un bucle `while` para contar del 1 al 15.  
No imprimas los números impares (solo deben mostrarse pares).

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int i = 1;

        while (i <= 15) {
            if (i % 2 != 0) {
                i++;
                continue;
            }

            System.out.println(i);
            i++;
        }
    }
}
```

</details>

---

## Ejercicio 8: Detener al encontrar un carácter

Declara una variable `text` con valor `"java_programming"`.  
Recorre sus caracteres con un bucle y detente cuando encuentres el carácter `'_'`.  
Imprime `"Underscore found"` justo antes de salir.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String text = "java_programming";

        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);

            if (c == '_') {
                System.out.println("Underscore found");
                break;
            }
        }
    }
}
```

</details>

---

## Ejercicio 9: Sumar solo valores válidos

Declara un array:

```java
int[] values = {3, 0, 5, -2, 0, 7};
```

Recorre el array y suma únicamente los valores que sean **mayores que 0**.  
Usa `continue` para ignorar el resto.

Imprime la suma final.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] values = {3, 0, 5, -2, 0, 7};
        int sum = 0;

        for (int i = 0; i < values.length; i++) {
            if (values[i] <= 0) {
                continue;
            }

            sum += values[i];
        }

        System.out.println(sum);
    }
}
```

</details>

---

## Ejercicio 10: Parar cuando la suma supere un límite

Declara un array:

```java
int[] values = {10, 20, 15, 30, 5};
```

Recorre el array sumando valores en orden.  
Cuando la suma sea **mayor que 40**, detén el bucle con `break`.  
Imprime la suma alcanzada.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int[] values = {10, 20, 15, 30, 5};
        int sum = 0;

        for (int i = 0; i < values.length; i++) {
            sum += values[i];

            if (sum > 40) {
                break;
            }
        }

        System.out.println(sum);
    }
}
```

</details>

---
