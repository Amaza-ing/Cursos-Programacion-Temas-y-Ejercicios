# Tema 16. Sobrecarga de constructores

## 1. Introducción

En temas anteriores ya has usado **constructores** para inicializar objetos al crearlos con `new`.

Ejemplo:

```java
User user = new User("Laura", 28);
```

Pero en proyectos reales es habitual que un objeto se pueda crear de **varias formas**.

Por ejemplo, imagina una clase `User`:

- A veces tienes nombre y edad
- A veces solo tienes el nombre
- A veces solo quieres crear un usuario “vacío” con valores por defecto
- A veces tienes nombre, edad y email

En Java, esto se resuelve con:

- **Sobrecarga de constructores**

La idea es la misma que en la sobrecarga de métodos:

- Mismo nombre (el de la clase)
- Diferentes parámetros (número y/o tipos)

En este tema aprenderás:

- Qué es la sobrecarga de constructores y por qué se usa
- Cómo crear varios constructores en una clase
- Qué es `this(...)` y por qué es clave para no duplicar código
- Buenas prácticas de inicialización y validación
- Ejemplos completos listos para copiar y ejecutar

---

## 2. Qué es la sobrecarga de constructores

Una clase puede tener **varios constructores**, siempre que sus parámetros sean diferentes.

Ejemplo de firmas distintas:

```java
public User() { ... }
public User(String name) { ... }
public User(String name, int age) { ... }
public User(String name, int age, String email) { ... }
```

Esto permite crear objetos de distintas formas:

```java
User u1 = new User();
User u2 = new User("Laura");
User u3 = new User("Laura", 28);
User u4 = new User("Laura", 28, "laura@example.com");
```

---

## 3. Valores por defecto y consistencia

Cuando tienes varios constructores, debes asegurarte de que el objeto siempre queda en un estado coherente.

Ejemplo de valores por defecto típicos:

- `name` → `"Unknown"`
- `age` → `0`
- `email` → `null` (según diseño)
- `active` → `true`

---

## 4. Problema típico: duplicación de código

Una forma inicial (pero mala) de hacer sobrecarga es repetir el mismo código en cada constructor.

Ejemplo a evitar:

```java
public class User {
    private String name;
    private int age;

    public User() {
        name = "Unknown";
        age = 0;
    }

    public User(String name) {
        this.name = name;
        age = 0;
    }

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }
}
```

Esto funciona, pero:

- Si cambias la lógica (por ejemplo, validación), tienes que cambiarla en varios sitios
- Es fácil olvidarse de actualizar un constructor
- Con el tiempo, se convierte en un foco de errores

Para solucionarlo, se usa `this(...)`.

---

## 5. `this(...)`: llamar a otro constructor

`this(...)` permite llamar a otro constructor **dentro de la misma clase**.

Reglas importantes:

1. `this(...)` debe ser **la primera línea** del constructor
2. Sirve para reutilizar código y centralizar inicialización

Ejemplo:

```java
public User() {
    this("Unknown", 0);
}

public User(String name) {
    this(name, 0);
}

public User(String name, int age) {
    this.name = name;
    this.age = age;
}
```

Aquí:

- El constructor sin parámetros delega en el constructor más completo
- El constructor con `name` delega en el constructor más completo
- La lógica real de inicialización está en un solo sitio

---

## 6. Ejemplo completo 1: `User` con sobrecarga de constructores

### 6.1. Objetivo

Queremos poder crear usuarios así:

- `new User()` → valores por defecto
- `new User("Laura")` → solo nombre
- `new User("Laura", 28)` → nombre y edad
- `new User("Laura", 28, "laura@example.com")` → nombre, edad y email

### 6.2. `User.java`

```java
public class User {
    private String name;
    private int age;
    private String email;
    private boolean active;

    public User() {
        this("Unknown", 0, null);
    }

    public User(String name) {
        this(name, 0, null);
    }

    public User(String name, int age) {
        this(name, age, null);
    }

    public User(String name, int age, String email) {
        this.active = true;

        setName(name);
        setAge(age);
        setEmail(email);
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public String getEmail() {
        return email;
    }

    public boolean isActive() {
        return active;
    }

    public void setName(String name) {
        if (name == null || name.isBlank()) {
            this.name = "Unknown";
            return;
        }

        this.name = name;
    }

    public void setAge(int age) {
        if (age < 0) {
            this.age = 0;
            return;
        }

        this.age = age;
    }

    public void setEmail(String email) {
        if (email == null || email.isBlank()) {
            this.email = null;
            return;
        }

        this.email = email;
    }

    public void deactivate() {
        this.active = false;
    }

    public void printInfo() {
        System.out.println(
                "Name: " + name +
                " | Age: " + age +
                " | Email: " + email +
                " | Active: " + active
        );
    }
}
```

