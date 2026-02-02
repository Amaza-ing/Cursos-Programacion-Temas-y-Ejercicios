# Tema 10. Wrappers de tipos de datos primitivos

## 1. Introducción

En Java has trabajado con **tipos primitivos** como:

- `int`, `double`, `boolean`, `char`, etc.

Estos tipos son rápidos y eficientes, pero tienen una limitación importante:

- **No son objetos**, por lo tanto no tienen métodos y no pueden usarse directamente en algunos contextos del lenguaje.

Para resolver esto, Java ofrece los **wrappers** (clases envoltorio) de los tipos primitivos.

Los wrappers permiten:

- Tratar valores primitivos como **objetos**
- Usar métodos útiles (parseo, comparaciones, constantes…)
- Trabajar con colecciones (`List`, `Map`, etc.), que requieren objetos
- Representar valores ausentes con `null` (algo imposible con primitivos)

En este tema aprenderás:

- Qué son los wrappers y para qué sirven
- Qué es **autoboxing** y **unboxing**
- Cómo convertir entre `String` y números con `parseXxx` y `valueOf`
- Constantes como `MAX_VALUE` y `MIN_VALUE`
- Comparación de wrappers y errores típicos

---

## 2. Qué es un wrapper

Un **wrapper** es una clase que “envuelve” un valor primitivo dentro de un objeto.

Ejemplo: `Integer` envuelve un `int`.

| Primitivo | Wrapper     |
| --------- | ----------- |
| `byte`    | `Byte`      |
| `short`   | `Short`     |
| `int`     | `Integer`   |
| `long`    | `Long`      |
| `float`   | `Float`     |
| `double`  | `Double`    |
| `boolean` | `Boolean`   |
| `char`    | `Character` |

Todos están en `java.lang`, así que no necesitas importarlos.

---

## 3. Por qué existen los wrappers (cuándo los necesitas)

### 3.1. Colecciones (no aceptan primitivos)

Más adelante verás colecciones como `List`, `Set` o `Map`. Estas estructuras guardan **objetos**, no primitivos.

Por ejemplo, esto NO es válido:

```java
// List<int> numbers = new ArrayList<>(); // error
```

La forma correcta usa `Integer`:

```java
// List<Integer> numbers = new ArrayList<>();
```

---

### 3.2. Necesitas `null` para representar “sin valor”

Un primitivo siempre tiene un valor. Por ejemplo, un `int` siempre es un número.

Pero a veces quieres representar:

- “No hay edad”
- “No se ha calculado aún”
- “Dato desconocido”

Con primitivos no puedes usar `null`, con wrappers sí:

```java
Integer age = null;
Double price = null;
Boolean isActive = null;
```

---

### 3.3. Métodos útiles

Los wrappers ofrecen métodos para:

- Convertir texto a número
- Convertir número a texto
- Comparar valores
- Obtener límites del tipo (máximos y mínimos)
- Validar caracteres (`Character`)

---

## 4. Crear wrappers

### 4.1. Asignación directa (recomendado)

```java
Integer score = 10;
Double price = 19.99;
Boolean isPremium = true;
Character initial = 'A';
```

Aquí ocurre **autoboxing**, lo veremos en breve.

### 4.2. `valueOf(...)` (forma explícita, también muy usada)

```java
Integer score = Integer.valueOf(10);
Double price = Double.valueOf(19.99);
Boolean isPremium = Boolean.valueOf(true);
```

---

## 5. Autoboxing y unboxing

### 5.1. Autoboxing

Autoboxing es cuando Java convierte un primitivo a su wrapper automáticamente.

```java
int number = 7;
Integer boxed = number; // autoboxing
```

### 5.2. Unboxing

Unboxing es cuando Java convierte un wrapper a primitivo automáticamente.

```java
Integer boxed = 7;
int number = boxed; // unboxing
```

---

## 6. Unboxing y `null` (error típico)

Si intentas hacer unboxing de `null`, obtendrás un `NullPointerException`.

Ejemplo:

```java
Integer value = null;
// int number = value; // NullPointerException
```

Patrón seguro:

```java
Integer value = null;

if (value != null) {
    int number = value;
    System.out.println(number);
} else {
    System.out.println("No value");
}
```

---

## 7. Parseo: convertir `String` a número (métodos `parseXxx`)

### 7.1. `Integer.parseInt(...)`

```java
String text = "42";
int number = Integer.parseInt(text);

System.out.println(number + 1); // 43
```

