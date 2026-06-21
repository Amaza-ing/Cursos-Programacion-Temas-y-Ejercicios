# Tema 27. `BigDecimal`

## 1. Introducción

Hasta ahora has trabajado con tipos numéricos como:

- `int`
- `long`
- `float`
- `double`
- wrappers como `Integer` o `Double`

Estos tipos son muy útiles, pero tienen una limitación importante:

> `double` y `float` no siempre representan los decimales con precisión exacta.

Esto puede ser un problema cuando trabajas con:

- precios
- dinero
- impuestos
- descuentos
- cálculos financieros
- porcentajes que necesitan precisión

Para estos casos, Java proporciona una clase muy importante:

- `BigDecimal`

`BigDecimal` permite trabajar con números decimales de forma mucho más precisa y controlada.

En este tema aprenderás:

- Por qué `double` puede dar problemas
- Qué es `BigDecimal`
- Cómo crear valores `BigDecimal` correctamente
- Cómo sumar, restar, multiplicar y dividir
- Cómo redondear con `RoundingMode`
- Qué significa que `BigDecimal` sea inmutable
- Diferencias entre `equals` y `compareTo`
- Buenas prácticas para trabajar con dinero y decimales precisos

---

## 2. El problema con `double`

En Java, `double` es muy cómodo para trabajar con decimales.

Ejemplo:

```java
double price = 19.99;
double tax = 4.21;

double total = price + tax;

System.out.println(total);
```

Pero en algunos casos aparecen resultados inesperados.

Ejemplo clásico:

```java
public class Main {
    public static void main(String[] args) {
        double result = 0.1 + 0.2;

        System.out.println(result);
    }
}
```

Podrías esperar:

```text
0.3
```

Pero muchas veces verás algo parecido a:

```text
0.30000000000000004
```

Esto ocurre porque muchos decimales no pueden representarse exactamente en binario.

---

## 3. Por qué esto importa

En algunos programas, este pequeño error no importa demasiado.

Por ejemplo:

- coordenadas aproximadas
- cálculos científicos con margen de error
- gráficos
- simulaciones

Pero en otros casos sí importa muchísimo.

Ejemplo:

```java
double price = 0.10;
double total = price + price + price;

System.out.println(total);
```

Si estás trabajando con dinero, no quieres resultados imprecisos.

Para eso usamos `BigDecimal`.

---

## 4. Qué es `BigDecimal`

`BigDecimal` es una clase de Java pensada para representar números decimales con precisión arbitraria.

Está en el paquete:

```java
java.math
```

Por eso normalmente necesitas importarla:

```java
import java.math.BigDecimal;
```

Con `BigDecimal`, puedes hacer cálculos decimales de forma más controlada.

Ejemplo:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("19.99");

        System.out.println(price);
    }
}
```

---

## 5. Crear un `BigDecimal`

Hay varias formas de crear un `BigDecimal`, pero no todas son igual de recomendables.

---

## 6. Forma recomendada: usar `String`

La forma más segura para valores decimales exactos es usar un `String`.

```java
BigDecimal price = new BigDecimal("19.99");
BigDecimal tax = new BigDecimal("4.21");
```

¿Por qué?

Porque así Java recibe exactamente el valor decimal que has escrito.

Ejemplo:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal value = new BigDecimal("0.1");

        System.out.println(value);
    }
}
```

Resultado:

```text
0.1
```

---

## 7. Evitar `new BigDecimal(double)`

Esta forma puede ser peligrosa:

```java
BigDecimal value = new BigDecimal(0.1);
```

Aunque parece correcta, puede producir un valor inesperado porque el `double` ya llega con imprecisión.

Ejemplo:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal value = new BigDecimal(0.1);

        System.out.println(value);
    }
}
```

Podrías ver algo como:

```text
0.1000000000000000055511151231257827021181583404541015625
```

Por eso, para valores escritos directamente, es mejor usar:

```java
BigDecimal value = new BigDecimal("0.1");
```

---

## 8. Usar `BigDecimal.valueOf`

Otra opción bastante usada es `BigDecimal.valueOf`.

```java
BigDecimal value = BigDecimal.valueOf(0.1);
```

Esta forma suele ser más segura que `new BigDecimal(0.1)` porque internamente usa una conversión basada en la representación textual del `double`.

Ejemplo:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal value = BigDecimal.valueOf(0.1);

        System.out.println(value);
    }
}
```

