# Exercises - Topic 36: Basic Concurrency

Below you will find **10 practical exercises** to work with **basic concurrency**: `Thread`, `Runnable`, `sleep`, `join`, `synchronized`, `ExecutorService`, `Callable`, `Future`, interruptions and virtual threads.

Try to solve them before looking at the solution.

---

## Exercise 1: Create a thread with `Thread`

Create a thread that prints:

```text
Running task
```

Start it using `start()`.

<details><summary>Show solution</summary>

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

## Exercise 2: Create a class that implements `Runnable`

Create a class `DownloadTask` that implements `Runnable`.

Its `run()` method must print:

```text
Downloading file...
```

From `main`, create a thread with that task and run it.

<details><summary>Show solution</summary>

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

## Exercise 3: Use `Thread.sleep`

Create a program that prints:

```text
Start
```

waits 1 second with `Thread.sleep(1000)` and then prints:

```text
End
```

Handle `InterruptedException`.

<details><summary>Show solution</summary>

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

## Exercise 4: Wait for a thread with `join`

Create a thread that waits 500 ms and then prints `"Worker finished"`.

In `main`, wait for it to finish with `join()` and then print `"Main finished"`.

<details><summary>Show solution</summary>

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

## Exercise 5: Launch multiple threads

Create 3 threads.  
Each one must print:

```text
Task X
```

where `X` is the task number.

<details><summary>Show solution</summary>

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

## Exercise 6: Counter with `synchronized`

Create a class `SafeCounter` with:

- `value` attribute
- synchronized `increment()` method
- synchronized `getValue()` method

From `main`, create two threads that increment the counter 1000 times each.  
At the end, print the value.

<details><summary>Show solution</summary>

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

## Exercise 7: Use `ExecutorService`

Create an `ExecutorService` with a 2-thread pool.

Submit 4 tasks that print:

```text
Processing task X
```

Close the executor with `shutdown()`.

<details><summary>Show solution</summary>

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

## Exercise 8: `Callable` and `Future`

Create a `Callable<Integer>` that returns the sum of `15 + 25`.

Submit it to an executor with `submit` and get the result with `future.get()`.

<details><summary>Show solution</summary>

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

## Exercise 9: Interrupt a thread

Create a thread that tries to sleep for 5 seconds.

From `main`, start the thread and interrupt it immediately.  
The thread must print `"Interrupted"` if it is interrupted.

<details><summary>Show solution</summary>

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

## Exercise 10: Create a virtual thread

Create a virtual thread that prints:

```text
Running in virtual thread
```

Wait for it to finish using `join()`.
<details><summary>Show solution</summary>

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
