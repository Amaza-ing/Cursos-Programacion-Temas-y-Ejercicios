# Ejercicios - Tema 26: Otras colecciones

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **`Set`, `HashSet`, `LinkedHashMap`, `TreeMap`, unicidad y orden**.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear `HashSet`

Añade elementos repetidos y comprueba el tamaño.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<String> tags = new HashSet<>();
        tags.add("java");
        tags.add("backend");
        tags.add("java");
        System.out.println(tags.size());
    }
}
```

</details>

---

## Ejercicio 2: Detectar duplicado

Usa el boolean devuelto por `add`.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<String> emails = new HashSet<>();
        System.out.println(emails.add("test@example.com"));
        System.out.println(emails.add("test@example.com"));
    }
}
```

</details>

---

## Ejercicio 3: Usar `contains`

Comprueba si un set contiene un id.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<Integer> ids = new HashSet<>();
        ids.add(100);
        ids.add(102);
        System.out.println(ids.contains(102));
    }
}
```

</details>

---

## Ejercicio 4: Eliminar duplicados

Convierte una lista en `HashSet`.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Laura");
        Set<String> uniqueNames = new HashSet<>(names);
        System.out.println(uniqueNames);
    }
}
```

</details>

---

## Ejercicio 5: Crear `LinkedHashMap`

Mantén orden de inserción.

<details><summary>Mostrar solución</summary>

```java
import java.util.LinkedHashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, String> steps = new LinkedHashMap<>();
        steps.put("step1", "Download JDK");
        steps.put("step2", "Install IDE");
        System.out.println(steps);
    }
}
```

</details>

---

## Ejercicio 6: Actualizar `LinkedHashMap`

Actualiza un valor existente.

<details><summary>Mostrar solución</summary>

```java
import java.util.LinkedHashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> prices = new LinkedHashMap<>();
        prices.put("Pen", 1.50);
        prices.put("Pen", 1.20);
        System.out.println(prices);
    }
}
```

</details>

---

## Ejercicio 7: Crear `TreeMap`

Ordena automáticamente por clave.

<details><summary>Mostrar solución</summary>

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

</details>

---

## Ejercicio 8: `TreeMap` numérico

Ordena ids de tareas.

<details><summary>Mostrar solución</summary>

```java
import java.util.Map;
import java.util.TreeMap;

public class Main {
    public static void main(String[] args) {
        Map<Integer, String> tasks = new TreeMap<>();
        tasks.put(3, "Review");
        tasks.put(1, "Create");
        tasks.put(2, "Test");
        System.out.println(tasks);
    }
}
```

</details>

---

## Ejercicio 9: Códigos únicos

Usa `Set` para códigos de descuento.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<String> codes = new HashSet<>();
        codes.add("SUMMER10");
        codes.add("WELCOME");
        codes.add("SUMMER10");
        System.out.println(codes);
    }
}
```

</details>

---

## Ejercicio 10: Comparar mapas

Compara `LinkedHashMap` y `TreeMap`.

<details><summary>Mostrar solución</summary>

```java
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.TreeMap;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> linked = new LinkedHashMap<>();
        Map<String, Integer> tree = new TreeMap<>();
        linked.put("C", 3); linked.put("A", 1); linked.put("B", 2);
        tree.putAll(linked);
        System.out.println(linked);
        System.out.println(tree);
    }
}
```

</details>

---
