# Tema 25. `Map` y `HashMap`

## 1. Introducción

Hasta ahora has trabajado con estructuras como:

- Arrays
- `ArrayList`
- Clases y objetos
- Enums

Con ellas puedes almacenar muchos datos, pero a veces aparece una necesidad distinta:

> Quiero guardar un valor y recuperarlo usando una clave.

Por ejemplo:

- La edad de una persona a partir de su nombre
- El precio de un producto a partir de su código
- La nota de un alumno a partir de su identificador
- La cantidad de stock a partir del nombre del producto
- El país de una ciudad a partir del nombre de la ciudad

Con una lista, buscar un valor por “nombre” puede ser incómodo, porque normalmente accedes por posición (`0`, `1`, `2`...).

Para resolver este problema, Java tiene la estructura **`Map`**, y una de sus implementaciones más usadas es:

- `HashMap`

En este tema aprenderás:

- Qué es un `Map`
- Qué es un `HashMap`
- Cómo guardar pares clave-valor
- Cómo añadir, leer, modificar y eliminar elementos
- Cómo recorrer un `HashMap`
- Métodos muy útiles como `containsKey`, `getOrDefault`, `putIfAbsent`
- Qué ocurre con claves duplicadas, `null` y el orden
- Errores típicos y buenas prácticas

---

[![Maps](https://img.youtube.com/vi/uC5sj53SYDo/0.jpg)](https://www.youtube.com/watch?v=uC5sj53SYDo&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. Qué es un `Map`

Un `Map` es una estructura que guarda datos en formato:

- **clave** → **valor**

Ejemplo conceptual:

```text
"Laura"  ->  28
"Alex"   ->  35
"Maria"  ->  31
```

Aquí:

- La clave puede ser el nombre
- El valor puede ser la edad

La idea importante es esta:

> En un `Map`, no buscas por índice, sino por clave.

---

## 3. Qué es un `HashMap`

`HashMap` es una clase de Java que implementa la interfaz `Map`.

En la práctica, `HashMap` es una de las opciones más comunes cuando necesitas:

- Guardar pares clave-valor
- Buscar rápido por clave
- Añadir y eliminar entradas con facilidad

Piensa en un `HashMap` como una especie de “diccionario”:

- das una clave
- Java encuentra el valor asociado

---

## 4. Importación necesaria

`Map` y `HashMap` están en `java.util`, así que hay que importarlos:

```java
import java.util.HashMap;
import java.util.Map;
```

---

## 5. `Map<K, V>`: genéricos

Igual que ocurría con `List<T>`, los mapas usan genéricos.

La forma general es:

```java
Map<K, V>
```

Donde:

- `K` = tipo de la clave (_key_)
- `V` = tipo del valor (_value_)

Ejemplo:

```java
Map<String, Integer> ages = new HashMap<>();
```

Aquí estás diciendo:

- La clave será `String`
- El valor será `Integer`

Es decir:

- `"Laura"` → `28`
- `"Alex"` → `35`

---

## 6. ¿Por qué usamos wrappers en `HashMap`?

Igual que en las colecciones, en un `Map` los tipos genéricos deben ser **objetos**, no tipos primitivos.

Esto no existe:

```java
// Map<String, int> ages = new HashMap<>(); // NO
```

La forma correcta es:

```java
Map<String, Integer> ages = new HashMap<>();
Map<String, Double> prices = new HashMap<>();
Map<Integer, Boolean> answers = new HashMap<>();
```

Por eso aquí vuelven a aparecer los **wrappers**:

- `Integer`
- `Double`
- `Boolean`
- etc.

---

## 7. Crear un `HashMap`

Forma recomendada:

```java
Map<String, Integer> ages = new HashMap<>();
```

Por qué así:

- Declaras con la interfaz (`Map`)
- Creas con una implementación concreta (`HashMap`)

También podrías hacer:

```java
HashMap<String, Integer> ages = new HashMap<>();
```

Pero normalmente se recomienda programar contra la interfaz.

---

## 8. Operación básica: `put(key, value)`

Para guardar una entrada en el mapa se usa `put`.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new HashMap<>();

        ages.put("Laura", 28);
        ages.put("Alex", 35);
        ages.put("Maria", 31);

        System.out.println(ages);
    }
}
```

Aquí has guardado tres pares clave-valor.

---

## 9. Leer un valor: `get(key)`

Para recuperar un valor asociado a una clave se usa `get`.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new HashMap<>();

        ages.put("Laura", 28);
        ages.put("Alex", 35);

        System.out.println(ages.get("Laura")); // 28
        System.out.println(ages.get("Alex"));  // 35
    }
}
```

