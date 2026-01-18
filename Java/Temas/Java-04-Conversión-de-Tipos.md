# Tema 4. Conversión de tipos

## 1. Introducción

En Java, **cada variable tiene un tipo**, y ese tipo determina:

- Qué valores puede almacenar
- Qué operaciones puedes hacer con ella
- Cómo se interpreta ese valor en memoria

A medida que programes, te encontrarás con situaciones típicas como:

- Quieres guardar un `int` dentro de un `double`
- Estás dividiendo números enteros y necesitas decimales
- Estás leyendo datos como texto (`String`) y necesitas convertirlos a número
- Estás mezclando `char`, `int` y `double` en una misma expresión

Para resolver todo eso necesitas dominar la **conversión de tipos**.

En este tema aprenderás:

- Qué es la **conversión implícita** (widening)
- Qué es la **conversión explícita** o **casting** (narrowing)
- Qué errores son los más comunes
- Cómo convertir entre `String` y tipos numéricos (muy usado en entrada por consola)

---

## 2. Idea clave: convertir significa “cambiar la forma de interpretar un valor”

Cuando conviertes tipos, no “cambias” el valor mágico del universo, sino cómo Java lo interpreta y lo maneja.

Ejemplo rápido:

- Un `int` almacena números enteros.
- Un `double` almacena números con decimales.

Si conviertes un `int` a `double`, el número sigue siendo el mismo, pero ahora tiene capacidad de decimales.

---

## 3. Conversión implícita (widening conversion)

La **conversión implícita** sucede cuando Java puede convertir un valor **sin riesgo de perder información**.

Esto suele ocurrir cuando pasas de un tipo “más pequeño” a uno “más grande”, por ejemplo:

- `int` -> `double`
- `byte` -> `int`
- `char` -> `int`
- `int` -> `long`

### 3.1. Tabla mental simple (de menor a mayor capacidad)

Una forma práctica de recordarlo:

```
byte -> short -> int -> long -> float -> double
```

> Nota: `char` va por su cuenta, pero puede convertirse a `int` porque internamente es un número (código Unicode).

---

### 3.2. Ejemplo: `int` a `double`

```java
int number = 7;
double result = number;

System.out.println(result); // 7.0
```

Aquí Java convierte automáticamente `7` en `7.0`.

---

### 3.3. Ejemplo: mezclar tipos en expresiones

Cuando mezclas tipos en una operación, Java suele “promocionar” el tipo a uno más grande para poder operar.

```java
int a = 5;
double b = 2.0;

double total = a + b;
System.out.println(total); // 7.0
```

- `a` (int) se convierte implícitamente a `double`
- el resultado es `double`

---

### 3.4. Ejemplo: `char` a `int` (código Unicode)

```java
char letter = 'A';
int code = letter;

System.out.println(code); // 65
```

`'A'` se convierte al número que representa ese carácter en Unicode.

Otro ejemplo:

```java
char letter = 'ñ';
int code = letter;

System.out.println(code);
```

Esto imprime el número asociado a ese carácter.

---

## 4. Conversión explícita (casting / narrowing conversion)

La **conversión explícita** es necesaria cuando hay **riesgo de perder información**.

Esto ocurre cuando vas de un tipo con más capacidad a uno con menos, por ejemplo:

- `double` -> `int`
- `long` -> `int`
- `int` -> `short`

En estos casos, Java te obliga a indicar que **asumes el riesgo**, usando un _cast_.

### 4.1. Sintaxis del casting

```java
targetType newValue = (targetType) oldValue;
```

---

### 4.2. Ejemplo: `double` a `int` (se pierde el decimal)

```java
double price = 19.99;
int intPrice = (int) price;

System.out.println(intPrice); // 19
```

Importante:

- Esto **no redondea**, simplemente **corta** (trunca) la parte decimal.

---

### 4.3. Ejemplo: `long` a `int` (posible pérdida por tamaño)

```java
long bigNumber = 3_000_000_000L;
int smallNumber = (int) bigNumber;

System.out.println(smallNumber);
```

Aquí puede ocurrir algo muy peligroso: el resultado **no será correcto**, porque `int` no puede representar ese valor.

Este es un ejemplo típico de por qué el casting puede ser peligroso.

---

### 4.4. Ejemplo: `int` a `byte` (pérdida por rango)

`byte` solo puede almacenar valores entre **-128 y 127**.

```java
int value = 130;
byte smallValue = (byte) value;

System.out.println(smallValue);
```

El resultado puede ser inesperado (por overflow).

> Regla práctica: si haces cast a tipos pequeños, asegúrate de que el valor cabe en ese tipo.

---

## 5. El caso más importante: división entre enteros

Este es, probablemente, el error más común cuando empiezas.

### 5.1. División entre `int` da `int`

```java
int a = 5;
int b = 2;

int result = a / b;
System.out.println(result); // 2
```

¿Por qué? Porque al dividir dos enteros, Java produce un entero, y descarta la parte decimal.

---

### 5.2. Solución: convertir antes de dividir

Puedes convertir uno de los operandos a `double`:

```java
int a = 5;
int b = 2;

double result = (double) a / b;
System.out.println(result); // 2.5
```

También valdría esto:

```java
double result = a / 2.0;
System.out.println(result); // 2.5
```

---

### 5.3. Ejemplo práctico: calcular una media

Si haces esto, te equivocas:

```java
int total = 7;
int count = 2;

double average = total / count;
System.out.println(average); // 3.0 (incorrecto)
```

La división se hace como `int` antes de guardarse.

La forma correcta:

```java
int total = 7;
int count = 2;

double average = (double) total / count;
System.out.println(average); // 3.5
```

---

## 6. Conversión entre `String` y tipos numéricos

Aunque esto lo usarás aún más en el tema de entrada por consola, es imprescindible entenderlo aquí porque es una conversión muy frecuente en Java.

### 6.1. Convertir `String` a `int`

```java
String text = "42";
int number = Integer.parseInt(text);

System.out.println(number + 1); // 43
```

Si `text` no contiene un número válido, Java lanzará un error (excepción).

Ejemplo problemático:

```java
String text = "42a";
int number = Integer.parseInt(text); // error
```

---

### 6.2. Convertir `String` a `double`

```java
String text = "19.99";
double price = Double.parseDouble(text);

System.out.println(price);
```

Ojo con esto: en Java, el separador decimal es `.` (punto), no coma.

Esto fallaría:

```java
String text = "19,99";
double price = Double.parseDouble(text); // error
```

---

### 6.3. Convertir números a `String`

Una forma muy común es usar `String.valueOf(...)`:

```java
int age = 30;
String ageText = String.valueOf(age);

System.out.println(ageText);
```

También puedes concatenar con una cadena vacía:

```java
int age = 30;
String ageText = age + "";

System.out.println(ageText);
```

> Recomendación: usa `String.valueOf(...)` por claridad.

---

## 7. Promoción de tipos en operaciones (por qué cambian los resultados)

Java aplica reglas automáticas en expresiones. En general:

- Si hay un `double` en la operación, el resultado tiende a ser `double`
- Si hay un `long` y un `int`, el resultado tiende a ser `long`
- Si hay tipos pequeños (`byte`, `short`), Java suele promoverlos a `int`

### 7.1. Ejemplo: `int` + `double`

```java
int a = 10;
double b = 0.5;

double total = a + b;
System.out.println(total); // 10.5
```

---

### 7.2. Ejemplo: `byte` en operaciones se promociona a `int`

Esto puede sorprender al principio:

```java
byte a = 10;
byte b = 20;

// byte c = a + b; // error
int c = a + b;
System.out.println(c); // 30
```

¿Por qué falla `byte c = a + b;`?  
Porque `a + b` se convierte a `int` internamente.

Si de verdad quieres `byte`, necesitarías un cast:

```java
byte a = 10;
byte b = 20;

byte c = (byte) (a + b);
System.out.println(c);
```

---

## 8. Errores comunes (y cómo evitarlos)

### 8.1. Creer que un cast “redondea”

Cast de `double` a `int` **no redondea**, trunca.

```java
double value = 9.99;
int result = (int) value;

System.out.println(result); // 9
```

Si quisieras redondear, tendrías que usar `Math.round`, que verás más adelante.

---

### 8.2. Hacer casting tarde (en lugar de antes de la operación)

Incorrecto:

```java
int a = 5;
int b = 2;

double result = (double) (a / b);
System.out.println(result); // 2.0
```

Aquí primero ocurre `a / b` como entero (2), y luego lo conviertes a `double` (2.0).

Correcto:

```java
double result = (double) a / b;
System.out.println(result); // 2.5
```

---

### 8.3. Convertir `String` con comas decimales

```java
String text = "10,5";
double value = Double.parseDouble(text); // error
```

Solución típica si el texto viene con coma:

```java
String text = "10,5";
text = text.replace(",", ".");

double value = Double.parseDouble(text);
System.out.println(value); // 10.5
```

---

### 8.4. Overflow al convertir a tipos más pequeños

```java
int value = 1000;
byte smallValue = (byte) value;

System.out.println(smallValue); // resultado inesperado
```

Solución:

- No hagas cast a tipos pequeños si no es estrictamente necesario.
- Si lo haces, asegúrate de que el rango es correcto.

---

## 9. Ejemplos guiados (paso a paso)

### 9.1. Ejemplo 1: calcular el total con IVA

Queremos sumar un precio base y aplicarle un IVA. Si trabajas con enteros, puedes perder precisión.

```java
public class Main {
    public static void main(String[] args) {
        int basePrice = 100;
        double vatRate = 0.21;

        double totalPrice = basePrice + (basePrice * vatRate);

        System.out.println(totalPrice); // 121.0
    }
}
```

Aquí ocurre conversión implícita porque `vatRate` es `double`.

---

### 9.2. Ejemplo 2: media de dos notas

```java
public class Main {
    public static void main(String[] args) {
        int grade1 = 7;
        int grade2 = 8;

        double average = (double) (grade1 + grade2) / 2;

        System.out.println(average); // 7.5
    }
}
```

Fíjate en el orden:

- `grade1 + grade2` se hace como `int`
- luego convertimos a `double` antes de dividir

Esto funciona porque el cast ocurre **antes** de la división.

---

### 9.3. Ejemplo 3: convertir un texto a número y operar

```java
public class Main {
    public static void main(String[] args) {
        String countText = "10";
        int count = Integer.parseInt(countText);

        int newCount = count + 5;

        System.out.println(newCount); // 15
    }
}
```

Sin conversión, `"10" + 5` no hace una suma numérica, hace concatenación.

---

## 10. A tener en cuenta

- La conversión implícita ocurre cuando no hay riesgo de pérdida.
- La conversión explícita (casting) puede perder información.
- La división entre enteros es una fuente clásica de errores.
- Convertir entre `String` y números es esencial en Java.
- Usa paréntesis y casts con intención: mejor claridad que “magia”.

---

En el próximo tema veremos **condicionales** (`if` y `switch`), donde estas conversiones serán muy útiles para comparar valores y tomar decisiones en nuestros programas.
