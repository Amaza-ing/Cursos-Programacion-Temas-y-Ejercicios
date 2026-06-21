# Ejercicios - Tema 1: Qué es Java y primer programa con IntelliJ

A continuación, encontrarás **4 ejercicios prácticos** relacionados con el primer contacto con Java, el entorno IntelliJ y la estructura básica de un programa.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Identificar los elementos de un programa Java

Observa el siguiente código:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, Java!");
    }
}
```

Indica:

- El nombre de la clase
- El nombre del método principal
- Qué línea muestra texto por consola

No modifiques el código, solo analízalo.

<details><summary>Mostrar Solución</summary>

- La clase se llama `Main`.
- El método principal es `main`.
- La línea que muestra texto por consola es:

```java
System.out.println("Hello, Java!");
```

</details>

---

## Ejercicio 2: Cambiar el texto que se muestra por consola

Partiendo de este programa:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, Java!");
    }
}
```

Modifica el texto para que muestre el mensaje:

```
My first Java program
```

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("My first Java program");
    }
}
```

</details>

---

## Ejercicio 3: Mostrar varios mensajes por consola

Escribe un programa que muestre **tres líneas distintas** por consola:

- Tu nombre
- El nombre del lenguaje (`Java`)
- El mensaje `Learning programming`

Cada mensaje debe aparecer en una línea diferente.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Alex");
        System.out.println("Java");
        System.out.println("Learning programming");
    }
}
```

</details>

---

## Ejercicio 4: Reconocer errores básicos

Este código no es correcto. Léelo y responde:

```java
public class main {
    public static void Main(String args) {
        system.out.println("Hello");
    }
}
```

Indica **al menos tres errores** que impedirían que el programa se ejecute correctamente.

<details><summary>Mostrar Solución</summary>

Errores del código:

1. El nombre de la clase debe empezar por mayúscula: `Main`.
2. El método principal debe llamarse exactamente `main` (minúsculas).
3. La firma correcta es `public static void main(String[] args)`.
4. `System` debe escribirse con mayúscula.
5. Falta `[]` en `String[] args`.

Una versión corregida sería:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello");
    }
}
```

</details>

---
