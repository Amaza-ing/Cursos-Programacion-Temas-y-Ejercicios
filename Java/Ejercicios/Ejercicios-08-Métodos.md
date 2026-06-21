# Ejercicios - Tema 8: Métodos

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **métodos**, parámetros, argumentos y valores de retorno.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Método sin parámetros ni retorno

Crea un método llamado `printHello` que muestre por consola el mensaje `"Hello Java"`.  
Llama al método desde `main`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        printHello();
    }

    public static void printHello() {
        System.out.println("Hello Java");
    }
}
```

</details>

---

## Ejercicio 2: Método con un parámetro

Crea un método `printName` que reciba un `String` llamado `name` y muestre  
`"Name: <name>"`.

Llama al método pasando `"Laura"` como argumento.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        printName("Laura");
    }

    public static void printName(String name) {
        System.out.println("Name: " + name);
    }
}
```

</details>

---

## Ejercicio 3: Método con dos parámetros y `return`

Crea un método `sum` que reciba dos `int` y devuelva su suma.  
Guarda el resultado en una variable y muéstralo por consola.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int result = sum(4, 6);
        System.out.println(result);
    }

    public static int sum(int a, int b) {
        return a + b;
    }
}
```

</details>

---

## Ejercicio 4: Método que devuelve `boolean`

Crea un método `isAdult` que reciba una edad (`int`) y devuelva `true` si es mayor o igual a 18.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        boolean result = isAdult(20);
        System.out.println(result);
    }

    public static boolean isAdult(int age) {
        return age >= 18;
    }
}
```

</details>

---

## Ejercicio 5: Método que construye un `String`

Crea un método `buildMessage` que reciba un nombre y una edad, y devuelva un texto con el formato:

```
Name: Laura | Age: 28
```

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        String message = buildMessage("Laura", 28);
        System.out.println(message);
    }

    public static String buildMessage(String name, int age) {
        return "Name: " + name + " | Age: " + age;
    }
}
```

</details>

---

## Ejercicio 6: Método que usa otro método

Crea un método `doubleNumber` que devuelva el doble de un número.  
Luego crea otro método `printDouble` que use `doubleNumber` para imprimir el resultado.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        printDouble(7);
    }

    public static int doubleNumber(int number) {
        return number * 2;
    }

    public static void printDouble(int number) {
        int result = doubleNumber(number);
        System.out.println(result);
    }
}
```

</details>

---

## Ejercicio 7: Método con condición y `return` anticipado

Crea un método `clampToZero` que reciba un `int`.  
Si el valor es negativo, devuelve `0`.  
Si no, devuelve el valor original.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(clampToZero(-5));
        System.out.println(clampToZero(10));
    }

    public static int clampToZero(int value) {
        if (value < 0) {
            return 0;
        }

        return value;
    }
}
```

</details>

---

## Ejercicio 8: Método con `double` y cálculo

Crea un método `calculateArea` que reciba el radio de un círculo (`double`)  
y devuelva el área (`π * r * r`). Usa `Math.PI`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        double area = calculateArea(3.0);
        System.out.println(area);
    }

    public static double calculateArea(double radius) {
        return Math.PI * radius * radius;
    }
}
```

</details>

---

## Ejercicio 9: Método que valida texto

Crea un método `isValidName` que reciba un `String` y devuelva `true` si:

- No es `null`
- No está vacío
- No está en blanco

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(isValidName("Laura"));
        System.out.println(isValidName("   "));
    }

    public static boolean isValidName(String name) {
        return name != null && !name.isBlank();
    }
}
```

</details>

---

## Ejercicio 10: Programa organizado con métodos

Crea un programa que:

- Tenga un método `printWelcome`
- Tenga un método `calculateScore` que reciba dos números y devuelva un resultado
- Desde `main`, llame a ambos métodos y muestre el resultado

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        printWelcome();

        int score = calculateScore(10, 5);
        System.out.println("Score: " + score);
    }

    public static void printWelcome() {
        System.out.println("Welcome!");
    }

    public static int calculateScore(int base, int bonus) {
        return base + bonus;
    }
}
```

</details>

---
