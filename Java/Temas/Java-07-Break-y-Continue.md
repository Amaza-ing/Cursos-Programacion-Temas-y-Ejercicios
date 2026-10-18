# Topic 7. Flow control in loops

## 1. Introduction

In the previous topic you learned how to repeat actions with `while` and `for`. However, in real programs you don't always want the loop to:

- Run from start to finish every time
- Repeat every iteration
- Depend only on the loop condition

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

## 2. Key idea: “altering” the loop from the inside

A loop normally proceeds like this:

1. Checks the condition
2. Runs the block
3. Updates the counter (if it's a `for`)
4. Repeats

With `break` and `continue` you can step into that flow:

- `break` cuts off the whole loop
- `continue` cuts off _only the current iteration_

---

## 3. `break`: exiting the loop

### 3.1. What `break` does

When Java executes `break` inside a loop, the loop ends immediately and the program continues **after** the loop.

This works the same in:

- `while`
- `for`
- `do-while`
- `switch` (although there it's a different use, which you already know)

---

### 3.2. Example 1: stopping when a value is found

Imagine you're “searching” for the number 7 within a range.

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
- When `i` is 7, it prints “Found it!” and runs `break`
- The loop ends, even though iterations 8, 9 and 10 are still left

---

### 3.3. Example 2: a `while` loop that stops because of an internal condition

Sometimes the `while` condition isn't enough, and you decide to end the loop from the inside.

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

- At the start, you don't know exactly which condition will stop the loop
- The condition depends on several internal factors

---

### 3.4. Common pattern: “find and stop”

This pattern comes up a lot when you work with arrays or lists:

- You go through something
- If you find what you're looking for, you stop with `break`

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

## 4. `continue`: skipping an iteration

### 4.1. What `continue` does

When Java executes `continue` inside a loop:

- The current iteration is stopped
- The rest of the block is skipped
- The loop goes directly to the next iteration

In other words, the loop doesn't end; it just “skips” one pass.

---

### 4.2. Example 1: skipping odd numbers

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
- For `i = 2`, it doesn't enter the `if`, so it's printed.
- Result: it only prints the even numbers.

---

### 4.3. Example 2: not processing “invalid” values

Imagine you want to “process” numbers, but ignore 0.

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

Without `continue`, there would be a division by zero (an error).  
With `continue`, `i == 0` is skipped and the loop continues.

---

### 4.4. Example 3: filtering and counting

You can use `continue` to filter out values you're not interested in.

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

## 5. Quick comparison: `break` vs `continue`

- `break` → ends the whole loop
- `continue` → skips the current iteration and keeps going

Visual example (idea):

- `break`: “I'm leaving the loop”
- `continue`: “not this round, next one”

---

## 6. `break` and `continue` in `while`

In `while`, the effect is the same, but there is an important detail:

- In a `for`, the counter is automatically updated at the end of the iteration
- In a `while`, you control everything

That means that if you use `continue` in a `while`, you have to make sure the loop state keeps updating, or you could create an infinite loop.

### 6.1. Example: using `continue` in a `while` carefully

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

Notice that `i++` happens **before** the `continue`.  
If it came after it, the loop would get “stuck”.

---

## 7. Good practices (when to use them and when to avoid them)

### 7.1. When `break` is a good option

- When you are looking for something and want to stop when you find it
- When you need a clear way out in a special case
- When a `while (true)` has an explicit and clear exit point

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
- When you want to avoid a big block of nested `if` statements

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

If you overuse `break` and `continue`, your loop can become hard to read, especially if there are many conditions and several `continue` statements.

In those cases it's usually better to:

- Rewrite the loop condition
- Move part of the logic into methods (you'll see them later)
- Use boolean variables for clarity

---

## 8. Complete examples (common patterns)

### 8.1. Pattern: validating attempts and stopping

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

### 8.2. Pattern: filtering and processing

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

### 8.3. Pattern: using `continue` to avoid an exception

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

## 9. Things to keep in mind

- `break` ends the entire loop immediately.
- `continue` skips the current iteration and goes to the next one.
- They are useful tools, but you should use them deliberately.
- In a `while`, use `continue` carefully so you don't create infinite loops.
- They are especially useful for patterns like “search”, “filter” and “avoid special cases”.

---

In the next topic we'll look at **methods**: what they are, how to define them and how to use them to organize your code better as it starts to grow.
