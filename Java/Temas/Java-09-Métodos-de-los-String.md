# Tema 9. Métodos de `String`

## 1. Introducción

En Java, `String` es el tipo más importante para trabajar con texto. Lo vas a usar constantemente:

- Nombres de usuario
- Mensajes por consola
- Datos leídos desde teclado
- Rutas de archivos
- Validaciones
- Formateo de resultados

Aunque `String` se “usa como un tipo básico”, en realidad **es un objeto** y por eso tiene muchos métodos útiles.

En este tema aprenderás:

- Qué significa que `String` sea **inmutable**
- Métodos esenciales para medir, comparar y buscar texto
- Métodos para extraer partes (`substring`) y acceder a caracteres (`charAt`)
- Transformaciones típicas (`toLowerCase`, `strip`, `replace`…)
- Métodos para dividir y unir texto (`split`, `String.join`)
- Buenas prácticas y errores comunes (`==` vs `equals`, `null`, etc.)

---

## 2. `String` es inmutable (idea clave)

En Java, los `String` son **inmutables**: no puedes cambiar el contenido de un `String` existente.  
Cuando “modificas” un `String`, en realidad estás creando **uno nuevo**.

Ejemplo:

```java
String text = "Hello";
text.toUpperCase();

System.out.println(text); // "Hello"
```

¿Por qué? Porque `toUpperCase()` devuelve un nuevo `String`, pero tú no lo guardaste.

Forma correcta:

```java
String text = "Hello";
text = text.toUpperCase();

System.out.println(text); // "HELLO"
```

---

## 3. Longitud: `length()`

`length()` devuelve el número de caracteres de un `String`.

```java
String userName = "Laura";
int size = userName.length();

System.out.println(size); // 5
```

Esto es muy común en validaciones:

```java
String password = "mySecret1";
boolean isLongEnough = password.length() >= 8;

System.out.println(isLongEnough);
```

---

## 4. Acceso a caracteres: `charAt(index)`

`charAt(int index)` devuelve el carácter en la posición indicada.

```java
String code = "A7X";
char first = code.charAt(0);
char last = code.charAt(2);

System.out.println(first); // 'A'
System.out.println(last);  // 'X'
```

Recuerda: los índices empiezan en 0.

### 4.1. Error típico: índice fuera de rango

```java
String text = "Hi";
char letter = text.charAt(2); // error
```

Los índices válidos son 0 y 1.

---

## 5. Extraer partes: `substring(beginIndex)` y `substring(beginIndex, endIndex)`

`substring` sirve para obtener una parte del texto.

### 5.1. `substring(beginIndex)`

Devuelve desde `beginIndex` hasta el final.

```java
String text = "JavaProgramming";
String part = text.substring(4);

System.out.println(part); // "Programming"
```

### 5.2. `substring(beginIndex, endIndex)`

Devuelve desde `beginIndex` hasta `endIndex`, pero **sin incluir** `endIndex`.

```java
String text = "JavaProgramming";
String part = text.substring(0, 4);

System.out.println(part); // "Java"
```

Regla práctica:

- `beginIndex` incluido
- `endIndex` excluido

---

## 6. Comparar `String`: `equals(...)` y `equalsIgnoreCase(...)`

### 6.1. Por qué NO usar `==`

`==` compara referencias (si son el mismo objeto), no el contenido.

```java
String a = "admin";
String b = "admin";

System.out.println(a == b); // puede ser true o false dependiendo del caso
```

Lo correcto para contenido es `equals`:

```java
String a = "admin";
String b = "admin";

System.out.println(a.equals(b)); // true
```

### 6.2. Comparación sin distinguir mayúsculas: `equalsIgnoreCase`

```java
String input = "Admin";

boolean isAdmin = input.equalsIgnoreCase("admin");
System.out.println(isAdmin); // true
```

---

## 7. Comparación alfabética: `compareTo(...)`

`compareTo` compara dos `String` en orden “alfabético” (orden lexicográfico).

