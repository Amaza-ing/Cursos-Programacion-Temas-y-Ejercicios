# Tema 26. Otras colecciones habituales de Java: `Set`, `LinkedHashMap` y `TreeMap`

## 1. Introducción

En el tema anterior aprendiste a trabajar con `Map` y `HashMap`, una estructura clave-valor muy útil cuando necesitas asociar datos.

Pero la librería de colecciones de Java ofrece más opciones, y es importante conocerlas porque no todas las estructuras se comportan igual.

En este tema vamos a estudiar tres colecciones muy habituales:

- `Set`
- `LinkedHashMap`
- `TreeMap`

Todas son muy útiles, pero cada una resuelve un problema diferente:

- `Set` sirve para guardar elementos **sin duplicados**
- `LinkedHashMap` es un mapa que **mantiene el orden de inserción**
- `TreeMap` es un mapa que **ordena automáticamente por clave**

Aprender a elegir bien la estructura correcta es muy importante en Java real.

En este tema aprenderás:

- Qué es un `Set`
- Qué diferencia hay entre `HashSet`, `LinkedHashSet` y `TreeSet` a nivel conceptual
- Cómo usar `Set` para evitar duplicados
- Qué es `LinkedHashMap` y cuándo usarlo en lugar de `HashMap`
- Qué es `TreeMap` y cómo ordena las claves
- Cómo recorrer estas colecciones
- Qué errores típicos debes evitar

---

[![Otras Colecciones](https://img.youtube.com/vi/BBNZmrhUKtc/0.jpg)](https://www.youtube.com/watch?v=BBNZmrhUKtc&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. La idea clave: no todas las colecciones hacen lo mismo

Hasta ahora ya has visto varias estructuras:

- Arrays
- `ArrayList`
- `HashMap`

Cada una tiene un propósito distinto.

### 2.1. `ArrayList`

Sirve para:

- guardar elementos en secuencia
- permitir duplicados
- acceder por índice
- mantener el orden de inserción

Ejemplo:

```java
List<String> names = new ArrayList<>();
names.add("Laura");
names.add("Alex");
names.add("Laura");
```

Aquí el valor `"Laura"` puede repetirse.

### 2.2. `Set`

Sirve para:

- guardar elementos únicos
- evitar duplicados
- no trabajar por índice

### 2.3. `Map`

Sirve para:

- guardar pares clave-valor
- acceder por clave

Por tanto:

- `List` = colección ordenada con posibles duplicados
- `Set` = colección sin duplicados
- `Map` = estructura clave-valor

---

## 3. Qué es un `Set`

Un `Set` es una colección que **no permite elementos duplicados**.

Ejemplo conceptual:

```text
["Laura", "Alex", "Laura", "Maria"]
```

En una lista eso sería válido.

Pero en un `Set`, el resultado sería algo equivalente a:

```text
["Laura", "Alex", "Maria"]
```

porque `"Laura"` no puede aparecer dos veces.

La interfaz principal es:

```java
Set<T>
```

Y una implementación muy usada es:

- `HashSet`

---

## 4. Importaciones necesarias

Para trabajar con `Set` y con algunas implementaciones habituales, suelen usarse estos imports:

```java
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
```

Más adelante también verás otras implementaciones como `LinkedHashSet` o `TreeSet`, pero en este tema vamos a centrarnos sobre todo en la idea general de `Set` y en `LinkedHashMap` y `TreeMap`.

---

## 5. Crear un `Set`

Forma habitual:

```java
Set<String> names = new HashSet<>();
```

Aquí estás diciendo:

- la colección guardará `String`
- no permitirá duplicados

Ejemplo:

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<String> names = new HashSet<>();

        names.add("Laura");
        names.add("Alex");
        names.add("Laura");

        System.out.println(names);
    }
}
```

Aunque intentes añadir `"Laura"` dos veces, en el conjunto solo habrá una.

---

## 6. Operación principal: `add`

Para insertar elementos se usa `add`.

```java
Set<String> cities = new HashSet<>();

cities.add("Madrid");
cities.add("Berlin");
cities.add("Paris");
```

Si añades un elemento repetido, el `Set` no lo guarda otra vez.

```java
cities.add("Madrid");
```

El conjunto seguirá teniendo una sola vez `"Madrid"`.

---

## 7. `add` devuelve `true` o `false`

Esto es muy útil y muchas veces se olvida.

En un `Set`, `add(...)` devuelve:

- `true` si el elemento se añadió
- `false` si no se añadió porque ya existía

Ejemplo:

```java
Set<String> names = new HashSet<>();

