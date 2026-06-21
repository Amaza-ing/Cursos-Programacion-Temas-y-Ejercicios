# Tema 29. Lambdas e Interfaces Funcionales

## 1. Introducción

En el tema anterior aprendiste qué son los **generics**, cómo permiten trabajar con tipos de forma más segura y cómo aparecen constantemente en colecciones y APIs modernas de Java.

Ahora vamos a entrar en una parte fundamental del Java actual:

- **expresiones lambda**
- **interfaces funcionales**

Estas herramientas hicieron que Java pudiera escribir código más compacto, más expresivo y más cómodo para trabajar con:

- colecciones
- ordenaciones
- callbacks
- validaciones
- `Stream API`

A primera vista, las lambdas pueden parecer una sintaxis extraña, pero en realidad resuelven una idea muy simple:

> poder pasar comportamiento como si fuera un dato

En este tema aprenderás:

- Qué es una interfaz funcional
- Qué relación tiene con las lambdas
- Cómo se escribe una lambda
- Cómo reemplazar clases anónimas por lambdas
- Interfaces funcionales habituales de Java
- La anotación `@FunctionalInterface`
- Variables capturadas en lambdas
- Qué es una method reference
- Errores típicos y buenas prácticas

---

## 2. El problema antes de las lambdas

Antes de las lambdas, si querías pasar un “comportamiento” a un método, normalmente necesitabas:

- crear una clase
- o usar una clase anónima

Eso funcionaba, pero a veces hacía el código más largo de lo necesario.

Por ejemplo, imagina que quieres definir una acción simple:

```java
public interface Action {
    void execute();
}
```

Sin lambdas, podrías hacer algo así:

```java
public class Main {
    public static void main(String[] args) {
        Action action = new Action() {
            @Override
            public void execute() {
                System.out.println("Running action...");
            }
        };

        action.execute();
    }
}
```

Esto funciona, pero para una operación tan pequeña el código es bastante verboso.

Las lambdas nacen para simplificar este tipo de situaciones.

---

## 3. Qué es una interfaz funcional

Una **interfaz funcional** es una interfaz que tiene **un único método abstracto**.

Ejemplo:

```java
public interface Action {
    void execute();
}
```

Esta interfaz tiene un único método abstracto:

- `execute()`

Por eso es una interfaz funcional.

### 3.1. Idea clave

Una interfaz funcional representa una acción o comportamiento que puede implementarse de una forma concreta.

Eso la hace perfecta para usar lambdas.

---

## 4. Ejemplo simple de interfaz funcional

```java
public interface Greeter {
    void greet();
}
```

Como solo tiene un método abstracto, es funcional.

Podemos implementarla de forma clásica:

```java
public class FriendlyGreeter implements Greeter {
    @Override
    public void greet() {
        System.out.println("Hello!");
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Greeter greeter = new FriendlyGreeter();
        greeter.greet();
    }
}
```

Pero con lambdas veremos que esto puede escribirse de forma mucho más corta.

---

## 5. Qué es una expresión lambda

Una **lambda** es una forma compacta de proporcionar la implementación de una interfaz funcional.

Ejemplo:

```java
() -> System.out.println("Hello!")
```

Esto significa, de forma simplificada:

- no recibe parámetros
- ejecuta esa instrucción

Si lo asignamos a la interfaz `Greeter`, quedaría así:

```java
public class Main {
    public static void main(String[] args) {
        Greeter greeter = () -> System.out.println("Hello!");

        greeter.greet();
    }
}
```

Esto hace lo mismo que la implementación clásica, pero con mucho menos código.

---

## 6. Sintaxis básica de una lambda

La forma general es esta:

```java
(parameters) -> expression
```

o bien:

```java
(parameters) -> {
    // block of code
}
```

La lambda tiene dos partes:

- a la izquierda, los parámetros
- a la derecha, el cuerpo

---

## 7. Primeros ejemplos de lambdas

### 7.1. Sin parámetros

```java
() -> System.out.println("Hello")
```

### 7.2. Con un parámetro

```java
name -> System.out.println(name)
```

### 7.3. Con dos parámetros

