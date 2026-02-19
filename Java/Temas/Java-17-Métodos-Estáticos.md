# Tema 17. Métodos estáticos y la librería `Math`

## 1. Introducción

Hasta ahora has trabajado principalmente con:

- Variables y tipos
- Métodos
- Clases y objetos (POO)
- Constructores y sobrecarga

En este punto aparece una pregunta muy común:

> ¿Por qué a veces llamamos métodos con un objeto, y otras veces los llamamos directamente con el nombre de una clase?

Ejemplos:

```java
String text = "Java";
System.out.println(text.length()); // método de instancia (necesita un objeto)
```

```java
System.out.println(Math.sqrt(9));   // método estático (se llama con la clase)
```

La diferencia está en **static**.

En este tema aprenderás:

- Qué es un método estático y en qué se diferencia de uno de instancia
- Cuándo usar `static` y cuándo no
- Qué es un atributo estático (`static`) y para qué sirve
- Cómo usar la librería `Math`: operaciones básicas, redondeos, potencias, raíces, aleatorios
- Errores típicos y buenas prácticas

---

## 2. Qué significa `static` en Java

`static` indica que un miembro (método o atributo) pertenece a la **clase**, no a un objeto concreto.

- Miembro **de instancia**: pertenece a cada objeto
- Miembro **estático**: pertenece a la clase y es compartido

### 2.1. Ejemplo rápido

Imagina una clase `Counter` que cuenta objetos creados:

```java
public class Counter {
    private static int total = 0;

    public Counter() {
        total++;
    }

    public static int getTotal() {
        return total;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        new Counter();
        new Counter();
        new Counter();

        System.out.println(Counter.getTotal()); // 3
    }
}
```

- `total` es compartido por todos.
- `getTotal()` es estático, así que se llama con `Counter.getTotal()`.

---

## 3. Métodos de instancia vs métodos estáticos

### 3.1. Método de instancia

Un método de instancia necesita un objeto para existir y suele trabajar con el estado de ese objeto.

```java
String name = "Laura";
int size = name.length();
```

Aquí `length()` trabaja con los caracteres del objeto `name`.

### 3.2. Método estático

Un método estático no necesita un objeto. Se llama con el nombre de la clase.

```java
double root = Math.sqrt(25);
```

Aquí `sqrt` es un cálculo general, no depende del estado de un objeto `Math`.

---

## 4. ¿Por qué `main` es `static`?

El método `main` es el punto de entrada de un programa Java.

```java
public static void main(String[] args) { ... }
```

Java lo llama sin crear un objeto `Main`.  
Por eso necesita ser `static`.

---

## 5. Reglas importantes de `static`

### 5.1. Un método estático NO puede acceder a atributos de instancia directamente

Ejemplo (error):

```java
public class User {
    private String name;

    public static void printName() {
        // System.out.println(name); // error: name no es estático
    }
}
```

¿Por qué? Porque `name` pertenece a objetos concretos, y en un contexto estático no hay un objeto “actual”.

Para acceder, necesitas un objeto:

```java
public static void printUserName(User user) {
    System.out.println(user.name); // dentro de la clase se puede acceder a private
}
```

> En la práctica, lo habitual es evitar este patrón y usar métodos de instancia para imprimir datos de instancia.

### 5.2. Un método de instancia sí puede usar miembros estáticos

Porque los estáticos siempre existen a nivel de clase.

---

## 6. Cuándo usar métodos estáticos

Usa `static` cuando el método:

- No depende del estado de un objeto
- Hace un cálculo o una utilidad general
- Es una función “pura” (mismo input → mismo output)
- Es un helper para reutilizar lógica

Ejemplos típicos:

- `Math.sqrt`, `Math.max`, `Integer.parseInt`
- Utilidades como `String.valueOf`
- Métodos helper en clases `Utils` (cuando tiene sentido)

---

## 7. Ejemplo: clase `Calculator` con métodos estáticos

```java
public class Calculator {

    public static int sum(int a, int b) {
        return a + b;
    }

    public static int clampToZero(int value) {
        if (value < 0) {
            return 0;
        }

        return value;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(Calculator.sum(5, 7));
        System.out.println(Calculator.clampToZero(-3));
    }
}
```

Observa que no necesitas crear `new Calculator()`.

---

## 8. Atributos estáticos (`static`) y constantes (`static final`)

### 8.1. Atributo estático

Un atributo estático se comparte entre todos los objetos.

Ejemplo: un contador de usuarios creados.

```java
public class User {
    private static int totalUsers = 0;

    private String name;

    public User(String name) {
        this.name = name;
        totalUsers++;
    }

    public static int getTotalUsers() {
        return totalUsers;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        new User("Laura");
        new User("Alex");

        System.out.println(User.getTotalUsers()); // 2
    }
}
```

### 8.2. Constantes: `static final`

Para valores que no cambian.

Convención: nombre en MAYÚSCULAS.

```java
public class AppConfig {
    public static final int MAX_ATTEMPTS = 3;
}
```

Uso:

```java
int attempts = AppConfig.MAX_ATTEMPTS;
```

---

## 9. La librería `Math`

`Math` es una clase en `java.lang`, no necesitas importarla.

Sus métodos más usados son **estáticos**, por eso se llaman con `Math.`

