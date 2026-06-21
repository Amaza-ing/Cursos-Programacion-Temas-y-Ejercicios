# Tema 30. Stream API

## 1. Introducción

En el tema anterior aprendiste qué son las **lambdas** y las **interfaces funcionales**, y viste cómo permiten escribir código más compacto y expresivo.

Ahora vamos a estudiar una de las herramientas más importantes del Java moderno:

- **Stream API**

`Stream API` permite trabajar con colecciones y secuencias de datos de una forma más declarativa.

En lugar de decir paso a paso:

- recorre esta lista
- comprueba esta condición
- transforma estos valores
- guarda este resultado

puedes expresar la intención de una forma más clara:

- filtra estos elementos
- transforma estos valores
- ordénalos
- recógelos en una lista

Esto hace que muchas operaciones sobre datos sean:

- más legibles
- más compactas
- más fáciles de encadenar
- más expresivas

En este tema aprenderás:

- Qué es un `Stream`
- Cómo crear streams
- Operaciones intermedias y terminales
- Métodos como `filter`, `map`, `sorted`, `distinct`, `limit`
- Cómo convertir el resultado en listas u otras estructuras
- Qué es `forEach`
- Métodos como `count`, `anyMatch`, `allMatch`, `findFirst`
- Reducciones con `reduce`
- Qué relación tiene `Stream API` con lambdas
- Errores típicos y buenas prácticas

---

## 2. Qué es un `Stream`

Un `Stream` es una secuencia de elementos sobre la que puedes aplicar operaciones como:

- filtrar
- transformar
- ordenar
- limitar
- contar
- recopilar resultados

Es muy importante entender esto:

> Un `Stream` no es una colección.

Una lista guarda datos.  
Un stream representa una forma de **procesar** datos.

Por ejemplo, si tienes una lista:

```java
List<String> names = List.of("Laura", "Alex", "Maria");
```

puedes crear un stream a partir de ella:

```java
names.stream()
```

y luego encadenar operaciones.

---

## 3. Procesamiento imperativo vs declarativo

Para entender bien `Stream API`, es útil comparar dos estilos.

### 3.1. Estilo imperativo

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "Jo");
        List<String> result = new ArrayList<>();

        for (String name : names) {
            if (name.length() >= 5) {
                result.add(name.toUpperCase());
            }
        }

        System.out.println(result);
    }
}
```

Aquí indicas paso a paso cómo hacerlo.

### 3.2. Estilo declarativo con streams

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "Jo");

        List<String> result = names.stream()
                .filter(name -> name.length() >= 5)
                .map(name -> name.toUpperCase())
                .toList();

        System.out.println(result);
    }
}
```

Aquí expresas la intención:

- filtra
- transforma
- conviértelo en lista

Ese es el gran valor de `Stream API`.

---

## 4. Cómo crear un stream

La forma más habitual es a partir de una colección.

### 4.1. Desde una lista

```java
List<String> names = List.of("Laura", "Alex", "Maria");

names.stream();
```

### 4.2. Desde un array

```java
import java.util.Arrays;
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) {
        String[] names = {"Laura", "Alex", "Maria"};

        Stream<String> stream = Arrays.stream(names);
    }
}
```

### 4.3. Con `Stream.of`

```java
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) {
        Stream<String> stream = Stream.of("Laura", "Alex", "Maria");
    }
}
```

---

## 5. Operaciones intermedias y terminales

En `Stream API` hay dos tipos de operaciones:

- **intermedias**
- **terminales**

### 5.1. Intermedias

Devuelven otro stream y permiten seguir encadenando operaciones.

Ejemplos:

- `filter`
- `map`
- `sorted`
- `distinct`
- `limit`
- `skip`

### 5.2. Terminales

Cierran el procesamiento y producen un resultado final.

Ejemplos:

- `toList`
- `forEach`
- `count`
- `findFirst`
- `reduce`
- `collect`

### 5.3. Idea clave

Un stream suele construirse así:

- origen
- varias operaciones intermedias
- una operación terminal

Ejemplo:

```java
names.stream()
        .filter(name -> name.length() > 4)
        .map(name -> name.toUpperCase())
        .toList();
```

---

## 6. `filter`

`filter` sirve para quedarse solo con los elementos que cumplen una condición.

Recibe un `Predicate<T>`.