La idea es:

- das una clave
- Java devuelve el valor asociado

---

## 10. Qué pasa si la clave no existe

Si llamas a `get` con una clave que no está en el mapa, el resultado será `null`.

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);

System.out.println(ages.get("David")); // null
```

Esto es muy importante.

Si el valor esperado es un objeto, `null` significa:

- no existe esa clave
- o no hay valor asociado

Con wrappers puede ser delicado:

```java
Integer age = ages.get("David");
System.out.println(age); // null
```

Pero esto sería peligroso:

```java
// int age = ages.get("David"); // puede dar NullPointerException por unboxing
```

---

## 11. Claves duplicadas: se sobrescribe el valor

En un `Map`, las claves deben ser únicas.

Si insertas la misma clave dos veces, el valor anterior se reemplaza.

```java
Map<String, Integer> ages = new HashMap<>();

ages.put("Laura", 28);
ages.put("Laura", 29);

System.out.println(ages.get("Laura")); // 29
```

Punto clave:

- **No se duplican claves**
- La nueva inserción sobrescribe el valor anterior

---

## 12. Tamaño y comprobaciones: `size()` e `isEmpty()`

### 12.1. `size()`

Devuelve cuántas entradas hay en el mapa.

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);

System.out.println(ages.size()); // 2
```

### 12.2. `isEmpty()`

Indica si el mapa está vacío.

```java
Map<String, Integer> ages = new HashMap<>();

if (ages.isEmpty()) {
    System.out.println("The map is empty");
}
```

---

## 13. Comprobar si existe una clave: `containsKey`

Es muy común querer comprobar si una clave existe antes de usarla.

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);

System.out.println(ages.containsKey("Laura")); // true
System.out.println(ages.containsKey("David")); // false
```

Esto suele ser más claro que depender de `get(...) == null`, sobre todo cuando `null` también podría ser un valor válido.

---

## 14. Comprobar si existe un valor: `containsValue`

También puedes comprobar si un valor existe en alguna entrada.

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);

System.out.println(ages.containsValue(28)); // true
System.out.println(ages.containsValue(50)); // false
```

---

## 15. Eliminar entradas: `remove`

### 15.1. Eliminar por clave

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);

ages.remove("Laura");

System.out.println(ages); // {Alex=35}
```

### 15.2. `remove` devuelve el valor eliminado

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);

Integer removedAge = ages.remove("Laura");
System.out.println(removedAge); // 28
```

Si la clave no existe, devuelve `null`.

---

## 16. Modificar un valor

Como `put` sobrescribe el valor si la clave ya existe, también sirve para modificar.

```java
Map<String, Double> prices = new HashMap<>();

prices.put("Mouse", 19.99);
prices.put("Mouse", 17.99);

System.out.println(prices.get("Mouse")); // 17.99
```

---

## 17. Recorrer un `HashMap`

A diferencia de listas y arrays, aquí no trabajas por índice.

Normalmente recorrerás un mapa de tres formas principales:

- por claves
- por valores
- por entradas completas (`key` + `value`)

---

## 18. Recorrer claves con `keySet()`

`keySet()` devuelve un conjunto con todas las claves del mapa.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new HashMap<>();

        ages.put("Laura", 28);
        ages.put("Alex", 35);
        ages.put("Maria", 31);

        for (String name : ages.keySet()) {
            System.out.println(name);
        }
    }
}
```

Esto imprime las claves.

---

## 19. Recorrer valores con `values()`

`values()` devuelve una colección con todos los valores.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new HashMap<>();

        ages.put("Laura", 28);
        ages.put("Alex", 35);
        ages.put("Maria", 31);

        for (Integer age : ages.values()) {
            System.out.println(age);
        }
    }
}
```

