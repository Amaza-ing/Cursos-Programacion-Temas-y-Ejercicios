# Tema 14. Clases y Objetos (POO): atributos, métodos, constructores, getters y setters

## 1. Introducción

Hasta ahora has programado usando:

- Variables y tipos
- Condicionales y bucles
- Métodos
- Arrays, listas y colecciones básicas

Con eso puedes hacer muchísimas cosas, pero a medida que tus programas crecen aparece un problema:

- Necesitas organizar el código y los datos de una forma más estructurada
- Quieres representar “cosas del mundo real” dentro del programa (un usuario, un producto, una tarea, un coche…)
- Quieres agrupar datos y acciones que están relacionados

Aquí entra la **Programación Orientada a Objetos** (POO).

La POO se basa en dos conceptos principales:

- **Clase**: el “molde” o plantilla
- **Objeto**: una “instancia” creada a partir de ese molde

En este tema aprenderás:

- Qué es una clase y qué es un objeto
- Cómo crear atributos (estado) y métodos (comportamiento)
- Cómo crear constructores (inicialización)
- Qué es la encapsulación y por qué usar `private`
- Cómo crear getters y setters correctamente
- Ejemplos completos y buenas prácticas iniciales

---

## 2. Qué es una clase y qué es un objeto

### 2.1. Clase

Una **clase** es una plantilla que describe:

- Qué datos tiene algo (atributos)
- Qué puede hacer (métodos)

Ejemplo: la clase `User` puede tener:

- Atributos: `name`, `age`, `email`
- Métodos: `printInfo()`, `isAdult()`

### 2.2. Objeto

Un **objeto** es una instancia concreta de una clase.

Ejemplo: si `User` es la plantilla, entonces:

- `User laura = new User(...);` es un objeto real.

Puedes crear varios objetos a partir de la misma clase, cada uno con sus propios datos.

---

## 3. Estructura básica de una clase

Una clase en Java normalmente tiene esta estructura:

- Atributos (campos)
- Constructores
- Métodos
- Getters y setters (si procede)

Ejemplo mínimo:

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

---

## 4. Atributos (estado de un objeto)

Un **atributo** (también llamado _field_ o _property_) es una variable declarada dentro de una clase.

Ejemplo:

```java
public class Product {
    private String name;
    private double price;
}
```

Cada objeto `Product` tiene su propio `name` y `price`.

### 4.1. `private` y encapsulación

En Java, es una buena práctica que los atributos sean `private`:

- Para proteger el estado del objeto
- Para controlar cómo se modifica
- Para evitar cambios “incontrolados” desde fuera

Ejemplo (mala práctica):

```java
public class Product {
    public double price;
}
```

Si `price` es público, cualquier parte del programa podría poner valores inválidos:

```java
product.price = -999; // mal
```

Con `private`, lo controlas con setters o métodos específicos.

---

## 5. Métodos (comportamiento de un objeto)

Un método dentro de una clase representa lo que el objeto “puede hacer”.

Ejemplo en `Product`:

```java
public class Product {
    private String name;
    private double price;

    public void applyDiscount(double discountRate) {
        price = price - (price * discountRate);
    }
}
```

- El método usa y modifica atributos del objeto (`price`).
- Cada objeto aplica el descuento sobre **su propio estado**.

---

## 6. Crear objetos con `new`

Para usar una clase, debes crear objetos.

Ejemplo:

```java
Product mouse = new Product();
```

Pero esto solo funciona si la clase tiene un constructor sin parámetros (por defecto o creado por ti).

En la práctica, para inicializar bien un objeto, usamos constructores.

---

## 7. Constructores

Un **constructor** es un método especial que se ejecuta al crear un objeto con `new`.

Características:

- Tiene el mismo nombre que la clase
- No tiene tipo de retorno (ni `void`)
- Se usa para inicializar atributos

### 7.1. Constructor con parámetros

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

### 7.2. Qué es `this`

`this` se refiere al objeto actual (la instancia actual).

En el constructor:

- `this.name` es el atributo del objeto
- `name` (sin `this`) es el parámetro del constructor

```java
this.name = name;
```

### 7.3. Usar el constructor desde `main`

```java
public class Main {
    public static void main(String[] args) {
        User laura = new User("Laura", 28);
        User alex = new User("Alex", 35);

        // Cada objeto tiene su propio estado
    }
}
```

---

## 8. Constructor por defecto (sin parámetros)

Si no defines ningún constructor, Java crea uno “vacío” automáticamente.

Pero si defines al menos un constructor, el constructor por defecto deja de existir, y si lo necesitas debes crearlo tú.

Ejemplo:

```java
public class User {
    private String name;
    private int age;

    public User() {
        this.name = "Unknown";
        this.age = 0;
    }

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }
}
```

