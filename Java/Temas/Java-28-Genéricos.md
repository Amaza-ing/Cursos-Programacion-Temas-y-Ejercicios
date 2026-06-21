# Tema 28. Generics

## 1. Introducción

En temas anteriores has trabajado con colecciones como:

- `ArrayList`
- `HashMap`
- `Set`
- `TreeMap`

Y seguramente ya has visto sintaxis como esta:

```java
List<String> names = new ArrayList<>();
Map<String, Integer> ages = new HashMap<>();
Set<Double> prices = new HashSet<>();
```

Ese `<String>`, `<Integer>` o `<Double>` forma parte de una característica muy importante de Java:

- **Generics**

Los **generics** permiten escribir clases, interfaces y métodos que trabajan con **tipos parametrizados**, es decir, con un tipo que se indica más tarde.

La gran ventaja es que permiten:

- reutilizar código
- trabajar con tipos de forma segura
- evitar muchos errores en tiempo de ejecución
- escribir APIs más limpias y expresivas

En este tema aprenderás:

- Qué son los generics
- Por qué son útiles
- Qué problema resuelven
- Cómo usar generics en colecciones
- Cómo crear clases genéricas
- Cómo crear métodos genéricos
- Qué son los comodines (`?`, `? extends`, `? super`)
- Qué limitaciones tienen los generics en Java
- Errores típicos y buenas prácticas

---

## 2. El problema antes de los generics

Para entender por qué existen los generics, primero hay que ver el problema que resuelven.

Antes de usar generics, una colección podía almacenar elementos como `Object`.

Ejemplo conceptual:

```java
List values = new ArrayList();
values.add("Laura");
values.add(28);
values.add(true);
```

Aquí puede entrar de todo:

- `String`
- `Integer`
- `Boolean`

Eso parece flexible, pero tiene varios problemas:

- pierdes seguridad de tipos
- necesitas conversiones manuales (_casting_)
- es más fácil cometer errores

Ejemplo:

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List values = new ArrayList();

        values.add("Laura");
        values.add(28);

        String name = (String) values.get(0);
        String wrongValue = (String) values.get(1); // error en ejecución
    }
}
```

El problema es que Java permite compilar ese código, pero falla en tiempo de ejecución con una excepción.

Los generics evitan precisamente este tipo de situaciones.

---

## 3. Qué son los generics

Los generics permiten definir tipos usando un parámetro de tipo.

Ejemplo:

```java
List<String> names = new ArrayList<>();
```

Aquí `String` es el tipo concreto que has indicado.

Eso significa:

- esta lista solo puede guardar `String`
- si intentas meter otro tipo, Java marcará error de compilación

Ejemplo:

```java
List<String> names = new ArrayList<>();
names.add("Laura");
names.add("Alex");

// names.add(25); // error
```

Esto hace el código mucho más seguro.

---

## 4. Ventajas principales de los generics

Las ventajas más importantes son estas:

### 4.1. Seguridad de tipos

Evitas mezclar tipos incorrectos en una estructura.

### 4.2. Menos casting

No necesitas hacer conversiones manuales constantemente.

### 4.3. Código más claro

Cuando ves esto:

```java
List<String> names
```

ya sabes que ahí solo hay `String`.

### 4.4. Reutilización

Puedes crear clases y métodos que funcionen con distintos tipos sin duplicar código.

---

## 5. Generics en colecciones

La mayoría de usos iniciales de generics aparecen en colecciones.

### 5.1. `List<String>`

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = new ArrayList<>();

        names.add("Laura");
        names.add("Alex");

        String firstName = names.get(0);
        System.out.println(firstName);
    }
}
```

Fíjate en que `get(0)` ya devuelve un `String`.  
No hace falta hacer casting.

---

