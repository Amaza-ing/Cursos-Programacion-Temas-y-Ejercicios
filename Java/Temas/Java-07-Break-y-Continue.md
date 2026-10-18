# Topic 7. Flow control in loops

## 1. Introduction

In the previous topic you learned how to repeat actions with `while` and `for`. However, in real programs you don't always want that loop:

- Always runs from start to finish
- Repeat all iterations
- Depend solely on the loop condition

Sometimes you need to **control the flow** inside the loop:

- Exit the loop early
- Skip a specific iteration and continue with the next one
- Avoid executing part of the block when a condition is met

For this, Java mainly offers:

- `break`
- `continue`

In this topic you will learn:

- What exactly `break` does
- What exactly `continue` does
- When to use them and when to avoid them
- Practical examples and typical patterns

---

[![Break & Continue](https://img.youtube.com/vi/2bOdbsMQqK4/0.jpg)](https://www.youtube.com/watch?v=2bOdbsMQqK4&list=PLzA2VyZwsq_-30Z1c9LjWZpq24Kf-2MjD)

---

## 2. Key idea: “alter” the loop from within

A loop normally proceeds like this:

1. Check condition
2. Run the block
3. Update counter (if `for`)
4. Repeat

With `break` and `continue` you can intervene in that flow:

- `break` cuts the entire loop
- `continue` cuts _only the current iteration_

---

## 3. `break`: exit the loop

### 3.1. What `break` does

When Java executes `break` inside a loop, the loop ends immediately and the program continues **after** the loop.

This works the same in:

- `while`
- `for`
- `do-while`
- `switch` (although in switches it is another use, you already know it)

---

### 3.2. Example 1: Stop when a value is found

Imagine that you are “searching” for the number 7 within a range.

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

What happens:

- The loop prints “Checking” for 1, 2, 3...
- When `i` is 7, print “Found it!” and run `break`
- The loop ends, although there would still be iterations 8, 9 and 10

---

### 3.3. Example 2: `while` loop stopping for an internal condition

Sometimes the condition of the `while` is not enough, and you decide to finish from within.

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

Here the loop condition is `true`, so **only `break` can stop it**.

This is often used when:

- You don't know what exact condition will stop the loop at the start
- Condition depends on several internal factors

---

### 3.4. Common pattern: “find and stop”

This pattern appears a lot when you work with arrays or lists:

- You walk something
- If you find what you are looking for, stop with `break`

Although we haven't seen arrays yet, you can get the idea with a range.

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

## 4. `continue`: skip an iteration

### 4.1. What `continue` does

When Java executes `continue` inside a loop:

- The current iteration is stopped
- Skip what's left of the block
- The loop goes directly to the next iteration

That is, the loop does not end, it only “jumps” one turn.

---

### 4.2. Example 1: Skip odd numbers

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

What happens:

- For `i = 1`, it is odd, so it does `continue` and does not print.
- For `i = 2`, it does not enter the `if` and print.
- Result: only print the pairs.

---

### 4.3. Example 2: Avoid processing “invalid” values

Imagine that you want to “process” numbers, but ignore the 0.

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

If you don't use `continue`, there would be division by zero (error).  
With `continue`, `i == 0` is skipped and the loop continues.

---

### 4.4. Example 3: filter and count

You can use `continue` to filter out securities that you are not interested in.

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

## 5. Quick Comparison: `break` vs `continue`

- `break` → complete loop ends
- `continue` → skip current iteration and continue

Visual example (idea):

- `break`: “I'm leaving the loop”
- `continue`: “not this round, next”

---

## 6. `break` and `continue` in `while`

In `while`, the effect is the same, but there is an important detail:

- On an `for`, the counter is automatically updated at the end of the iteration
- In an `while`, you control everything

That means that if you do `continue` on an `while`, you have to make sure the loop state keeps updating, or you could create an infinite loop.

### 6.1. Example: `continue` in `while` carefully

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

Note that `i++` occurs **before** `continue`.  
If it were after, the loop would get “stuck”.

---

## 7. Good practices (when to use them and when to avoid it)

### 7.1. When `break` is a good option

- When you are looking for something and want to stop when you find it
- When you need a clear way out in a special case
- When an `while (true)` has an explicit and clear exit point

Example of reasonable use:

```java
for (int i = 0; i < 100; i++) {
    if (i == 25) {
        break;
    }
}
```

---

### 7.2. When `continue` is a good option

- When you want to filter cases quickly
- When you want to avoid a large block of nested `if`

Cleaner example with `continue`:

```java
for (int i = 1; i <= 10; i++) {
    if (i == 5) {
        continue;
    }

    System.out.println(i);
}
```

---

### 7.3. When you should be careful

If you abuse `break` and `continue`, your loop can become difficult to read, especially if there are many conditions and multiple `continue`.

In those cases it is usually better:

- Rewrite loop condition
- Move part of the logic to methods (you will see it later)
- Use boolean variables for clarity

---

## 8. Complete examples (frequent patterns)

### 8.1. Pattern: Validate attempts and cut

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

### 8.2. Pattern: filter and process

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

### 8.3. Pattern: Combine `continue` to avoid an exception

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

## 9. To take into account

- `break` ends the entire loop immediately.
- `continue` skips the current iteration and goes to the next one.
- They are useful tools, but they must be used with intention.
- In `while`, use `continue` carefully so as not to create infinite loops.
- They are especially useful for patterns like “search”, “filter” and “avoid special cases”.

---

In the next topic we will see **methods**: what they are, how they are defined and how they are used to better organize your code when it starts to grow.
