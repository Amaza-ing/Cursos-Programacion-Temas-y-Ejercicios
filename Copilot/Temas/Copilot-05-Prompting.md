# Topic 05 — Prompting for programmers

## 1. Topic objectives

In this topic, you will learn how to communicate with GitHub Copilot effectively to get better results when programming.

By the end of this topic you should be able to:

- Understand what a technical prompt is.
- Differentiate between a poor prompt and a useful prompt.
- Write prompts with context, objective, restrictions and expected format.
- Ask Copilot to generate functions.
- Request code documentation.
- Request refactorings.
- Request tests.
- Request bug detection.
- Iterate on a Copilot response.
- Critically review the generated code.

---

## 2. What is a prompt

A **prompt** is the instruction we give to an artificial intelligence tool to generate a response.

In programming, a prompt can be used to request:

- A function.
- A class.
- An explanation.
- A refactoring.
- A test.
- A solution to a bug.
- An implementation alternative.
- Technical documentation.

Example of a simple prompt:

```text
Create a function to validate an email.
```

This prompt may work, but it is very general.

A more useful prompt would be:

```text
Create a JavaScript function called isValidEmail that receives a string and returns true if it has a valid email format. Do not use external libraries. Add simple comments explaining the main steps.
```

The second version is better because it indicates:

- The language.
- The name of the function.
- The input parameter.
- The expected result.
- A restriction.
- The desired level of explanation.

---

## 3. Why prompting is important for programming

Copilot can generate code from the editor context, but it doesn't always know exactly what you want.

A good prompt helps reduce:

- Incomplete code.
- Code that does not follow the style of the project.
- Overly complex solutions.
- Functions that do not return what is expected.
- Tests that are not very useful.
- Explanations that are too general.

The goal is not to write long prompts every time, but to write prompts that are **clear enough**.

---

## 4. Recommended structure for a good technical prompt

A practical structure is the following:

```text
Contexto + Objetivo + Restricciones + Formato esperado + Criterios de calidad
```

You don't always need to include all the elements, but it's helpful to know them.

---

### 4.1. Context

The context tells Copilot where you are working and what to consider.

Example:

```text
This file contains utility functions for a shopping cart in a JavaScript application.
```

Another example:

```text
We are working on a Spring MVC application using controllers, services and repositories.
```

---

### 4.2. Objective

The objective indicates what you want to achieve.

Example:

```text
Create a function that calculates the total price of all products in the cart.
```

---

### 4.3. Restrictions

Restrictions set limits or conditions.

Example:

```text
Do not use external libraries.
```

```text
Keep the function pure and do not modify the original array.
```

```text
Use async/await instead of promises with .then().
```

---

### 4.4. Expected format

Indicate how you want to receive the response.

Example:

```text
Return only the code.
```

```text
Explain the solution step by step before showing the final code.
```

```text
Give me the answer as a Markdown table.
```

---

### 4.5. Quality criteria

These describe what the solution should be like.

Example:

```text
The code should be readable, simple and easy to test.
```

```text
Include edge cases for empty arrays, null values and invalid input.
```

---

## 5. Complete example of a technical prompt

Imprecise prompt:

```text
Make a login function.
```

Improved prompt:

```text
Create a JavaScript function called loginUser. It should receive an email and a password, validate that both values are not empty, and return an object with success and message properties. Do not connect to a real database. Keep the function simple and easy to test.
```

A possible answer would be:

```javascript
function loginUser(email, password) {
  if (!email || !password) {
    return {
      success: false,
      message: "Email and password are required",
    };
  }

  return {
    success: true,
    message: "Login data is valid",
  };
}
```

---

## 6. Prompting to generate functions

When you ask for a function, try to specify:

- The function name.
- Language.
- Parameters.
- What it should return.
- Special cases.
- Restrictions.

Useful template:

```text
Create a [language] function called [functionName] that receives [parameters] and returns [expected result]. It should handle [edge cases]. Do not use [restriction].
```