### 7.2. `Double.parseDouble(...)`

```java
String text = "19.99";
double price = Double.parseDouble(text);

System.out.println(price * 2); // 39.98
```

### 7.3. `Boolean.parseBoolean(...)`

`parseBoolean` devuelve `true` solo si el texto (ignorando mayúsculas/minúsculas) es `"true"`.

```java
System.out.println(Boolean.parseBoolean("true"));  // true
System.out.println(Boolean.parseBoolean("TRUE"));  // true
System.out.println(Boolean.parseBoolean("yes"));   // false
System.out.println(Boolean.parseBoolean("false")); // false
```

---

## 8. `valueOf(...)`: `String` a wrapper

`valueOf` devuelve un **wrapper**, no un primitivo.

```java
String text = "42";
Integer number = Integer.valueOf(text);

System.out.println(number);
```

Comparación rápida:

- `parseInt("42")` → `int`
- `valueOf("42")` → `Integer`

---

## 9. Convertir número a texto

### 9.1. `String.valueOf(...)`

```java
int level = 5;
String text = String.valueOf(level);

System.out.println("Level: " + text);
```

### 9.2. `toString()` en wrappers

```java
Integer points = 100;
String text = points.toString();

System.out.println(text);
```

---

## 10. Constantes útiles: `MIN_VALUE` y `MAX_VALUE`

```java
System.out.println(Integer.MIN_VALUE);
System.out.println(Integer.MAX_VALUE);
```

Ejemplo con `Double`:

```java
System.out.println(Double.MIN_VALUE);
System.out.println(Double.MAX_VALUE);
```

---

## 11. Comparar wrappers

### 11.1. `equals(...)`

```java
Integer a = 100;
Integer b = 100;

System.out.println(a.equals(b)); // true
```

### 11.2. `==` (cuidado)

`==` en objetos compara referencias. En wrappers puede dar resultados confusos por el cache interno de `Integer`.

```java
Integer a = 200;
Integer b = 200;

System.out.println(a == b); // probablemente false
```

Regla práctica:

- Para wrappers, usa `equals`.
- Para primitivos, `==` está bien.

---

## 12. `compareTo(...)`

```java
Integer a = 10;
Integer b = 20;

System.out.println(a.compareTo(b));  // negativo
System.out.println(b.compareTo(a));  // positivo
System.out.println(a.compareTo(10)); // 0
```

---

## 13. `Character`: métodos útiles

```java
char c1 = '7';
System.out.println(Character.isDigit(c1)); // true

char c2 = 'A';
System.out.println(Character.isLetter(c2)); // true

char c3 = ' ';
System.out.println(Character.isWhitespace(c3)); // true
```

---

## 14. Ejemplos guiados completos

### 14.1. Validar si un `String` es un entero antes de convertir

```java
public class Main {
    public static void main(String[] args) {
        String input = "120";
        boolean isNumeric = true;

        for (int i = 0; i < input.length(); i++) {
            char c = input.charAt(i);
            if (!Character.isDigit(c)) {
                isNumeric = false;
                break;
            }
        }

        if (isNumeric) {
            int value = Integer.parseInt(input);
            System.out.println("Number: " + value);
        } else {
            System.out.println("Invalid number");
        }
    }
}
```

---

### 14.2. Convertir texto a número para calcular un total

```java
public class Main {
    public static void main(String[] args) {
        String unitPriceText = "19.99";
        String quantityText = "3";

        double unitPrice = Double.parseDouble(unitPriceText);
        int quantity = Integer.parseInt(quantityText);

        double total = unitPrice * quantity;

        System.out.println(String.format("Total: %.2f", total));
    }
}
```

---

### 14.3. Usar `null` con wrappers

```java
public class Main {
    public static void main(String[] args) {
        Integer age = null;

        if (age == null) {
            System.out.println("Age not provided");
        } else {
            System.out.println("Age: " + age);
        }
    }
}
```

---

## 15. A tener en cuenta

- Los wrappers representan primitivos como objetos.
- Son clave para colecciones y para usar `null` como “sin valor”.
- Autoboxing/unboxing simplifica el código, pero cuidado con `null`.
- `parseXxx` convierte `String` → primitivo.
- `valueOf` devuelve wrappers.
- Para comparar wrappers usa `equals`, no `==`.

---

En el próximo tema profundizaremos en **sobrecarga de métodos**, y verás cómo Java permite métodos con el mismo nombre pero diferentes parámetros.