### 5.2. `List<Integer>`

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = new ArrayList<>();

        numbers.add(10);
        numbers.add(20);
        numbers.add(30);

        int value = numbers.get(1);
        System.out.println(value);
    }
}
```

Aquí se usan wrappers (`Integer`) en lugar de `int`, porque los generics trabajan con objetos, no con tipos primitivos.

---

### 5.3. `Map<String, Integer>`

```java
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        Map<String, Integer> ages = new HashMap<>();

        ages.put("Laura", 28);
        ages.put("Alex", 35);

        int age = ages.get("Laura");
        System.out.println(age);
    }
}
```

---

## 6. Sintaxis general de los parámetros de tipo

Los parámetros de tipo suelen escribirse entre `< >`.

Ejemplo simple:

```java
ClassName<T>
```

Puedes ver nombres como:

- `T` → Type
- `E` → Element
- `K` → Key
- `V` → Value

Son convenciones muy habituales en Java.

Ejemplos:

```java
List<E>
Map<K, V>
Optional<T>
```

---

## 7. Crear una clase genérica

Ahora vamos a dar el paso importante: no solo usar generics, sino crear una clase genérica.

Imagina una clase que guarda un único valor.

Sin generics, tendrías que hacer versiones separadas:

- `StringBox`
- `IntegerBox`
- `DoubleBox`

Con generics, puedes hacer una sola clase.

### 7.1. Ejemplo básico: `Box<T>`

```java
public class Box<T> {
    private T value;

    public Box(T value) {
        this.value = value;
    }

    public T getValue() {
        return value;
    }

    public void setValue(T value) {
        this.value = value;
    }
}
```

Aquí `T` representa “el tipo que se decidirá al usar la clase”.

### 7.2. Uso de la clase

```java
public class Main {
    public static void main(String[] args) {
        Box<String> nameBox = new Box<>("Laura");
        Box<Integer> ageBox = new Box<>(28);

        System.out.println(nameBox.getValue());
        System.out.println(ageBox.getValue());
    }
}
```

Ahora la misma clase sirve para distintos tipos.

---

## 8. Qué significa `T`

`T` no es una palabra reservada especial.  
Es solo una letra elegida por convención.

Podrías escribir:

```java
public class Box<ValueType> {
    private ValueType value;

    public Box(ValueType value) {
        this.value = value;
    }

    public ValueType getValue() {
        return value;
    }
}
```

Esto funciona, pero normalmente en Java se usan letras cortas porque son una convención muy extendida.

Las más habituales son:

- `T` → tipo genérico
- `E` → elemento
- `K` → clave
- `V` → valor
- `R` → resultado

---

## 9. Clase genérica con dos parámetros

Una clase puede tener más de un parámetro de tipo.

Ejemplo:

```java
public class Pair<K, V> {
    private K key;
    private V value;

    public Pair(K key, V value) {
        this.key = key;
        this.value = value;
    }

    public K getKey() {
        return key;
    }

    public V getValue() {
        return value;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Pair<String, Integer> userAge = new Pair<>("Laura", 28);

        System.out.println(userAge.getKey());
        System.out.println(userAge.getValue());
    }
}
```

---

## 10. Métodos genéricos

No solo las clases pueden ser genéricas. También los métodos.

Un método genérico define su propio parámetro de tipo.

### 10.1. Ejemplo: imprimir cualquier valor

```java
public class Printer {
    public static <T> void printValue(T value) {
        System.out.println(value);
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Printer.printValue("Laura");
        Printer.printValue(28);
        Printer.printValue(true);
    }
}
```

Aquí el método funciona con distintos tipos sin necesidad de sobrecargarlo varias veces.

---

## 11. Sintaxis de un método genérico

La sintaxis general es esta:

```java
public static <T> ReturnType methodName(T param) {
    ...
}
```

Ejemplo:

```java
public static <T> T getFirst(T first, T second) {
    return first;
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        String value1 = getFirst("A", "B");
        Integer value2 = getFirst(10, 20);

        System.out.println(value1);
        System.out.println(value2);
    }

    public static <T> T getFirst(T first, T second) {
        return first;
    }
}
```

---

## 12. Ejemplo útil: intercambiar dos valores en un array

```java
public class ArrayUtils {
    public static <T> void swap(T[] array, int firstIndex, int secondIndex) {
        T temp = array[firstIndex];
        array[firstIndex] = array[secondIndex];
        array[secondIndex] = temp;
    }
}
```

Uso:

```java
import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        String[] names = {"Laura", "Alex", "Maria"};

        ArrayUtils.swap(names, 0, 2);

        System.out.println(Arrays.toString(names));
    }
}
```

Este método funciona para cualquier tipo de array de objetos:

- `String[]`
- `Integer[]`
- `Double[]`

---

## 13. Restricciones: los generics no aceptan tipos primitivos

Esto es muy importante.

Esto no es válido:

```java
// Box<int> numberBox = new Box<>(10); // NO
```

La forma correcta es:

```java
Box<Integer> numberBox = new Box<>(10);
```

Lo mismo ocurre con colecciones:

```java
List<Integer> numbers = new ArrayList<>();
```

No puede ser `List<int>`.

Debes usar wrappers:

- `Integer`
- `Double`
- `Boolean`
- `Character`
- etc.

---

## 14. Inferencia de tipos y operador diamante `<>`

Desde Java 7, cuando el tipo ya está claro a la izquierda, puedes usar el operador diamante.

Ejemplo:

```java
List<String> names = new ArrayList<>();
```

En lugar de escribir:

```java
List<String> names = new ArrayList<String>();
```

Java puede inferir el tipo.

Lo mismo aquí:

```java
Box<String> nameBox = new Box<>("Laura");
```

Esto hace el código más limpio.

---

## 15. `Object` no es lo mismo que generic

A veces alguien piensa:

> “Si todo hereda de `Object`, ¿para qué necesito generics?”

La diferencia es enorme.

### 15.1. Con `Object`

```java
public class Box {
    private Object value;