```java
(a, b) -> a + b
```

### 7.4. Con bloque de código

```java
(name) -> {
    String message = "Hello, " + name;
    System.out.println(message);
}
```

---

## 8. Reemplazar una clase anónima por una lambda

Este es uno de los pasos más importantes para entenderlas.

### 8.1. Versión con clase anónima

```java
public interface Calculator {
    int calculate(int a, int b);
}

public class Main {
    public static void main(String[] args) {
        Calculator add = new Calculator() {
            @Override
            public int calculate(int a, int b) {
                return a + b;
            }
        };

        System.out.println(add.calculate(10, 20));
    }
}
```

### 8.2. Versión con lambda

```java
public interface Calculator {
    int calculate(int a, int b);
}

public class Main {
    public static void main(String[] args) {
        Calculator add = (a, b) -> a + b;

        System.out.println(add.calculate(10, 20));
    }
}
```

Ahora el código es mucho más claro.

---

## 9. Cuándo una interfaz puede usarse con lambda

Solo cuando sea una **interfaz funcional**, es decir, cuando tenga **un único método abstracto**.

Esto sí:

```java
public interface Printer {
    void print(String text);
}
```

Esto no:

```java
public interface InvalidInterface {
    void method1();
    void method2();
}
```

La segunda no puede representarse con una sola lambda porque hay dos métodos abstractos.

---

## 10. La anotación `@FunctionalInterface`

Java tiene una anotación muy útil para marcar que una interfaz está pensada como funcional:

```java
@FunctionalInterface
public interface Printer {
    void print(String text);
}
```

### 10.1. Para qué sirve

Sirve para:

- dejar clara la intención
- hacer el código más legible
- pedirle al compilador que avise si rompes la regla del único método abstracto

Ejemplo:

```java
@FunctionalInterface
public interface Printer {
    void print(String text);

    // void otherMethod(); // esto daría error
}
```

Si añades un segundo método abstracto, Java marcará error.

### 10.2. Buena práctica

Aunque no es obligatorio, es muy recomendable usar `@FunctionalInterface` cuando una interfaz esté pensada para lambdas.

---

## 11. Interfaces funcionales propias

Puedes crear tus propias interfaces funcionales cuando tenga sentido.

### 11.1. Ejemplo: `TextValidator`

```java
@FunctionalInterface
public interface TextValidator {
    boolean isValid(String text);
}
```

Uso con lambda:

```java
public class Main {
    public static void main(String[] args) {
        TextValidator notBlank = text -> text != null && !text.isBlank();

        System.out.println(notBlank.isValid("Java"));
        System.out.println(notBlank.isValid("   "));
    }
}
```

---

## 12. Parámetros en lambdas

### 12.1. Un parámetro sin tipo explícito

```java
name -> System.out.println(name)
```

### 12.2. Un parámetro con tipo explícito

```java
(String name) -> System.out.println(name)
```

Ambas opciones son válidas muchas veces.

### 12.3. Varios parámetros

```java
(a, b) -> a + b
```

o con tipos explícitos:

```java
(int a, int b) -> a + b
```

En la mayoría de casos Java puede inferir el tipo, así que no hace falta escribirlo.

---

## 13. Cuerpo de una lambda

### 13.1. Expresión simple

Si el cuerpo es una sola expresión, puedes escribirlo sin llaves:

```java
(a, b) -> a + b
```

### 13.2. Bloque con varias instrucciones

Si necesitas varias líneas, usa llaves:

```java
(a, b) -> {
    int result = a + b;
    return result;
}
```

### 13.3. Regla importante

Si usas llaves y la lambda devuelve algo, debes usar `return`.

---

## 14. Interfaces funcionales estándar de Java

Java ya trae muchas interfaces funcionales listas para usar, sobre todo en el paquete:

```java
java.util.function
```

Las más habituales son:

- `Predicate<T>`
- `Function<T, R>`
- `Consumer<T>`
- `Supplier<T>`
- `UnaryOperator<T>`
- `BinaryOperator<T>`

Estas interfaces se usan muchísimo con `Stream API`, colecciones y código moderno.

---

## 15. `Predicate<T>`