boolean firstInsert = names.add("Laura");
boolean secondInsert = names.add("Laura");

System.out.println(firstInsert);  // true
System.out.println(secondInsert); // false
```

Esto puede ser útil si quieres detectar duplicados.

---

## 8. `Set` no usa índices

A diferencia de una lista, un `Set` no tiene posiciones como `0`, `1`, `2`...

Esto no existe:

```java
// names.get(0); // NO
```

En un `Set`:

- no accedes por índice
- recorres los elementos con un bucle
- compruebas si un elemento existe
- añades y eliminas

Esto tiene sentido porque el objetivo de un `Set` no es gestionar posiciones, sino unicidad.

---

## 9. Métodos básicos de `Set`

Los métodos más importantes al empezar son:

- `add`
- `remove`
- `contains`
- `size`
- `isEmpty`
- `clear`

---

## 10. `contains`

Sirve para comprobar si un elemento está en el conjunto.

```java
Set<String> names = new HashSet<>();
names.add("Laura");
names.add("Alex");

System.out.println(names.contains("Laura")); // true
System.out.println(names.contains("Maria")); // false
```

---

## 11. `remove`

Sirve para eliminar un elemento.

```java
Set<String> names = new HashSet<>();
names.add("Laura");
names.add("Alex");

names.remove("Laura");

System.out.println(names.contains("Laura")); // false
```

También devuelve `true` o `false`:

- `true` si se eliminó
- `false` si no existía

---

## 12. `size`, `isEmpty` y `clear`

### 12.1. `size`

```java
Set<String> names = new HashSet<>();
names.add("Laura");
names.add("Alex");

System.out.println(names.size()); // 2
```

### 12.2. `isEmpty`

```java
Set<String> names = new HashSet<>();

System.out.println(names.isEmpty()); // true
```

### 12.3. `clear`

```java
Set<String> names = new HashSet<>();
names.add("Laura");
names.add("Alex");

names.clear();

System.out.println(names.size()); // 0
```

---

## 13. Recorrer un `Set`

Como no hay índices, se suele recorrer con `for-each`.

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<String> names = new HashSet<>();

        names.add("Laura");
        names.add("Alex");
        names.add("Maria");

        for (String name : names) {
            System.out.println(name);
        }
    }
}
```

---

## 14. Orden en `HashSet`

Igual que ocurría con `HashMap`, **`HashSet` no garantiza el orden**.

Ejemplo:

```java
Set<String> names = new HashSet<>();
names.add("Laura");
names.add("Alex");
names.add("Maria");

System.out.println(names);
```

El orden de impresión puede no coincidir con el orden en que añadiste los elementos.

Por tanto:

- no asumas orden de inserción
- no uses `HashSet` si necesitas orden concreto

---

## 15. Cuándo usar un `Set`

Un `Set` es ideal cuando quieres:

- evitar duplicados
- comprobar rápidamente si algo ya existe
- trabajar con una colección de elementos únicos

Ejemplos típicos:

- usuarios únicos conectados
- categorías de productos sin repetir
- palabras únicas en un texto
- emails registrados sin duplicados

---

## 16. Ejemplo guiado: eliminar duplicados de una lista

Este es uno de los usos más típicos de `Set`.

```java
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        List<String> names = new ArrayList<>();
        names.add("Laura");
        names.add("Alex");
        names.add("Laura");
        names.add("Maria");
        names.add("Alex");

        Set<String> uniqueNames = new HashSet<>(names);

        System.out.println(names);
        System.out.println(uniqueNames);
    }
}
```

Aquí:

- la lista original tiene duplicados
- el `Set` elimina los repetidos automáticamente

---