Esto imprime los valores.

---

## 20. Recorrer clave y valor con `entrySet()`

Esta es una de las formas más útiles.

`entrySet()` devuelve el conjunto de entradas del mapa.

Cada entrada tiene:

- una clave
- un valor

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new HashMap<>();

        ages.put("Laura", 28);
        ages.put("Alex", 35);
        ages.put("Maria", 31);

        for (Map.Entry<String, Integer> entry : ages.entrySet()) {
            System.out.println("Key: " + entry.getKey() + " | Value: " + entry.getValue());
        }
    }
}
```

Esta forma es muy habitual cuando necesitas trabajar con ambas partes a la vez.

---

## 21. `getOrDefault(key, defaultValue)`

Este método devuelve:

- el valor real si la clave existe
- un valor por defecto si no existe

Ejemplo:

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);

int lauraAge = ages.getOrDefault("Laura", 0);
int davidAge = ages.getOrDefault("David", 0);

System.out.println(lauraAge); // 28
System.out.println(davidAge); // 0
```

Esto es muy útil para evitar `null` en muchos casos.

---

## 22. `putIfAbsent(key, value)`

Este método inserta una entrada **solo si la clave no existe todavía**.

```java
Map<String, String> countries = new HashMap<>();

countries.put("Madrid", "Spain");
countries.putIfAbsent("Madrid", "Portugal");

System.out.println(countries.get("Madrid")); // Spain
```

La segunda inserción no cambia nada porque `"Madrid"` ya estaba en el mapa.

---

## 23. `replace(key, value)`

`replace` cambia un valor solo si la clave ya existe.

```java
Map<String, Double> prices = new HashMap<>();

prices.put("Keyboard", 49.99);
prices.replace("Keyboard", 44.99);

System.out.println(prices.get("Keyboard")); // 44.99
```

Si la clave no existe, no se añade nada.

---

## 24. `clear()`

Vacía completamente el mapa.

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);

ages.clear();

System.out.println(ages.size());    // 0
System.out.println(ages.isEmpty()); // true
```

---

## 25. Orden en `HashMap`

Un punto muy importante:

> `HashMap` **no garantiza el orden** de sus elementos.

Ejemplo:

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);
ages.put("Alex", 35);
ages.put("Maria", 31);

System.out.println(ages);
```

Podrías ver algo como:

```text
{Alex=35, Laura=28, Maria=31}
```

o en otro caso un orden diferente.

### 25.1. Idea clave

- No asumas que el orden será el de inserción
- No uses `HashMap` si necesitas un orden concreto

Más adelante, cuando estudies otras implementaciones, verás alternativas como:

- `LinkedHashMap` → mantiene orden de inserción
- `TreeMap` → ordena por clave

Pero en este tema nos centramos en `HashMap`.

---

## 26. `null` en `HashMap`

`HashMap` permite trabajar con `null` en algunos casos.

### 26.1. Clave `null`

Puede existir una clave `null`:

```java
Map<String, String> data = new HashMap<>();
data.put(null, "No key");

System.out.println(data.get(null)); // No key
```

### 26.2. Valores `null`

También puedes guardar valores `null`:

```java
Map<String, String> users = new HashMap<>();
users.put("Laura", null);

System.out.println(users.get("Laura")); // null
```

### 26.3. Cuidado con esto

Aunque Java lo permita, a nivel de diseño puede complicarte el código:

- `null` puede significar “no existe la clave”
- o “la clave existe pero el valor es null”

Por eso conviene usarlo con cuidado.

---

## 27. Ejemplo guiado 1: notas de alumnos

Vamos a usar un caso muy claro.

