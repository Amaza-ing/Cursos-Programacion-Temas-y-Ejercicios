# Tema 11. Sobrecarga de métodos

## 1. Introducción

En los temas anteriores aprendiste a crear y usar métodos con parámetros y con `return`. Ahora vamos a dar un paso más: **usar el mismo nombre de método para diferentes “versiones”**.

Esto se llama **sobrecarga de métodos** (_method overloading_).

La sobrecarga es una técnica muy común en Java porque permite:

- Tener un nombre de método coherente para una misma acción
- Adaptar esa acción a distintos tipos de datos o cantidades de parámetros
- Mantener el código más limpio y fácil de leer

Ejemplo de idea:

- `sum(2, 3)`
- `sum(2, 3, 4)`
- `sum(2.5, 3.1)`

Todos hacen “sumar”, pero con firmas distintas.

---

## 2. Qué es la sobrecarga de métodos

Dos métodos están **sobrecargados** si:

- Tienen el mismo **nombre**
- Están en la misma **clase**
- Pero tienen una **lista de parámetros diferente**

La lista de parámetros puede ser distinta por:

- Número de parámetros
- Tipo de parámetros
- Orden de tipos en los parámetros

A esa combinación se le llama la **firma del método** (_method signature_).

---

## 3. La firma de un método (lo que Java usa para diferenciarlos)

Java identifica un método por:

- Nombre del método
- Tipos de los parámetros (incluyendo su orden)

**Java NO usa** el tipo de retorno para diferenciar métodos.

Ejemplo de firmas distintas:

```java
sum(int, int)
sum(int, int, int)
sum(double, double)
sum(String, String)
```

---

## 4. Sobrecarga por número de parámetros

Esta es la forma más fácil de entender.

### 4.1. Ejemplo: `sum` con 2 y con 3 valores

```java
public class Main {
    public static void main(String[] args) {
        int a = sum(2, 3);
        int b = sum(2, 3, 4);

        System.out.println(a);
        System.out.println(b);
    }

    public static int sum(int x, int y) {
        return x + y;
    }

    public static int sum(int x, int y, int z) {
        return x + y + z;
    }
}
```

Qué ocurre:

- `sum(2, 3)` llama a `sum(int, int)`
- `sum(2, 3, 4)` llama a `sum(int, int, int)`

Java elige automáticamente la versión correcta.

---

## 5. Sobrecarga por tipo de parámetros

Puedes tener métodos con el mismo nombre y mismo número de parámetros, pero con **tipos diferentes**.

### 5.1. Ejemplo: `sum` para `int` y para `double`

```java
public class Main {
    public static void main(String[] args) {
        int a = sum(10, 5);
        double b = sum(10.5, 5.2);

        System.out.println(a);
        System.out.println(b);
    }

    public static int sum(int x, int y) {
        return x + y;
    }

    public static double sum(double x, double y) {
        return x + y;
    }
}
```

Aquí:

- Si pasas enteros, Java usa la versión `int`
- Si pasas decimales, Java usa la versión `double`

---

## 6. Sobrecarga por orden de tipos

También puedes sobrecargar si cambias el orden de tipos en los parámetros.

### 6.1. Ejemplo: `formatUser` con orden distinto

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(formatUser("Laura", 28));
        System.out.println(formatUser(28, "Laura"));
    }

    public static String formatUser(String name, int age) {
        return "Name: " + name + " | Age: " + age;
    }

    public static String formatUser(int age, String name) {
        return "Age: " + age + " | Name: " + name;
    }
}
```

Esto funciona porque la firma es distinta:

- `formatUser(String, int)`
- `formatUser(int, String)`

---

## 7. Lo que NO es sobrecarga

### 7.1. No es sobrecarga cambiar solo el tipo de retorno

Esto NO compila:

```java
public static int getValue() {
    return 10;
}

public static double getValue() {
    return 10.0;
}
```

Java no puede diferenciarlo porque los parámetros son idénticos (no hay parámetros).

---

### 7.2. No es sobrecarga cambiar solo los nombres de los parámetros

Esto NO es sobrecarga, porque el tipo y el número son iguales:

```java
public static int sum(int a, int b) {
    return a + b;
}