    public Box(Object value) {
        this.value = value;
    }

    public Object getValue() {
        return value;
    }
}
```

Uso:

```java
Box box = new Box("Laura");
String name = (String) box.getValue();
```

Necesitas casting.

### 15.2. Con generics

```java
public class Box<T> {
    private T value;

    public Box(T value) {
        this.value = value;
    }

    public T getValue() {
        return value;
    }
}
```

Uso:

```java
Box<String> box = new Box<>("Laura");
String name = box.getValue();
```

Ahora no necesitas casting y el compilador protege mejor tu código.

---

## 16. Wildcards: `?`

Ahora vamos a ver una parte muy importante: los comodines.

El símbolo `?` significa:

- “algún tipo”
- “un tipo desconocido”

Ejemplo:

```java
List<?> values
```

Esto significa:

- una lista de algún tipo
- no sabemos cuál exactamente

Puede ser:

- `List<String>`
- `List<Integer>`
- `List<Double>`

---

## 17. Cuándo usar `List<?>`

Es útil cuando solo necesitas leer o trabajar de forma general con una colección sin importar el tipo concreto.

Ejemplo:

```java
import java.util.List;

public class Main {
    public static void printList(List<?> values) {
        for (Object value : values) {
            System.out.println(value);
        }
    }
}
```

Uso:

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex");
        List<Integer> numbers = List.of(10, 20, 30);

        printList(names);
        printList(numbers);
    }

    public static void printList(List<?> values) {
        for (Object value : values) {
            System.out.println(value);
        }
    }
}
```

Aquí `printList` sirve para listas de cualquier tipo.

---

## 18. `? extends T`

Este comodín se usa cuando quieres aceptar un tipo o cualquiera de sus subtipos.

Ejemplo:

```java
List<? extends Number>
```

Esto puede aceptar:

- `List<Integer>`
- `List<Double>`
- `List<Long>`

porque todos esos tipos heredan de `Number`.

### 18.1. Ejemplo: sumar números

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> integers = List.of(10, 20, 30);
        List<Double> doubles = List.of(1.5, 2.5, 3.0);

        System.out.println(sumNumbers(integers));
        System.out.println(sumNumbers(doubles));
    }

    public static double sumNumbers(List<? extends Number> numbers) {
        double sum = 0;

        for (Number number : numbers) {
            sum += number.doubleValue();
        }

        return sum;
    }
}
```

Aquí el método acepta distintas listas numéricas.

---

## 19. Idea mental de `extends`

Cuando ves esto:

```java
<? extends Number>
```

léelo así:

- “algún tipo que es `Number` o hereda de `Number`”

Es muy útil para **leer** datos de una estructura.

---

## 20. `? super T`

Este comodín se usa cuando quieres aceptar un tipo o cualquiera de sus supertipos.

Ejemplo:

```java
List<? super Integer>
```

Esto puede aceptar:

- `List<Integer>`
- `List<Number>`
- `List<Object>`

### 20.1. Ejemplo conceptual

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Number> numbers = new ArrayList<>();
        addNumbers(numbers);

        System.out.println(numbers);
    }

    public static void addNumbers(List<? super Integer> values) {
        values.add(10);
        values.add(20);
        values.add(30);
    }
}
```

Aquí puedes añadir `Integer` porque la lista acepta `Integer` o un supertipo suyo.

---

## 21. Regla práctica muy útil: PECS

Hay una regla famosa para recordar `extends` y `super`:

- **Producer Extends**
- **Consumer Super**

Idea:

- si una estructura **produce** datos para leer → `extends`
- si una estructura **consume** datos para escribir → `super`

