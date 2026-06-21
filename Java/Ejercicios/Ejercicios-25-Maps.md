# Ejercicios - Tema 25: `Map` y `HashMap`

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **`Map`, `HashMap`, `put`, `get`, `remove`, `containsKey`, `getOrDefault`, `putIfAbsent` y `entrySet`**.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear mapa

Crea un mapa de países y capitales.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, String> capitals = new HashMap<>();
        capitals.put("Spain", "Madrid");
        capitals.put("Italy", "Rome");
        capitals.put("Portugal", "Lisbon");
        System.out.println(capitals);
    }
}
```

</details>

---

## Ejercicio 2: Leer con `get`

Recupera el precio de `P02`.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> prices = new HashMap<>();
        prices.put("P01", 9.99);
        prices.put("P02", 24.50);
        System.out.println(prices.get("P02"));
    }
}
```

</details>

---

## Ejercicio 3: Actualizar valor

Actualiza el stock de `Mouse`.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> stock = new HashMap<>();
        stock.put("Mouse", 10);
        stock.put("Mouse", 15);
        System.out.println(stock.get("Mouse"));
    }
}
```

</details>

---

## Ejercicio 4: Usar `containsKey`

Comprueba si existe `admin`.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, String> emails = new HashMap<>();
        emails.put("admin", "admin@example.com");
        System.out.println(emails.containsKey("admin"));
    }
}
```

</details>

---

## Ejercicio 5: Usar `getOrDefault`

Obtén puntuación por defecto si no existe.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> scores = new HashMap<>();
        scores.put("Laura", 120);
        System.out.println(scores.getOrDefault("Maria", 0));
    }
}
```

</details>

---

## Ejercicio 6: Usar `putIfAbsent`

Intenta cambiar `theme` sin sobrescribirlo.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, String> settings = new HashMap<>();
        settings.put("theme", "dark");
        settings.putIfAbsent("theme", "light");
        System.out.println(settings.get("theme"));
    }
}
```

</details>

---

## Ejercicio 7: Eliminar entrada

Elimina `Cable` del mapa.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> prices = new HashMap<>();
        prices.put("Mouse", 19.99);
        prices.put("Cable", 4.99);
        prices.remove("Cable");
        System.out.println(prices);
    }
}
```

</details>

---

## Ejercicio 8: Recorrer `entrySet`

Imprime alumnos y notas.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Double> grades = new HashMap<>();
        grades.put("Laura", 8.5);
        grades.put("Alex", 6.7);
        for (Map.Entry<String, Double> entry : grades.entrySet()) {
            System.out.println(entry.getKey() + " -> " + entry.getValue());
        }
    }
}
```

</details>

---

## Ejercicio 9: Contar repeticiones

Cuenta letras repetidas.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        String[] letters = {"a", "b", "a", "c", "b", "a"};
        Map<String, Integer> counts = new HashMap<>();
        for (String letter : letters) {
            counts.put(letter, counts.getOrDefault(letter, 0) + 1);
        }
        System.out.println(counts);
    }
}
```

</details>

---

## Ejercicio 10: Mapa con objetos

Guarda estudiantes por id.

<details><summary>Mostrar solución</summary>

```java
import java.util.HashMap;
import java.util.Map;

public class Student {
    private String name;

    public Student(String name) {
        this.name = name;
    }
}

public class Main {
    public static void main(String[] args) {
        Map<String, Student> students = new HashMap<>();
        students.put("S01", new Student("Laura"));
    }
}
```

</details>

---