`Predicate<T>` representa una función que:

- recibe un valor de tipo `T`
- devuelve `boolean`

Es ideal para validaciones y filtros.

Ejemplo:

```java
import java.util.function.Predicate;

public class Main {
    public static void main(String[] args) {
        Predicate<String> isLongText = text -> text.length() > 5;

        System.out.println(isLongText.test("Java"));
        System.out.println(isLongText.test("Programming"));
    }
}
```

Método principal:

- `test(T value)`

---

## 16. `Function<T, R>`

`Function<T, R>` representa una función que:

- recibe un valor de tipo `T`
- devuelve un valor de tipo `R`

Ejemplo:

```java
import java.util.function.Function;

public class Main {
    public static void main(String[] args) {
        Function<String, Integer> textLength = text -> text.length();

        System.out.println(textLength.apply("Java"));
    }
}
```

Método principal:

- `apply(T value)`

---

## 17. `Consumer<T>`

`Consumer<T>` representa una operación que:

- recibe un valor de tipo `T`
- no devuelve nada

Se usa mucho para imprimir, guardar, procesar, etc.

Ejemplo:

```java
import java.util.function.Consumer;

public class Main {
    public static void main(String[] args) {
        Consumer<String> printer = text -> System.out.println("Text: " + text);

        printer.accept("Hello");
    }
}
```

Método principal:

- `accept(T value)`

---

## 18. `Supplier<T>`

`Supplier<T>` representa una operación que:

- no recibe parámetros
- devuelve un valor de tipo `T`

Ejemplo:

```java
import java.util.function.Supplier;

public class Main {
    public static void main(String[] args) {
        Supplier<Double> randomValue = () -> Math.random();

        System.out.println(randomValue.get());
    }
}
```

Método principal:

- `get()`

---

## 19. `UnaryOperator<T>` y `BinaryOperator<T>`

Estas son variantes útiles de `Function`.

### 19.1. `UnaryOperator<T>`

Recibe un valor de tipo `T` y devuelve otro `T`.

```java
import java.util.function.UnaryOperator;

public class Main {
    public static void main(String[] args) {
        UnaryOperator<String> toUpperCase = text -> text.toUpperCase();

        System.out.println(toUpperCase.apply("java"));
    }
}
```

### 19.2. `BinaryOperator<T>`

Recibe dos valores de tipo `T` y devuelve otro `T`.

```java
import java.util.function.BinaryOperator;

public class Main {
    public static void main(String[] args) {
        BinaryOperator<Integer> add = (a, b) -> a + b;

        System.out.println(add.apply(10, 20));
    }
}
```

---

## 20. Ejemplo guiado: usar una interfaz funcional propia

```java
@FunctionalInterface
public interface NumberChecker {
    boolean check(int number);
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        NumberChecker isEven = number -> number % 2 == 0;
        NumberChecker isPositive = number -> number > 0;

        System.out.println(isEven.check(10));
        System.out.println(isEven.check(7));

        System.out.println(isPositive.check(5));
        System.out.println(isPositive.check(-3));
    }
}
```

---

## 21. Lambdas y paso de comportamiento a métodos

Una de las grandes ventajas de las lambdas es que puedes pasarlas como argumento a un método.

Ejemplo:

```java
import java.util.function.Consumer;

public class Main {
    public static void main(String[] args) {
        executeAction(() -> System.out.println("Running action..."));
    }

    public static void executeAction(Action action) {
        action.execute();
    }
}

@FunctionalInterface
interface Action {
    void execute();
}
```

Aquí estás pasando una implementación directamente al método.

---

## 22. Ejemplo guiado: método que recibe un `Predicate`

```java
import java.util.function.Predicate;

public class Main {
    public static void main(String[] args) {
        System.out.println(checkText("Java", text -> text.length() > 3));
        System.out.println(checkText("Hi", text -> text.length() > 3));
    }

    public static boolean checkText(String text, Predicate<String> validator) {
        return validator.test(text);
    }
}
```

Esto hace que el método sea más flexible, porque el criterio de validación no está fijo.

---

## 23. Lambdas con colecciones

