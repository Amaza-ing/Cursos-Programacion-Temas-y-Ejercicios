# Topic 36. Basic Concurrency

## 1. Introduction

So far you have written programs that normally run sequentially.

That means Java runs the instructions one after another:

```java
System.out.println("Step 1");
System.out.println("Step 2");
System.out.println("Step 3");
```

Step 1 is executed first, then 2, and then 3.

But in many real programs we need several tasks to be able to progress at the same time or independently.

Examples:

- downloading a file while the app keeps running
- handling requests from several users
- processing data in the background
- running scheduled tasks
- doing long calculations without blocking the entire program
- reading multiple files
- querying several external services

For that we use **concurrency**.

In this topic you will learn:

- What concurrency is
- What a thread of execution (_thread_) is
- How to create tasks with `Thread`
- How to use `Runnable`
- How to pause a thread with `sleep`
- How to wait for a thread to end with `join`
- What problems can come up with shared data
- What a race condition is
- How to use `synchronized` in a basic way
- What `ExecutorService` is
- How to use `Callable` and `Future`
- What virtual threads are, as a modern idea
- Common mistakes and best practices

---

## 2. What is concurrency?

**Concurrency** means organizing a program so that it can handle several tasks during the same period of time.

It doesn't always mean that everything runs literally at the same instant.

It means the program can make progress on several tasks in a coordinated way.

Conceptual example:

```text
Tarea 1: descargar archivo
Tarea 2: mostrar progreso
Tarea 3: responder al usuario
```

Instead of blocking everything until a task is finished, the program can be organized to handle several things.

---

## 3. Concurrency vs parallelism

These two concepts are often confused.

### 3.1. Concurrency

Concurrency is about managing several tasks at the same time from a design point of view.

Example:

- an application can download a file and still respond to the user

### 3.2. Parallelism

Parallelism occurs when multiple tasks run literally at the same time, typically using multiple processor cores.

Example:

- a computer with multiple cores executes several calculations simultaneously

### 3.3. A simple rule

- Concurrency: organizing multiple tasks
- Parallelism: running several tasks at the same time

In this topic we'll focus on the basics of concurrency.

---

## 4. What is a thread?

A **thread** is a thread of execution.

When you run a Java program, there is at least one main thread:

- the thread where `main` is executed

Example:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Main thread");
    }
}
```

But Java lets you create more threads to run tasks independently.

---

## 5. First example with `Thread`

A basic way to create a thread is to use the `Thread` class.

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

Two things happen here:

- `thread.start()` starts a new thread
- `main` continues to run

The order of the output may vary.

---

## 6. `start()` vs `run()`

This point is very important.

To start a thread, you must call:

```java
thread.start();
```

Not:

```java
thread.run();
```

### 6.1. `start()`
Creates a new thread of execution.

```java
thread.start();
```

### 6.2. `run()`

Executes the code as a normal method call, without creating a new thread.

```java
thread.run();
```

Example:

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

Rule of thumb:

> To launch a thread, use `start()`.

---

## 7. `Runnable`

`Runnable` is a functional interface that represents a task that receives no parameters and returns no result.

Its main method is:

```java
void run();
```

Example:

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

Since `Runnable` is a functional interface, we can use a lambda.

---

## 8. Creating a class that implements `Runnable`

You can also create your own class.

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

This approach is useful when the task has more logic or needs attributes.

---

## 9. Creating multiple threads

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

The output order is not guaranteed.

You might see:

```text
Thread 2
Main finished
Thread 1
Thread 3
```

or any other order.

---

## 10. Order is not guaranteed

In concurrent programming, the order of execution can vary.

Example:

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

You might see:

```text
Main thread
Child thread
```

or:

```text
Child thread
Main thread
```

It depends on how the system schedules the threads.

---

## 11. Pausing a thread with `Thread.sleep`

`Thread.sleep` pauses the current thread for a while.

The time is given in milliseconds.

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

Here the program waits approximately 1 second.

---

## 12. `InterruptedException`

`Thread.sleep` can throw `InterruptedException`.

That means that the thread can be interrupted while it is waiting.

That's why we must use `try-catch`.

```java
try {
    Thread.sleep(1000);
} catch (InterruptedException e) {
    Thread.currentThread().interrupt();
}
```

This line is good practice:

```java
Thread.currentThread().interrupt();
```

It restores the thread's interrupt status.

---

## 13. Guided example with `sleep`

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

Here the counter runs in another thread while the main thread carries on.

---

## 14. Waiting for a thread to finish with `join`

Sometimes you want the main thread to wait for another thread to finish.

For that we use `join`.

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

Here `Main finished` is printed after `worker` finishes.

---

## 15. Example without `join` and with `join`

### 15.1. Without `join`

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

Order is not guaranteed.

### 15.2. With `join`

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

Now `Main finished` waits for `worker` to finish.

---

## 16. Data shared between threads

When multiple threads access the same data, problems may arise.

Example:

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

It seems simple, but if multiple threads call `increment` at the same time, the result may be incorrect.

---

## 17. What is a race condition?

A **race condition** occurs when the result depends on the exact order in which multiple threads execute.

Example:

```java
value++;
```

It looks like a single operation, but internally it involves several steps:

1. read `value`
2. add 1
3. store the result

If two threads do this at the same time, they can overwrite each other's changes.

---

## 18. Example of a problem with a shared counter

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

`Counter` class:

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

You might expect:

```text
2000
```

But you may get a smaller number.

---

## 19. Basic solution: `synchronized`
` synchronized` allows you to protect a section of code so that only one thread can execute it at a time on the same object.

Example:

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

Now, if two threads call `increment`, Java prevents both threads from entering that method for the same object at the same time.

---

## 20. `synchronized` in methods

You can mark a method as `synchronized`.

```java
public synchronized void increment() {
    value++;
}
```

This blocks concurrent access to the method for the same object.

You could also synchronize the getter if you need maximum consistency:

```java
public synchronized int getValue() {
    return value;
}
```

---

## 21. Fixed example with `synchronized`

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

Usage:

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

Now the result should be:

```text
2000
```

---

## 22. `synchronized` blocks

You can also synchronize just part of the code.

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

This allows you to control exactly which part needs to be protected.

---

## 23. Be careful when sharing mutable data

Concurrency becomes more complex when multiple threads modify the same data.

Example of shared data:

- modifiable lists
- modifiable maps
- counters
- balances
- object states

A first rule of thumb:

> The less data shared between threads, the better.

---

## 24. `ExecutorService`

Creating threads manually with `new Thread(...)` is fine for learning, but in real applications a higher-level tool is usually used:

- `ExecutorService`

`ExecutorService` lets you manage a set of threads and submit tasks for them to run.

Imports:

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
```