Puntos clave del ejemplo:

- Los constructores “pequeños” llaman al “grande” (`this(...)`).
- El constructor principal reutiliza setters para validar.
- El objeto siempre queda con valores coherentes.

### 6.3. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        User u1 = new User();
        User u2 = new User("Laura");
        User u3 = new User("Laura", 28);
        User u4 = new User("Laura", 28, "laura@example.com");
        User u5 = new User("   ", -5, "   ");

        u1.printInfo();
        u2.printInfo();
        u3.printInfo();
        u4.printInfo();
        u5.printInfo();
    }
}
```

---

## 7. Ejemplo completo 2: `Order` con sobrecarga y estado inicial

### 7.1. Objetivo

Crear pedidos de varias formas:

- `new Order()` → id + estado `"CREATED"` + total 0
- `new Order(String customer)` → lo mismo pero con cliente
- `new Order(String customer, double total)` → cliente y total

### 7.2. `Order.java`

```java
public class Order {
    private static int nextId = 1;

    private int id;
    private String customer;
    private double total;
    private String status;

    public Order() {
        this("Unknown", 0.0);
    }

    public Order(String customer) {
        this(customer, 0.0);
    }

    public Order(String customer, double total) {
        this.id = nextId;
        nextId++;

        this.status = "CREATED";

        setCustomer(customer);
        setTotal(total);
    }

    public int getId() {
        return id;
    }

    public String getCustomer() {
        return customer;
    }

    public double getTotal() {
        return total;
    }

    public String getStatus() {
        return status;
    }

    public void setCustomer(String customer) {
        if (customer == null || customer.isBlank()) {
            this.customer = "Unknown";
            return;
        }

        this.customer = customer;
    }

    public void setTotal(double total) {
        if (total < 0) {
            this.total = 0.0;
            return;
        }

        this.total = total;
    }

    public void markAsPaid() {
        this.status = "PAID";
    }

    public void printInfo() {
        System.out.println(
                "Order #" + id +
                " | Customer: " + customer +
                " | Total: " + total +
                " | Status: " + status
        );
    }
}
```

### 7.3. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        Order o1 = new Order();
        Order o2 = new Order("Laura");
        Order o3 = new Order("Laura", 49.99);
        Order o4 = new Order("   ", -10);

        o1.printInfo();
        o2.printInfo();
        o3.printInfo();
        o4.printInfo();

        o3.markAsPaid();
        o3.printInfo();
    }
}
```

Puntos clave:

- `nextId` es `static`: pertenece a la clase, no a cada objeto.
- Los constructores delegan a uno principal.
- El estado por defecto (`status`) se inicializa de forma consistente.

---

## 8. Errores típicos en sobrecarga de constructores

### 8.1. Llamar a `this(...)` después de otras líneas

Esto es inválido:

```java
public User() {
    System.out.println("Creating user");
    this("Unknown"); // error: this(...) debe ser la primera línea
}
```

### 8.2. Crear constructores que se llaman en bucle

Ejemplo de error (bucle infinito):

```java
public User() {
    this("Unknown");
}

public User(String name) {
    this(); // vuelve a llamar al primero => bucle
}
```

### 8.3. Dejar atributos sin inicializar en algunas sobrecargas

Si un constructor no inicializa lo mismo que los demás, puedes terminar con estados inconsistentes.  
Por eso el patrón recomendado es:

- Un constructor “principal”
- El resto delegan a él

---

## 9. Buenas prácticas

- Usa sobrecarga para ofrecer distintas formas de crear objetos.
- Centraliza la inicialización con `this(...)` para no duplicar lógica.
- El constructor más completo suele ser el que hace el trabajo real.
- Reutiliza setters con validación si ya existen y tiene sentido.
- Define valores por defecto coherentes (y mantenlos en un solo lugar).

---

## 10. A tener en cuenta

- Sobrecarga de constructores = varios constructores con diferentes parámetros.
- `this(...)` llama a otro constructor de la misma clase.
- `this(...)` siempre debe ser la primera instrucción del constructor.
- Evita duplicar lógica: delega siempre a un constructor “principal”.
- Diseña valores por defecto coherentes para evitar objetos “a medias”.

---

En el siguiente tema seguiremos profundizando en POO con conceptos como **`static`**, miembros de clase vs instancia, y patrones comunes para organizar modelos en proyectos reales.
