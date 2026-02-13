# Tema 13. `List` y `ArrayList`

## 1. Introducción

Hasta ahora has trabajado con **arrays**, que son una estructura fundamental en Java. Sin embargo, los arrays tienen varias limitaciones importantes:

- Su tamaño es **fijo** (no puede crecer ni reducirse)
- No tienen métodos “de alto nivel” para insertar, borrar, buscar, etc.
- Al gestionar inserciones o eliminaciones, tú tienes que mover elementos manualmente

Para resolver esto, Java proporciona las **colecciones**, y una de las más usadas es:

- `List` (interfaz)
- `ArrayList` (implementación)

**Idea clave:**

- **`List`** define “qué operaciones puedo hacer” (contrato).
- **`ArrayList`** es una clase concreta que implementa ese contrato y funciona con un array interno que crece automáticamente.

En este tema aprenderás:

- Qué es `List` y qué es `ArrayList`
- Por qué necesitas **wrappers** (`Integer`, `Double`, etc.) en colecciones
- Cómo crear, añadir, obtener, modificar y eliminar elementos
- Cómo recorrer listas con bucles
- Métodos útiles (`contains`, `indexOf`, `isEmpty`, `clear`…)
- Conversión entre arrays y listas
- Errores típicos (índices, `null`, `ConcurrentModificationException`, etc.)

---

## 2. `List` vs `ArrayList`

### 2.1. ¿Qué es `List`?

`List` es una **interfaz** de Java que representa una colección ordenada de elementos.

Características de una `List`:

- Tiene **orden** (hay posición 0, 1, 2…)
- Permite **duplicados**
- Se accede por **índice** (igual que en arrays)

### 2.2. ¿Qué es `ArrayList`?

`ArrayList` es una clase que implementa `List` y guarda los elementos internamente en un array que puede crecer.

En general, `ArrayList` es la opción por defecto cuando necesitas:

- Añadir elementos dinámicamente
- Acceder rápido por índice (`get(i)`)
- Recorrer la lista con facilidad

---

## 3. Importación necesaria

`List` y `ArrayList` no están en `java.lang`, así que hay que importarlas:

```java
import java.util.ArrayList;
import java.util.List;
```

---

## 4. Genéricos: `List<T>`

En Java, las colecciones se definen con **genéricos**, indicando el tipo de elementos que pueden contener.

Ejemplo:

```java
List<String> names = new ArrayList<>();
```

Aquí estás diciendo:

- “`names` es una lista de `String`”
- No podrás meter `int`, `double`, etc. (a menos que sean wrappers)

---

## 5. ¿Por qué usamos wrappers en listas?

Las colecciones guardan **objetos**, no tipos primitivos.

Por eso esto no existe:

```java
// List<int> numbers = new ArrayList<>(); // NO
```

La forma correcta:

```java
List<Integer> numbers = new ArrayList<>();
List<Double> prices = new ArrayList<>();
List<Boolean> flags = new ArrayList<>();
```

Esto conecta directamente con el **Tema 10: Wrappers**.

---

## 6. Crear una `ArrayList`

Forma recomendada:

```java
List<String> names = new ArrayList<>();
```

Por qué así:

- Declaras con la interfaz (`List`) para programar de forma flexible
- Usas una implementación concreta (`ArrayList`) para crear el objeto

También puedes declarar directamente como `ArrayList`, pero se recomienda menos:

```java
ArrayList<String> names = new ArrayList<>();
```

---

## 7. Operaciones básicas: `add`, `get`, `set`, `remove`

Vamos a construir una lista y trabajar con sus elementos.

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> cities = new ArrayList<>();

        cities.add("Madrid");
        cities.add("Berlin");
        cities.add("Paris");

        System.out.println(cities.get(0)); // Madrid
        System.out.println(cities.get(2)); // Paris
    }
}
```

### 7.1. `add(element)`

Añade al final:

```java
cities.add("Rome");
```

### 7.2. `add(index, element)`

Inserta en una posición concreta (mueve el resto hacia la derecha):

```java
cities.add(1, "Lisbon");
```

### 7.3. `get(index)`

Obtiene el elemento en la posición:

```java
String first = cities.get(0);
```

### 7.4. `set(index, element)`

Reemplaza el elemento en una posición (no cambia el tamaño):

```java
cities.set(0, "Valencia");
```

### 7.5. `remove(index)` y `remove(object)`

- Eliminar por índice:

```java
cities.remove(1);
```

- Eliminar por valor (si existe, elimina la primera coincidencia):

```java
cities.remove("Paris");
```

---

## 8. Tamaño y comprobaciones: `size`, `isEmpty`

### 8.1. `size()`

Equivalente a `length` en arrays, pero aquí es un método:

```java
System.out.println(cities.size());
```

### 8.2. `isEmpty()`

```java
if (cities.isEmpty()) {
    System.out.println("No cities");
}
```

---

## 9. Recorrer una lista

### 9.1. Bucle `for` con índices

```java
for (int i = 0; i < cities.size(); i++) {
    System.out.println(cities.get(i));
}
```

### 9.2. Bucle `for-each`

```java
for (String city : cities) {
    System.out.println(city);
}
```

---

## 10. Métodos útiles: `contains`, `indexOf`, `lastIndexOf`

```java
boolean hasBerlin = cities.contains("Berlin");
int pos = cities.indexOf("Paris");