Ahora puedes hacer:

```java
User u1 = new User();
User u2 = new User("Laura", 28);
```

---

## 9. Getters y setters

Como los atributos suelen ser `private`, necesitas una forma controlada de acceder y modificar valores:

- **Getter**: devuelve el valor de un atributo
- **Setter**: modifica el valor de un atributo

### 9.1. Ejemplo completo con getters y setters

```java
public class User {
    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAge(int age) {
        this.age = age;
    }
}
```

### 9.2. Usarlos desde `main`

```java
public class Main {
    public static void main(String[] args) {
        User user = new User("Laura", 28);

        System.out.println(user.getName());
        System.out.println(user.getAge());

        user.setName("Laura M.");
        user.setAge(29);

        System.out.println(user.getName());
        System.out.println(user.getAge());
    }
}
```

---

## 10. Validación dentro de setters (buena práctica)

Un setter no tiene por qué aceptar cualquier valor. Puedes validar.

Ejemplo: evitar edad negativa

```java
public void setAge(int age) {
    if (age < 0) {
        return;
    }

    this.age = age;
}
```

Más explícito:

```java
public void setAge(int age) {
    if (age < 0) {
        System.out.println("Invalid age");
        return;
    }

    this.age = age;
}
```

Esto protege la coherencia del objeto.

---

## 11. Métodos que usan atributos (ejemplos útiles)

### 11.1. Método `isAdult()`

```java
public boolean isAdult() {
    return age >= 18;
}
```

### 11.2. Método `printInfo()`

```java
public void printInfo() {
    System.out.println("Name: " + name + " | Age: " + age);
}
```

---

## 12. Ejemplo completo: clase `User`

Aquí tienes un ejemplo completo, listo para copiar y ejecutar.

### 12.1. `User.java`

```java
public class User {
    private String name;
    private int age;

    public User() {
        this.name = "Unknown";
        this.age = 0;
    }

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public void setName(String name) {
        if (name == null || name.isBlank()) {
            return;
        }

        this.name = name;
    }

    public void setAge(int age) {
        if (age < 0) {
            return;
        }

        this.age = age;
    }

    public boolean isAdult() {
        return age >= 18;
    }

    public void printInfo() {
        System.out.println("Name: " + name + " | Age: " + age);
    }
}
```

### 12.2. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        User user1 = new User("Laura", 28);
        User user2 = new User();

        user1.printInfo();
        user2.printInfo();

        System.out.println(user1.isAdult()); // true
        System.out.println(user2.isAdult()); // false

        user2.setName("Alex");
        user2.setAge(35);

        user2.printInfo();
    }
}
```

---

## 13. Ejemplo completo: clase `Product`

Un ejemplo diferente para ver que la idea se aplica a cualquier “cosa”.

### 13.1. `Product.java`

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

    public void setPrice(double price) {
        if (price < 0) {
            return;
        }

        this.price = price;
    }

    public void applyDiscount(double discountRate) {
        if (discountRate < 0 || discountRate > 1) {
            return;
        }

        price = price - (price * discountRate);
    }

    public void printInfo() {
        System.out.println("Product: " + name + " | Price: " + price);
    }
}
```

### 13.2. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        Product keyboard = new Product("Keyboard", 49.99);

        keyboard.printInfo();

        keyboard.applyDiscount(0.20);
        keyboard.printInfo();

        keyboard.setPrice(-10); // no cambia
        keyboard.printInfo();
    }
}
```

---

## 14. Errores típicos al empezar con clases

### 14.1. Intentar acceder a atributos `private` desde fuera

Si un atributo es `private`, no puedes hacer esto:

```java
// user.age = 30; // error
```

Debes usar un setter o un método:

```java
user.setAge(30);
```

### 14.2. Olvidar inicializar atributos

Si no inicializas, tendrás valores por defecto:

- `int` → 0
- `double` → 0.0
- `boolean` → false
- `String` → null

Por eso los constructores son importantes.

### 14.3. Confundir clase con objeto

- Clase: `User`
- Objeto: `User laura = new User("Laura", 28);`

---

## 15. A tener en cuenta

- Una **clase** es una plantilla; un **objeto** es una instancia.
- Los **atributos** representan el estado del objeto.
- Los **métodos** representan su comportamiento.
- Los **constructores** inicializan el objeto al crearlo.
- `this` se refiere al objeto actual.
- Usar atributos `private` + getters/setters mejora el control y la seguridad del estado.
- Los setters pueden y deben validar valores cuando tenga sentido.

---

En el siguiente tema profundizaremos en conceptos fundamentales de POO como **encapsulación**, **modificadores de acceso**, `this` en más detalle y cómo organizar mejor las clases para proyectos reales.
