# Tema 36. Concurrencia Básica

## 1. Introducción

Hasta ahora has escrito programas que normalmente se ejecutan de forma secuencial.

Eso significa que Java va ejecutando las instrucciones una detrás de otra:

```java
System.out.println("Step 1");
System.out.println("Step 2");
System.out.println("Step 3");
```

Primero se ejecuta el paso 1, luego el 2 y luego el 3.

Pero en muchos programas reales necesitamos que varias tareas puedan avanzar al mismo tiempo o de forma independiente.

Ejemplos:

- descargar un archivo mientras la aplicación sigue funcionando
- atender varias peticiones de usuarios
- procesar datos en segundo plano
- ejecutar tareas programadas
- hacer cálculos largos sin bloquear todo el programa
- leer varios archivos
- consultar varios servicios externos

Para eso usamos **concurrencia**.

En este tema aprenderás:

- Qué es la concurrencia
- Qué es un hilo de ejecución (_thread_)
- Cómo crear tareas con `Thread`
- Cómo usar `Runnable`
- Cómo pausar un hilo con `sleep`
- Cómo esperar a que termine un hilo con `join`
- Qué problemas pueden aparecer con datos compartidos
- Qué es una condición de carrera
- Cómo usar `synchronized` de forma básica
- Qué es `ExecutorService`
- Cómo usar `Callable` y `Future`
- Qué son los virtual threads como idea moderna
- Errores típicos y buenas prácticas

---

## 2. Qué es la concurrencia

La **concurrencia** consiste en organizar un programa para que pueda gestionar varias tareas durante el mismo periodo de tiempo.

No siempre significa que todo se ejecute literalmente al mismo instante.

Significa que el programa puede avanzar con varias tareas de manera coordinada.

Ejemplo conceptual:

```text
Tarea 1: descargar archivo
Tarea 2: mostrar progreso
Tarea 3: responder al usuario
```

En lugar de bloquear todo hasta que termine una tarea, el programa puede organizarse para atender varias cosas.

---

## 3. Concurrencia vs paralelismo

Estos dos conceptos suelen confundirse.

### 3.1. Concurrencia

La concurrencia consiste en gestionar varias tareas a la vez desde el punto de vista del diseño.

Ejemplo:

- una aplicación puede descargar un archivo y seguir respondiendo al usuario

### 3.2. Paralelismo

El paralelismo ocurre cuando varias tareas se ejecutan literalmente al mismo tiempo, normalmente usando varios núcleos del procesador.

Ejemplo:

- un ordenador con varios núcleos ejecuta varios cálculos simultáneamente

### 3.3. Regla sencilla

- Concurrencia: organizar varias tareas
- Paralelismo: ejecutar varias tareas al mismo tiempo

En este tema nos centraremos en la base de la concurrencia.

---

## 4. Qué es un thread

Un **thread** es un hilo de ejecución.

Cuando ejecutas un programa Java, existe al menos un hilo principal:

- el hilo donde se ejecuta `main`

Ejemplo:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Main thread");
    }
}
```

Pero Java permite crear más hilos para ejecutar tareas de forma independiente.

---

## 5. Primer ejemplo con `Thread`

Una forma básica de crear un hilo es usar la clase `Thread`.

```java
public class Main {
    public static void main(String[] args) {
        Thread thread = new Thread(() -> {
            System.out.println("Running in another thread");
        });

        thread.start();

        System.out.println("Running in main thread");
    }
}
```

Aquí ocurren dos cosas:

- `thread.start()` inicia un nuevo hilo
- el `main` sigue ejecutándose

El orden de impresión puede variar.

---

## 6. `start()` vs `run()`

Este punto es muy importante.

Para iniciar un hilo, debes llamar a:

```java
thread.start();
```

No a:

```java
thread.run();
```

### 6.1. `start()`

Crea un nuevo hilo de ejecución.

```java
thread.start();
```

### 6.2. `run()`

Ejecuta el código como una llamada normal de método, sin crear un nuevo hilo.

```java
thread.run();
```

Ejemplo:

```java
public class Main {
    public static void main(String[] args) {
        Thread thread = new Thread(() -> {
            System.out.println("Task running");
        });

        thread.run(); // no crea un hilo nuevo
    }
}
```

Regla práctica:

> Para lanzar un hilo, usa `start()`.

---

## 7. `Runnable`

`Runnable` es una interfaz funcional que representa una tarea que no recibe parámetros y no devuelve resultado.

Su método principal es:

```java
void run();
```

Ejemplo:

```java
public class Main {
    public static void main(String[] args) {
        Runnable task = () -> {
            System.out.println("Task running");
        };

        Thread thread = new Thread(task);
        thread.start();
    }
}
```

Como `Runnable` es una interfaz funcional, podemos usar una lambda.

---

## 8. Crear una clase que implemente `Runnable`

También puedes crear una clase propia.

### 8.1. `PrintTask.java`

```java
public class PrintTask implements Runnable {
    private String message;