cities.add("Berlin");
int firstBerlin = cities.indexOf("Berlin");
int lastBerlin = cities.lastIndexOf("Berlin");

System.out.println(hasBerlin);
System.out.println(pos);
System.out.println(firstBerlin);
System.out.println(lastBerlin);
```

---

## 11. Duplicados y orden

Una `List`:

- Permite duplicados
- Mantiene el orden de inserción

```java
List<Integer> values = new ArrayList<>();
values.add(5);
values.add(5);
values.add(2);

System.out.println(values); // [5, 5, 2]
```

---

## 12. `null` en listas

En una lista puedes guardar `null` (depende de tu diseño, pero es posible):

```java
List<String> names = new ArrayList<>();
names.add("Laura");
names.add(null);
names.add("Alex");
```

Cuidado: si llamas métodos sobre un elemento `null`, tendrás `NullPointerException`.

---

## 13. `remove` y el caso especial de `List<Integer>`

Con `List<Integer>`, `remove` puede ser confuso porque existe:

- `remove(int index)`
- `remove(Object o)`

Si quieres eliminar el valor 20:

```java
numbers.remove(Integer.valueOf(20));
```

---

## 14. `clear()`

```java
cities.clear();
System.out.println(cities.size()); // 0
```

---

## 15. Ordenar una lista: `Collections.sort` y `List.sort`

```java
import java.util.Collections;

Collections.sort(cities);
cities.sort(null); // orden natural
```

---

## 16. Convertir entre arrays y listas

### 16.1. Array → List

`List.of(...)` es inmutable:

```java
List<String> fixed = List.of("A", "B", "C");
// fixed.add("D"); // UnsupportedOperationException
```

Lista modificable a partir de otra lista:

```java
List<String> names = new ArrayList<>(List.of("A", "B", "C"));
names.add("D");
```

### 16.2. List → Array

```java
String[] array = names.toArray(new String[0]);
```

---

## 17. Ejemplos guiados completos

### 17.1. Gestión de tareas

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> tasks = new ArrayList<>();

        tasks.add("Study Java");
        tasks.add("Practice loops");
        tasks.add("Read about ArrayList");

        tasks.set(1, "Practice for and while loops");
        tasks.remove("Study Java");

        System.out.println(tasks);
    }
}
```

### 17.2. Sumar valores en `List<Integer>`

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> values = new ArrayList<>();
        values.add(10);
        values.add(20);
        values.add(5);

        int sum = 0;

        for (Integer value : values) {
            sum += value; // unboxing automático
        }

        System.out.println(sum); // 35
    }
}
```

---

## 18. Errores típicos y cómo evitarlos

- `IndexOutOfBoundsException`: índices válidos de `0` a `size() - 1`
- Evita eliminar elementos en un `for-each` (puede causar `ConcurrentModificationException`)
- Con `List<Integer>`, usa `remove(Integer.valueOf(x))` si quieres borrar por valor

Ejemplo moderno para eliminar por condición:

```java
items.removeIf(item -> item.equals("A"));
```

---

## 19. A tener en cuenta

- `List` es la interfaz; `ArrayList` es una implementación común.
- Las listas tienen tamaño dinámico.
- En colecciones se usan wrappers (`Integer`, `Double`, etc.), no primitivos.
- Métodos esenciales: `add`, `get`, `set`, `remove`, `size`, `contains`, `indexOf`.
- Cuidado con `null`, con índices fuera de rango y con `remove` en `List<Integer>`.

---

En el siguiente tema aprenderemos qué son las **clases y objetos**, y nos adentraremos en el mundo de la programación orientada a objetos (**POO**).