Aunque todavía no hayas visto `Stream API`, las lambdas ya se pueden usar con colecciones en varios métodos modernos.

Por ejemplo, con `forEach`.

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        names.forEach(name -> System.out.println(name));
    }
}
```

Aquí cada elemento de la lista se procesa con una lambda.

---

## 24. Ejemplo con `removeIf`

Otro método muy útil es `removeIf`, que recibe un `Predicate`.

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = new ArrayList<>(List.of("Laura", "Al", "Maria", "Jo"));

        names.removeIf(name -> name.length() < 4);

        System.out.println(names);
    }
}
```

La lambda indica qué elementos deben eliminarse.

---

## 25. Ejemplo con `sort`

También puedes usar lambdas para definir cómo ordenar.

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = new ArrayList<>(List.of("Laura", "Alex", "Maria"));

        names.sort((a, b) -> a.compareTo(b));

        System.out.println(names);
    }
}
```

Y también podrías ordenar por longitud:

```java
names.sort((a, b) -> Integer.compare(a.length(), b.length()));
```

---

## 26. Variables capturadas en lambdas

Una lambda puede usar variables de su contexto exterior, pero con una regla importante:

> la variable debe ser final o efectivamente final

Ejemplo válido:

```java
public class Main {
    public static void main(String[] args) {
        String prefix = "Hello ";

        Consumer<String> greeter = name -> System.out.println(prefix + name);

        greeter.accept("Laura");
    }
}
```

Esto funciona porque `prefix` no cambia después de asignarse.

### 26.1. Qué significa “efectivamente final”

Significa que no hace falta escribir `final`, pero en la práctica la variable no cambia.

Esto sería incorrecto:

```java
public class Main {
    public static void main(String[] args) {
        String prefix = "Hello ";

        // prefix = "Hi "; // si cambias esto, ya no sería efectivamente final

        Consumer<String> greeter = name -> System.out.println(prefix + name);
    }
}
```

---

## 27. `this` en lambdas y clases anónimas

Este es un detalle más avanzado, pero útil:

- en una **clase anónima**, `this` se refiere al objeto de la clase anónima
- en una **lambda**, `this` se refiere al objeto exterior

No necesitas memorizarlo a fondo todavía, pero conviene saber que lambdas y clases anónimas no son exactamente lo mismo internamente.

---

## 28. Qué es una method reference

Una **method reference** es una forma aún más breve de escribir ciertas lambdas.

Ejemplo con lambda:

```java
name -> System.out.println(name)
```

Method reference equivalente:

```java
System.out::println
```

Uso completo:

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        names.forEach(System.out::println);
    }
}
```

Esto hace lo mismo, pero con una sintaxis más compacta.

---

## 29. Tipos comunes de method references

### 29.1. Método estático

```java
Integer::parseInt
```

### 29.2. Método de instancia de un objeto concreto

```java
System.out::println
```

### 29.3. Método de instancia de un tipo

```java
String::toUpperCase
```

### 29.4. Constructor

```java
ArrayList::new
```

No hace falta dominar todas ahora mismo, pero sí reconocer la sintaxis.

---

## 30. Ejemplo guiado con method reference

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Laura", "Alex", "Maria");

        names.forEach(System.out::println);
    }
}
```

Esto es equivalente a:

```java
names.forEach(name -> System.out.println(name));
```

---

## 31. Ejemplo guiado: validador con `Predicate`

```java
import java.util.function.Predicate;

public class Main {
    public static void main(String[] args) {
        Predicate<String> notBlank = text -> text != null && !text.isBlank();
        Predicate<String> longEnough = text -> text.length() >= 5;

        System.out.println(notBlank.test("Java"));
        System.out.println(notBlank.test("   "));

        System.out.println(longEnough.test("Hi"));
        System.out.println(longEnough.test("Programming"));
    }
}
```

---

## 32. Ejemplo guiado: transformador con `Function`

```java
import java.util.function.Function;

public class Main {
    public static void main(String[] args) {
        Function<String, String> toUpperCase = text -> text.toUpperCase();
        Function<String, Integer> textLength = text -> text.length();

        System.out.println(toUpperCase.apply("java"));
        System.out.println(textLength.apply("Programming"));
    }
}
```

---

## 33. Ejemplo guiado: consumidor con `Consumer`

```java
import java.util.List;
import java.util.function.Consumer;

