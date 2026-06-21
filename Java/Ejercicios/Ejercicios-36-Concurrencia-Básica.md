# Ejercicios - Tema 36: Concurrencia Básica

A continuación encontrarás **10 ejercicios prácticos** para trabajar con **concurrencia básica**: `Thread`, `Runnable`, `sleep`, `join`, `synchronized`, `ExecutorService`, `Callable`, `Future`, interrupciones y virtual threads.

Intenta resolverlos antes de consultar la solución.

---

## Ejercicio 1: Crear un hilo con `Thread`

Crea un hilo que imprima:

```text
Running task
```

Inícialo usando `start()`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        Thread thread = new Thread(() -> {
            System.out.println("Running task");
        });

        thread.start();
    }
}
```

</details>

---

## Ejercicio 2: Crear una clase que implemente `Runnable`

Crea una clase `DownloadTask` que implemente `Runnable`.

Su método `run()` debe imprimir:

```text
Downloading file...
```

Desde `main`, crea un hilo con esa tarea y ejecútalo.

<details><summary>Mostrar solución</summary>

```java
public class DownloadTask implements Runnable {
    @Override
    public void run() {
        System.out.println("Downloading file...");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Thread thread = new Thread(new DownloadTask());

        thread.start();
    }
}
```

</details>

---

## Ejercicio 3: Usar `Thread.sleep`

Crea un programa que imprima:

```text
Start
```

espere 1 segundo con `Thread.sleep(1000)` y después imprima:

```text
End
```

Maneja `InterruptedException`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Start");

        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        System.out.println("End");
    }
}
```

</details>

---

## Ejercicio 4: Esperar a un hilo con `join`

Crea un hilo que espere 500 ms y después imprima `"Worker finished"`.

En `main`, espera a que termine con `join()` y luego imprime `"Main finished"`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        Thread worker = new Thread(() -> {
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                return;
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

</details>

---

## Ejercicio 5: Lanzar varios hilos

Crea 3 hilos.  
Cada uno debe imprimir:

```text
Task X
```

donde `X` sea el número de la tarea.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 3; i++) {
            int taskNumber = i;

            Thread thread = new Thread(() -> {
                System.out.println("Task " + taskNumber);
            });

            thread.start();
        }
    }
}
```

</details>

---

## Ejercicio 6: Contador con `synchronized`

Crea una clase `SafeCounter` con:

- atributo `value`
- método `increment()` sincronizado
- método `getValue()` sincronizado

Desde `main`, crea dos hilos que incrementen el contador 1000 veces cada uno.  
Al final, imprime el valor.

<details><summary>Mostrar solución</summary>

```java
public class SafeCounter {
    private int value;

    public synchronized void increment() {
        value++;
    }

    public synchronized int getValue() {
        return value;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        SafeCounter counter = new SafeCounter();

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

</details>

---

## Ejercicio 7: Usar `ExecutorService`

Crea un `ExecutorService` con un pool de 2 hilos.

Envía 4 tareas que impriman:

```text
Processing task X
```

Cierra el executor con `shutdown()`.

<details><summary>Mostrar solución</summary>

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Main {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(2);

        for (int i = 1; i <= 4; i++) {
            int taskNumber = i;

            executor.execute(() -> {
                System.out.println("Processing task " + taskNumber);
            });
        }

        executor.shutdown();
    }
}
```

</details>

---

## Ejercicio 8: `Callable` y `Future`

Crea un `Callable<Integer>` que devuelva la suma de `15 + 25`.

Envíalo a un executor con `submit` y obtén el resultado con `future.get()`.

<details><summary>Mostrar solución</summary>

```java
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class Main {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newSingleThreadExecutor();

        Callable<Integer> task = () -> 15 + 25;

        Future<Integer> future = executor.submit(task);

        try {
            Integer result = future.get();
            System.out.println(result);
        } catch (Exception e) {
            System.out.println("Could not get result");
        }

        executor.shutdown();
    }
}
```

</details>

---

## Ejercicio 9: Interrumpir un hilo

Crea un hilo que intente dormir 5 segundos.

Desde `main`, inicia el hilo e interrúmpelo inmediatamente.  
El hilo debe imprimir `"Interrupted"` si recibe la interrupción.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        Thread worker = new Thread(() -> {
            try {
                Thread.sleep(5000);
            } catch (InterruptedException e) {
                System.out.println("Interrupted");
                Thread.currentThread().interrupt();
            }
        });

        worker.start();
        worker.interrupt();
    }
}
```

</details>

---

## Ejercicio 10: Crear un virtual thread

Crea un virtual thread que imprima:

```text
Running in virtual thread
```

Espera a que termine usando `join()`.

<details><summary>Mostrar solución</summary>

```java
public class Main {
    public static void main(String[] args) {
        Thread thread = Thread.startVirtualThread(() -> {
            System.out.println("Running in virtual thread");
        });

        try {
            thread.join();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}
```

</details>

---