---

## 10. Operaciones básicas con `Math`

### 10.1. `Math.abs` (valor absoluto)

```java
int value = -10;
System.out.println(Math.abs(value)); // 10
```

### 10.2. `Math.max` y `Math.min`

```java
int a = 10;
int b = 25;

System.out.println(Math.max(a, b)); // 25
System.out.println(Math.min(a, b)); // 10
```

---

## 11. Potencias y raíces

### 11.1. `Math.pow`

Devuelve `double`.

```java
double result = Math.pow(2, 3);
System.out.println(result); // 8.0
```

### 11.2. `Math.sqrt`

```java
double root = Math.sqrt(81);
System.out.println(root); // 9.0
```

### 11.3. `Math.cbrt` (raíz cúbica)

```java
double value = Math.cbrt(27);
System.out.println(value); // 3.0
```

---

## 12. Redondeos

### 12.1. `Math.round`

Redondea al entero más cercano (devuelve `long` o `int` según el tipo).

```java
double value = 4.6;
System.out.println(Math.round(value)); // 5
```

### 12.2. `Math.floor` y `Math.ceil`

- `floor`: hacia abajo
- `ceil`: hacia arriba

```java
double value = 4.2;

System.out.println(Math.floor(value)); // 4.0
System.out.println(Math.ceil(value));  // 5.0
```

---

## 13. Números aleatorios

### 13.1. `Math.random()`

`Math.random()` devuelve un `double` entre:

- 0.0 (incluido)
- 1.0 (excluido)

```java
double r = Math.random();
System.out.println(r);
```

### 13.2. Aleatorio entero en un rango (muy común)

Queremos un entero entre `min` y `max` (incluidos).

Fórmula:

```java
int randomInt = (int) (Math.random() * (max - min + 1)) + min;
```

Ejemplo: entero entre 1 y 6 (como un dado)

```java
int min = 1;
int max = 6;

int dice = (int) (Math.random() * (max - min + 1)) + min;
System.out.println(dice);
```

---

## 14. Constantes matemáticas

### 14.1. `Math.PI`

```java
System.out.println(Math.PI);
```

Ejemplo: área de un círculo

```java
double radius = 3.0;
double area = Math.PI * radius * radius;

System.out.println(area);
```

### 14.2. `Math.E`

```java
System.out.println(Math.E);
```

---

## 15. Ejemplos guiados completos

### 15.1. Calcular distancia en una línea (valor absoluto)

Objetivo: dados dos puntos en una recta, calcular la distancia.

```java
public class Main {
    public static void main(String[] args) {
        int x1 = -3;
        int x2 = 10;

        int distance = Math.abs(x2 - x1);
        System.out.println(distance); // 13
    }
}
```

---

### 15.2. Redondear un precio a 2 decimales (enfoque simple)

A veces quieres redondear a 2 decimales. Un enfoque típico es:

- Multiplicar por 100
- Redondear
- Dividir entre 100

```java
public class Main {
    public static void main(String[] args) {
        double price = 19.987;

        double rounded = Math.round(price * 100.0) / 100.0;
        System.out.println(rounded); // 19.99
    }
}
```

---

### 15.3. Generar una contraseña numérica de 4 dígitos

Generar un número aleatorio entre 1000 y 9999:

```java
public class Main {
    public static void main(String[] args) {
        int min = 1000;
        int max = 9999;

        int code = (int) (Math.random() * (max - min + 1)) + min;
        System.out.println(code);
    }
}
```

---

## 16. Errores típicos con `Math` y `static`

### 16.1. Pensar que `Math.random()` incluye el 1.0

No lo incluye, puede acercarse pero no llega a 1.0.

### 16.2. Olvidar el `+ 1` en rangos inclusivos

Para rangos que incluyen `max`, necesitas `(max - min + 1)`.

### 16.3. Confundir métodos estáticos con métodos de instancia

Esto es incorrecto:

```java
// Math m = new Math(); // no se puede (constructor privado)
```

`Math` se usa directamente:

```java
double x = Math.sqrt(9);
```

### 16.4. Usar `Math.pow` y esperar un `int`

`Math.pow` devuelve `double`. Si necesitas `int`, convierte con cuidado:

```java
int value = (int) Math.pow(2, 3); // 8
```

---

## 17. Buenas prácticas

- Usa métodos estáticos cuando no necesites estado de objeto.
- Centraliza utilidades en métodos estáticos (si tiene sentido).
- Evita clases “Utils” enormes: que tengan un propósito claro.
- Para aleatorios, recuerda la fórmula para rangos.
- Para redondeos con decimales, usa técnicas claras (como la de multiplicar y dividir).

---

## 18. A tener en cuenta

- `static` significa “pertenece a la clase”.
- Métodos estáticos se llaman con `ClassName.method()`.
- Métodos de instancia se llaman con `object.method()`.
- `main` es estático porque Java lo ejecuta sin crear objetos.
- `Math` es una clase de utilidades con métodos estáticos: `sqrt`, `pow`, `max`, `round`, etc.
- `Math.random()` genera un `double` entre 0.0 y 1.0 (sin incluir 1.0).

---

En el siguiente tema continuaremos con los importantes conceptos de Programación Orientada a Objetos **Herencia y Polimorfismo**.