- Devuelve 0 si son iguales
- Devuelve un número negativo si el primero “va antes”
- Devuelve un número positivo si el primero “va después”

```java
String a = "apple";
String b = "banana";

System.out.println(a.compareTo(b)); // negativo
System.out.println(b.compareTo(a)); // positivo
System.out.println(a.compareTo("apple")); // 0
```

---

## 8. Buscar texto dentro de texto

### 8.1. `contains(...)`

Devuelve `true` si el texto contiene una subcadena.

```java
String email = "laura@example.com";
boolean hasAt = email.contains("@");

System.out.println(hasAt); // true
```

### 8.2. `startsWith(...)` y `endsWith(...)`

```java
String fileName = "report_2026.pdf";

System.out.println(fileName.startsWith("report_")); // true
System.out.println(fileName.endsWith(".pdf"));      // true
```

---

## 9. Encontrar posiciones: `indexOf(...)` y `lastIndexOf(...)`

### 9.1. `indexOf(...)`

Devuelve el índice de la primera ocurrencia. Si no encuentra, devuelve `-1`.

```java
String text = "Java is Java";
int first = text.indexOf("Java");

System.out.println(first); // 0
```

### 9.2. Buscar desde un índice

```java
String text = "Java is Java";
int second = text.indexOf("Java", 1);

System.out.println(second); // 8
```

### 9.3. `lastIndexOf(...)`

Devuelve el índice de la última ocurrencia.

```java
String text = "Java is Java";
int last = text.lastIndexOf("Java");

System.out.println(last); // 8
```

---

## 10. Reemplazar texto: `replace(...)`, `replaceAll(...)`, `replaceFirst(...)`

### 10.1. `replace(old, new)` (simple)

```java
String text = "Hello world";
String updated = text.replace("world", "Java");

System.out.println(updated); // "Hello Java"
```

### 10.2. Reemplazar caracteres

```java
String phone = "123-456-789";
String cleaned = phone.replace("-", "");

System.out.println(cleaned); // "123456789"
```

### 10.3. `replaceAll(...)` (usa expresiones regulares)

`replaceAll` trabaja con patrones (regex). Úsalo si lo necesitas, pero si solo reemplazas texto literal, `replace` suele ser mejor.

Ejemplo: eliminar espacios múltiples (regex):

```java
String text = "Hello   Java   25";
String normalized = text.replaceAll("\\s+", " ");

System.out.println(normalized); // "Hello Java 25"
```

---

## 11. Mayúsculas y minúsculas: `toUpperCase()` y `toLowerCase()`

```java
String country = "Es";
System.out.println(country.toUpperCase()); // "ES"
System.out.println(country.toLowerCase()); // "es"
```

Esto se usa mucho antes de comparar entradas:

```java
String input = "YES";
boolean isYes = input.toLowerCase().equals("yes");

System.out.println(isYes);
```

---

## 12. Quitar espacios: `trim()` y `strip()`

### 12.1. `trim()`

Elimina espacios “simples” al principio y al final.

```java
String raw = "   hello   ";
String clean = raw.trim();

System.out.println(clean); // "hello"
```

### 12.2. `strip()`

`strip()` es más moderno y maneja mejor ciertos tipos de espacios Unicode.

```java
String raw = "   hello   ";
String clean = raw.strip();

System.out.println(clean); // "hello"
```

---

## 13. Vacío vs blanco: `isEmpty()` y `isBlank()`

- `isEmpty()` es `true` si la longitud es 0 (`""`).
- `isBlank()` es `true` si está vacío o solo tiene espacios.

```java
String a = "";
String b = "   ";

System.out.println(a.isEmpty()); // true
System.out.println(b.isEmpty()); // false

System.out.println(a.isBlank()); // true
System.out.println(b.isBlank()); // true
```

---

## 14. Dividir texto: `split(...)`

`split` separa un texto en partes y devuelve un array de `String`.

