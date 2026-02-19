# Tema 7. Control del flujo en bucles

## 1. Introducción

En el tema anterior aprendiste a repetir acciones con `while` y `for`. Sin embargo, en programas reales no siempre quieres que el bucle:

- Se ejecute siempre de principio a fin
- Repita todas las iteraciones
- Dependa únicamente de la condición del bucle

A veces necesitas **controlar el flujo** dentro del bucle:

- Salir del bucle antes de tiempo
- Saltarte una iteración concreta y seguir con la siguiente
- Evitar ejecutar parte del bloque cuando se cumple una condición

Para esto, Java ofrece principalmente:

- `break`
- `continue`

En este tema aprenderás:

- Qué hace exactamente `break`
- Qué hace exactamente `continue`
- Cuándo conviene usarlos y cuándo evitarlos
- Ejemplos prácticos y patrones típicos

---

## 2. Idea clave: “alterar” el bucle desde dentro

Un bucle normalmente avanza así:

1. Comprueba condición
2. Ejecuta el bloque
3. Actualiza contador (si es `for`)
4. Repite

Con `break` y `continue` puedes intervenir en ese flujo:

- `break` corta el bucle completo
- `continue` corta _solo la iteración actual_

---

## 3. `break`: salir del bucle

### 3.1. Qué hace `break`

Cuando Java ejecuta `break` dentro de un bucle, el bucle termina inmediatamente y el programa continúa **después** del bucle.

Esto funciona igual en:

- `while`
- `for`
- `do-while`
- `switch` (aunque en switch es otro uso, ya lo conoces)

---

### 3.2. Ejemplo 1: detenerse cuando se encuentra un valor

Imagina que estás “buscando” el número 7 dentro de un rango.

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 10; i++) {
            System.out.println("Checking: " + i);

            if (i == 7) {
                System.out.println("Found it!");
                break;
            }
        }

        System.out.println("Loop finished");
    }
}
```

Qué ocurre:

- El bucle imprime “Checking” para 1, 2, 3...
- Cuando `i` vale 7, imprime “Found it!” y ejecuta `break`
- El bucle termina, aunque todavía quedarían iteraciones 8, 9 y 10

---

### 3.3. Ejemplo 2: bucle `while` que se detiene por una condición interna

A veces la condición del `while` no es suficiente, y decides terminar desde dentro.

```java
public class Main {
    public static void main(String[] args) {
        int attempts = 0;

        while (true) {
            attempts++;
            System.out.println("Attempt: " + attempts);

            if (attempts == 3) {
                System.out.println("Stopping after 3 attempts");
                break;
            }
        }

        System.out.println("Done");
    }
}
```

Aquí la condición del bucle es `true`, así que **solo `break` puede detenerlo**.

Esto se usa mucho cuando:

- No sabes qué condición exacta detendrá el bucle al inicio
- La condición depende de varios factores internos

---

### 3.4. Patrón común: “buscar y parar”

Este patrón aparece muchísimo cuando trabajes con arrays o listas:

- Recorres algo
- Si encuentras lo que buscas, paras con `break`

Aunque aún no hemos visto arrays, puedes entender la idea con un rango.

```java
public class Main {
    public static void main(String[] args) {
        int target = 9;
        boolean found = false;

        for (int i = 1; i <= 20; i++) {
            if (i == target) {
                found = true;
                break;
            }
        }

        System.out.println("Found: " + found);
    }
}
```

---

## 4. `continue`: saltar una iteración

### 4.1. Qué hace `continue`

Cuando Java ejecuta `continue` dentro de un bucle:

- Se detiene la iteración actual
- Se salta lo que queda del bloque
- El bucle pasa directamente a la siguiente iteración

Es decir, no termina el bucle, solo “salta” una vuelta.

---

### 4.2. Ejemplo 1: saltar números impares

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 10; i++) {
            if (i % 2 != 0) {
                continue;
            }

            System.out.println(i);
        }
    }
}
```

Qué ocurre:

- Para `i = 1`, es impar, así que hace `continue` y no imprime.
- Para `i = 2`, no entra al `if` y se imprime.
- Resultado: solo imprime los pares.

---

### 4.3. Ejemplo 2: evitar procesar valores “inválidos”

Imagina que quieres “procesar” números, pero ignorar el 0.

```java
public class Main {
    public static void main(String[] args) {
        for (int i = -3; i <= 3; i++) {
            if (i == 0) {
                continue;
            }

            int result = 10 / i;
            System.out.println("10 / " + i + " = " + result);
        }
    }
}
```

