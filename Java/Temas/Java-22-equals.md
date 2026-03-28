# Tema 22. `equals`, `hashCode` y `toString`

## 1. Introducción

Cuando empiezas a trabajar con objetos en Java, tarde o temprano aparecen estas preguntas:

- ¿Cómo comparo dos objetos correctamente?
- ¿Por qué dos objetos con los mismos datos a veces parecen “distintos”?
- ¿Por qué al imprimir un objeto sale algo raro como `User@5f184fc6`?
- ¿Qué relación tiene todo esto con colecciones como `Set`, `Map` o `List`?

Las respuestas pasan por tres métodos muy importantes heredados de `Object`:

- `equals(...)`
- `hashCode()`
- `toString()`

Estos métodos están presentes en prácticamente todas las clases Java, porque todas las clases heredan directa o indirectamente de `Object`.

En este tema aprenderás:

- Qué hace `equals` y por qué no es lo mismo que `==`
- Qué hace `hashCode` y por qué debe ser coherente con `equals`
- Qué hace `toString` y por qué es tan útil al depurar o mostrar información
- Cómo sobrescribir correctamente estos métodos
- Qué errores son muy comunes al empezar
- Cómo afectan a colecciones como `HashSet` y `HashMap`

---

## 2. La clase `Object`: el origen de todo

En Java, todas las clases heredan de `Object`.

Por eso cualquier clase tiene, entre otros, estos métodos:

```java
public boolean equals(Object obj)
public int hashCode()
public String toString()
```

Si no sobrescribes estos métodos en tu clase, Java usará la implementación por defecto de `Object`.

Y eso suele ser insuficiente cuando quieres comparar objetos por su contenido.

---

## 3. `==` vs `equals(...)`

Esta es la diferencia más importante de todo el tema.

### 3.1. `==` compara referencias

Cuando usas `==` con objetos, Java comprueba si ambas variables apuntan al **mismo objeto en memoria**.

Ejemplo:

```java
User u1 = new User("Laura", 28);
User u2 = new User("Laura", 28);

System.out.println(u1 == u2); // false
```

¿Por qué `false`?

Porque `u1` y `u2` son dos objetos distintos, aunque tengan los mismos datos.

### 3.2. `equals(...)` compara “igualdad lógica”

La idea de `equals` es comprobar si dos objetos deberían considerarse iguales por su contenido.

Pero si no lo sobrescribes, el comportamiento por defecto de `Object` es parecido a `==`.

Ejemplo:

```java
User u1 = new User("Laura", 28);
User u2 = new User("Laura", 28);

System.out.println(u1.equals(u2)); // false si no sobrescribes equals
```

---

## 4. Primer ejemplo: clase sin `equals`

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        User u1 = new User("Laura", 28);
        User u2 = new User("Laura", 28);

        System.out.println(u1 == u2);      // false
        System.out.println(u1.equals(u2)); // false
    }
}
```

Aunque `u1` y `u2` tienen el mismo `name` y la misma `age`, Java no sabe que quieres compararlos por esos datos.

---

## 5. Sobrescribir `equals(...)`

Para comparar por contenido, debes sobrescribir `equals`.

### 5.1. Qué debe hacer `equals`

Normalmente, un `equals` bien hecho sigue estos pasos:

1. Si ambas referencias son exactamente la misma → `true`
2. Si el otro objeto es `null` → `false`
3. Si no son de la misma clase → `false`
4. Comparar los atributos relevantes

### 5.2. Ejemplo completo de `equals`

```java
import java.util.Objects;

