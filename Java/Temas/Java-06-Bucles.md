# Tema 6. Bucles (while y for)

## 1. Introducción

En programación, muchas tareas consisten en **repetir acciones**:

- Mostrar una lista de números
- Sumar valores hasta que ocurra algo
- Pedir datos al usuario hasta que sean válidos
- Repetir intentos en un juego
- Recorrer una estructura de datos (arrays, listas, etc.)

Para esto existen los **bucles**.

Un bucle permite ejecutar un bloque de código **varias veces**, bajo una condición o un número determinado de repeticiones.

En Java, los bucles más importantes al empezar son:

- `while` (bucle condicional)
- `for` (bucle contador)

En este tema aprenderás:

- Cómo funciona un bucle `while`
- Cómo funciona un bucle `for`
- Cómo elegir entre uno y otro
- Errores comunes (bucles infinitos, off-by-one, etc.)
- Patrones básicos que usarás constantemente

---

## 2. Concepto clave: condición, repetición y estado

Todo bucle tiene tres ideas importantes:

1. **Condición**: decide si el bucle continúa o se detiene.
2. **Estado**: una variable (o varias) que cambia con el tiempo.
3. **Actualización**: lo que modifica el estado para que el bucle avance.

Si no actualizas el estado, es fácil caer en un **bucle infinito**.

---

## 3. Bucle `while`

### 3.1. ¿Qué es un `while`?

Un `while` repite un bloque **mientras** la condición sea `true`.

Sintaxis:

```java
while (condition) {
    // code to repeat
}
```

- Si la condición es `true`, entra al bucle.
- Después de cada iteración, vuelve a comprobar la condición.
- Si la condición es `false`, el bucle termina.

---

### 3.2. Ejemplo 1: contar de 1 a 5

```java
public class Main {
    public static void main(String[] args) {
        int counter = 1;

        while (counter <= 5) {
            System.out.println(counter);
            counter++;
        }
    }
}
```

Qué está pasando:

- `counter` empieza en 1 (estado inicial)
- La condición es `counter <= 5`
- En cada vuelta se imprime y luego se incrementa
- Al llegar a 6, la condición es falsa y el bucle termina

Salida:

```
1
2
3
4
5
```

---

### 3.3. Ejemplo 2: sumar números hasta alcanzar un límite

```java
public class Main {
    public static void main(String[] args) {
        int total = 0;
        int number = 1;

        while (total < 10) {
            total = total + number;
            number++;

            System.out.println("Total: " + total);
        }
    }
}
```

Ideas clave:

- `total` cambia y controla cuándo parar
- `number` también cambia para que cada suma sea distinta

---

### 3.4. Error típico: bucle infinito por no actualizar el contador

Esto es un error clásico:

```java
int counter = 1;

while (counter <= 5) {
    System.out.println(counter);
}
```

La condición siempre es `true` porque `counter` nunca cambia.  
El programa no termina (bucle infinito).

Solución: actualiza el estado

```java
int counter = 1;

while (counter <= 5) {
    System.out.println(counter);
    counter++;
}
```

---

## 4. Bucle `do-while` (muy útil para validar)

Aunque el tema se centra en `while` y `for`, conviene conocer `do-while` porque aparece mucho cuando quieres que algo se ejecute al menos una vez.

Sintaxis:

```java
do {
    // code to repeat
} while (condition);
```

La diferencia con `while` es:

- `do-while` ejecuta el bloque **una vez** y luego evalúa la condición.

Ejemplo:

```java
public class Main {
    public static void main(String[] args) {
        int counter = 10;

        do {
            System.out.println(counter);
            counter++;
        } while (counter <= 5);
    }
}
```

Esto imprime `10` una vez, aunque la condición sea falsa desde el inicio.

---

## 5. Bucle `for`

### 5.1. ¿Qué es un `for`?

Un `for` es ideal cuando sabes cuántas veces quieres repetir algo. Es un bucle contador.

Sintaxis:

```java
for (initialization; condition; update) {
    // code to repeat
}
```

- **initialization**: se ejecuta una sola vez al inicio
- **condition**: se comprueba antes de cada iteración
- **update**: se ejecuta después de cada iteración

---

### 5.2. Ejemplo 1: contar de 1 a 5

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 5; i++) {
            System.out.println(i);
        }
    }
}
```

Comparado con `while`, el `for` agrupa en una sola línea:

- variable contador (`int i = 1`)
- condición (`i <= 5`)
- actualización (`i++`)

---

### 5.3. Ejemplo 2: contar hacia atrás

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 5; i >= 1; i--) {
            System.out.println(i);
        }
    }
}
```

Salida:

```
5
4
3
2
1
```

---

