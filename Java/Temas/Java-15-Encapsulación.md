# Tema 15. Encapsulación, getters & setters y modificadores de acceso

## 1. Introducción

En el tema anterior aprendiste a crear **clases y objetos** con:

- Atributos (estado)
- Métodos (comportamiento)
- Constructores
- Getters y setters

Ahora vamos a profundizar en una idea clave de la POO en Java:

- **Encapsulación**

La encapsulación es lo que hace que una clase sea “segura” y fácil de mantener:  
evita que el estado interno del objeto se modifique de forma incorrecta desde fuera.

Para conseguir encapsulación, Java nos da dos herramientas principales:

- **Modificadores de acceso** (`public`, `private`, `protected`, sin modificador)
- **Getters y setters** (acceso controlado a atributos)

En este tema aprenderás:

- Qué es la encapsulación y por qué importa
- Qué modificadores de acceso existen y qué significan
- Cómo diseñar getters y setters con validación
- Cuándo NO deberías crear setters
- Cómo exponer comportamiento con métodos en vez de “exponer datos”
- Errores típicos al empezar

---

## 2. Qué es la encapsulación

Encapsular significa:

- Ocultar el estado interno (atributos) de una clase
- Permitir acceso/control mediante métodos (getters, setters u otros métodos)

**Objetivo:** proteger la coherencia del objeto.

### 2.1. Ejemplo: clase sin encapsulación (mala práctica)

```java
public class BankAccount {
    public double balance;
}
```

Desde cualquier sitio podrías hacer:

```java
BankAccount account = new BankAccount();
account.balance = -5000; // estado inválido
```

Esto rompe las reglas del dominio (un saldo no debería hacerse negativo “por magia” en muchos casos).

### 2.2. Clase encapsulada (buena práctica)

```java
public class BankAccount {
    private double balance;

    public double getBalance() {
        return balance;
    }

    public void deposit(double amount) {
        if (amount <= 0) {
            return;
        }

        balance += amount;
    }

    public boolean withdraw(double amount) {
        if (amount <= 0) {
            return false;
        }

        if (amount > balance) {
            return false;
        }

        balance -= amount;
        return true;
    }
}
```

Aquí el saldo solo cambia de formas controladas (`deposit`, `withdraw`).

---

## 3. Modificadores de acceso en Java

Un modificador de acceso determina **desde dónde** se puede acceder a una clase, atributo o método.

Los principales son:

- `public`
- `private`
- `protected`
- sin modificador (_package-private_)

### 3.1. `public`

Accesible desde cualquier clase, en cualquier paquete.

```java
public class User {
    public String name;
}
```

### 3.2. `private`

Solo accesible desde la **misma clase**.

```java
public class User {
    private String name;
}
```

Desde fuera no se puede hacer:

```java
// user.name = "Laura"; // error
```

### 3.3. Sin modificador (package-private)

Si no pones nada, el acceso es “por paquete”:  
solo se puede acceder desde clases dentro del mismo paquete.

```java
class Helper {
    void doWork() {}
}
```

### 3.4. `protected`

Accesible desde:

- El mismo paquete
- Subclases (aunque estén en otro paquete)

`protected` se usa mucho cuando trabajas con herencia (lo verás más adelante).

---

## 4. Tabla de accesos (resumen)

De forma simplificada:

- `private` → solo dentro de la clase
- sin modificador → dentro del paquete
- `protected` → paquete + subclases
- `public` → desde cualquier sitio

---

## 5. Encapsulación aplicada: atributos `private`

La regla típica en Java es:

- Atributos casi siempre `private`
- Se accede/modifica con métodos

Ejemplo:

```java
public class User {
    private String name;
    private int age;
}
```

---

## 6. Getters: leer el estado de forma controlada

Un **getter** devuelve el valor de un atributo.

Convención de nombre:

- `getName()` para `name`
- `getAge()` para `age`
- `isActive()` para `boolean active`

Ejemplo:

```java
public class User {
    private String name;
    private boolean active;

    public String getName() {
        return name;
    }

    public boolean isActive() {
        return active;
    }
}
```

---

## 7. Setters: modificar el estado de forma controlada

Un **setter** modifica el valor de un atributo.

Convención:

- `setName(String name)`
- `setAge(int age)`

Ejemplo básico:

```java
public void setAge(int age) {
    this.age = age;
}
```

Pero lo importante es que el setter puede incluir **validación**.

---

## 8. Setters con validación

Un setter debería evitar que el objeto quede en un estado incoherente.

### 8.1. Validar edad

```java
public void setAge(int age) {
    if (age < 0) {
        return;
    }

    this.age = age;
}
```

### 8.2. Validar nombre

```java
public void setName(String name) {
    if (name == null || name.isBlank()) {
        return;
    }

    this.name = name;
}
```

---

## 9. Cuándo NO crear setters

No siempre necesitas setters.

Si un atributo no debería cambiar, puedes:

- No crear setter (solo getter)
- Hacer el atributo `final`

Ejemplo: un `id` que no debe cambiar:

```java
public class User {
    private String id;
    private String name;

    public User(String id, String name) {
        this.id = id;
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        if (name == null || name.isBlank()) {
            return;
        }

        this.name = name;
    }
}
```

---

## 10. Mejor que un setter: métodos con intención

A veces es mejor crear métodos que expresen la intención del cambio, en vez de exponer setters genéricos.

Ejemplo:

- En vez de `setBalance(...)` (peligroso)
- Mejor `deposit(...)` y `withdraw(...)`

---

## 11. Ejemplo completo: `User` con encapsulación y validación

### 11.1. `User.java`

```java
public class User {
    private String name;
    private int age;
    private boolean active;

    public User(String name, int age) {
        setName(name);
        setAge(age);
        this.active = true;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public boolean isActive() {
        return active;
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

    public void deactivate() {
        this.active = false;
    }

    public void printInfo() {
        System.out.println("Name: " + name + " | Age: " + age + " | Active: " + active);
    }
}
```

### 11.2. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        User user = new User("Laura", 28);

        user.printInfo();

        user.setAge(-10); // se ignora
        user.setName("   "); // se ignora

        user.printInfo();

        user.deactivate();
        user.printInfo();
    }
}
```

---

## 12. Ejemplo completo: `BankAccount` sin setters peligrosos

```java
public class BankAccount {
    private double balance;

    public BankAccount() {
        this.balance = 0;
    }

    public double getBalance() {
        return balance;
    }

    public void deposit(double amount) {
        if (amount <= 0) {
            return;
        }

        balance += amount;
    }

    public boolean withdraw(double amount) {
        if (amount <= 0) {
            return false;
        }

        if (amount > balance) {
            return false;
        }

        balance -= amount;
        return true;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        BankAccount account = new BankAccount();

        account.deposit(100);
        System.out.println(account.getBalance()); // 100

        boolean ok = account.withdraw(30);
        System.out.println(ok); // true
        System.out.println(account.getBalance()); // 70

        ok = account.withdraw(200);
        System.out.println(ok); // false
        System.out.println(account.getBalance()); // 70
    }
}
```

---

## 13. Errores típicos

- Usar atributos `public` “por comodidad”
- Crear setters sin validación cuando el dominio lo requiere
- Validar solo en el constructor y no en setters (o al revés)

Patrón recomendado: el constructor puede llamar a los setters para reutilizar validación.

---

## 14. A tener en cuenta

- Encapsulación = atributos privados + acceso controlado por métodos.
- `public`, `private`, `protected` y package-private determinan desde dónde puedes acceder.
- Getters se usan para leer el estado; setters para modificarlo con validación.
- No siempre necesitas setters.
- Muchas veces es mejor un método con intención (`deposit`, `withdraw`) que un setter genérico (`setBalance`).

---

En el siguiente tema avanzaremos con constructores más completos, sobrecarga de constructores y patrones típicos de creación de objetos.