---

## 25. Creating an `ExecutorService`

Example with a pool of 2 threads:

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

Here:

- the pool has 2 threads
- you can submit multiple tasks
- the executor decides when to run them

---

## 26. `execute`

`execute` takes a `Runnable`.

```java
executor.execute(() -> {
    System.out.println("Running task");
});
```

Use it when:

- the task doesn't return a result
- you don't need to collect a final value

---

## 27. `shutdown`

When you finish submitting tasks, you must shut down the executor.

```java
executor.shutdown();
```

This means:

- it doesn't accept new tasks
- it lets the tasks already submitted finish

Don't forget to call `shutdown`.

---

## 28. Guided example with `ExecutorService`

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

Important:

```java
int taskNumber = i;
```

We create a local variable to use within the lambda.

---

## 29. `Callable`

`Runnable` represents a task that does not return a result.

But sometimes you want a task to return a value.

That's what `Callable` is for.

Import:

```java
import java.util.concurrent.Callable;
```

Example:

```java
Callable<Integer> task = () -> {
    return 10 + 20;
};
```

`Callable<T>` returns a value of type `T`.

---

## 30. `Future`

When you submit a `Callable` to an executor, you get back a `Future`.

A `Future` represents a result that will be available in the future.

Import:

```java
import java.util.concurrent.Future;
```

Example:

```java
Future<Integer> future = executor.submit(task);
```

To get the result:

```java
Integer result = future.get();
```

`get()` waits until the task finishes.

---

## 31. Example with `Callable` and `Future`

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

## 32. `submit` with `Runnable`

`submit` can also take a `Runnable`.

```java
Future<?> future = executor.submit(() -> {
    System.out.println("Task running");
});
```

But if you just need to run a task with no result, `execute` is usually enough.

---
## 33. Difference between `execute` and `submit`

### 33.1. `execute`

- takes a `Runnable`
- doesn't return a result
- is used to run simple tasks

```java
executor.execute(() -> System.out.println("Hello"));
```

### 33.2. `submit`

- takes a `Runnable` or a `Callable`
- returns a `Future`
- lets you check the result or whether the task has finished

```java
Future<Integer> future = executor.submit(() -> 42);
```

---

## 34. Complete example: calculating a sum in the background

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

## 35. Exceptions in concurrent tasks

Exceptions in concurrent tasks need special attention.

If a task submitted as a `Callable` fails, the exception shows up when you call:

```java
future.get();
```

Example:

```java
Callable<Integer> task = () -> {
    throw new IllegalArgumentException("Invalid task");
};
```

When you do:

```java
future.get();
```

an exception will be thrown that wraps the original problem.

---

## 36. Interrupting a thread

A thread can be interrupted.

An interrupt is a way of asking a thread to stop or react.

Example:

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

An interrupt doesn't magically kill the thread.  
It is a signal that the thread must handle correctly.

---

## 37. `Thread.currentThread()`

You can get the current thread with:

```java
Thread.currentThread()
```

Example:

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

This can help you understand which thread is executing which piece of code.

---

## 38. Naming a thread

You can assign a name to a thread.

```java
Thread worker = new Thread(() -> {
    System.out.println(Thread.currentThread().getName());
}, "worker-thread");

worker.start();
```

Names are useful for debugging.

---

## 39. Collections and concurrency

Normal collections like `ArrayList` or `HashMap` are not intended to be modified by multiple threads at once without protection.

Dangerous example:

```java
List<String> names = new ArrayList<>();

Thread thread1 = new Thread(() -> names.add("Laura"));
Thread thread2 = new Thread(() -> names.add("Alex"));
```

In real programs, there are specific tools for working with collections shared between threads in:

```java
java.util.concurrent
```

For example:

- `ConcurrentHashMap`
- `CopyOnWriteArrayList`
- `BlockingQueue`

In this topic you only need the general idea: sharing mutable collections between threads requires care.

---

## 40. Introduction to virtual threads

Modern Java includes a tool called **virtual threads**.

A virtual thread is a lightweight thread managed by the JVM.

The main idea is:

- creating many concurrent tasks at a lower cost than traditional threads
- simplifying certain types of applications, especially when there are lots of operations that wait

Basic example:

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

You don't need to master virtual threads yet, but it's important to know that they exist in modern Java.

---

## 41. Virtual threads with `ExecutorService`

You can also use an executor for virtual threads.

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

This approach is modern, but when you're starting out it's better to understand these first:

- `Thread`
- `Runnable`
- `ExecutorService`
- `Callable`
- `Future`

---

## 42. When to use concurrency

Concurrency can be useful when:

- a task takes a long time
- you need to avoid blocking the main program
- there are several independent operations
- you work with input/output
- you process many requests
- you want to make better use of resources

Examples:

- web server
- file processing
- API calls
- scheduled tasks
- background data loading

---

## 43. When NOT to use concurrency

Don't use concurrency if:

- the program is very simple
- a sequential solution is sufficient
- there are no independent tasks
- it adds complexity without adding value
- you don't know how to protect shared data

Concurrency can improve a program, but it can also make it more difficult to understand.

---

## 44. Complete example: task processing

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

Here there are 4 tasks, but only 2 threads in the pool.  
The executor organizes the execution as it goes.

---

## 45. Complete example: notification service

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

This example simulates sending notifications concurrently.

---

## 46. Common beginner mistakes

### 46.1. Calling `run()` instead of `start()`

```java
thread.run(); // no crea un hilo nuevo
```

You must use:

```java
thread.start();
```

### 46.2. Assuming a fixed order of execution

With concurrency, the order may vary.

### 46.3. Sharing unprotected mutable data

This can produce race conditions.

### 46.4. Forgetting `shutdown`

If you use `ExecutorService`, remember to close it.

```java
executor.shutdown();
```

### 46.5. Ignoring `InterruptedException`

It's not a good idea to leave the `catch` empty.

Better:

```java
Thread.currentThread().interrupt();
```

### 46.6. Creating too many threads manually

For many tasks, it is best to use `ExecutorService`.

---

## 47. Best practices

- At first, use concurrency only when it's really necessary.
- Use `Runnable` for tasks without results.
- Use `Callable` for tasks with results.
- Use `ExecutorService` instead of creating many threads manually.
- Call `shutdown` when you are done with the executor.
- Avoid sharing mutable data between threads.
- Use `synchronized` if multiple threads modify the same state.
- Handle `InterruptedException` correctly.
- Use thread names if you need to debug.
- Keep tasks small and clear.

---

## 48. Things to keep in mind

- A thread is a thread of execution.
- `main` runs in the main thread.
- `Thread.start()` creates a new thread.
- `Runnable` represents a task with no result.
- `Thread.sleep` pauses the current thread.
- `join` lets you wait for a thread to finish.
- Shared data can cause race conditions.
- `synchronized` allows you to protect critical sections.
- `ExecutorService` manages thread pools.
- `Callable` lets you return results.
- `Future` represents a result that will come later.
- Virtual threads are a modern tool for lightweight concurrency.

---

## 49. Final summary

Concurrency allows a program to manage multiple tasks during the same period of time.

In Java, the basics of concurrency start with:

```java
Thread
Runnable
```

But in more realistic code you usually work with higher-level tools:

```java
ExecutorService
Callable
Future
```

You've also seen that concurrency introduces new problems, especially when multiple threads share and modify the same data.

That is why it is important to understand ideas like:

- execution order is not guaranteed
- race conditions
- synchronization
- interrupts
- shutting down executors properly

Concurrency is a broad topic, but with this foundation you can already understand how Java executes tasks in parallel or in the background in a controlled way.

---
In the next topic we'll look at **Annotations**: what they are and how you can work with them.
