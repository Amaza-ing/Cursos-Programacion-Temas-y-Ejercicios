# Topic 6. Loops (while and for)

## 1. Introduction

In programming, many tasks consist of **repeating actions**:

- Show a list of numbers
- Add values until something happens
- Ask the user for data until they are valid
- Repeat attempts in a game
- Loop through a data structure (arrays, lists, etc.)

For this there are **loops**.

A loop allows a block of code to be executed **multiple times**, under a condition or a certain number of repetitions.

In Java, the most important loops to get started with are:

- `while` (conditional loop)
- `for` (counter loop)

In this topic you will learn:

- How an `while` loop works
- How an `for` loop works
- How to choose between one and the other
- Common errors (infinite loops, off-by-one, etc.)
- Basic patterns that you will use constantly

---

[![Loops](https://img.youtube.com/vi/YYZ6HcfevLs/0.jpg)](https://www.youtube.com/watch?v=YYZ6HcfevLs&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. Key concept: condition, repetition and state

Every loop has three important ideas:

1. **Condition**: Decides whether the loop continues or stops.
2. **State**: a variable (or several) that changes over time.
3. **Update**: which modifies the state so that the loop advances.

If you don't update the state, it's easy to fall into an **infinite loop**.

---

## 3. `while` loop

### 3.1. What is an `while`?

An `while` repeats a block **as long as** the condition is `true`.

Syntax:

```java
while (condition) {
    // code to repeat
}
```

- If the condition is `true`, enter the loop.
- After each iteration, check the condition again.
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
- Condition is `counter <= 5`
- On each turn it is printed and then incremented
- When reaching 6, the condition is false and the loop ends

Output:

```
1
2
3
4
5
```

---

### 3.3. Example 2: Adding numbers until a limit is reached

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

### 3.4. Typical error: infinite loop due to not updating the counter

This is a classic mistake:

```java
int counter = 1;

while (counter <= 5) {
    System.out.println(counter);
}
```

The condition is always `true` because `counter` never changes.  
The program does not terminate (infinite loop).

Solution: update the status

```java
int counter = 1;

while (counter <= 5) {
    System.out.println(counter);
    counter++;
}
```

---

## 4. `do-while` loop (very useful for validating)

Although the topic focuses on `while` and `for`, it is worth knowing `do-while` because it appears a lot when you want something to be executed at least once.

Syntax:

```java
do {
    // code to repeat
} while (condition);
```

The difference with `while` is:

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

## 5. `for` loop

### 5.1. What is an `for`?

An `for` is ideal when you know how many times you want to repeat something. It is a counter loop.

Syntax:

```java
for (initialization; condition; update) {
    // code to repeat
}
```

- **initialization**: executed once at startup
- **condition**: checked before each iteration
- **update**: executed after each iteration

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

Compared to `while`, `for` groups into a single line:

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

### 5.4. Example 3: jumps (step) 2 by 2

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

## 6. When to use `while` and when to use `for`?

### 6.1. Use `for` when

- You know how many repetitions there will be
- You are running through a clear range: 1 to 10, 0 to 99, etc.
- There is a counter with simple increment

Typical example: repeat 10 times

```java
for (int i = 0; i < 10; i++) {
    System.out.println("Attempt: " + i);
}
```

---

### 6.2. Use `while` when

- You don't know how many repetitions there will be
-Depends on an external condition
- You are waiting for something to happen

Typical example: repeat until a value reaches a state

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

An accumulator is a variable that “stores” a result.

```java
int sum = 0;

for (int i = 1; i <= 5; i++) {
    sum += i;
}

System.out.println(sum); // 15
```

Here `sum` is the accumulator.

---

### 7.3. Pattern 3: Find a maximum

Although we haven't seen arrays yet, we can understand the idea with single variables:

```java
int max = 10;
int value = 25;

if (value > max) {
    max = value;
}
```

When you see arrays, this pattern is used inside loops.

---

### 7.4. Pattern 4: Conditional Counter

Count how many times something happens:

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

### 8.1. infinite loop

Occurs when the condition never becomes `false`.

Typical causes:

- Do not update the counter
- Update it in the wrong address
- Condition misspelled

Typical example (wrong address):

```java
int counter = 1;

while (counter <= 5) {
    System.out.println(counter);
    counter--; // va hacia abajo, nunca llegará a 6
}
```

---

### 8.2. “Off-by-one” error

Very common in ranges.

Example:

```java
for (int i = 0; i <= 10; i++) {
    System.out.println(i);
}
```

Prints 11 numbers (0 to 10).

If you wanted to print 10 numbers, it is usually:

```java
for (int i = 0; i < 10; i++) {
    System.out.println(i);
}
```

- `i < 10` → 0 to 9 (10 values)

---

### 8.3. Reuse counters with “dirty” values

If you reuse the same variable without resetting it, it may cause logic failures.

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

Solution: Reset `i` before the second loop.

---

## 9. Complete and guided examples

### 9.1. Example 1: Print a simple table (multiply by 3)

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

This prints a multiplication table of 3, 1 to 10.

---

### 9.2. Example 2: simulate attempts until reaching a goal

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
- `attempts` counts how many turns the loop has taken
- `progress` grows and eventually reaches the target

---

### 9.3. Example 3: Combine loop and conditional inside

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

This adds only the pairs 1 to 10.

---

## 10. To take into account

- A loop repeats code until an exit condition is met.
- `while` is ideal when you don't know how many repetitions there will be.
- `for` is ideal when there is a counter and a clear range.
- Almost all loops need a variable that changes (state).
- The most common errors are: infinite loops and off-by-one.
- Practicing patterns (counter, accumulator, filtering) will help you in future topics such as arrays and collections.

---

In the next topic we will see **flow control in loops** (`break` and `continue`), to stop a repetition or skip an iteration when you need it.
