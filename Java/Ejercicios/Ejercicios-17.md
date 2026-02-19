# Ejercicios - Tema 17: Métodos estáticos y la librería `Math`

A continuación encontrarás **10 ejercicios prácticos** sobre **métodos estáticos** y la librería **`Math`**: diferencias entre métodos de instancia y `static`, creación de utilidades, `static final` (constantes), `Math.abs`, `min/max`, `pow`, `sqrt`, `round/floor/ceil`, `random` con rangos, y casos habituales de cálculo.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Método estático `isEven`

Crea una clase `NumberUtils` con un método estático:

```java
public static boolean isEven(int value)
```

Debe devolver `true` si `value` es par y `false` si es impar.

En `main`, prueba el método con `4`, `7` y `0`.

<details><summary>Mostrar solución</summary>

```java
public class NumberUtils {
    public static boolean isEven(int value) {
        return value % 2 == 0;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(NumberUtils.isEven(4));
        System.out.println(NumberUtils.isEven(7));
        System.out.println(NumberUtils.isEven(0));
    }
}
```

</details>

---

## Ejercicio 2: Método estático `clamp`

Crea un método estático en `NumberUtils`:

```java
public static int clamp(int value, int min, int max)
```

Debe devolver:

- `min` si `value < min`
- `max` si `value > max`
- `value` si está dentro del rango

En `main`, prueba con:

- `clamp(5, 0, 10)`
- `clamp(-2, 0, 10)`
- `clamp(99, 0, 10)`

<details><summary>Mostrar solución</summary>

```java
public class NumberUtils {
    public static int clamp(int value, int min, int max) {
        if (value < min) {
            return min;
        }

        if (value > max) {
            return max;
        }

        return value;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(NumberUtils.clamp(5, 0, 10));
        System.out.println(NumberUtils.clamp(-2, 0, 10));
        System.out.println(NumberUtils.clamp(99, 0, 10));
    }
}
```

</details>

---

## Ejercicio 3: Constante `static final` para IVA

Crea una clase `TaxConfig` con una constante:

```java
public static final double VAT_RATE = 0.21;
```

En `main`, calcula el precio final de un producto con:

- `double basePrice = 100;`

Fórmula:

```
finalPrice = basePrice + basePrice * VAT_RATE
```

<details><summary>Mostrar solución</summary>

```java
public class TaxConfig {
    public static final double VAT_RATE = 0.21;
}
```

```java
public class Main {
    public static void main(String[] args) {
        double basePrice = 100;
        double finalPrice = basePrice + basePrice * TaxConfig.VAT_RATE;

        System.out.println(finalPrice);
    }
}
```

</details>

---

## Ejercicio 4: Distancia en una recta con `Math.abs`

Declara:

- `int a = -8;`
- `int b = 3;`

Calcula la distancia entre ambos en la recta numérica usando `Math.abs`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int a = -8;
        int b = 3;

        int distance = Math.abs(b - a);
        System.out.println(distance);
    }
}
```

</details>

---

## Ejercicio 5: Mayor y menor de 3 valores con `Math.max` y `Math.min`

Declara:

- `int x = 12;`
- `int y = 5;`
- `int z = 30;`

Calcula:

- El mayor de los 3
- El menor de los 3

Usa combinaciones de `Math.max` y `Math.min`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int x = 12;
        int y = 5;
        int z = 30;

        int max = Math.max(x, Math.max(y, z));
        int min = Math.min(x, Math.min(y, z));

        System.out.println("Max: " + max);
        System.out.println("Min: " + min);
    }
}
```

</details>

---

## Ejercicio 6: Hipotenusa con `Math.sqrt` y `Math.pow`

Declara un triángulo rectángulo con:

- `double a = 3;`
- `double b = 4;`

Calcula la hipotenusa con:

```
c = sqrt(a^2 + b^2)
```

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        double a = 3;
        double b = 4;

        double c = Math.sqrt(Math.pow(a, 2) + Math.pow(b, 2));
        System.out.println(c);
    }
}
```

</details>

---

## Ejercicio 7: Redondear a 2 decimales usando `Math.round`

Declara:

- `double price = 19.987;`

Redondea a 2 decimales con la técnica de multiplicar y dividir por 100.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        double price = 19.987;

        double rounded = Math.round(price * 100.0) / 100.0;
        System.out.println(rounded);
    }
}
```

</details>

---

## Ejercicio 8: `floor` y `ceil` para separar parte entera

Declara:

- `double value = 7.3;`

Imprime:

- `Math.floor(value)`
- `Math.ceil(value)`

Luego calcula la parte decimal aproximada como:

```
decimal = value - floor(value)
```

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        double value = 7.3;

        double floored = Math.floor(value);
        double ceiled = Math.ceil(value);

        System.out.println(floored);
        System.out.println(ceiled);

        double decimal = value - floored;
        System.out.println(decimal);
    }
}
```

</details>

---

## Ejercicio 9: Aleatorio entero en un rango

Genera un número entero aleatorio entre `1` y `10` (incluidos).  
Imprime el resultado.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int min = 1;
        int max = 10;

        int randomValue = (int) (Math.random() * (max - min + 1)) + min;
        System.out.println(randomValue);
    }
}
```

</details>

---

## Ejercicio 10: Método estático para lanzar un dado `rollDice`

Crea una clase `RandomUtils` con un método estático:

```java
public static int rollDice()
```

Debe devolver un entero entre `1` y `6` usando `Math.random()`.

En `main`, llama al método 5 veces e imprime cada resultado.

<details><summary>Mostrar solución</summary>

```java
public class RandomUtils {
    public static int rollDice() {
        int min = 1;
        int max = 6;

        return (int) (Math.random() * (max - min + 1)) + min;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 0; i < 5; i++) {
            System.out.println(RandomUtils.rollDice());
        }
    }
}
```

</details>

---