## 17. Ejemplo guiado: detectar si un valor ya apareció

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        String[] words = {"java", "code", "map", "java", "set"};

        Set<String> seenWords = new HashSet<>();

        for (String word : words) {
            if (seenWords.add(word)) {
                System.out.println("New word: " + word);
            } else {
                System.out.println("Repeated word: " + word);
            }
        }
    }
}
```

Aquí aprovechamos que `add(...)` devuelve `false` si el elemento ya existía.

---

## 18. Variantes importantes de `Set`

Aunque `Set` es la interfaz, hay varias implementaciones.

A nivel inicial conviene que tengas esta idea mental:

- `HashSet` → no garantiza orden
- `LinkedHashSet` → mantiene orden de inserción
- `TreeSet` → ordena automáticamente

En este tema no vamos a profundizar en todas ellas, pero es importante que sepas que existen porque siguen la misma lógica que verás ahora con `LinkedHashMap` y `TreeMap`.

---

## 19. Qué es `LinkedHashMap`

En el tema anterior viste `HashMap`, que:

- guarda pares clave-valor
- permite búsqueda rápida por clave
- **no garantiza el orden**

`LinkedHashMap` es muy parecido a `HashMap`, pero con una diferencia clave:

> `LinkedHashMap` mantiene el orden de inserción.

Es decir, si insertas:

```text
"Laura" -> 28
"Alex"  -> 35
"Maria" -> 31
```

al recorrer el mapa, aparecerán en ese mismo orden.

---

## 20. Crear un `LinkedHashMap`

```java
import java.util.LinkedHashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new LinkedHashMap<>();

        ages.put("Laura", 28);
        ages.put("Alex", 35);
        ages.put("Maria", 31);

        System.out.println(ages);
    }
}
```

Resultado esperado:

```text
{Laura=28, Alex=35, Maria=31}
```

Aquí sí se conserva el orden de inserción.

---

## 21. `LinkedHashMap` tiene casi la misma forma de uso que `HashMap`

Los métodos básicos son los mismos:

- `put`
- `get`
- `remove`
- `containsKey`
- `containsValue`
- `size`
- `isEmpty`
- `clear`
- `entrySet`
- `keySet`
- `values`

Ejemplo:

```java
import java.util.LinkedHashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> prices = new LinkedHashMap<>();

        prices.put("Mouse", 19.99);
        prices.put("Keyboard", 49.99);
        prices.put("Monitor", 199.99);

        System.out.println(prices.get("Keyboard"));
        System.out.println(prices.containsKey("Mouse"));

        prices.remove("Monitor");

        for (Map.Entry<String, Double> entry : prices.entrySet()) {
            System.out.println(entry.getKey() + " -> " + entry.getValue());
        }
    }
}
```

La gran diferencia no está en los métodos, sino en el comportamiento del orden.

---

## 22. Cuándo usar `LinkedHashMap`

Usa `LinkedHashMap` cuando necesitas:

- asociar clave y valor
- mantener el orden en que insertaste las entradas

Ejemplos típicos:

- mostrar datos en el mismo orden en que se cargaron
- generar menús o configuraciones ordenadas
- almacenar historial de inserción
- tener comportamiento más predecible al imprimir o recorrer

---

## 23. `HashMap` vs `LinkedHashMap`

### 23.1. `HashMap`

- estructura clave-valor
- no garantiza orden

### 23.2. `LinkedHashMap`

- estructura clave-valor
- mantiene orden de inserción

Ejemplo comparativo:

```java
Map<String, Integer> hashMap = new HashMap<>();
Map<String, Integer> linkedHashMap = new LinkedHashMap<>();

hashMap.put("C", 3);
hashMap.put("A", 1);
hashMap.put("B", 2);

linkedHashMap.put("C", 3);
linkedHashMap.put("A", 1);
linkedHashMap.put("B", 2);

System.out.println(hashMap);
System.out.println(linkedHashMap);
```

En `linkedHashMap`, el orden será:

```text
{C=3, A=1, B=2}
```

En `hashMap`, no debes asumir nada.

---

## 24. Qué es `TreeMap`

`TreeMap` es otra implementación de `Map`, pero con una diferencia muy importante:

> `TreeMap` ordena automáticamente las entradas por la clave.

No por el orden de inserción, sino por el **orden natural de las claves**.

Ejemplo con claves `String`:

- `"A"`
- `"B"`
- `"C"`

Ejemplo con claves `Integer`:

- `1`
- `2`
- `3`

---

## 25. Crear un `TreeMap`

```java
import java.util.Map;
import java.util.TreeMap;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new TreeMap<>();

        ages.put("Maria", 31);
        ages.put("Alex", 35);
        ages.put("Laura", 28);

        System.out.println(ages);
    }
}
```

Resultado esperado:

```text
{Alex=35, Laura=28, Maria=31}
```

Aunque insertaste en otro orden, `TreeMap` organiza por clave.

---

## 26. Ejemplo con claves numéricas en `TreeMap`

```java
import java.util.Map;
import java.util.TreeMap;

