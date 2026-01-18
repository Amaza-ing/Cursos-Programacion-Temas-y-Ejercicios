# Ejercicios - Tema 3: Operadores y expresiones (Java)

A continuación, encontrarás **10 ejercicios prácticos** sobre operadores aritméticos, relacionales, lógicos, de asignación y prioridad de operadores.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Operaciones aritméticas básicas

Declara dos variables:

- `a` con valor `14`
- `b` con valor `4`

Calcula y muestra por consola:

- La suma
- La resta
- La multiplicación
- La división
- El resto

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int a = 14;
        int b = 4;

        System.out.println(a + b);
        System.out.println(a - b);
        System.out.println(a * b);
        System.out.println(a / b);
        System.out.println(a % b);
    }
}
```

</details>

---

## Ejercicio 2: División con decimales

Declara:

- `totalPoints` con valor `9`
- `numberOfPlayers` con valor `2`

Calcula la media correcta usando `double`.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int totalPoints = 9;
        int numberOfPlayers = 2;

        double average = (double) totalPoints / numberOfPlayers;
        System.out.println(average);
    }
}
```

</details>

---

## Ejercicio 3: Par o impar

Declara una variable `number` con valor `21`.

Comprueba si el número es par y muestra el resultado (`true` o `false`).

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int number = 21;

        boolean isEven = number % 2 == 0;
        System.out.println(isEven);
    }
}
```

</details>

---

## Ejercicio 4: Comparaciones relacionales

Declara:

- `age` con valor `16`

Crea variables booleanas que indiquen si:

- Es mayor de edad
- Es menor de edad
- Tiene exactamente 18 años

Imprime los resultados.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int age = 16;

        boolean isAdult = age >= 18;
        boolean isMinor = age < 18;
        boolean isExactly18 = age == 18;

        System.out.println(isAdult);
        System.out.println(isMinor);
        System.out.println(isExactly18);
    }
}
```

</details>

---

## Ejercicio 5: Operadores lógicos AND (`&&`)

Declara:

- `age` con valor `22`
- `hasId` con valor `true`

Crea una variable `canEnter` que sea `true` solo si cumple ambas condiciones.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int age = 22;
        boolean hasId = true;

        boolean canEnter = age >= 18 && hasId;
        System.out.println(canEnter);
    }
}
```

</details>

---

## Ejercicio 6: Operadores lógicos OR (`||`)

Declara:

- `isVip` con valor `false`
- `hasInvitation` con valor `true`

Crea una variable `hasAccess` que sea `true` si cumple al menos una condición.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        boolean isVip = false;
        boolean hasInvitation = true;

        boolean hasAccess = isVip || hasInvitation;
        System.out.println(hasAccess);
    }
}
```

</details>

---

## Ejercicio 7: Operador NOT (`!`)

Declara una variable `isBlocked` con valor `true`.

Crea una variable `canLogin` que sea el valor contrario.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        boolean isBlocked = true;

        boolean canLogin = !isBlocked;
        System.out.println(canLogin);
    }
}
```

</details>

---

## Ejercicio 8: Operadores de asignación compuesta

Declara una variable `score` con valor `10`.

- Suma 5 usando `+=`
- Resta 3 usando `-=`
- Multiplica por 2 usando `*=`

Imprime el valor final.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int score = 10;

        score += 5;
        score -= 3;
        score *= 2;

        System.out.println(score);
    }
}
```

</details>

---

## Ejercicio 9: Incremento y decremento

Declara una variable `counter` con valor `0`.

- Incrementa una vez
- Incrementa otra vez
- Decrementa una vez

Imprime el resultado final.

<details><summary>Mostrar Solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        int counter = 0;

        counter++;
        counter++;
        counter--;

        System.out.println(counter);
    }
}
```

</details>

---

## Ejercicio 10: Prioridad de operadores

Sin ejecutar el código, piensa cuál será el resultado:

```java
int result = 4 + 2 * 5;
System.out.println(result);
```

Después, modifica la expresión para que el resultado sea `30`.

<details><summary>Mostrar Solución</summary>

Resultado original:

```
14
```

Versión modificada:

```java
int result = (4 + 2) * 5;
System.out.println(result);
```

</details>

---