Ejemplo:

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "Jo");

        List<String> longNames = names.stream()
                .filter(name -> name.length() >= 5)
                .toList();

        System.out.println(longNames);
    }
}
```

Aquí solo pasan los nombres con longitud mayor o igual que 5.

---

## 7. `map`

`map` sirve para transformar cada elemento en otro valor.

Recibe una `Function<T, R>`.

Ejemplo:

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        List<String> upperNames = names.stream()
                .map(name -> name.toUpperCase())
                .toList();

        System.out.println(upperNames);
    }
}
```

Cada `String` original se transforma en su versión en mayúsculas.

---

## 8. Encadenar `filter` y `map`

Esto es muy habitual en `Stream API`.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "Jo");

        List<String> result = names.stream()
                .filter(name -> name.length() >= 5)
                .map(name -> name.toUpperCase())
                .toList();

        System.out.println(result);
    }
}
```

Proceso:

1. parte de la lista original
2. filtra los nombres largos
3. los transforma a mayúsculas
4. crea una nueva lista

---

## 9. `forEach`

`forEach` es una operación terminal que ejecuta una acción para cada elemento.

Recibe un `Consumer<T>`.

Ejemplo:

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        names.stream()
                .forEach(name -> System.out.println(name));
    }
}
```

También puedes usar una method reference:

```java
names.stream()
        .forEach(System.out::println);
```

---

## 10. `toList`

`toList()` convierte el resultado del stream en una lista.

Ejemplo:

```java
List<String> result = names.stream()
        .filter(name -> name.startsWith("A"))
        .toList();
```

Es una forma muy cómoda de terminar una cadena de operaciones.

---

## 11. `count`

`count` devuelve cuántos elementos hay después del procesamiento.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "Jo");

        long count = names.stream()
                .filter(name -> name.length() >= 5)
                .count();

        System.out.println(count);
    }
}
```

Aquí cuenta cuántos nombres tienen al menos 5 caracteres.

---

## 12. `sorted`

`sorted` ordena los elementos.

### 12.1. Orden natural

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Maria", "Alex", "Laura");

        List<String> sortedNames = names.stream()
                .sorted()
                .toList();

        System.out.println(sortedNames);
    }
}
```

### 12.2. Con comparador

```java
import java.util.Comparator;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Maria", "Alex", "Laura");

        List<String> sortedByLength = names.stream()
                .sorted(Comparator.comparingInt(name -> name.length()))
                .toList();

        System.out.println(sortedByLength);
    }
}
```

---

## 13. `distinct`

`distinct` elimina duplicados.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Laura", "Maria", "Alex");

        List<String> uniqueNames = names.stream()
                .distinct()
                .toList();

        System.out.println(uniqueNames);
    }
}
```

Es muy útil cuando quieres limpiar repeticiones.

---

## 14. `limit` y `skip`

### 14.1. `limit`

Se queda con los primeros `n` elementos.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "John", "Emma");

        List<String> firstThree = names.stream()
                .limit(3)
                .toList();

        System.out.println(firstThree);
    }
}
```

### 14.2. `skip`

Salta los primeros `n` elementos.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "John", "Emma");

        List<String> afterTwo = names.stream()
                .skip(2)
                .toList();

        System.out.println(afterTwo);
    }
}
```

---

## 15. `findFirst`

`findFirst` devuelve el primer elemento, si existe.

El resultado es un `Optional<T>`.

```java
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        Optional<String> result = names.stream()
                .filter(name -> name.startsWith("A"))
                .findFirst();

        System.out.println(result);
    }
}
```

Si quieres actuar sobre el valor:

```java
result.ifPresent(System.out::println);
```

---

## 16. `anyMatch`, `allMatch` y `noneMatch`

Estos métodos sirven para comprobar condiciones.

### 16.1. `anyMatch`

Devuelve `true` si al menos un elemento cumple la condición.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        boolean hasShortName = names.stream()
                .anyMatch(name -> name.length() < 4);

        System.out.println(hasShortName);
    }
}
```

### 16.2. `allMatch`

Devuelve `true` si todos cumplen la condición.

```java
boolean allLongEnough = names.stream()
        .allMatch(name -> name.length() >= 3);
```

### 16.3. `noneMatch`

Devuelve `true` si ninguno cumple la condición.

```java
boolean noneStartsWithZ = names.stream()
        .noneMatch(name -> name.startsWith("Z"));
```

---

## 17. `reduce`

`reduce` sirve para combinar todos los elementos en un único resultado.

Ejemplo: sumar números.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(10, 20, 30, 40);

        int sum = numbers.stream()
                .reduce(0, (a, b) -> a + b);

        System.out.println(sum);
    }
}
```

Aquí:

- `0` es el valor inicial
- `(a, b) -> a + b` indica cómo combinar valores

---

## 18. Ejemplo con `reduce` para concatenar texto

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> words = List.of("Java", "Stream", "API");

        String result = words.stream()
                .reduce("", (a, b) -> a + " " + b)
                .trim();

        System.out.println(result);
    }
}
```