Example:

```text
Create a JavaScript function called calculateDiscountedPrice that receives a price and a discount percentage. It should return the final price after applying the discount. If the price is negative or the discount is outside the 0-100 range, return null. Do not use external libraries.
```

Possible result:

```javascript
function calculateDiscountedPrice(price, discountPercentage) {
  if (price < 0 || discountPercentage < 0 || discountPercentage > 100) {
    return null;
  }

  const discount = price * (discountPercentage / 100);
  return price - discount;
}
```

---

## 7. Prompting to document code

Copilot can help document functions, classes, or entire files.

It is important to ask for the type of documentation you need.

Asking:

```text
Document this code.
```

is not the same as asking:

```text
Add JSDoc comments to this function. Explain the parameters, the return value and the possible edge cases. Keep the comments concise.
```

---

### 7.1. JSDoc documentation example

Initial code:

```javascript
function calculateAverage(numbers) {
  if (!Array.isArray(numbers) || numbers.length === 0) {
    return 0;
  }

  const total = numbers.reduce((sum, number) => sum + number, 0);
  return total / numbers.length;
}
```

Prompt:

```text
Add JSDoc documentation to this function. Include parameter type, return type and a short description. Do not modify the function logic.
```

Expected result:

```javascript
/**
 * Calculates the average value of an array of numbers.
 *
 * @param {number[]} numbers - The list of numbers to average.
 * @returns {number} The average value, or 0 if the input is not a valid non-empty array.
 */
function calculateAverage(numbers) {
  if (!Array.isArray(numbers) || numbers.length === 0) {
    return 0;
  }

  const total = numbers.reduce((sum, number) => sum + number, 0);
  return total / numbers.length;
}
```

---

## 8. Prompting to refactor code

Refactoring means improving the internal structure of the code without changing its external behavior.

You can ask Copilot to improve:

- Readability.
- Code repetition.
- Variable names.
- Separation of responsibilities.
- Complexity of functions.
- File organization.

A prompt that is too general:

```text
Improve this code.
```

A more useful prompt:

```text
Refactor this function to make it easier to read. Do not change its behavior. Keep the same input and output. Explain the changes after the code.
```

---

### 8.1. Refactoring example

Initial code:

```javascript
function getFinalPrice(price, userType) {
  let discount = 0;
  if (userType === "student") {
    discount = 0.15;
  } else if (userType === "premium") {
    discount = 0.2;
  } else if (userType === "regular") {
    discount = 0.05;
  } else {
    discount = 0;
  }
  return price - price * discount;
}
```

Prompt:

```text
Refactor this function to make the discount rules easier to maintain. Do not change the behavior. Keep the same function name and parameters.
```

Possible result:

```javascript
function getFinalPrice(price, userType) {
  const discounts = {
    student: 0.15,
    premium: 0.2,
    regular: 0.05,
  };

  const discount = discounts[userType] || 0;
  return price - price * discount;
}
```

---

## 9. Prompting to write tests

One of the most useful things Copilot can do is help you create tests.

To get good tests, it's a good idea to specify:

- Testing framework.
- Function or class to test.
- Normal cases.
- Edge cases.
- Error cases.
- Expected format.

Template:

```text
Generate unit tests for [function/class] using [testing framework]. Include normal cases, edge cases and invalid input cases. Do not modify the source code.
```

Example:

```text
Generate Jest unit tests for the calculateDiscountedPrice function. Include valid discounts, zero discount, 100% discount, negative price and discount values outside the 0-100 range.
```

Possible result:

```javascript
const { calculateDiscountedPrice } = require("../src/prices");

describe("calculateDiscountedPrice", () => {
  test("applies a valid discount", () => {
    expect(calculateDiscountedPrice(100, 20)).toBe(80);
  });

  test("returns the original price when discount is 0", () => {
    expect(calculateDiscountedPrice(100, 0)).toBe(100);
  });

  test("returns 0 when discount is 100", () => {
    expect(calculateDiscountedPrice(100, 100)).toBe(0);
  });

  test("returns null for a negative price", () => {
    expect(calculateDiscountedPrice(-100, 20)).toBeNull();
  });

  test("returns null for a discount greater than 100", () => {
    expect(calculateDiscountedPrice(100, 120)).toBeNull();
  });
});
```

> Tests generated by Copilot must be reviewed. Just because a test exists does not mean that it is sufficient or that it is well designed.

---

## 10. Prompting to detect bugs

Copilot can help find errors, but it should not replace human analysis.

Useful prompt:

```text
Review this function and identify possible bugs or edge cases. Explain each problem and suggest a minimal fix.
```

Example of problematic code:

```javascript
function divide(a, b) {
  return a / b;
}
```

Prompt:

```text
Review this function and identify possible bugs or edge cases. Suggest a safer version.
```

Possible answer:

```javascript
function divide(a, b) {
  if (b === 0) {
    throw new Error("Cannot divide by zero");
  }

  return a / b;
}
```

Expected explanation:

```text
The original function does not handle division by zero. In JavaScript, dividing by zero returns Infinity, which may cause unexpected behavior. The revised version throws an explicit error.
```

---

## 11. Prompting to explain code

Copilot can also help you understand other people's code or legacy code.

Useful prompts:

```text
Explain this function step by step in simple language.
```

```text
Explain the purpose of this file and how its main functions are connected.
```

```text
Summarize this code for a junior developer.
```

```text
Explain this code as if I already know JavaScript but I am new to React.
```

The last one is better because it states the reader's level.

---

## 12. Prompting to generate alternatives

Sometimes we don't want a single answer, but rather to compare approaches.

Example:

```text
Give me two different ways to implement this validation: one simple and one more scalable. Explain the pros and cons of each option.
```

This can be useful when you have to decide between:

- Simple code or extensible code.
- A standalone function or a class.
- Manual validation or an external library.
- A quick solution or a maintainable one.

---

## 13. Iterative prompting

Working with Copilot is not about writing a single prompt and accepting the first response.

The usual approach is to iterate.

Example sequence:

```text
Create a JavaScript function to validate a password.
```

Then:

```text
Modify it so the password must have at least 8 characters, one uppercase letter, one lowercase letter and one number.
```

Then:

```text
Return an object with isValid and errors instead of only true or false.
```

Then:

```text
Add unit tests using Jest.
```

Then:

```text
Refactor the code to make each validation rule easier to maintain.
```

This way of working is a lot like collaborating with a fellow programmer.

---

## 14. Prompts with style restrictions

You can ask Copilot to follow a specific style.

Examples:

```text
Use clear variable names and avoid nested if statements.
```

```text
Use early returns to reduce indentation.
```

```text
Use modern JavaScript syntax, but avoid advanced patterns that would make the code harder for beginners.
```

```text
Follow the existing style of this file.
```

This kind of instruction helps keep the project consistent.

---

## 15. Prompts for working with errors

When you get an error, avoid writing just:

```text
Fix this error.
```

It is better to include:

- What you were trying to do.
- The error message.
- The relevant code snippet.
- What behavior you expected.
- What behavior you got.

Template:

```text
I am trying to [goal]. I get this error: [error message]. This is the relevant code: [code]. I expected [expected behavior], but I got [actual behavior]. Explain the likely cause and suggest a fix.
```

Example:

```text
I am trying to run a Jest test for my calculateAverage function. I get this error: TypeError: calculateAverage is not a function. The function is defined in src/calculator.js and the test imports it from ../src/calculator. Explain the likely cause and suggest a fix.
```

---

## 16. What to do when Copilot gives a bad answer

If Copilot gives an answer that is incorrect, incomplete, or too general, don't just accept it.

You can improve the conversation with new prompts.