public static int sum(int x, int y) {
    return x + y;
}
```

Para Java, ambas firmas son `sum(int, int)`.

---

## 8. Cómo decide Java qué método llamar

Cuando llamas a un método sobrecargado, Java elige la versión que “mejor encaja” con los argumentos.

### 8.1. Ejemplo: llamada exacta

```java
sum(2, 3);          // encaja con sum(int, int)
sum(2.0, 3.0);      // encaja con sum(double, double)
```

### 8.2. Ejemplo: conversión implícita

Recuerda el tema de conversión de tipos: Java puede convertir implícitamente `int` a `double`.

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(sum(2, 3));   // llama a int
        System.out.println(sum(2, 3.5)); // llama a double
    }

    public static int sum(int x, int y) {
        return x + y;
    }

    public static double sum(double x, double y) {
        return x + y;
    }
}
```

En `sum(2, 3.5)`:

- `3.5` ya es `double`
- Java convierte `2` a `double`
- Elige `sum(double, double)`

---

## 9. Ambigüedad (cuando Java no sabe qué versión usar)

A veces puedes crear sobrecargas que generan llamadas ambiguas. En estos casos, Java dará error de compilación.

Un ejemplo típico es cuando hay varias conversiones posibles y ninguna es claramente “mejor”.

La regla práctica para evitarlo:

- No crees sobrecargas que dependan de conversiones “dudosas”
- Mantén firmas muy claras y diferentes

---

## 10. Caso real: métodos tipo “build” con variantes

Un uso común de la sobrecarga es permitir varias formas de usar un método para generar una salida o construir un valor.

### 10.1. Ejemplo: `buildMessage` con variantes

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(buildMessage("Welcome"));
        System.out.println(buildMessage("Welcome", "Laura"));
        System.out.println(buildMessage("Welcome", "Laura", 3));
    }

    public static String buildMessage(String text) {
        return text;
    }

    public static String buildMessage(String text, String userName) {
        return text + ", " + userName;
    }

    public static String buildMessage(String text, String userName, int attempts) {
        return text + ", " + userName + " | Attempts: " + attempts;
    }
}
```

---

## 11. Buenas prácticas al sobrecargar

### 11.1. Mantén la intención consistente

Si el método se llama `sum`, todas las versiones deben “sumar”.  
Si el método se llama `calculateTotal`, todas las versiones deben calcular un total.

---

### 11.2. Evita sobrecargas que confundan

Cambiar el orden de parámetros puede ser legal, pero puede generar llamadas difíciles de leer si no eres consistente.

---

### 11.3. Usa sobrecarga para simplificar el uso

Un patrón habitual es que una versión “simple” llame a otra más completa.

```java
public static int sum(int x, int y) {
    return sum(x, y, 0);
}

public static int sum(int x, int y, int z) {
    return x + y + z;
}
```

---

## 12. Ejemplo completo: cálculo de precio final con variantes

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(calculateTotal(10.0, 3));            // 30.0
        System.out.println(calculateTotal(10.0, 3, 0.10));      // 27.0
        System.out.println(calculateTotal(10.0, 3, 0.10, 2.0)); // 29.0
    }

    public static double calculateTotal(double unitPrice, int quantity) {
        return unitPrice * quantity;
    }

    public static double calculateTotal(double unitPrice, int quantity, double discountRate) {
        double base = unitPrice * quantity;
        return base - (base * discountRate);
    }

    public static double calculateTotal(double unitPrice, int quantity, double discountRate, double extraFee) {
        double discounted = calculateTotal(unitPrice, quantity, discountRate);
        return discounted + extraFee;
    }
}
```

---

## 13. Errores comunes al empezar

- Pensar que el retorno crea sobrecarga (no).
- Crear sobrecargas demasiado parecidas.
- Duplicar lógica en cada versión (mejor reutilizar).

---

## 14. A tener en cuenta

- La sobrecarga permite varios métodos con el mismo nombre y distintas firmas.
- La firma depende del nombre y parámetros (no del retorno).
- Puedes sobrecargar por número, tipo u orden de parámetros.
- Java elige la versión que mejor encaja con los argumentos.
- Bien usada, la sobrecarga hace el código más limpio y fácil de usar.

---

En el próximo tema seguiremos trabajando buenas prácticas y organización del código, preparando el terreno para **arrays** y estructuras de datos.