```java
String line = "Laura,28,Madrid";
String[] parts = line.split(",");

System.out.println(parts[0]); // "Laura"
System.out.println(parts[1]); // "28"
System.out.println(parts[2]); // "Madrid"
```

### 14.1. Cuidado: `split` usa regex

Si divides por un punto `.` tienes que escaparlo:

```java
String domain = "example.com";
String[] parts = domain.split("\\.");

System.out.println(parts[0]); // "example"
System.out.println(parts[1]); // "com"
```

---

## 15. Unir texto: `String.join(...)`

```java
String result = String.join(" - ", "Java", "IntelliJ", "JDK");
System.out.println(result); // "Java - IntelliJ - JDK"
```

---

## 16. Formatear texto: `String.format(...)`

```java
String userName = "Laura";
int age = 28;

String message = String.format("User: %s | Age: %d", userName, age);
System.out.println(message);
```

Ejemplo con decimales:

```java
double price = 19.99;
String text = String.format("Price: %.2f", price);

System.out.println(text); // "Price: 19.99"
```

---

## 17. Convertir a `String`: `String.valueOf(...)`

```java
int level = 5;
String text = String.valueOf(level);

System.out.println("Level: " + text);
```

---

## 18. Repetir texto: `repeat(n)`

```java
String dash = "-";
System.out.println(dash.repeat(10)); // "----------"
```

---

## 19. `String` y caracteres especiales (escapes)

- `\n` salto de línea
- `\t` tabulación
- `\"` comilla doble
- `\\` barra invertida

```java
String text = "Line 1\nLine 2";
System.out.println(text);
```

---

## 20. `null` y `String`: cómo evitar errores

Patrón seguro con comprobación:

```java
String name = null;

if (name != null && !name.isBlank()) {
    System.out.println(name.length());
}
```

Comparación sin riesgo:

```java
String role = null;

boolean isAdmin = "admin".equals(role);
System.out.println(isAdmin);
```

---

## 21. `+` vs `StringBuilder` (vista previa)

Para concatenaciones repetidas, `StringBuilder` suele ser mejor:

```java
StringBuilder builder = new StringBuilder();
builder.append("User: ");
builder.append("Laura");

String message = builder.toString();
System.out.println(message);
```

---

## 22. Ejemplos guiados completos

### 22.1. Normalizar entrada de usuario

```java
public class Main {
    public static void main(String[] args) {
        String input = "   StArT   ";

        String normalized = input.strip().toLowerCase();

        if (normalized.equals("start")) {
            System.out.println("Starting...");
        } else {
            System.out.println("Unknown command");
        }
    }
}
```

---

### 22.2. Extraer extensión de un archivo

```java
public class Main {
    public static void main(String[] args) {
        String fileName = "report_2026.pdf";

        int dotIndex = fileName.lastIndexOf(".");

        if (dotIndex == -1) {
            System.out.println("No extension");
        } else {
            String extension = fileName.substring(dotIndex + 1);
            System.out.println(extension);
        }
    }
}
```

---

### 22.3. Convertir una línea CSV en variables

```java
public class Main {
    public static void main(String[] args) {
        String line = "Laura,28,19.99";

        String[] parts = line.split(",");

        String userName = parts[0];
        int age = Integer.parseInt(parts[1]);
        double price = Double.parseDouble(parts[2]);

        String message = String.format("User: %s | Age: %d | Price: %.2f", userName, age, price);
        System.out.println(message);
    }
}
```

---

## 23. A tener en cuenta

- Los `String` son inmutables: guarda el resultado de los métodos si quieres “modificar” el texto.
- Para comparar contenido usa `equals` (y `equalsIgnoreCase` si aplica).
- `substring`, `indexOf` y `split` son esenciales para procesar texto.
- `strip/trim`, `isBlank/isEmpty` son clave en validaciones.
- Evita `NullPointerException` comprobando `null` o comparando con `"literal".equals(variable)`.

---

En el próximo tema aprenderemos sobre los **Wrappers de tipos primitivos**, y verás qué ventajas tienen frente a usar los tipos básicos.
