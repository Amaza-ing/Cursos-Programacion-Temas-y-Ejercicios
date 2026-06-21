# Ejercicios - Tema 27: `BigDecimal`

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **`BigDecimal`, operaciones, redondeo, inmutabilidad y `compareTo`**.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear valores

Crea dos `BigDecimal` con `String`.

<details><summary>Mostrar solución</summary>

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal first = new BigDecimal("12.50");
        BigDecimal second = new BigDecimal("7.25");
        System.out.println(first);
        System.out.println(second);
    }
}
```

</details>

---

## Ejercicio 2: Sumar

Suma tres precios.

<details><summary>Mostrar solución</summary>

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal total = BigDecimal.ZERO;
        total = total.add(new BigDecimal("14.99"));
        total = total.add(new BigDecimal("1.50"));
        total = total.add(new BigDecimal("4.25"));
        System.out.println(total);
    }
}
```

</details>

---

## Ejercicio 3: Restar

Resta un descuento.

<details><summary>Mostrar solución</summary>

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("80.00");
        BigDecimal discount = new BigDecimal("15.00");
        System.out.println(price.subtract(discount));
    }
}
```

</details>

---

## Ejercicio 4: Multiplicar

Multiplica precio por cantidad.

<details><summary>Mostrar solución</summary>

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal unitPrice = new BigDecimal("6.75");
        BigDecimal quantity = new BigDecimal("4");
        System.out.println(unitPrice.multiply(quantity));
    }
}
```

</details>

---

## Ejercicio 5: Dividir

Divide con escala y redondeo.

<details><summary>Mostrar solución</summary>

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal result = new BigDecimal("52.00")
                .divide(new BigDecimal("3"), 2, RoundingMode.HALF_UP);
        System.out.println(result);
    }
}
```

</details>

---

## Ejercicio 6: Redondear

Usa `setScale`.

<details><summary>Mostrar solución</summary>

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal price = new BigDecimal("19.995");
        System.out.println(price.setScale(2, RoundingMode.HALF_UP));
    }
}
```

</details>

---

## Ejercicio 7: Inmutabilidad

Guarda el resultado tras cada operación.

<details><summary>Mostrar solución</summary>

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal total = BigDecimal.ZERO;
        total = total.add(new BigDecimal("10.00"));
        total = total.add(new BigDecimal("25.50"));
        System.out.println(total);
    }
}
```

</details>

---

## Ejercicio 8: Comparar

Compara `10.0` y `10.00` con `compareTo`.

<details><summary>Mostrar solución</summary>

```java
import java.math.BigDecimal;

public class Main {
    public static void main(String[] args) {
        BigDecimal a = new BigDecimal("10.0");
        BigDecimal b = new BigDecimal("10.00");
        System.out.println(a.compareTo(b) == 0);
    }
}
```

</details>

---

## Ejercicio 9: Validar precio

Asigna cero si el precio es negativo.

<details><summary>Mostrar solución</summary>

```java
import java.math.BigDecimal;

public class Product {
    private BigDecimal price;

    public void setPrice(BigDecimal price) {
        if (price == null || price.compareTo(BigDecimal.ZERO) < 0) {
            this.price = BigDecimal.ZERO;
            return;
        }
        this.price = price;
    }
}
```

</details>

---

## Ejercicio 10: Calcular impuesto

Calcula 21% de impuesto.

<details><summary>Mostrar solución</summary>

```java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {
    public static void main(String[] args) {
        BigDecimal base = new BigDecimal("120.00");
        BigDecimal rate = new BigDecimal("0.21");
        BigDecimal tax = base.multiply(rate).setScale(2, RoundingMode.HALF_UP);
        System.out.println(tax);
    }
}
```

</details>

---