### 5.4. Ejemplo 3: saltos (step) de 2 en 2

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 0; i <= 10; i += 2) {
            System.out.println(i);
        }
    }
}
```

Salida:

```
0
2
4
6
8
10
```

---

## 6. ¿Cuándo usar `while` y cuándo usar `for`?

### 6.1. Usa `for` cuando

- Sabes cuántas repeticiones habrá
- Estás recorriendo un rango claro: 1 a 10, 0 a 99, etc.
- Hay un contador con incremento simple

Ejemplo típico: repetir 10 veces

```java
for (int i = 0; i < 10; i++) {
    System.out.println("Attempt: " + i);
}
```

---

### 6.2. Usa `while` cuando

- No sabes cuántas repeticiones habrá
- Dependende de una condición externa
- Estás esperando que ocurra algo

Ejemplo típico: repetir hasta que un valor alcance un estado

```java
while (balance > 0) {
    balance = balance - costPerDay;
}
```

---

## 7. Patrones básicos de bucles (muy importantes)

### 7.1. Patrón 1: contador

```java
int counter = 0;

while (counter < 3) {
    System.out.println(counter);
    counter++;
}
```

---

### 7.2. Patrón 2: acumulador

Un acumulador es una variable que “va guardando” un resultado.

```java
int sum = 0;

for (int i = 1; i <= 5; i++) {
    sum += i;
}

System.out.println(sum); // 15
```

Aquí `sum` es el acumulador.

---

### 7.3. Patrón 3: encontrar un máximo

Aunque aún no hemos visto arrays, podemos entender la idea con variables sueltas:

```java
int max = 10;
int value = 25;

if (value > max) {
    max = value;
}
```

Cuando veas arrays, este patrón se usa dentro de bucles.

---

### 7.4. Patrón 4: contador condicionado

Contar cuántas veces ocurre algo:

```java
int count = 0;

for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) {
        count++;
    }
}

System.out.println(count); // cuántos pares hay entre 1 y 10
```

---

## 8. Errores comunes al trabajar con bucles

### 8.1. Bucle infinito

Ocurre cuando la condición nunca se vuelve `false`.

Causas típicas:

- No actualizar el contador
- Actualizarlo en la dirección incorrecta
- Condición mal escrita

Ejemplo típico (dirección incorrecta):

```java
int counter = 1;

while (counter <= 5) {
    System.out.println(counter);
    counter--; // va hacia abajo, nunca llegará a 6
}
```

---

### 8.2. Error de “una vez de más” (off-by-one)

Muy frecuente en rangos.

Ejemplo:

```java
for (int i = 0; i <= 10; i++) {
    System.out.println(i);
}
```

Imprime 11 números (0 a 10).

Si querías imprimir 10 números, suele ser:

```java
for (int i = 0; i < 10; i++) {
    System.out.println(i);
}
```

- `i < 10` → 0 a 9 (10 valores)

---

### 8.3. Reutilizar contadores con valores “sucios”

Si reusas la misma variable sin reiniciarla, puede causar fallos lógicos.

Ejemplo:

```java
int i = 0;

while (i < 3) {
    i++;
}

while (i < 3) {
    System.out.println(i); // nunca entra
    i++;
}
```

Solución: reiniciar `i` antes del segundo bucle.

---

## 9. Ejemplos completos y guiados

### 9.1. Ejemplo 1: imprimir una tabla simple (multiplicar por 3)

```java
public class Main {
    public static void main(String[] args) {
        int base = 3;

        for (int i = 1; i <= 10; i++) {
            int result = base * i;
            System.out.println(base + " x " + i + " = " + result);
        }
    }
}
```

Esto imprime una tabla de multiplicar del 3, del 1 al 10.

---

### 9.2. Ejemplo 2: simular intentos hasta alcanzar un objetivo

```java
public class Main {
    public static void main(String[] args) {
        int attempts = 0;
        int progress = 0;

        while (progress < 100) {
            attempts++;
            progress += 15;

            System.out.println("Attempt: " + attempts + " | Progress: " + progress);
        }

        System.out.println("Finished in " + attempts + " attempts.");
    }
}
```

Ideas clave:

- `progress` controla cuándo parar
- `attempts` cuenta cuántas vueltas ha dado el bucle
- `progress` crece y eventualmente alcanza el objetivo

---

### 9.3. Ejemplo 3: combinar bucle y condicional dentro

```java
public class Main {
    public static void main(String[] args) {
        int evenSum = 0;

        for (int i = 1; i <= 10; i++) {
            if (i % 2 == 0) {
                evenSum += i;
            }
        }

        System.out.println("Even sum: " + evenSum);
    }
}
```

Esto suma solo los pares del 1 al 10.

---

## 10. A tener en cuenta

- Un bucle repite código hasta que se cumple una condición de salida.
- `while` es ideal cuando no sabes cuántas repeticiones habrá.
- `for` es ideal cuando hay un contador y un rango claro.
- Casi todos los bucles necesitan una variable que cambie (estado).
- Los errores más comunes son: bucles infinitos y off-by-one.
- Practicar patrones (contador, acumulador, filtrado) te ayudará en temas futuros como arrays y colecciones.

---

En el próximo tema veremos **control del flujo en bucles** (`break` y `continue`), para detener una repetición o saltar una iteración cuando lo necesites.