Si no usas `continue`, habría división entre cero (error).  
Con `continue`, `i == 0` se salta y el bucle sigue.

---

### 4.4. Ejemplo 3: filtrar y contar

Puedes usar `continue` para filtrar valores que no te interesan.

```java
public class Main {
    public static void main(String[] args) {
        int count = 0;

        for (int i = 1; i <= 20; i++) {
            if (i % 3 != 0) {
                continue;
            }

            count++;
        }

        System.out.println("Multiples of 3: " + count);
    }
}
```

---

## 5. Comparación rápida: `break` vs `continue`

- `break` → termina el bucle completo
- `continue` → salta la iteración actual y sigue

Ejemplo visual (idea):

- `break`: “me voy del bucle”
- `continue`: “esta vuelta no, siguiente”

---

## 6. `break` y `continue` en `while`

En `while`, el efecto es el mismo, pero hay un detalle importante:

- En un `for`, el contador se actualiza automáticamente al final de la iteración
- En un `while`, tú controlas todo

Eso significa que, si haces `continue` en un `while`, debes asegurarte de que el estado del bucle sigue actualizándose, o podrías crear un bucle infinito.

### 6.1. Ejemplo: `continue` en `while` con cuidado

```java
public class Main {
    public static void main(String[] args) {
        int i = 0;

        while (i < 10) {
            i++;

            if (i % 2 != 0) {
                continue;
            }

            System.out.println(i);
        }
    }
}
```

Fíjate en que `i++` ocurre **antes** del `continue`.  
Si estuviera después, el bucle se quedaría “atascado”.

---

## 7. Buenas prácticas (cuándo usarlos y cuándo evitarlo)

### 7.1. Cuándo `break` es una buena opción

- Cuando estás buscando algo y quieres parar al encontrarlo
- Cuando necesitas una salida clara ante un caso especial
- Cuando un `while (true)` tiene un punto de salida explícito y claro

Ejemplo de uso razonable:

```java
for (int i = 0; i < 100; i++) {
    if (i == 25) {
        break;
    }
}
```

---

### 7.2. Cuándo `continue` es una buena opción

- Cuando quieres filtrar casos rápidamente
- Cuando quieres evitar un bloque grande de `if` anidados

Ejemplo más limpio con `continue`:

```java
for (int i = 1; i <= 10; i++) {
    if (i == 5) {
        continue;
    }

    System.out.println(i);
}
```

---

### 7.3. Cuándo deberías tener cuidado

Si abusas de `break` y `continue`, tu bucle puede volverse difícil de leer, especialmente si hay muchas condiciones y varios `continue`.

En esos casos suele ser mejor:

- Reescribir la condición del bucle
- Mover parte de la lógica a métodos (lo verás más adelante)
- Usar variables booleanas para claridad

---

## 8. Ejemplos completos (patrones frecuentes)

### 8.1. Patrón: validar intentos y cortar

```java
public class Main {
    public static void main(String[] args) {
        int attempts = 0;
        int maxAttempts = 5;

        while (attempts < maxAttempts) {
            attempts++;
            System.out.println("Attempt: " + attempts);

            boolean isSuccess = attempts == 4; // simulación
            if (isSuccess) {
                System.out.println("Success!");
                break;
            }
        }

        System.out.println("Attempts used: " + attempts);
    }
}
```

---

### 8.2. Patrón: filtrar y procesar

```java
public class Main {
    public static void main(String[] args) {
        int processed = 0;

        for (int i = 1; i <= 15; i++) {
            if (i % 4 != 0) {
                continue;
            }

            processed++;
            System.out.println("Processed: " + i);
        }

        System.out.println("Total processed: " + processed);
    }
}
```

---

### 8.3. Patrón: combinar `continue` para evitar una excepción

```java
public class Main {
    public static void main(String[] args) {
        for (int i = -2; i <= 2; i++) {
            if (i == 0) {
                continue;
            }

            System.out.println("100 / " + i + " = " + (100 / i));
        }
    }
}
```

---

## 9. A tener en cuenta

- `break` termina el bucle completo inmediatamente.
- `continue` salta la iteración actual y pasa a la siguiente.
- Son herramientas útiles, pero deben usarse con intención.
- En `while`, usa `continue` con cuidado para no crear bucles infinitos.
- Son especialmente útiles para patrones como “buscar”, “filtrar” y “evitar casos especiales”.

---

En el próximo tema veremos **métodos**: qué son, cómo se definen y cómo se usan para organizar mejor tu código cuando empieza a crecer.