public class Main {
    public static void main(String[] args) {
        Map<Integer, String> students = new TreeMap<>();

        students.put(3, "Laura");
        students.put(1, "Alex");
        students.put(2, "Maria");

        System.out.println(students);
    }
}
```

Resultado esperado:

```text
{1=Alex, 2=Maria, 3=Laura}
```

---

## 27. `TreeMap` también usa los mismos métodos básicos

Los métodos principales son los mismos que en otros mapas:

- `put`
- `get`
- `remove`
- `containsKey`
- `size`
- `entrySet`

Ejemplo:

```java
import java.util.Map;
import java.util.TreeMap;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> prices = new TreeMap<>();

        prices.put("Keyboard", 49.99);
        prices.put("Mouse", 19.99);
        prices.put("Monitor", 199.99);

        System.out.println(prices.get("Mouse"));

        for (Map.Entry<String, Double> entry : prices.entrySet()) {
            System.out.println(entry.getKey() + " -> " + entry.getValue());
        }
    }
}
```

La diferencia sigue siendo el orden por clave.

---

## 28. Cuándo usar `TreeMap`

Usa `TreeMap` cuando necesitas:

- almacenar pares clave-valor
- tener las claves ordenadas automáticamente

Ejemplos típicos:

- listado alfabético de productos
- ranking por identificador numérico
- mostrar datos ordenados por clave sin ordenar manualmente después
- estructuras donde el orden por clave es importante

---

## 29. `LinkedHashMap` vs `TreeMap`

Esta comparación es muy importante.

### 29.1. `LinkedHashMap`

Mantiene:

- el orden en que insertaste las entradas

Ejemplo:

```text
C -> 3
A -> 1
B -> 2
```

Se recorre así:

```text
C, A, B
```

### 29.2. `TreeMap`

Mantiene:

- el orden natural de las claves

Con esas mismas claves, se recorre así:

```text
A, B, C
```

### 29.3. Regla práctica

- Si quieres conservar el orden de inserción → `LinkedHashMap`
- Si quieres ordenar por clave automáticamente → `TreeMap`

---

## 30. Qué pasa con claves duplicadas en `LinkedHashMap` y `TreeMap`

Igual que en cualquier `Map`, las claves son únicas.

Si repites una clave, el valor anterior se sobrescribe.

Ejemplo:

```java
Map<String, Integer> ages = new TreeMap<>();

ages.put("Laura", 28);
ages.put("Laura", 29);

System.out.println(ages.get("Laura")); // 29
```

No se crean dos entradas. Solo queda una.

---

## 31. `null` en estas colecciones

### 31.1. `LinkedHashMap`

Se comporta de forma parecida a `HashMap` en muchos casos y permite trabajar con `null` en clave y valores.

### 31.2. `TreeMap`

Aquí hay que tener más cuidado.

Como `TreeMap` necesita ordenar claves, el uso de `null` como clave puede dar problemas porque no puede compararse correctamente en el orden natural.

A nivel inicial, la mejor recomendación es:

- evita usar `null` como clave en `TreeMap`
- usa claves comparables y bien definidas

---

## 32. Recorrer `LinkedHashMap` y `TreeMap`

Igual que con `HashMap`, la forma más útil suele ser `entrySet()`.

### 32.1. Recorrido de `LinkedHashMap`

```java
Map<String, Integer> ages = new LinkedHashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);
ages.put("Maria", 31);

for (Map.Entry<String, Integer> entry : ages.entrySet()) {
    System.out.println(entry.getKey() + " -> " + entry.getValue());
}
```

### 32.2. Recorrido de `TreeMap`

```java
Map<String, Integer> ages = new TreeMap<>();
ages.put("Maria", 31);
ages.put("Alex", 35);
ages.put("Laura", 28);