Resultado:

```text
0.1
```

### 8.1. Regla práctica

Para valores decimales fijos, usa preferentemente:

```java
new BigDecimal("19.99")
```

o:

```java
BigDecimal.valueOf(19.99)
```

Evita:

```java
new BigDecimal(19.99)
```

---

## 9. Constantes útiles

`BigDecimal` incluye algunas constantes útiles:

```java
BigDecimal.ZERO
BigDecimal.ONE
BigDecimal.TEN
```

Ejemplo:

```java
BigDecimal total = BigDecimal.ZERO;
```

Esto es mejor que escribir:

```java
BigDecimal total = new BigDecimal("0");
```

---

## 10. Operaciones básicas

Con `BigDecimal` no usamos operadores como `+`, `-`, `*` o `/`.

Esto no se puede hacer:

```java
// BigDecimal total = price + tax; // error
```

En su lugar, usamos métodos:

- `add`
- `subtract`
- `multiply`
- `divide`

---

## 11. Sumar con `add`

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("19.99");
        BigDecimal tax = new BigDecimal("4.21");

        BigDecimal total = price.add(tax);

        System.out.println(total);
    }
}
```

Resultado:

```text
24.20
```

---

## 12. Restar con `subtract`

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("19.99");
        BigDecimal discount = new BigDecimal("5.00");

        BigDecimal finalPrice = price.subtract(discount);

        System.out.println(finalPrice);
    }
}
```

Resultado:

```text
14.99
```

---

## 13. Multiplicar con `multiply`

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal unitPrice = new BigDecimal("12.50");
        BigDecimal quantity = new BigDecimal("3");

        BigDecimal total = unitPrice.multiply(quantity);

        System.out.println(total);
    }
}
```

Resultado:

```text
37.50
```

---

## 14. Dividir con `divide`

Dividir con `BigDecimal` requiere más cuidado.

Ejemplo simple:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal total = new BigDecimal("10");
        BigDecimal parts = new BigDecimal("2");

        BigDecimal result = total.divide(parts);

        System.out.println(result);
    }
}
```

Resultado:

```text
5
```

Pero algunas divisiones no terminan de forma exacta.

Ejemplo:

```java
BigDecimal result = new BigDecimal("10").divide(new BigDecimal("3"));
```

Esto puede lanzar una excepción:

```text
ArithmeticException
```

¿Por qué?

Porque `10 / 3` da un decimal infinito:

```text
3.333333333...
```

Java necesita saber cómo redondear.

---

## 15. Dividir con escala y redondeo

Para dividir de forma segura, normalmente indicamos:

- escala
- modo de redondeo

La escala indica cuántos decimales queremos.

Ejemplo:

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal total = new BigDecimal("10");
        BigDecimal parts = new BigDecimal("3");

        BigDecimal result = total.divide(parts, 2, RoundingMode.HALF_UP);

        System.out.println(result);
    }
}
```

Resultado:

```text
3.33
```

Aquí:

- `2` indica dos decimales
- `RoundingMode.HALF_UP` indica el criterio de redondeo

---

## 16. Qué es `RoundingMode`

`RoundingMode` es un enum de Java que define cómo se redondea un número.

Está en:

```java
java.math.RoundingMode
```

Importación:

```java
import java.math.RoundingMode;
```

Algunos modos habituales son:

- `HALF_UP`
- `HALF_DOWN`
- `HALF_EVEN`
- `UP`
- `DOWN`
- `CEILING`
- `FLOOR`

Para empezar, el más intuitivo suele ser:

```java
RoundingMode.HALF_UP
```

que se parece al redondeo típico que aprendemos normalmente.

---

## 17. `setScale`

`setScale` permite ajustar el número de decimales.

Ejemplo:

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("19.999");

        BigDecimal roundedPrice = price.setScale(2, RoundingMode.HALF_UP);

        System.out.println(roundedPrice);
    }
}
```

Resultado:

```text
20.00
```

---

## 18. `BigDecimal` es inmutable

Esto es muy importante.

Un objeto `BigDecimal` no cambia después de crearse.