public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        User other = (User) obj;

        return age == other.age && Objects.equals(name, other.name);
    }
}
```

### 5.3. Uso

```java
public class Main {
    public static void main(String[] args) {
        User u1 = new User("Laura", 28);
        User u2 = new User("Laura", 28);
        User u3 = new User("Alex", 30);

        System.out.println(u1.equals(u2)); // true
        System.out.println(u1.equals(u3)); // false
    }
}
```

---

## 6. `Objects.equals(...)` y por qué ayuda

En el ejemplo anterior hemos usado:

```java
Objects.equals(name, other.name)
```

Esto es útil porque compara de forma segura incluso si uno de los dos valores es `null`.

Ejemplo:

```java
Objects.equals(null, null);      // true
Objects.equals("A", null);       // false
Objects.equals("A", "A");        // true
```

Así evitas `NullPointerException`.

---

## 7. Reglas importantes de `equals`

Un buen `equals` debería cumplir estas propiedades:

### 7.1. Reflexiva

Un objeto debe ser igual a sí mismo:

```java
u1.equals(u1) // true
```

### 7.2. Simétrica

Si `u1.equals(u2)` es `true`, entonces `u2.equals(u1)` también debe ser `true`.

### 7.3. Transitiva

Si `u1.equals(u2)` y `u2.equals(u3)`, entonces `u1.equals(u3)`.

### 7.4. Consistente

Si los datos no cambian, varias llamadas a `equals` deben dar el mismo resultado.

### 7.5. Nunca igual a `null`

```java
u1.equals(null) // false
```

---

## 8. Qué es `hashCode()`

`hashCode()` devuelve un número entero asociado al objeto.

Ese número se usa mucho en estructuras hash, como:

- `HashSet`
- `HashMap`
- `Hashtable`

La idea es que Java pueda ubicar objetos rápidamente en “cubos” internos según su hash.

### 8.1. Regla fundamental

Si dos objetos son iguales según `equals`, entonces **deben tener el mismo `hashCode`**.

Es decir:

```java
if (a.equals(b)) {
    a.hashCode() == b.hashCode() // debe ser true
}
```

La inversa no siempre es cierta:

- dos objetos pueden tener el mismo hash y no ser iguales

---

## 9. Sobrescribir `hashCode()` correctamente

Siempre que sobrescribas `equals`, debes sobrescribir también `hashCode`.

### 9.1. Ejemplo con `Objects.hash(...)`

```java
import java.util.Objects;

public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        User other = (User) obj;

        return age == other.age && Objects.equals(name, other.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, age);
    }
}
```

`Objects.hash(...)` simplifica muchísimo la implementación.

---

## 10. Qué pasa si sobrescribes `equals` pero no `hashCode`

Esto genera errores sutiles, sobre todo en `HashSet` y `HashMap`.

### 10.1. Ejemplo conceptual

Supongamos:

- dos objetos son iguales según `equals`
- pero tienen distinto `hashCode`

Entonces una colección hash puede tratarlos como si estuvieran en lugares distintos, y el comportamiento será incorrecto o inconsistente.

Por eso la regla práctica es:

> Si sobrescribes `equals`, sobrescribe siempre `hashCode`.

---

## 11. Ejemplo con `HashSet`

### 11.1. Clase correcta

```java
import java.util.Objects;

public class Product {
    private String name;
    private double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        Product other = (Product) obj;
        return Double.compare(price, other.price) == 0
                && Objects.equals(name, other.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, price);
    }
}
```

### 11.2. Uso con `HashSet`

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Set<Product> products = new HashSet<>();

        products.add(new Product("Mouse", 19.99));
        products.add(new Product("Mouse", 19.99));

        System.out.println(products.size()); // 1
    }
}
```

Si `equals` y `hashCode` están bien hechos, el `HashSet` detecta que son iguales y no duplica el elemento.

---

## 12. Comparar `double` dentro de `equals`

Cuando comparas `double`, suele recomendarse usar:

```java
Double.compare(a, b) == 0
```

En lugar de:

```java
a == b
```

Ejemplo:

```java
return Double.compare(price, other.price) == 0;
```

Esto es más robusto y estándar para implementar `equals` con valores decimales.

---

## 13. Qué es `toString()`

`toString()` devuelve una representación en texto del objeto.

Si no lo sobrescribes, Java usa una versión por defecto parecida a esta:

```java
User@5f184fc6
```

Eso suele ser poco útil.

### 13.1. Ejemplo sin sobrescribir

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        User user = new User("Laura", 28);
        System.out.println(user);
    }
}
```

Salida aproximada:

```java
User@4e25154f
```

---

## 14. Sobrescribir `toString()`

### 14.1. Ejemplo simple

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    @Override
    public String toString() {
        return "User{name='" + name + "', age=" + age + "}";
    }
}
```