---

## 19. `collect`

`collect` es una operación terminal muy importante que permite recopilar resultados de distintas formas.

Aunque `toList()` es muy cómodo, `collect` ofrece más opciones.

Ejemplo con `Collectors.toList()`:

```java
import java.util.List;
import java.util.stream.Collectors;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        List<String> result = names.stream()
                .map(name -> name.toUpperCase())
                .collect(Collectors.toList());

        System.out.println(result);
    }
}
```

---

## 20. `collect` con `joining`

También puedes unir cadenas.

```java
import java.util.List;
import java.util.stream.Collectors;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        String result = names.stream()
                .collect(Collectors.joining(", "));

        System.out.println(result);
    }
}
```

Resultado:

```text
Laura, Alex, Maria
```

---

## 21. `collect` con `toSet`

Puedes recopilar el resultado en un conjunto.

```java
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Laura", "Maria");

        Set<String> uniqueNames = names.stream()
                .collect(Collectors.toSet());

        System.out.println(uniqueNames);
    }
}
```

---

## 22. Flujo mental de un stream

Un stream suele leerse así:

```java
source.stream()
        .intermediateOperation(...)
        .intermediateOperation(...)
        .terminalOperation(...)
```

Por ejemplo:

```java
names.stream()
        .filter(name -> name.length() > 4)
        .map(name -> name.toUpperCase())
        .sorted()
        .toList();
```

Lectura natural:

- toma la lista
- quédate con los nombres largos
- pásalos a mayúsculas
- ordénalos
- conviértelos en lista

---

## 23. Los streams no modifican la colección original

Esto es muy importante.

Ejemplo:

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        List<String> upperNames = names.stream()
                .map(name -> name.toUpperCase())
                .toList();

        System.out.println(names);
        System.out.println(upperNames);
    }
}
```

La lista original sigue igual.  
El stream produce un nuevo resultado.

---

## 24. Un stream no se reutiliza

Una vez que ejecutas una operación terminal, ese stream ya no puede volver a usarse.

Ejemplo incorrecto:

```java
// Stream<String> stream = names.stream();
// stream.forEach(System.out::println);
// stream.count(); // error
```

Si necesitas otro procesamiento, crea un nuevo stream.

---

## 25. Ejemplo guiado: filtrar números pares

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(1, 2, 3, 4, 5, 6);

        List<Integer> evenNumbers = numbers.stream()
                .filter(number -> number % 2 == 0)
                .toList();

        System.out.println(evenNumbers);
    }
}
```

---

## 26. Ejemplo guiado: transformar nombres a mayúsculas

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        List<String> result = names.stream()
                .map(name -> name.toUpperCase())
                .toList();

        System.out.println(result);
    }
}
```

---

## 27. Ejemplo guiado: filtrar y ordenar

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "Jo", "Emma");

        List<String> result = names.stream()
                .filter(name -> name.length() >= 4)
                .sorted()
                .toList();

        System.out.println(result);
    }
}
```

---

## 28. Ejemplo guiado: contar elementos que cumplen una condición

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria", "Jo");

        long count = names.stream()
                .filter(name -> name.contains("a") || name.contains("A"))
                .count();

        System.out.println(count);
    }
}
```

---

## 29. Ejemplo guiado: obtener el primer número mayor que 10

```java
import java.util.List;
import java.util.Optional;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(3, 7, 12, 20, 5);

        Optional<Integer> result = numbers.stream()
                .filter(number -> number > 10)
                .findFirst();

        result.ifPresent(System.out::println);
    }
}
```

---

## 30. Ejemplo guiado: sumar con `reduce`

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(5, 10, 15);

        int total = numbers.stream()
                .reduce(0, (a, b) -> a + b);

        System.out.println(total);
    }
}
```

---

## 31. Ejemplo guiado: eliminar duplicados y ordenar

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Laura", "Maria", "Alex");

        List<String> result = names.stream()
                .distinct()
                .sorted()
                .toList();

        System.out.println(result);
    }
}
```

---

## 32. Ejemplo guiado: trabajar con objetos

Los streams son especialmente útiles cuando trabajas con objetos.

### 32.1. Clase `Product`

```java
public class Product {
    private String name;
    private double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }
}
```

### 32.2. Uso con stream

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Product> products = List.of(
                new Product("Mouse", 19.99),
                new Product("Keyboard", 49.99),
                new Product("Monitor", 199.99),
                new Product("Cable", 5.99)
        );

        List<String> expensiveProductNames = products.stream()
                .filter(product -> product.getPrice() > 20)
                .map(product -> product.getName())
                .toList();

        System.out.println(expensiveProductNames);
    }
}
```