Cuando haces una operación, Java devuelve un nuevo `BigDecimal`.

Ejemplo incorrecto:

```java
BigDecimal price = new BigDecimal("10.00");

price.add(new BigDecimal("5.00"));

System.out.println(price); // 10.00
```

La suma no modifica `price`.

Lo correcto es guardar el resultado:

```java
BigDecimal price = new BigDecimal("10.00");

price = price.add(new BigDecimal("5.00"));

System.out.println(price); // 15.00
```

---

## 19. Ejemplo de inmutabilidad paso a paso

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal total = BigDecimal.ZERO;

        total.add(new BigDecimal("10.00"));
        total.add(new BigDecimal("5.00"));

        System.out.println(total);
    }
}
```

Resultado:

```text
0
```

¿Por qué?

Porque no estás guardando los resultados.

Versión correcta:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal total = BigDecimal.ZERO;

        total = total.add(new BigDecimal("10.00"));
        total = total.add(new BigDecimal("5.00"));

        System.out.println(total);
    }
}
```

Resultado:

```text
15.00
```

---

## 20. Comparar `BigDecimal`

Con `BigDecimal`, hay dos formas importantes de comparar:

- `equals`
- `compareTo`

Y no significan exactamente lo mismo.

---

## 21. `equals`

`equals` compara tanto el valor como la escala.

Ejemplo:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal a = new BigDecimal("10.0");
        BigDecimal b = new BigDecimal("10.00");

        System.out.println(a.equals(b));
    }
}
```

Resultado:

```text
false
```

¿Por qué?

Porque:

- `10.0` tiene escala 1
- `10.00` tiene escala 2

Aunque numéricamente representen lo mismo, `equals` considera la escala.

---

## 22. `compareTo`

`compareTo` compara el valor numérico.

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal a = new BigDecimal("10.0");
        BigDecimal b = new BigDecimal("10.00");

        System.out.println(a.compareTo(b));
    }
}
```

Resultado:

```text
0
```

Un resultado de `0` significa que son iguales numéricamente.

Regla práctica:

- para comparar valores numéricos, usa `compareTo`
- para comparar igualdad exacta incluyendo escala, usa `equals`

---

## 23. Comparaciones típicas con `compareTo`

`compareTo` devuelve:

- negativo si el primero es menor
- `0` si son iguales
- positivo si el primero es mayor

Ejemplo:

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("19.99");
        BigDecimal limit = new BigDecimal("20.00");

        if (price.compareTo(limit) < 0) {
            System.out.println("Price is lower than limit");
        }

        if (price.compareTo(limit) == 0) {
            System.out.println("Price is equal to limit");
        }

        if (price.compareTo(limit) > 0) {
            System.out.println("Price is greater than limit");
        }
    }
}
```

---

## 24. Comprobar si un valor es cero

No es recomendable hacer esto:

```java
price.equals(BigDecimal.ZERO)
```

porque podría fallar si la escala es diferente.

Mejor:

```java
price.compareTo(BigDecimal.ZERO) == 0
```

Ejemplo:

```java
BigDecimal value = new BigDecimal("0.00");

System.out.println(value.equals(BigDecimal.ZERO)); // false
System.out.println(value.compareTo(BigDecimal.ZERO) == 0); // true
```

---

## 25. Ejemplo guiado: calcular total de carrito

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal mousePrice = new BigDecimal("19.99");
        BigDecimal keyboardPrice = new BigDecimal("49.99");
        BigDecimal cablePrice = new BigDecimal("5.50");

        BigDecimal total = BigDecimal.ZERO;

        total = total.add(mousePrice);
        total = total.add(keyboardPrice);
        total = total.add(cablePrice);

        System.out.println("Total: " + total);
    }
}
```

---

## 26. Ejemplo guiado: precio por cantidad

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal unitPrice = new BigDecimal("12.50");
        BigDecimal quantity = new BigDecimal("4");

        BigDecimal total = unitPrice.multiply(quantity);

        System.out.println("Total: " + total);
    }
}
```

---

## 27. Ejemplo guiado: aplicar descuento

Vamos a aplicar un descuento del 20%.

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("100.00");
        BigDecimal discountRate = new BigDecimal("0.20");

        BigDecimal discount = price.multiply(discountRate);
        BigDecimal finalPrice = price.subtract(discount);

        finalPrice = finalPrice.setScale(2, RoundingMode.HALF_UP);

        System.out.println("Discount: " + discount);
        System.out.println("Final price: " + finalPrice);
    }
}
```