public class Main {
    public static void main(String[] args) {
        Consumer<String> printer = text -> System.out.println("Value: " + text);

        List<String> names = List.of("Laura", "Alex", "Maria");

        names.forEach(printer);
    }
}
```

---

## 34. Ejemplo guiado: proveedor con `Supplier`

```java
import java.util.function.Supplier;

public class Main {
    public static void main(String[] args) {
        Supplier<String> fixedMessage = () -> "Welcome to Java";
        Supplier<Integer> randomNumber = () -> (int) (Math.random() * 100);

        System.out.println(fixedMessage.get());
        System.out.println(randomNumber.get());
    }
}
```

---

## 35. Cuándo usar interfaces propias y cuándo usar las de `java.util.function`

### 35.1. Usa interfaces estándar cuando

- el caso encaje bien en `Predicate`, `Function`, `Consumer`, `Supplier`, etc.
- quieras aprovechar APIs estándar
- quieras código más familiar para otros programadores Java

### 35.2. Usa interfaces propias cuando

- el nombre del comportamiento sea importante para el dominio
- quieras una interfaz más expresiva
- el caso no encaje bien en las interfaces estándar

Por ejemplo, `TextValidator` o `OrderCalculator` pueden tener sentido como nombres propios del proyecto.

---

## 36. Errores típicos al empezar

### 36.1. Pensar que cualquier interfaz sirve para lambda

No.  
Solo una interfaz funcional.

### 36.2. Olvidar que con varias instrucciones necesitas llaves

Esto no:

```java
// (a, b) -> int result = a + b; return result; // no
```

Debe ser:

```java
(a, b) -> {
    int result = a + b;
    return result;
}
```

### 36.3. Olvidar `return` en una lambda con bloque

Si usas llaves y la lambda devuelve valor, necesitas `return`.

### 36.4. Intentar modificar variables capturadas

Las variables externas usadas por la lambda deben ser final o efectivamente final.

### 36.5. Usar lambdas cuando una clase normal sería más clara

No todo debe escribirse con lambdas.  
Hay casos donde una clase o un método con nombre claro es mejor.

---

## 37. Buenas prácticas

- Usa `@FunctionalInterface` cuando diseñes una interfaz funcional propia.
- Prefiere interfaces estándar (`Predicate`, `Function`, `Consumer`, `Supplier`) cuando encajen bien.
- Usa lambdas para comportamientos cortos y claros.
- Si la lambda empieza a ser compleja, considera mover la lógica a un método con nombre.
- Usa method references cuando mejoren la legibilidad.
- No compliques el código solo por usar una sintaxis moderna.

---

## 38. A tener en cuenta

- Una interfaz funcional tiene un único método abstracto.
- Las lambdas son una forma compacta de implementar interfaces funcionales.
- Java incluye interfaces funcionales estándar muy útiles en `java.util.function`.
- `Predicate` valida, `Function` transforma, `Consumer` consume y `Supplier` produce.
- Las lambdas permiten pasar comportamiento a métodos.
- Las method references son una versión abreviada de algunas lambdas.
- Las lambdas se usan muchísimo con colecciones y `Stream API`.

---

## 39. Resumen final

Las lambdas y las interfaces funcionales forman una parte esencial del Java moderno.

Gracias a ellas puedes escribir código:

- más compacto
- más expresivo
- más flexible
- mejor preparado para trabajar con colecciones y streams

Al principio pueden parecer una sintaxis nueva difícil de leer, pero en cuanto entiendes que una lambda no es más que una implementación breve de una interfaz funcional, todo empieza a encajar.

Dominar esta parte te ayudará muchísimo en temas como:

- ordenaciones
- filtros
- transformaciones
- `forEach`
- `removeIf`
- `Stream API`

---

En el siguiente tema seguiremos avanzando con Java moderno y veremos **Stream API**, una herramienta potentísima que trabaja constantemente junto a lambdas e interfaces funcionales.
