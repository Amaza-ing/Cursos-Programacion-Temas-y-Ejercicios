# Tema 12. Arrays

## 1. Introducción

Hasta ahora has trabajado con variables que guardan **un único valor**:

- Un `int` guarda un número
- Un `double` guarda un decimal
- Un `String` guarda un texto
- Un `boolean` guarda `true` o `false`

Pero en programación es muy habitual necesitar **varios valores del mismo tipo**:

- Las notas de un alumno
- Los precios de un carrito
- Los intentos de una partida
- Los días de la semana
- Las puntuaciones de varios jugadores

Podrías crear muchas variables:

```java
int score1 = 10;
int score2 = 15;
int score3 = 8;
```

Pero esto no escala. Por eso existen los **arrays**.

Un **array** es una estructura que permite almacenar **varios valores del mismo tipo** dentro de una única variable.

---

## 2. Qué es un array

Un array:

- Guarda una colección de elementos del **mismo tipo**
- Tiene un tamaño fijo (se decide al crearlo)
- Permite acceder a cada elemento por su **índice** (posición)
- Empieza siempre en índice **0**

Si tienes un array de 5 elementos, sus índices son:

```
0  1  2  3  4
```

---

## 3. Declarar un array

Para declarar un array, se usa `[]` después del tipo:

```java
int[] scores;
```

Esto solo declara la variable. Todavía no hay array creado (no hay memoria reservada para los elementos).

---

## 4. Crear un array (reservar memoria)

Para crear un array se usa `new` y se indica el tamaño.

```java
int[] scores = new int[5];
```

Aquí:

- Se crea un array de `int`
- Con tamaño 5
- Todos los elementos se inicializan con el valor por defecto de `int`, que es `0`

---

## 5. Tamaño del array: `length`

Los arrays tienen una propiedad llamada `length` que indica cuántos elementos tienen.

```java
int[] scores = new int[5];
System.out.println(scores.length); // 5
```

Importante:

- En arrays se usa `length` (sin paréntesis)
- En `String` se usa `length()` (con paréntesis)

---

## 6. Índices: acceder a un elemento

Para acceder a una posición se usa `[]` con el índice.

```java
int[] scores = new int[5];

System.out.println(scores[0]); // primer elemento
System.out.println(scores[4]); // último elemento
```

Recuerda:

- Primer elemento → índice 0
- Último elemento → índice `length - 1`

---

## 7. Asignar valores a un array

Puedes asignar valores a posiciones concretas usando el índice.

```java
int[] scores = new int[5];

scores[0] = 10;
scores[1] = 15;
scores[2] = 8;
scores[3] = 20;
scores[4] = 12;

System.out.println(scores[3]); // 20
```

---

## 8. Inicializar un array con valores (forma rápida)

A veces ya sabes los valores al crear el array. En ese caso puedes usar una inicialización literal:

```java
int[] scores = {10, 15, 8, 20, 12};
```

Aquí Java:

- Crea el array automáticamente
- Le asigna tamaño 5
- Mete los valores en orden

---

## 9. Arrays de otros tipos

### 9.1. `double[]`

```java
double[] prices = {19.99, 5.50, 12.00};
```

### 9.2. `boolean[]`

```java
boolean[] answers = {true, false, true, true};
```

### 9.3. `String[]`

```java
String[] names = {"Laura", "Alex", "Sara"};
```

---

## 10. Valores por defecto en arrays

Cuando creas un array con `new`, Java inicializa automáticamente sus elementos:

- `int` → 0
- `double` → 0.0
- `boolean` → false
- `char` → '\u0000' (carácter “vacío”)
- `String` (y otros objetos) → `null`

Ejemplo:

```java
String[] names = new String[3];

System.out.println(names[0]); // null
```

`null` significa “no hay objeto” o “no hay valor asignado”.

---

## 11. Errores comunes con arrays

### 11.1. `ArrayIndexOutOfBoundsException` (índice fuera de rango)

Este es el error más típico:

```java
int[] scores = new int[3];
scores[3] = 10; // error
```

¿Por qué?

- Si el tamaño es 3, los índices válidos son 0, 1 y 2.
- El índice 3 está fuera del rango.

Regla práctica:

- Nunca uses un índice mayor o igual que `length`.

---