---

## 28. Ejemplo guiado: calcular IVA

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal basePrice = new BigDecimal("80.00");
        BigDecimal taxRate = new BigDecimal("0.21");

        BigDecimal tax = basePrice.multiply(taxRate);
        BigDecimal total = basePrice.add(tax);

        tax = tax.setScale(2, RoundingMode.HALF_UP);
        total = total.setScale(2, RoundingMode.HALF_UP);

        System.out.println("Tax: " + tax);
        System.out.println("Total: " + total);
    }
}
```

---

## 29. Ejemplo guiado: dividir una cuenta

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal bill = new BigDecimal("47.50");
        BigDecimal people = new BigDecimal("3");

        BigDecimal eachPersonPays = bill.divide(people, 2, RoundingMode.HALF_UP);

        System.out.println("Each person pays: " + eachPersonPays);
    }
}
```

---

## 30. Crear una clase `Product` con `BigDecimal`

Cuando trabajas con precios, es mejor usar `BigDecimal` que `double`.

### 30.1. `Product.java`

```java
import java.math.BigDecimal;

public class Product {
    private String name;
    private BigDecimal price;

    public Product(String name, BigDecimal price) {
        setName(name);
        setPrice(price);
    }

    public String getName() {
        return name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setName(String name) {
        if (name == null || name.isBlank()) {
            this.name = "Unknown";
            return;
        }

        this.name = name;
    }

    public void setPrice(BigDecimal price) {
        if (price == null || price.compareTo(BigDecimal.ZERO) < 0) {
            this.price = BigDecimal.ZERO;
            return;
        }

        this.price = price;
    }

    public void printInfo() {
        System.out.println("Product: " + name + " | Price: " + price);
    }
}
```

### 30.2. `Main.java`

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        Product mouse = new Product("Mouse", new BigDecimal("19.99"));
        Product keyboard = new Product("Keyboard", new BigDecimal("49.99"));

        mouse.printInfo();
        keyboard.printInfo();
    }
}
```

---

## 31. Ejemplo completo: carrito con productos

### 31.1. `Product.java`

```java
import java.math.BigDecimal;

public class Product {
    private String name;
    private BigDecimal price;

    public Product(String name, BigDecimal price) {
        this.name = name;
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public BigDecimal getPrice() {
        return price;
    }
}
```

### 31.2. `Main.java`

```java
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Product> products = new ArrayList<>();

        products.add(new Product("Mouse", new BigDecimal("19.99")));
        products.add(new Product("Keyboard", new BigDecimal("49.99")));
        products.add(new Product("Cable", new BigDecimal("5.50")));

        BigDecimal total = BigDecimal.ZERO;

        for (Product product : products) {
            total = total.add(product.getPrice());
        }

        System.out.println("Total: " + total);
    }
}
```

---

## 32. `BigDecimal` y `Stream API` como vista previa

Más adelante verás `Stream API`, pero aquí puedes ver cómo quedaría sumar precios con streams.

```java
import java.math.BigDecimal;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<BigDecimal> prices = List.of(
                new BigDecimal("19.99"),
                new BigDecimal("49.99"),
                new BigDecimal("5.50")
        );

        BigDecimal total = prices.stream()
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        System.out.println(total);
    }
}
```

No necesitas dominar todavía esta sintaxis, pero es útil ver que `BigDecimal` funciona muy bien con colecciones modernas.

---

## 33. Formatear la salida

`BigDecimal` representa el valor, pero a veces quieres mostrarlo con formato.

Por ejemplo, con dos decimales:

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("19.9");

        BigDecimal formattedPrice = price.setScale(2, RoundingMode.HALF_UP);

        System.out.println(formattedPrice);
    }
}
```

Resultado:

```text
19.90
```

Para interfaces reales, facturas o aplicaciones con moneda, más adelante podrías usar herramientas de formato como `NumberFormat`.

---

## 34. Usar `MathContext`

`MathContext` permite controlar la precisión de algunas operaciones.

Ejemplo:

```java
import java.math.BigDecimal;
import java.math.MathContext;

public class Main {
    public static void main(String[] args) {
        BigDecimal a = new BigDecimal("10");
        BigDecimal b = new BigDecimal("3");

        BigDecimal result = a.divide(b, new MathContext(4));

        System.out.println(result);
    }
}
```

Resultado aproximado:

```text
3.333
```

A nivel inicial, para cálculos de dinero suele ser más habitual controlar decimales con:

```java
setScale(2, RoundingMode.HALF_UP)
```

o dividir con escala y redondeo.

---

## 35. Cuándo usar `BigDecimal`

Usa `BigDecimal` cuando trabajes con:

- dinero
- precios
- impuestos
- intereses
- descuentos
- porcentajes donde la precisión importe
- cálculos financieros

Ejemplo:

```java
BigDecimal price = new BigDecimal("19.99");
```

---

## 36. Cuándo puede ser suficiente `double`

`double` sigue siendo útil en muchos casos.

Puedes usar `double` cuando trabajes con:

- medidas aproximadas
- gráficos
- cálculos físicos aproximados
- posiciones
- porcentajes donde un pequeño error no sea relevante
- simulaciones

Ejemplo:

```java
double distance = 12.75;
double average = 8.43;
```

No se trata de que `double` sea “malo”, sino de usar cada tipo para el caso adecuado.

---

## 37. Errores típicos al empezar

### 37.1. Crear `BigDecimal` con `double`

Evita:

```java
BigDecimal value = new BigDecimal(0.1);
```

Mejor:

```java
BigDecimal value = new BigDecimal("0.1");
```

o:

```java
BigDecimal value = BigDecimal.valueOf(0.1);
```

### 37.2. Usar operadores aritméticos

Esto no se puede:

```java
// BigDecimal total = price + tax;
```

Usa:

```java
BigDecimal total = price.add(tax);
```

### 37.3. Olvidar que `BigDecimal` es inmutable

Esto no modifica el valor original:

```java
total.add(price);
```

Debes hacer:

```java
total = total.add(price);
```

### 37.4. Dividir sin redondeo cuando el resultado es infinito

Esto puede fallar:

```java
// BigDecimal result = new BigDecimal("10").divide(new BigDecimal("3"));
```

Mejor:

```java
BigDecimal result = new BigDecimal("10")
        .divide(new BigDecimal("3"), 2, RoundingMode.HALF_UP);
```

### 37.5. Usar `equals` para comparar valores numéricos

Esto puede sorprender:

```java
new BigDecimal("10.0").equals(new BigDecimal("10.00")); // false
```

Para comparación numérica, usa:

```java
a.compareTo(b) == 0
```

---

## 38. Buenas prácticas

- Usa `BigDecimal` para dinero y cálculos decimales exactos.
- Crea valores decimales con `String` o `BigDecimal.valueOf`.
- Evita `new BigDecimal(double)`.
- Recuerda guardar el resultado de cada operación.
- Usa `compareTo` para comparar valores numéricos.
- Define claramente la escala y el redondeo.
- Para precios, suele tener sentido trabajar con 2 decimales.
- Usa constantes como `BigDecimal.ZERO`, `BigDecimal.ONE` y `BigDecimal.TEN`.

---

## 39. A tener en cuenta

- `double` puede tener errores de precisión decimal.
- `BigDecimal` permite cálculos decimales más exactos.
- No se usan operadores como `+` o `*`, sino métodos.
- `BigDecimal` es inmutable.
- Para divisiones no exactas, necesitas indicar redondeo.
- `equals` tiene en cuenta la escala.
- `compareTo` compara el valor numérico.
- Es la opción habitual para precios, dinero e impuestos.

---

## 40. Resumen final

`BigDecimal` es una clase fundamental cuando necesitas precisión decimal.

Aunque su sintaxis es algo más larga que usar `double`, ofrece mucho más control y evita errores peligrosos en cálculos sensibles.

La idea principal es:

- usa `double` para cálculos aproximados
- usa `BigDecimal` para cálculos exactos o financieros

Si trabajas con precios, impuestos, descuentos o importes, `BigDecimal` será casi siempre la mejor opción.

---

En el siguiente tema seguiremos ampliando el dominio de Java moderno con los tipos de datos genéricos.