for (Map.Entry<String, Integer> entry : ages.entrySet()) {
    System.out.println(entry.getKey() + " -> " + entry.getValue());
}
```

La sintaxis es la misma, pero el orden de recorrido cambia.

---

## 33. Ejemplo completo: categorías únicas con `Set`

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<String> categories = new HashSet<>();

        categories.add("Technology");
        categories.add("Books");
        categories.add("Technology");
        categories.add("Sports");

        System.out.println("Total categories: " + categories.size());

        for (String category : categories) {
            System.out.println(category);
        }
    }
}
```

Aquí:

- `"Technology"` solo aparece una vez
- el conjunto evita duplicados automáticamente

---

## 34. Ejemplo completo: historial de inserción con `LinkedHashMap`

```java
import java.util.LinkedHashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, String> capitals = new LinkedHashMap<>();

        capitals.put("Spain", "Madrid");
        capitals.put("France", "Paris");
        capitals.put("Germany", "Berlin");

        for (Map.Entry<String, String> entry : capitals.entrySet()) {
            System.out.println(entry.getKey() + " -> " + entry.getValue());
        }
    }
}
```

Este ejemplo mantiene el orden:

1. Spain
2. France
3. Germany

---

## 35. Ejemplo completo: mapa ordenado con `TreeMap`

```java
import java.util.Map;
import java.util.TreeMap;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> products = new TreeMap<>();

        products.put("Keyboard", 49.99);
        products.put("Mouse", 19.99);
        products.put("Cable", 5.99);
        products.put("Monitor", 199.99);

        for (Map.Entry<String, Double> entry : products.entrySet()) {
            System.out.println("Product: " + entry.getKey() + " | Price: " + entry.getValue());
        }
    }
}
```

Aunque insertes en otro orden, el resultado estará ordenado por nombre de producto.

---

## 36. Cómo elegir la estructura correcta

Aquí tienes una guía mental muy útil.

### 36.1. Usa `Set` cuando

- no quieres duplicados
- no te importa trabajar por índice
- quieres comprobar existencia de elementos únicos

### 36.2. Usa `HashMap` cuando

- quieres pares clave-valor
- no necesitas orden

### 36.3. Usa `LinkedHashMap` cuando

- quieres pares clave-valor
- quieres mantener el orden de inserción

### 36.4. Usa `TreeMap` cuando

- quieres pares clave-valor
- quieres que las claves estén ordenadas automáticamente

---

## 37. Errores típicos al empezar

### 37.1. Intentar usar índices en un `Set`

Esto no existe:

```java
// set.get(0); // error
```

### 37.2. Pensar que `HashSet` mantiene orden

No debes asumirlo.

### 37.3. Pensar que `LinkedHashMap` ordena alfabéticamente

No ordena alfabéticamente por sí mismo.  
Solo mantiene el orden de inserción.

### 37.4. Pensar que `TreeMap` conserva el orden de inserción

No.  
`TreeMap` ordena por clave.

### 37.5. Olvidar que las claves en un `Map` son únicas

Si repites la clave, reemplazas el valor anterior.

---

## 38. Buenas prácticas iniciales

- Usa la interfaz como tipo de referencia cuando tenga sentido:
  - `Set<String> names = new HashSet<>();`
  - `Map<String, Integer> ages = new LinkedHashMap<>();`
- Elige la colección según el comportamiento que necesitas, no por costumbre.
- Si necesitas unicidad, piensa en `Set`.
- Si necesitas orden de inserción en un mapa, piensa en `LinkedHashMap`.
- Si necesitas orden por clave, piensa en `TreeMap`.
- Usa nombres claros como:
  - `uniqueNames`
  - `pricesByProduct`
  - `usersById`
  - `capitalsByCountry`

---

## 39. A tener en cuenta

- `Set` guarda elementos únicos.
- `HashSet` no garantiza orden.
- `LinkedHashMap` mantiene el orden de inserción.
- `TreeMap` ordena automáticamente por clave.
- `Map` sigue usando pares clave-valor con claves únicas.
- Elegir bien la colección hace el código más claro y más útil.

---

## 40. Resumen final

En Java no existe una única colección “mejor” para todo.

Cada estructura está pensada para un tipo de problema.

- `Set` te ayuda a trabajar con valores únicos
- `LinkedHashMap` te ayuda a conservar el orden en que añadiste entradas
- `TreeMap` te ayuda a tener claves ordenadas automáticamente

Saber distinguir estos casos es muy importante porque, en proyectos reales, la elección de la colección adecuada simplifica mucho el código y evita errores innecesarios.

---
