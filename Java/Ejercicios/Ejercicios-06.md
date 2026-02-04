# Ejercicios - Tema 6: Bucles (while y for)

A continuación encontrarás **10 ejercicios prácticos** sobre el uso de bucles `while`, `do-while` y `for`.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Contar del 1 al 10 con `while`

Escribe un programa que muestre por consola los números del **1 al 10** usando un bucle `while`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int i = 1;

        while (i <= 10) {
            System.out.println(i);
            i++;
        }
    }
}
```

</details>

---

## Ejercicio 2: Contar del 10 al 1 con `for`

Muestra por consola los números del **10 al 1** usando un bucle `for`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 10; i >= 1; i--) {
            System.out.println(i);
        }
    }
}
```

</details>

---

## Ejercicio 3: Mostrar solo números pares

Usa un bucle `for` para mostrar por consola los números **pares del 1 al 20**.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 20; i++) {
            if (i % 2 == 0) {
                System.out.println(i);
            }
        }
    }
}
```

</details>

---

## Ejercicio 4: Sumar números del 1 al 100

Calcula la **suma de los números del 1 al 100** usando un bucle.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int sum = 0;

        for (int i = 1; i <= 100; i++) {
            sum += i;
        }

        System.out.println(sum);
    }
}
```

</details>

---

## Ejercicio 5: Contar cuántos múltiplos de 3 hay entre 1 y 50

Usa un bucle para contar cuántos números entre **1 y 50** son múltiplos de 3.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int count = 0;

        for (int i = 1; i <= 50; i++) {
            if (i % 3 == 0) {
                count++;
            }
        }

        System.out.println(count);
    }
}
```

</details>

---

## Ejercicio 6: Repetir un mensaje 5 veces con `do-while`

Muestra el mensaje `"Learning Java"` **5 veces** usando un bucle `do-while`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int i = 0;

        do {
            System.out.println("Learning Java");
            i++;
        } while (i < 5);
    }
}
```

</details>

---

## Ejercicio 7: Calcular el factorial de un número

Declara una variable `number` con valor `5` y calcula su **factorial** usando un bucle.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int number = 5;
        int result = 1;

        for (int i = 1; i <= number; i++) {
            result *= i;
        }

        System.out.println(result);
    }
}
```

</details>

---

## Ejercicio 8: Sumar solo los números impares del 1 al 20

Usa un bucle para sumar únicamente los **números impares** entre 1 y 20.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int sum = 0;

        for (int i = 1; i <= 20; i++) {
            if (i % 2 != 0) {
                sum += i;
            }
        }

        System.out.println(sum);
    }
}
```

</details>

---

## Ejercicio 9: Contar caracteres de una cadena

Declara una variable `text` con el valor `"Java"` y usa un bucle para contar cuántos caracteres tiene.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String text = "Java";
        int count = 0;

        for (int i = 0; i < text.length(); i++) {
            count++;
        }

        System.out.println(count);
    }
}
```

</details>

---

## Ejercicio 10: Simular intentos hasta alcanzar un valor

Declara una variable `progress` que empiece en `0`.  
En cada iteración aumenta su valor en `15` hasta que llegue o supere `100`.  
Muestra cuántos intentos han sido necesarios.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int progress = 0;
        int attempts = 0;

        while (progress < 100) {
            progress += 15;
            attempts++;
        }

        System.out.println("Attempts: " + attempts);
    }
}
```

</details>

---