No hace falta memorizarla todavía a la perfección, pero sí entender la idea general.

---

## 22. Ejemplo comparando `extends` y `super`

### 22.1. Leer números con `extends`

```java
public static double sumNumbers(List<? extends Number> numbers)
```

Esta firma es buena para leer números.

### 22.2. Escribir enteros con `super`

```java
public static void addNumbers(List<? super Integer> values)
```

Esta firma es buena para añadir enteros.

---

## 23. Clases genéricas con límites

También puedes limitar qué tipos son válidos en un generic.

Ejemplo:

```java
public class NumericBox<T extends Number> {
    private T value;

    public NumericBox(T value) {
        this.value = value;
    }

    public double doubleValue() {
        return value.doubleValue();
    }
}
```

Aquí `T` debe ser `Number` o un subtipo.

Uso válido:

```java
NumericBox<Integer> intBox = new NumericBox<>(10);
NumericBox<Double> doubleBox = new NumericBox<>(5.5);
```

Uso no válido:

```java
// NumericBox<String> textBox = new NumericBox<>("Hello"); // error
```

---

## 24. Ejemplo completo: `NumericBox<T extends Number>`

```java
public class NumericBox<T extends Number> {
    private T value;

    public NumericBox(T value) {
        this.value = value;
    }

    public T getValue() {
        return value;
    }

    public double square() {
        double number = value.doubleValue();
        return number * number;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        NumericBox<Integer> intBox = new NumericBox<>(4);
        NumericBox<Double> doubleBox = new NumericBox<>(2.5);

        System.out.println(intBox.square());
        System.out.println(doubleBox.square());
    }
}
```

---

## 25. Generics e herencia

Esta parte suele confundir bastante al empezar.

Aunque `Integer` herede de `Number`, eso **no** significa que:

```java
List<Integer>
```

sea subtipo de:

```java
List<Number>
```

Esto es incorrecto:

```java
// List<Number> numbers = new ArrayList<Integer>(); // NO
```

Y esto sorprende al principio.

La razón es que, si eso se permitiera, podrías romper la seguridad de tipos.

Por eso existen los comodines (`? extends Number`).

---

## 26. Ejemplo para entender por qué `List<Integer>` no es `List<Number>`

Imagina que esto fuera válido:

```java
List<Number> numbers = new ArrayList<Integer>();
numbers.add(3.14);
```

Entonces estarías metiendo un `Double` dentro de una lista que en realidad era de `Integer`.

Eso rompería completamente la seguridad de tipos.

Por eso Java no lo permite.

---

## 27. Borrado de tipos (_type erasure_)

Los generics en Java funcionan mediante una técnica llamada:

- **type erasure**

Eso significa que, en tiempo de compilación, Java usa la información genérica para comprobar tipos, pero en tiempo de ejecución esa información no se conserva igual que en otros lenguajes.

A nivel inicial, lo importante es entender dos ideas:

- los generics ayudan sobre todo en compilación
- tienen ciertas limitaciones por cómo están implementados

No hace falta profundizar mucho más por ahora, pero sí conocer el concepto.

---

## 28. Limitaciones típicas de los generics

### 28.1. No puedes crear arrays de tipo genérico directamente

Esto no está permitido:

```java
// T[] values = new T[10]; // NO
```

### 28.2. No puedes usar tipos primitivos

Esto tampoco:

```java
// Box<int> box = new Box<>(10); // NO
```

### 28.3. No puedes usar `instanceof` con el tipo parametrizado concreto de esa forma

Por ejemplo, esto no se usa así:

```java
// if (value instanceof T) { ... } // NO
```

### 28.4. No puedes crear objetos del tipo genérico con `new T()`

Esto tampoco:

```java
// T value = new T(); // NO
```

Estas limitaciones son consecuencia del _type erasure_.

---

## 29. Raw types: por qué evitarlos

Una **raw type** es usar una clase genérica sin indicar el tipo.

Ejemplo:

```java
List values = new ArrayList();
```

Esto compila en muchos casos, pero es una mala práctica porque pierdes todas las ventajas de los generics.

Lo correcto es:

```java
List<String> values = new ArrayList<>();
```

Evita las raw types salvo en contextos muy concretos o legado.

---

## 30. Ejemplo guiado: clase genérica para almacenar dos valores del mismo tipo