### 14.2. Uso

```java
public class Main {
    public static void main(String[] args) {
        User user = new User("Laura", 28);
        System.out.println(user);
    }
}
```

Salida:

```java
User{name='Laura', age=28}
```

Mucho más útil para depurar, registrar información o mostrar objetos por consola.

---

## 15. Cuándo usar `toString()`

`toString()` es especialmente útil para:

- Depurar código
- Mostrar listas de objetos por consola
- Ver estado interno rápidamente
- Registrar logs legibles

Ejemplo con lista:

```java
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<User> users = new ArrayList<>();
        users.add(new User("Laura", 28));
        users.add(new User("Alex", 31));

        System.out.println(users);
    }
}
```

Si `User` tiene un buen `toString`, la salida será mucho más clara.

---

## 16. Ejemplo completo: `Book` con `equals`, `hashCode` y `toString`

```java
import java.util.Objects;

public class Book {
    private String title;
    private String author;
    private int year;

    public Book(String title, String author, int year) {
        this.title = title;
        this.author = author;
        this.year = year;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        Book other = (Book) obj;

        return year == other.year
                && Objects.equals(title, other.title)
                && Objects.equals(author, other.author);
    }

    @Override
    public int hashCode() {
        return Objects.hash(title, author, year);
    }

    @Override
    public String toString() {
        return "Book{title='" + title + "', author='" + author + "', year=" + year + "}";
    }
}
```

Uso:

```java
import java.util.HashSet;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Book b1 = new Book("Clean Code", "Robert C. Martin", 2008);
        Book b2 = new Book("Clean Code", "Robert C. Martin", 2008);

        System.out.println(b1.equals(b2)); // true
        System.out.println(b1.hashCode() == b2.hashCode()); // true
        System.out.println(b1); // Book{title='Clean Code', author='Robert C. Martin', year=2008}

        Set<Book> books = new HashSet<>();
        books.add(b1);
        books.add(b2);

        System.out.println(books.size()); // 1
    }
}
```

---

## 17. `equals` y selección de atributos

No siempre tienes que comparar todos los atributos.

La decisión depende de qué significa “igualdad” en tu dominio.

Ejemplo: dos usuarios podrían considerarse iguales por su `id`, aunque tengan distinto nombre actual.

```java
public class User {
    private String id;
    private String name;
    private int age;
}
```

Podrías decidir que `equals` y `hashCode` usen solo `id`.

Eso depende del problema, no solo de la sintaxis.

---

## 18. Errores típicos al empezar

### 18.1. Usar `==` para comparar objetos

Esto solo compara referencias, no contenido.

### 18.2. Sobrescribir `equals` pero no `hashCode`

Especialmente problemático en `HashSet` y `HashMap`.

### 18.3. Escribir un `equals` sin comprobar tipo o `null`

Puede producir errores o comparaciones incorrectas.

### 18.4. No usar `@Override`

No es obligatorio, pero ayuda muchísimo a detectar errores en la firma.

### 18.5. Crear un `toString()` poco útil

Ejemplo malo:

```java
@Override
public String toString() {
    return "User";
}
```

Eso no aporta casi información.

---

## 19. Buenas prácticas

- Usa `@Override` siempre en `equals`, `hashCode` y `toString`.
- Si sobrescribes `equals`, sobrescribe también `hashCode`.
- Usa `Objects.equals(...)` y `Objects.hash(...)` para simplificar.
- Haz que `toString()` muestre información útil y legible.
- Piensa bien qué atributos definen la igualdad lógica de tu clase.

---

## 20. A tener en cuenta

- `==` compara referencias; `equals` compara igualdad lógica.
- `hashCode` debe ser coherente con `equals`.
- `toString` sirve para obtener una representación legible del objeto.
- `equals`, `hashCode` y `toString` se heredan de `Object`.
- En clases de dominio, es muy frecuente sobrescribir estos tres métodos.
- Son especialmente importantes cuando trabajas con colecciones y depuración.

---

En el siguiente tema seguiremos avanzando con herramientas para dar robustez a nuestros programas y veremos como **gestionar excepciones** en Java.