    public PrintTask(String message) {
        this.message = message;
    }

    @Override
    public void run() {
        System.out.println(message);
    }
}
```

### 8.2. `Main.java`

```java
public class Main {
    public static void main(String[] args) {
        Thread thread1 = new Thread(new PrintTask("Task 1"));
        Thread thread2 = new Thread(new PrintTask("Task 2"));

        thread1.start();
        thread2.start();
    }
}
```

Esta forma es útil cuando la tarea tiene más lógica o necesita atributos.

---

## 9. Crear varios hilos

```java
public class Main {
    public static void main(String[] args) {
        Thread thread1 = new Thread(() -> System.out.println("Thread 1"));
        Thread thread2 = new Thread(() -> System.out.println("Thread 2"));
        Thread thread3 = new Thread(() -> System.out.println("Thread 3"));

        thread1.start();
        thread2.start();
        thread3.start();

        System.out.println("Main finished");
    }
}
```

El orden de salida no está garantizado.

Podrías ver:

```text
Thread 2
Main finished
Thread 1
Thread 3
```

o cualquier otro orden.

---

## 10. El orden no está garantizado

En programación concurrente, el orden de ejecución puede variar.

Ejemplo:

```java
public class Main {
    public static void main(String[] args) {
        Thread thread = new Thread(() -> {
            System.out.println("Child thread");
        });

        thread.start();

        System.out.println("Main thread");
    }
}
```

Podrías ver:

```text
Main thread
Child thread
```

o:

```text
Child thread
Main thread
```

Depende de cómo el sistema planifique los hilos.

---

## 11. Pausar un hilo con `Thread.sleep`

`Thread.sleep` pausa el hilo actual durante un tiempo.

El tiempo se indica en milisegundos.

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Start");

        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            System.out.println("Thread interrupted");
        }

        System.out.println("End");
    }
}
```

Aquí el programa espera aproximadamente 1 segundo.

---

## 12. `InterruptedException`

`Thread.sleep` puede lanzar `InterruptedException`.

Eso significa que el hilo puede ser interrumpido mientras está esperando.

Por eso debemos usar `try-catch`.

```java
try {
    Thread.sleep(1000);
} catch (InterruptedException e) {
    Thread.currentThread().interrupt();
}
```

Esta línea es una buena práctica:

```java
Thread.currentThread().interrupt();
```

Sirve para restaurar el estado de interrupción del hilo.

---

## 13. Ejemplo guiado con `sleep`

```java
public class Main {
    public static void main(String[] args) {
        Thread counter = new Thread(() -> {
            for (int i = 1; i <= 5; i++) {
                System.out.println("Counter: " + i);

                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    return;
                }
            }
        });

        counter.start();

        System.out.println("Main continues...");
    }
}
```

Aquí el contador se ejecuta en otro hilo mientras el hilo principal continúa.

---

## 14. Esperar a que termine un hilo con `join`

A veces quieres que el hilo principal espere a que otro hilo termine.

Para eso usamos `join`.

```java
public class Main {
    public static void main(String[] args) {
        Thread worker = new Thread(() -> {
            System.out.println("Worker started");

            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }

            System.out.println("Worker finished");
        });

        worker.start();

        try {
            worker.join();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        System.out.println("Main finished");
    }
}
```

Aquí `Main finished` se imprime después de que termine `worker`.

---

## 15. Ejemplo sin `join` y con `join`

### 15.1. Sin `join`

```java
public class Main {
    public static void main(String[] args) {
        Thread worker = new Thread(() -> {
            System.out.println("Worker running");
        });

        worker.start();

        System.out.println("Main finished");
    }
}
```

El orden no está garantizado.