```java
public class DoubleBox<T> {
    private T firstValue;
    private T secondValue;

    public DoubleBox(T firstValue, T secondValue) {
        this.firstValue = firstValue;
        this.secondValue = secondValue;
    }

    public T getFirstValue() {
        return firstValue;
    }

    public T getSecondValue() {
        return secondValue;
    }

    public void printValues() {
        System.out.println("First: " + firstValue);
        System.out.println("Second: " + secondValue);
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        DoubleBox<String> names = new DoubleBox<>("Laura", "Alex");
        DoubleBox<Integer> numbers = new DoubleBox<>(10, 20);

        names.printValues();
        numbers.printValues();
    }
}
```

---

## 31. Ejemplo guiado: método genérico para comparar igualdad

```java
public class CompareUtils {
    public static <T> boolean areEqual(T firstValue, T secondValue) {
        if (firstValue == null) {
            return secondValue == null;
        }

        return firstValue.equals(secondValue);
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(CompareUtils.areEqual("Java", "Java"));
        System.out.println(CompareUtils.areEqual(10, 20));
        System.out.println(CompareUtils.areEqual(true, true));
    }
}
```

---

## 32. Ejemplo guiado: imprimir cualquier colección

```java
import java.util.List;

public class CollectionPrinter {
    public static void printItems(List<?> items) {
        for (Object item : items) {
            System.out.println(item);
        }
    }
}
```

Uso:

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex");
        List<Integer> numbers = List.of(10, 20, 30);

        CollectionPrinter.printItems(names);
        CollectionPrinter.printItems(numbers);
    }
}
```

---

## 33. Cuándo usar generics

Usa generics cuando quieras:

- crear estructuras reutilizables para varios tipos
- trabajar con colecciones de forma segura
- evitar casting manual
- expresar claramente qué tipo maneja una clase o método

Ejemplos claros:

- `List<String>`
- `Map<String, Integer>`
- `Optional<User>`
- `Comparator<Product>`

---

## 34. Errores típicos al empezar

### 34.1. Pensar que generics acepta primitivos

No:

```java
// List<int> numbers = new ArrayList<>(); // error
```

Debe ser:

```java
List<Integer> numbers = new ArrayList<>();
```

### 34.2. Pensar que `List<Integer>` es subtipo de `List<Number>`

No lo es.

### 34.3. Usar raw types por comodidad

Esto hace el código menos seguro:

```java
List values = new ArrayList();
```

### 34.4. Confundir `Object` con generic

No es lo mismo.  
Con `Object` pierdes seguridad de tipos y necesitas casting.

### 34.5. Querer escribir y leer igual con `extends` y `super`

Cada uno tiene un propósito distinto:

- `extends` → leer
- `super` → escribir

---

## 35. Buenas prácticas

- Usa generics siempre que trabajes con colecciones.
- Evita raw types.
- Usa nombres claros en clases genéricas cuando sea necesario, pero respeta las convenciones habituales (`T`, `E`, `K`, `V`).
- Usa límites (`extends`) cuando un tipo deba pertenecer a una jerarquía concreta.
- Usa comodines cuando un método deba aceptar familias de tipos relacionadas.
- No compliques la API si no hace falta: a veces un tipo concreto es mejor que una firma genérica excesiva.

---

## 36. A tener en cuenta

- Los generics permiten trabajar con tipos parametrizados.
- Mejoran la seguridad de tipos y evitan muchos errores.
- Se usan muchísimo en colecciones.
- Puedes crear clases genéricas y métodos genéricos.
- `?` representa un tipo desconocido.
- `? extends T` sirve para leer de una jerarquía de tipos.
- `? super T` sirve para escribir en una jerarquía de tipos.
- Los generics no aceptan tipos primitivos.
- En Java existen limitaciones por el _type erasure_.

---

## 37. Resumen final

Los generics son una de las herramientas más importantes de Java porque permiten escribir código:

- más seguro
- más reutilizable
- más claro
- más profesional

Al principio los verás sobre todo en colecciones como `List<String>` o `Map<String, Integer>`, pero su utilidad va mucho más allá.

Gracias a los generics puedes crear clases y métodos que funcionan con muchos tipos sin perder control ni claridad.

Dominar esta parte te ayudará muchísimo a entender mejor:

- colecciones
- comparadores
- streams
- optional
- APIs modernas de Java en general

---

En el siguiente tema seguiremos avanzando con Java moderno y veremos las **expresiones lambda** y las **interfaces funcionales**, que están muy relacionadas con generics y se usan constantemente junto a `Stream API`.