Queremos guardar la nota de varios alumnos usando su nombre como clave.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> grades = new HashMap<>();

        grades.put("Laura", 8.5);
        grades.put("Alex", 6.0);
        grades.put("Maria", 9.2);

        System.out.println("Laura: " + grades.get("Laura"));
        System.out.println("Alex: " + grades.get("Alex"));
        System.out.println("Maria: " + grades.get("Maria"));
    }
}
```

Aquí la gran ventaja es que no necesitas buscar por posición.

Buscas directamente por nombre.

---

## 28. Ejemplo guiado 2: actualizar stock

Un caso muy realista es guardar stock por producto.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> stock = new HashMap<>();

        stock.put("Mouse", 10);
        stock.put("Keyboard", 5);
        stock.put("Monitor", 3);

        stock.put("Mouse", 12); // actualiza el valor

        System.out.println("Mouse stock: " + stock.get("Mouse"));
        System.out.println("Keyboard stock: " + stock.get("Keyboard"));
        System.out.println("Monitor stock: " + stock.get("Monitor"));
    }
}
```

---

## 29. Ejemplo guiado 3: contar repeticiones

Este ejemplo es muy importante porque muestra un uso muy típico de `HashMap`.

Queremos contar cuántas veces aparece cada palabra.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        String[] words = {"java", "code", "java", "map", "code", "java"};

        Map<String, Integer> counts = new HashMap<>();

        for (String word : words) {
            int currentCount = counts.getOrDefault(word, 0);
            counts.put(word, currentCount + 1);
        }

        System.out.println(counts);
    }
}
```

Resultado esperado:

```text
{java=3, code=2, map=1}
```

### 29.1. Qué está pasando aquí

Para cada palabra:

1. Miramos cuántas veces había aparecido ya
2. Si no estaba, usamos `0`
3. Guardamos el nuevo valor incrementado

Este patrón se usa muchísimo en programación real.

---

## 30. Ejemplo guiado 4: recorrer un mapa completo

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> prices = new HashMap<>();

        prices.put("Mouse", 19.99);
        prices.put("Keyboard", 49.99);
        prices.put("Monitor", 199.99);

        for (Map.Entry<String, Double> entry : prices.entrySet()) {
            String productName = entry.getKey();
            double productPrice = entry.getValue();

            System.out.println("Product: " + productName + " | Price: " + productPrice);
        }
    }
}
```

---

## 31. Mapas con objetos como valor

Un `HashMap` no solo puede guardar números o texto. También puede guardar objetos.

Ejemplo con una clase `User`:

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public void printInfo() {
        System.out.println("Name: " + name + " | Age: " + age);
    }
}
```

Uso del mapa:

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, User> usersById = new HashMap<>();

        usersById.put("u1", new User("Laura", 28));
        usersById.put("u2", new User("Alex", 35));

        User user = usersById.get("u1");

        if (user != null) {
            user.printInfo();
        }
    }
}
```

Aquí:

- la clave es un `String` (`"u1"`, `"u2"`)
- el valor es un objeto `User`

---

## 32. Mapas con objetos como clave

También puedes usar objetos como clave, pero aquí hay un matiz importante:

- la clave debe poder compararse correctamente
- esto conecta con el tema de `equals`

Si usas objetos como clave, normalmente tendrás que definir bien:

- `equals`
- `hashCode`

Como todavía estás en una fase inicial del curso, lo más seguro por ahora es usar como clave tipos simples como:

- `String`
- `Integer`
- `Long`
- enums

Más adelante, cuando profundices en colecciones y hashing, esta parte cobrará mucho más sentido.

---

## 33. Diferencia mental entre `ArrayList` y `HashMap`

Es importante tener clara la diferencia.

### 33.1. `ArrayList`

En una lista:

- guardas elementos en orden
- accedes por índice

```java
List<String> names = new ArrayList<>();
names.add("Laura");
names.add("Alex");

System.out.println(names.get(0)); // Laura
```

### 33.2. `HashMap`

En un mapa:

- guardas pares clave-valor
- accedes por clave

```java
Map<String, Integer> ages = new HashMap<>();
ages.put("Laura", 28);

System.out.println(ages.get("Laura")); // 28
```

### 33.3. Cuándo usar cada uno

Usa `ArrayList` cuando:

- te importa el orden
- quieres recorrer elementos como una secuencia
- accedes por posición

Usa `HashMap` cuando:

- quieres buscar por clave
- necesitas asociar un dato a otro
- no te interesa acceder por índice

---

## 34. Errores típicos al empezar

### 34.1. Pensar que `get` lanza error si no existe la clave

No lanza error por sí mismo. Devuelve `null`.