### 15.2. Con `join`

```java
public class Main {
    public static void main(String[] args) {
        Thread worker = new Thread(() -> {
            System.out.println("Worker running");
        });

        worker.start();

        try {
            worker.join();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        System.out.println("Main finished");
    }
}
```

Ahora `Main finished` espera a que `worker` termine.

---

## 16. Datos compartidos entre hilos

Cuando varios hilos acceden a los mismos datos, pueden aparecer problemas.

Ejemplo:

```java
public class Counter {
    private int value = 0;

    public void increment() {
        value++;
    }

    public int getValue() {
        return value;
    }
}
```

Parece sencillo, pero si varios hilos llaman a `increment` al mismo tiempo, el resultado puede ser incorrecto.

---

## 17. Qué es una condición de carrera

Una **condición de carrera** ocurre cuando el resultado depende del orden exacto en que se ejecutan varios hilos.

Ejemplo:

```java
value++;
```

Parece una sola operación, pero internamente implica varios pasos:

1. leer `value`
2. sumar 1
3. guardar el resultado

Si dos hilos hacen esto al mismo tiempo, pueden pisarse.

---

## 18. Ejemplo de problema con contador compartido

```java
public class Main {
    public static void main(String[] args) {
        Counter counter = new Counter();

        Thread thread1 = new Thread(() -> {
            for (int i = 0; i < 1000; i++) {
                counter.increment();
            }
        });

        Thread thread2 = new Thread(() -> {
            for (int i = 0; i < 1000; i++) {
                counter.increment();
            }
        });

        thread1.start();
        thread2.start();

        try {
            thread1.join();
            thread2.join();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        System.out.println(counter.getValue());
    }
}
```

Clase `Counter`:

```java
public class Counter {
    private int value = 0;

    public void increment() {
        value++;
    }

    public int getValue() {
        return value;
    }
}
```

Podrías esperar:

```text
2000
```

Pero puede salir un número menor.

---

## 19. Solución básica: `synchronized`

` synchronized` permite proteger una sección de código para que solo un hilo la ejecute a la vez sobre el mismo objeto.

Ejemplo:

```java
public class Counter {
    private int value = 0;

    public synchronized void increment() {
        value++;
    }

    public int getValue() {
        return value;
    }
}
```

Ahora, si dos hilos llaman a `increment`, Java evita que ambos entren a la vez en ese método para el mismo objeto.

---

## 20. `synchronized` en métodos

Puedes marcar un método como `synchronized`.

```java
public synchronized void increment() {
    value++;
}
```

Esto bloquea el acceso concurrente al método para el mismo objeto.

También podrías sincronizar el getter si necesitas máxima consistencia:

```java
public synchronized int getValue() {
    return value;
}
```

---

## 21. Ejemplo corregido con `synchronized`

```java
public class Counter {
    private int value = 0;

    public synchronized void increment() {
        value++;
    }

    public synchronized int getValue() {
        return value;
    }
}
```

Uso:

```java
public class Main {
    public static void main(String[] args) {
        Counter counter = new Counter();

        Thread thread1 = new Thread(() -> {
            for (int i = 0; i < 1000; i++) {
                counter.increment();
            }
        });

        Thread thread2 = new Thread(() -> {
            for (int i = 0; i < 1000; i++) {
                counter.increment();
            }
        });

        thread1.start();
        thread2.start();

        try {
            thread1.join();
            thread2.join();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        System.out.println(counter.getValue());
    }
}
```

Ahora el resultado debería ser:

```text
2000
```

---

## 22. Bloques `synchronized`

También puedes sincronizar solo una parte del código.

```java
public class Counter {
    private int value = 0;

    public void increment() {
        synchronized (this) {
            value++;
        }
    }

    public int getValue() {
        synchronized (this) {
            return value;
        }
    }
}
```

Esto permite controlar exactamente qué parte debe protegerse.

---

## 23. Cuidado con compartir datos mutables

La concurrencia se vuelve más compleja cuando varios hilos modifican los mismos datos.

Ejemplo de datos compartidos:

- listas modificables
- mapas modificables
- contadores
- saldos
- estados de objetos

Regla práctica inicial:

> Cuantos menos datos compartidos entre hilos, mejor.

---

## 24. `ExecutorService`

