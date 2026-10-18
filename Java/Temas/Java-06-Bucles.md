# Topic 6. Loops (while and for)

## 1. Introduction

In programming, many tasks consist of **repeating actions**:

- Showing a list of numbers
- Adding values until something happens
- Asking the user for data until it's valid
- Repeating attempts in a game
- Looping through a data structure (arrays, lists, etc.)

That's what **loops** are for.

A loop lets you run a block of code **several times**, based on a condition or a set number of repetitions.

In Java, the most important loops to get started with are:

- `while` (conditional loop)
- `for` (counter loop)

In this topic you will learn:

- How a `while` loop works
- How a `for` loop works
- How to choose between them
- Common mistakes (infinite loops, off-by-one, etc.)
- Basic patterns you'll use all the time

---

[![Loops](https://img.youtube.com/vi/YYZ6HcfevLs/0.jpg)](https://www.youtube.com/watch?v=YYZ6HcfevLs&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. Key concept: condition, repetition and state

Every loop involves three important ideas:

1. **Condition**: decides whether the loop continues or stops.
2. **State**: a variable (or several) that changes over time.
3. **Update**: what modifies the state so the loop moves forward.

If you don't update the state, it's easy to fall into an **infinite loop**.

---

## 3. The `while` loop

### 3.1. What is a `while`?

A `while` repeats a block **as long as** the condition is `true`.

Syntax:

```java
while (condition) {
    // code to repeat
}
```

- If the condition is `true`, it enters the loop.
- After each iteration, it checks the condition again.
- If the condition is `false`, the loop ends.

---

### 3.2. Example 1: counting from 1 to 5

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

What's happening:

- `counter` starts at 1 (initial state)
- The condition is `counter <= 5`
- On each pass it's printed and then incremented
- When it reaches 6, the condition is false and the loop ends

Output:

```
1
2
3
4
5
```

---

### 3.3. Example 2: adding numbers until a limit is reached

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

Key ideas:

- `total` changes and controls when to stop
- `number` also changes so that each sum is different

---

### 3.4. Common mistake: an infinite loop from not updating the counter

This is a classic mistake:

```java
int counter = 1;

while (counter <= 5) {
    System.out.println(counter);
}
```

The condition is always `true` because `counter` never changes.  
The program does not terminate (infinite loop).

Solution: update the state

```java
int counter = 1;

while (counter <= 5) {
    System.out.println(counter);
    counter++;
}
```

---

## 4. The `do-while` loop (very useful for validation)

Although the topic focuses on `while` and `for`, it's worth knowing `do-while` because it comes up a lot when you want something to run at least once.

Syntax:

```java
do {
    // code to repeat
} while (condition);
```

The difference from `while` is:

- `do-while` executes the block **once** and then evaluates the condition.

Example:

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

This prints `10` once, even if the condition is false from the start.

---

## 5. The `for` loop

### 5.1. What is a `for`?

A `for` is ideal when you know how many times you want to repeat something. It is a counter loop.

Syntax:

```java
for (initialization; condition; update) {
    // code to repeat
}
```

- **initialization**: runs only once, at the start
- **condition**: checked before each iteration
- **update**: runs after each iteration

---

### 5.2. Example 1: counting from 1 to 5

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 1; i <= 5; i++) {
            System.out.println(i);
        }
    }
}
```

Compared to `while`, a `for` groups into a single line:

- counter variable (`int i = 1`)
- condition (`i <= 5`)
- update (`i++`)

---

### 5.3. Example 2: counting backwards

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 5; i >= 1; i--) {
            System.out.println(i);
        }
    }
}
```

Output:

```
5
4
3
2
1
```

---

### 5.4. Example 3: jumps (step) of 2

```java
public class Main {
    public static void main(String[] args) {
        for (int i = 0; i <= 10; i += 2) {
            System.out.println(i);
        }
    }
}
```

Output:

```
0
2
4
6
8
10
```

---

## 6. When should you use `while` and when `for`?

### 6.1. Use `for` when

- You know how many repetitions there will be
- You're going through a clear range: 1 to 10, 0 to 99, etc.
- There's a counter with a simple increment

Typical example: repeating 10 times

```java
for (int i = 0; i < 10; i++) {
    System.out.println("Attempt: " + i);
}
```

---

### 6.2. Use `while` when

- You don't know how many repetitions there will be
- It depends on an external condition
- You are waiting for something to happen

Typical example: repeating until a value reaches a certain state

```java
while (balance > 0) {
    balance = balance - costPerDay;
}
```

---

## 7. Basic loop patterns (very important)

### 7.1. Pattern 1: counter

```java
int counter = 0;

while (counter < 3) {
    System.out.println(counter);
    counter++;
}
```

---

### 7.2. Pattern 2: accumulator

An accumulator is a variable that “builds up” a result.

```java
int sum = 0;

for (int i = 1; i <= 5; i++) {
    sum += i;
}

System.out.println(sum); // 15
```

Here `sum` is the accumulator.

---

### 7.3. Pattern 3: finding a maximum

Although we haven't seen arrays yet, we can understand the idea with separate variables:

```java
int max = 10;
int value = 25;

if (value > max) {
    max = value;
}
```

When you get to arrays, you'll use this pattern inside loops.

---

### 7.4. Pattern 4: conditional counter

Counting how many times something happens:

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

## 8. Common mistakes when working with loops

### 8.1. Infinite loop

It happens when the condition never becomes `false`.

Typical causes:

- Not updating the counter
- Updating it in the wrong direction
- A badly written condition

Typical example (wrong direction):

```java
int counter = 1;

while (counter <= 5) {
    System.out.println(counter);
    counter--; // va hacia abajo, nunca llegará a 6
}
```

---

### 8.2. The “one too many” error (off-by-one)

Very common in ranges.

Example:

```java
for (int i = 0; i <= 10; i++) {
    System.out.println(i);
}
```

It prints 11 numbers (0 to 10).

If you wanted to print 10 numbers, you usually write:

```java
for (int i = 0; i < 10; i++) {
    System.out.println(i);
}
```

- `i < 10` → 0 to 9 (10 values)

---

### 8.3. Reusing counters with “dirty” values

If you reuse the same variable without resetting it, it can cause logic errors.

Example:

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

Solution: reset `i` before the second loop.

---

## 9. Complete, guided examples

### 9.1. Example 1: printing a simple times table (multiplying by 3)

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

This prints the 3 times table, from 1 to 10.

---

### 9.2. Example 2: simulating attempts until reaching a goal

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

Key ideas:

- `progress` controls when to stop
- `attempts` counts how many times the loop has run
- `progress` grows and eventually reaches the target

---

### 9.3. Example 3: combining a loop with a conditional inside it

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

This adds only the even numbers from 1 to 10.

---

## 10. Things to keep in mind

- A loop repeats code until an exit condition is met.
- `while` is ideal when you don't know how many repetitions there will be.
- `for` is ideal when there is a counter and a clear range.
- Almost all loops need a variable that changes (state).
- The most common mistakes are infinite loops and off-by-one errors.
- Practicing patterns (counter, accumulator, filtering) will help you in future topics such as arrays and collections.

---

In the next topic we'll look at **flow control in loops** (`break` and `continue`), to stop a loop or skip an iteration when you need to.