### 11.2. Olvidar que empieza en 0

Si tienes un array de 5:

- Primer índice: 0
- Último índice: 4

Esto es clave para evitar errores.

---

### 11.3. Confundir declaración con creación

Esto declara un array, pero NO lo crea:

```java
int[] scores;
```

Si intentas usarlo así, dará error de compilación porque no está inicializado.

Lo correcto es crearlo:

```java
int[] scores = new int[5];
```

---

## 12. Ejemplos guiados (para entender el uso real)

### 12.1. Ejemplo: guardar y mostrar datos

```java
public class Main {
    public static void main(String[] args) {
        String[] cities = {"Madrid", "Berlin", "Paris"};

        System.out.println(cities[0]);
        System.out.println(cities[1]);
        System.out.println(cities[2]);
    }
}
```

---

### 12.2. Ejemplo: actualizar un valor del array

```java
public class Main {
    public static void main(String[] args) {
        int[] scores = {10, 15, 8};

        scores[1] = 20;

        System.out.println(scores[0]); // 10
        System.out.println(scores[1]); // 20
        System.out.println(scores[2]); // 8
    }
}
```

---

### 12.3. Ejemplo: usar `length` para acceder al último elemento

```java
public class Main {
    public static void main(String[] args) {
        int[] numbers = {3, 9, 12, 7};

        int lastIndex = numbers.length - 1;
        System.out.println(numbers[lastIndex]);
    }
}
```

---

## 13. Arrays y métodos

Es muy común pasar arrays a métodos para procesarlos.

### 13.1. Método que imprime el primer y último elemento

```java
public class Main {
    public static void main(String[] args) {
        int[] numbers = {4, 8, 15, 16, 23, 42};
        printFirstAndLast(numbers);
    }

    public static void printFirstAndLast(int[] values) {
        int first = values[0];
        int last = values[values.length - 1];

        System.out.println("First: " + first);
        System.out.println("Last: " + last);
    }
}
```

Fíjate en:

- El parámetro `int[] values` indica que el método recibe un array de int.
- Dentro del método, `values` se usa igual que cualquier array.

---

### 13.2. Método que modifica un array

En Java, cuando pasas un array a un método, el método puede modificar su contenido.

```java
public class Main {
    public static void main(String[] args) {
        int[] scores = {10, 20, 30};

        increaseFirst(scores);

        System.out.println(scores[0]); // 11
    }

    public static void increaseFirst(int[] values) {
        values[0] = values[0] + 1;
    }
}
```

Esto ocurre porque el array es un objeto y el método recibe una referencia al mismo array.

---

## 14. Arrays y bucles (vista previa)

En el siguiente tema verás el recorrido de arrays con bucles, pero es útil entender ya la idea básica.

Para recorrer un array de tamaño `n`, normalmente haces:

- Desde índice 0
- Hasta índice `length - 1`

Ejemplo conceptual:

```java
int[] numbers = {10, 20, 30};

for (int i = 0; i < numbers.length; i++) {
    System.out.println(numbers[i]);
}
```

No necesitas memorizarlo aún, pero fíjate en:

- El bucle empieza en 0
- La condición es `i < numbers.length` (no `<=`)

---

## 15. Arrays de dos dimensiones (introducción)

Un array también puede ser “de arrays”, creando una estructura en forma de tabla.

Ejemplo de una matriz 2x3 (2 filas, 3 columnas):

```java
int[][] grid = new int[2][3];
```

Acceso:

- `grid[0][0]` → primera fila, primera columna
- `grid[1][2]` → segunda fila, tercera columna

Inicialización rápida:

```java
int[][] grid = {
    {1, 2, 3},
    {4, 5, 6}
};
```

En cursos iniciales, lo más importante es dominar primero los arrays de una dimensión.

---

## 16. A tener en cuenta

- Un array guarda múltiples valores del mismo tipo.
- Los índices empiezan en 0.
- El tamaño es fijo y se consulta con `length`.
- Se crean con `new` o con inicialización literal `{...}`.
- Los errores más comunes son los índices fuera de rango.
- Los arrays se usan muchísimo junto a bucles y métodos.

---

En el próximo tema aprenderás a **recorrer arrays** con bucles, y a leer/modificar sus valores de forma eficiente.