Crear hilos manualmente con `new Thread(...)` está bien para aprender, pero en aplicaciones reales suele usarse una herramienta de más alto nivel:

- `ExecutorService`

`ExecutorService` permite gestionar un conjunto de hilos y enviar tareas para que se ejecuten.

Importaciones:

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
```

---

## 25. Crear un `ExecutorService`

Ejemplo con un pool de 2 hilos:

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Main {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(2);

        executor.execute(() -> System.out.println("Task 1"));
        executor.execute(() -> System.out.println("Task 2"));
        executor.execute(() -> System.out.println("Task 3"));

        executor.shutdown();
    }
}
```

Aquí:

- el pool tiene 2 hilos
- puedes enviar varias tareas
- el executor decide cuándo ejecutarlas

---

## 26. `execute`

`execute` recibe un `Runnable`.

```java
executor.execute(() -> {
    System.out.println("Running task");
});
```

Se usa cuando la tarea:

- no devuelve resultado
- no necesitas recoger un valor final

---

## 27. `shutdown`

Cuando terminas de enviar tareas, debes cerrar el executor.

```java
executor.shutdown();
```

Esto significa:

- no acepta nuevas tareas
- deja terminar las tareas ya enviadas

No debes olvidar llamar a `shutdown`.

---

## 28. Ejemplo guiado con `ExecutorService`

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Main {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(3);

        for (int i = 1; i <= 5; i++) {
            int taskNumber = i;

            executor.execute(() -> {
                System.out.println("Running task " + taskNumber);
            });
        }

        executor.shutdown();
    }
}
```

Importante:

```java
int taskNumber = i;
```

Creamos una variable local para usarla dentro de la lambda.

---

## 29. `Callable`

`Runnable` representa una tarea que no devuelve resultado.

Pero a veces quieres que una tarea devuelva un valor.

Para eso existe `Callable`.

Importación:

```java
import java.util.concurrent.Callable;
```

Ejemplo:

```java
Callable<Integer> task = () -> {
    return 10 + 20;
};
```

`Callable<T>` devuelve un valor de tipo `T`.

---

## 30. `Future`

Cuando envías un `Callable` a un executor, recibes un `Future`.

Un `Future` representa un resultado que estará disponible en el futuro.

Importación:

```java
import java.util.concurrent.Future;
```

Ejemplo:

```java
Future<Integer> future = executor.submit(task);
```

Para obtener el resultado:

```java
Integer result = future.get();
```

`get()` espera hasta que la tarea termine.

---

## 31. Ejemplo con `Callable` y `Future`

```java
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class Main {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newSingleThreadExecutor();

        Callable<Integer> task = () -> {
            return 10 + 20;
        };

        Future<Integer> future = executor.submit(task);

        try {
            Integer result = future.get();
            System.out.println("Result: " + result);
        } catch (Exception e) {
            System.out.println("Could not get result");
            System.out.println(e.getMessage());
        }

        executor.shutdown();
    }
}
```

---

## 32. `submit` con `Runnable`

`submit` también puede recibir un `Runnable`.

```java
Future<?> future = executor.submit(() -> {
    System.out.println("Task running");
});
```

Pero si necesitas solo ejecutar una tarea sin resultado, `execute` suele ser suficiente.

---

## 33. Diferencia entre `execute` y `submit`

### 33.1. `execute`

- recibe `Runnable`
- no devuelve resultado
- se usa para ejecutar tareas simples

```java
executor.execute(() -> System.out.println("Hello"));
```

### 33.2. `submit`

- recibe `Runnable` o `Callable`
- devuelve un `Future`
- permite consultar el resultado o la finalización

```java
Future<Integer> future = executor.submit(() -> 42);
```

---

## 34. Ejemplo completo: calcular suma en segundo plano

```java
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class Main {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newSingleThreadExecutor();

        List<Integer> numbers = List.of(10, 20, 30, 40);

        Callable<Integer> sumTask = () -> {
            int sum = 0;

            for (Integer number : numbers) {
                sum += number;
            }

            return sum;
        };

        Future<Integer> future = executor.submit(sumTask);

        try {
            Integer result = future.get();
            System.out.println("Sum: " + result);
        } catch (Exception e) {
            System.out.println("Error getting result");
            System.out.println(e.getMessage());
        }

        executor.shutdown();
    }
}
```

---

## 35. Excepciones en tareas concurrentes

Las excepciones en tareas concurrentes requieren atención.

Si una tarea enviada con `Callable` falla, la excepción aparece al llamar a:

```java
future.get();
```

Ejemplo:

```java
Callable<Integer> task = () -> {
    throw new IllegalArgumentException("Invalid task");
};
```

Al hacer:

```java
future.get();
```

se lanzará una excepción envolviendo el problema original.

---

## 36. Interrumpir un hilo

Un hilo puede ser interrumpido.

La interrupción es una forma de pedirle a un hilo que pare o reaccione.

Ejemplo:

```java
Thread worker = new Thread(() -> {
    try {
        Thread.sleep(5000);
    } catch (InterruptedException e) {
        System.out.println("Worker interrupted");
        Thread.currentThread().interrupt();
    }
});