### 16.1. Ask for more precision

```text
Be more specific and show the exact code changes.
```

### 16.2. Ask for a simpler solution

```text
Simplify the solution. Avoid unnecessary abstractions.
```

### 16.3. Ask for an explanation

```text
Explain why this solution works.
```

### 16.4. Ask it to look for problems

```text
Review your previous answer and identify any possible issue or missing edge case.
```

### 16.5. Ask it not to change parts of the code

```text
Keep the public function names unchanged because other files depend on them.
```

---

## 17. Common mistakes when writing prompts

### Mistake 1: Being too ambiguous

```text
Make this better.
```

Problem: It is not clear what “better” means.

Improved version:

```text
Refactor this code to reduce duplication and improve readability. Do not change the behavior.
```

---

### Mistake 2: Not specifying the language or framework

```text
Create a test for this function.
```

Improved version:

```text
Create Jest unit tests for this JavaScript function.
```

---

### Mistake 3: Not specifying restrictions

```text
Validate this email.
```

Improved version:

```text
Create a simple email validation function without external libraries. It should return true or false.
```

---

### Mistake 4: Accepting the first answer without checking it

Copilot can generate code that looks correct, but that:

- Does not compile.
- Does not handle edge cases.
- Does not follow the style of the project.
- Has security problems.
- Uses dependencies that do not exist.
- Solves a different problem from the one you asked about.

---

## 18. Checklist for reviewing code generated by Copilot

Before accepting generated code, review:

- Do I understand what it does?
- Does it compile or run?
- Does it fulfill exactly what I asked for?
- Does it follow the project's style?
- Does it use clear names?
- Does it handle foreseeable errors?
- Does it cover edge cases?
- Does it introduce unnecessary dependencies?
- Could it have security problems?
- Does it need tests?

---

## 19. Step-by-step guide: recommended prompting flow

When you use Copilot for a programming task, you can follow this flow:

### Step 1: Define the objective

Before asking, be clear about what you want to achieve.

Example:

```text
Quiero validar los datos de un formulario de registro.
```

---

### Step 2: Give context

State the language, framework or file.

Example:

```text
This is a JavaScript project using plain functions, without frameworks.
```

---

### Step 3: Specify restrictions

Example:

```text
Do not use external libraries.
```

---

### Step 4: Ask for the result

Example:

```text
Create a function called validateRegisterForm.
```

---

### Step 5: Ask for edge cases

Example:

```text
Handle empty values, invalid email and password shorter than 8 characters.
```

---

### Step 6: Review the answer

Don't accept the code automatically.

Check:

- Logic.
- Names.
- Errors.
- Security.
- Edge cases.

---

### Step 7: Iterate

If something is missing, ask for it.

Example:

```text
Modify the function so it returns an array of error messages instead of only true or false.
```

---

### Step 8: Request tests

Example:

```text
Generate Jest tests for this function, including valid data, empty fields and invalid email.
```

---

## 20. Summary

In this topic you have learned how to write better prompts for programming with GitHub Copilot.

You have seen:

- What a technical prompt is.
- Why context is important.
- How to structure a good prompt.
- How to request functions.
- How to request documentation.
- How to request refactorings.
- How to request tests.
- How to request bug detection.
- How to iterate on responses.
- How to critically review the result.

The main idea is that Copilot works best when given clear instructions, sufficient context, and concrete criteria.

Using Copilot well doesn't mean accepting everything it suggests, but using it as support to think, write, review and improve code.

---

## 21. Recommended official documentation

- GitHub Copilot documentation: `https://docs.github.com/copilot`
- Prompt engineering for GitHub Copilot Chat: `https://docs.github.com/copilot/concepts/prompt-engineering-for-copilot-chat`
- Best practices for using GitHub Copilot: `https://docs.github.com/copilot/get-started/best-practices`
- Writing tests with GitHub Copilot: `https://docs.github.com/copilot/tutorials/write-tests`