```java
Map<String, Integer> ages = new HashMap<>();
System.out.println(ages.get("Unknown")); // null
```

El problema aparece si después haces algo que no admite `null`.

---

### 34.2. Asumir que el orden está garantizado

Con `HashMap`, el orden no está garantizado.

No escribas código que dependa del orden de impresión o recorrido.

---

### 34.3. Confundir `containsKey` con `containsValue`

Esto comprueba clave:

```java
ages.containsKey("Laura");
```

Esto comprueba valor:

```java
ages.containsValue(28);
```

Son cosas distintas.

---

### 34.4. Pensar que una clave duplicada crea una segunda entrada

No.

Esto:

```java
ages.put("Laura", 28);
ages.put("Laura", 29);
```

no crea dos entradas.

Solo deja una:

```text
Laura -> 29
```

---

### 34.5. Olvidar que los genéricos usan objetos

Esto está mal:

```java
// Map<String, int> ages = new HashMap<>();
```

Debe ser:

```java
Map<String, Integer> ages = new HashMap<>();
```

---

## 35. Buenas prácticas iniciales

- Usa `Map` como tipo de referencia y `HashMap` como implementación.
- Elige nombres claros para las variables:
  - `agesByName`
  - `stockByProduct`
  - `usersById`
- Usa `getOrDefault` cuando tenga sentido evitar `null`.
- Usa `containsKey` cuando quieras comprobar claramente si una clave existe.
- No dependas del orden en `HashMap`.
- Usa claves simples y estables cuando estés empezando.

---

## 36. Ejemplo completo: gestión simple de productos

Este ejemplo junta varias operaciones en un caso realista.

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> pricesByProduct = new HashMap<>();

        pricesByProduct.put("Mouse", 19.99);
        pricesByProduct.put("Keyboard", 49.99);
        pricesByProduct.put("Monitor", 199.99);

        System.out.println("Initial map: " + pricesByProduct);

        double mousePrice = pricesByProduct.getOrDefault("Mouse", 0.0);
        double laptopPrice = pricesByProduct.getOrDefault("Laptop", 0.0);

        System.out.println("Mouse price: " + mousePrice);
        System.out.println("Laptop price: " + laptopPrice);

        pricesByProduct.put("Mouse", 17.99);
        pricesByProduct.putIfAbsent("Laptop", 899.99);

        System.out.println("After updates: " + pricesByProduct);

        if (pricesByProduct.containsKey("Monitor")) {
            System.out.println("Monitor exists");
        }

        pricesByProduct.remove("Keyboard");

        for (Map.Entry<String, Double> entry : pricesByProduct.entrySet()) {
            System.out.println("Product: " + entry.getKey() + " | Price: " + entry.getValue());
        }
    }
}
```

---

## 37. A tener en cuenta

- `Map` representa una estructura de clave-valor.
- `HashMap` es una implementación muy usada de `Map`.
- Las claves deben ser únicas.
- `put` añade o reemplaza.
- `get` recupera un valor por clave.
- `containsKey` y `containsValue` sirven para comprobaciones.
- `entrySet()` es muy útil para recorrer clave y valor a la vez.
- `HashMap` no garantiza el orden.
- `getOrDefault` y `putIfAbsent` son métodos muy prácticos.
- En genéricos se usan objetos (`Integer`, `Double`, etc.), no primitivos.

---

## 38. Resumen final

`HashMap` es una de las estructuras más útiles de Java cuando necesitas relacionar datos.

Te permite trabajar con una idea muy poderosa:

- en vez de buscar por posición
- buscas por una clave significativa

Eso hace que muchos problemas sean más fáciles de modelar.

Ejemplos típicos:

- nombre → edad
- producto → precio
- usuarioId → usuario
- palabra → número de repeticiones

Dominar `HashMap` te ayudará muchísimo en proyectos reales, porque los mapas aparecen constantemente en aplicaciones, APIs, configuraciones, conteos, caches y estructuras de datos de todo tipo.

---

En el siguiente tema continuaremos con otras colecciones muy habituales de Java, como `Set`, `LinkedHashMap`, `TreeMap` o iteradores, para ampliar tu dominio de la librería de colecciones.