worker.start();
worker.interrupt();
```

La interrupción no mata el hilo mágicamente.  
Es una señal que el hilo debe manejar correctamente.

---

## 37. `Thread.currentThread()`

Puedes obtener el hilo actual con:

```java
Thread.currentThread()
```

Ejemplo:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println(Thread.currentThread().getName());

        Thread thread = new Thread(() -> {
            System.out.println(Thread.currentThread().getName());
        });

        thread.start();
    }
}
```

Esto puede ayudarte a entender qué hilo está ejecutando cada parte del código.

---

## 38. Poner nombre a un hilo

Puedes asignar un nombre a un hilo.

```java
Thread worker = new Thread(() -> {
    System.out.println(Thread.currentThread().getName());
}, "worker-thread");

worker.start();
```

Los nombres son útiles para depurar.

---

## 39. Colecciones y concurrencia

Las colecciones normales como `ArrayList` o `HashMap` no están pensadas para ser modificadas por varios hilos a la vez sin protección.

Ejemplo peligroso:

```java
List<String> names = new ArrayList<>();

Thread thread1 = new Thread(() -> names.add("Laura"));
Thread thread2 = new Thread(() -> names.add("Alex"));
```

En programas reales, para trabajar con colecciones compartidas entre hilos existen herramientas específicas en:

```java
java.util.concurrent
```

Por ejemplo:

- `ConcurrentHashMap`
- `CopyOnWriteArrayList`
- `BlockingQueue`

En este tema solo necesitas conocer la idea: compartir colecciones mutables entre hilos requiere cuidado.

---

## 40. Introducción a virtual threads

Java moderno incluye una herramienta llamada **virtual threads**.

Un virtual thread es un hilo ligero gestionado por la JVM.

La idea principal es:

- crear muchas tareas concurrentes con menor coste que los hilos tradicionales
- simplificar ciertos tipos de aplicaciones, especialmente cuando hay muchas operaciones de espera

Ejemplo básico:

```java
public class Main {
    public static void main(String[] args) throws InterruptedException {
        Thread thread = Thread.startVirtualThread(() -> {
            System.out.println("Running in a virtual thread");
        });

        thread.join();
    }
}
```

No necesitas dominar virtual threads todavía, pero es importante saber que existen en Java moderno.

---

## 41. Virtual threads con `ExecutorService`

También puedes usar un executor para virtual threads.

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Main {
    public static void main(String[] args) {
        try (ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor()) {
            executor.submit(() -> {
                System.out.println("Task in virtual thread");
            });
        }
    }
}
```

Este enfoque es moderno, pero para empezar es mejor entender primero:

- `Thread`
- `Runnable`
- `ExecutorService`
- `Callable`
- `Future`

---

## 42. Cuándo usar concurrencia

La concurrencia puede ser útil cuando:

- una tarea tarda mucho
- necesitas no bloquear el programa principal
- hay varias operaciones independientes
- trabajas con entrada/salida
- procesas muchas peticiones
- quieres aprovechar mejor los recursos

Ejemplos:

- servidor web
- procesamiento de archivos
- llamadas a APIs
- tareas programadas
- carga de datos en segundo plano

---

## 43. Cuándo NO usar concurrencia

No uses concurrencia si:

- el programa es muy simple
- una solución secuencial es suficiente
- no hay tareas independientes
- aumenta la complejidad sin aportar valor
- no sabes cómo proteger los datos compartidos

La concurrencia puede mejorar un programa, pero también puede hacerlo más difícil de entender.

---

## 44. Ejemplo completo: procesamiento de tareas

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Main {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(2);

        executor.execute(() -> processTask("Task 1"));
        executor.execute(() -> processTask("Task 2"));
        executor.execute(() -> processTask("Task 3"));
        executor.execute(() -> processTask("Task 4"));

        executor.shutdown();
    }

    public static void processTask(String taskName) {
        System.out.println("Starting " + taskName);

        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            return;
        }

        System.out.println("Finished " + taskName);
    }
}
```