Aquí:

- filtras productos caros
- transformas cada producto en su nombre
- recoges el resultado en una lista

---

## 33. `map` no modifica, transforma

Esto es clave:

- `filter` decide si un elemento pasa o no
- `map` transforma un elemento en otro valor

Ejemplo:

```java
List<Integer> lengths = names.stream()
        .map(name -> name.length())
        .toList();
```

Aquí conviertes una lista de `String` en una lista de `Integer`.

---

## 34. `Stream API` y pereza (_lazy evaluation_)

Las operaciones intermedias como `filter` o `map` son perezosas.

Eso significa que no hacen el trabajo inmediatamente.  
El procesamiento real ocurre cuando aparece una operación terminal.

Ejemplo:

```java
names.stream()
        .filter(name -> name.length() > 3)
        .map(name -> name.toUpperCase());
```

Aquí todavía no pasa nada útil hasta que pongas algo como:

```java
.toList()
```

o:

```java
.forEach(...)
```

A nivel inicial, lo importante es recordar:

- las operaciones intermedias preparan el procesamiento
- la operación terminal lo ejecuta

---

## 35. Cuándo usar `Stream API`

Usa streams cuando necesites:

- filtrar colecciones
- transformar datos
- ordenar resultados
- contar elementos
- buscar valores
- encadenar varias operaciones de procesamiento

Es especialmente útil cuando el flujo es claro y expresivo.

---

## 36. Cuándo no conviene abusar de streams

Aunque son muy útiles, no todo debe hacerse con streams.

Evita complicar el código si:

- la lógica es muy larga
- necesitas muchas condiciones difíciles de leer
- un `for` simple resulta más claro
- el equipo entenderá mejor una versión imperativa

La idea no es usar streams siempre, sino cuando mejoren el código.

---

## 37. Errores típicos al empezar

### 37.1. Pensar que un stream modifica la lista original

No la modifica.  
Produce un resultado nuevo.

### 37.2. Intentar reutilizar un stream

Un stream solo se usa una vez.

### 37.3. Confundir `filter` con `map`

- `filter` selecciona
- `map` transforma

### 37.4. Olvidar la operación terminal

Sin operación terminal, el procesamiento no se completa.

### 37.5. Escribir cadenas de streams difíciles de leer

Si una cadena empieza a ser demasiado compleja, quizá convenga dividirla o usar otro enfoque.

---

## 38. Buenas prácticas

- Usa streams cuando hagan el código más claro.
- Mantén las lambdas pequeñas y legibles.
- Usa `map` para transformar y `filter` para seleccionar.
- Prefiere nombres claros cuando una expresión se vuelve difícil de entender.
- No fuerces el uso de streams en casos donde un bucle simple sea más expresivo.
- Recuerda que `toList()`, `count()`, `findFirst()` o `forEach()` cierran el stream.

---

## 39. A tener en cuenta

- Un `Stream` es una secuencia de procesamiento, no una colección.
- Se suele crear a partir de listas, arrays u otras fuentes.
- Hay operaciones intermedias y terminales.
- `filter` filtra, `map` transforma, `sorted` ordena, `distinct` elimina duplicados.
- `count`, `forEach`, `toList`, `findFirst` y `reduce` son operaciones terminales muy comunes.
- Los streams no modifican la colección original.
- Un stream no se reutiliza.
- `Stream API` se apoya muchísimo en lambdas e interfaces funcionales.

---

## 40. Resumen final

`Stream API` es una de las herramientas más potentes del Java moderno para trabajar con datos de forma declarativa.

Te permite encadenar operaciones como:

- filtrar
- transformar
- ordenar
- contar
- recopilar resultados

de una manera clara y elegante.

Al principio puede parecer una sintaxis nueva, pero en cuanto entiendes la diferencia entre:

- origen
- operaciones intermedias
- operación terminal

todo empieza a tener mucho sentido.

Dominar `Stream API` te ayudará muchísimo a escribir código más limpio y expresivo cuando trabajes con:

- listas
- conjuntos
- mapas
- objetos
- resultados de búsqueda
- transformaciones de datos

---

En el siguiente tema seguiremos avanzando con Java moderno y veremos **Optional**, una herramienta muy útil para representar la presencia o ausencia de un valor de forma más segura.