Aquí hay 4 tareas, pero solo 2 hilos en el pool.  
El executor va organizando la ejecución.

---

## 45. Ejemplo completo: servicio de notificaciones

### 45.1. `NotificationService.java`

```java
public class NotificationService {
    public void sendEmail(String email) {
        System.out.println("Sending email to " + email);

        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            return;
        }

        System.out.println("Email sent to " + email);
    }
}
```

### 45.2. `Main.java`

```java
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Main {
    public static void main(String[] args) {
        NotificationService service = new NotificationService();

        List<String> emails = List.of(
                "laura@example.com",
                "alex@example.com",
                "maria@example.com"
        );

        ExecutorService executor = Executors.newFixedThreadPool(2);

        for (String email : emails) {
            executor.execute(() -> service.sendEmail(email));
        }

        executor.shutdown();
    }
}
```

Este ejemplo simula el envío concurrente de notificaciones.

---

## 46. Errores típicos al empezar

### 46.1. Llamar a `run()` en lugar de `start()`

```java
thread.run(); // no crea un hilo nuevo
```

Debes usar:

```java
thread.start();
```

### 46.2. Asumir un orden fijo de ejecución

En concurrencia, el orden puede variar.

### 46.3. Compartir datos mutables sin protección

Esto puede producir condiciones de carrera.

### 46.4. Olvidar `shutdown`

Si usas `ExecutorService`, recuerda cerrarlo.

```java
executor.shutdown();
```

### 46.5. Ignorar `InterruptedException`

No conviene dejar el `catch` vacío.

Mejor:

```java
Thread.currentThread().interrupt();
```

### 46.6. Crear demasiados hilos manualmente

Para muchas tareas, es mejor usar `ExecutorService`.

---

## 47. Buenas prácticas

- Empieza usando concurrencia solo cuando realmente sea necesaria.
- Usa `Runnable` para tareas sin resultado.
- Usa `Callable` para tareas con resultado.
- Usa `ExecutorService` en vez de crear muchos hilos manualmente.
- Llama a `shutdown` cuando termines con el executor.
- Evita compartir datos mutables entre hilos.
- Usa `synchronized` si varios hilos modifican el mismo estado.
- Maneja correctamente `InterruptedException`.
- Usa nombres de hilos si necesitas depurar.
- Mantén las tareas pequeñas y claras.

---

## 48. A tener en cuenta

- Un thread es un hilo de ejecución.
- `main` se ejecuta en el hilo principal.
- `Thread.start()` crea un nuevo hilo.
- `Runnable` representa una tarea sin resultado.
- `Thread.sleep` pausa el hilo actual.
- `join` permite esperar a que un hilo termine.
- Los datos compartidos pueden provocar condiciones de carrera.
- `synchronized` permite proteger secciones críticas.
- `ExecutorService` gestiona pools de hilos.
- `Callable` permite devolver resultados.
- `Future` representa un resultado que llegará más adelante.
- Los virtual threads son una herramienta moderna para concurrencia ligera.

---

## 49. Resumen final

La concurrencia permite que un programa gestione varias tareas durante el mismo periodo de tiempo.

En Java, la base de la concurrencia empieza con:

```java
Thread
Runnable
```

Pero en código más realista se suele trabajar con herramientas de más alto nivel:

```java
ExecutorService
Callable
Future
```

También has visto que la concurrencia introduce nuevos problemas, especialmente cuando varios hilos comparten y modifican los mismos datos.

Por eso es importante entender ideas como:

- orden no garantizado
- condiciones de carrera
- sincronización
- interrupciones
- cierre correcto de executors

La concurrencia es un tema amplio, pero con esta base ya puedes entender cómo Java ejecuta tareas en paralelo o en segundo plano de forma controlada.

---

En el siguiente tema veremos qué son y cómo puedes trabajar con **Anotaciones**.
