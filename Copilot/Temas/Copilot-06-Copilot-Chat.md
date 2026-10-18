# Topic 06 — Copilot Chat applied to development

## 1. Topic objectives

In this topic you will learn how to use **GitHub Copilot Chat** as a development assistant within the editor.

By the end of this topic you should be able to:

- Open and use Copilot Chat in the IDE.
- Ask about a specific file.
- Ask about a code selection.
- Ask for technical explanations adapted to the user's level.
- Request refactorings.
- Ask it to generate tests.
- Ask for help with errors.
- Use Copilot Chat to document code.
- Differentiate between requesting new code and requesting analysis of existing code.
- Critically review Copilot Chat responses.

---

## 2. What is Copilot Chat

**Copilot Chat** is a conversational interface integrated into the development environment.

Unlike inline suggestions, which appear while you write code, Copilot Chat allows you to have a conversation with Copilot.

You can ask it things like:

```text
What does this function do?
```

```text
Can you refactor this code to make it more readable?
```

```text
Generate unit tests for this file.
```

```text
Why am I getting this error?
```

```text
Document this class using JSDoc.
```

Copilot Chat is especially useful when you need broader explanations, analysis or changes.

---

## 3. Difference between Copilot Chat and inline suggestions

| Feature | Inline suggestions | Copilot Chat |
| ----------------- | ---------------------------- | -------------------------------------------- |
| How you use it | They appear while you write | Through a conversation |
| Best for | Completing code quickly | Analyzing, explaining and transforming code |
| Context level | Code near the cursor | File, selection, project and prompt |
| Interaction | Accept or reject | Ask, answer, iterate |
| Example | Completing a function | Asking for tests, explaining errors or refactoring |

In general:

- Use **inline suggestions** to write code faster.
- Use **Copilot Chat** to understand, review, modify or plan code.

---

## 4. Opening Copilot Chat in Visual Studio Code

In Visual Studio Code you can open Copilot Chat in several ways.

### Option 1: From the sidebar

1. Open Visual Studio Code.
2. Look for the Copilot or Chat icon in the sidebar.
3. Click to open the chat panel.

### Option 2: From the Command Palette

1. Press:

```text
Ctrl + Shift + P
```

On macOS:

```text
Cmd + Shift + P
```

2. Type:

```text
Copilot Chat
```

3. Select the corresponding option.

### Option 3: From the editor

In some versions you can right-click a code selection and choose a Copilot-related action.

For example:

```text
Copilot > Explain
```

Or:

```text
Copilot > Fix
```

Exact availability may vary depending on the editor and extension version.

---

## 5. Opening Copilot Chat in JetBrains

In JetBrains IDEs, Copilot Chat is usually available after installing the official GitHub Copilot plugin.

General steps:

1. Open the IDE.
2. Open a project.
3. Find the GitHub Copilot window or tool.
4. Sign in if the IDE asks you to.
5. Open the chat.
6. Write a question related to the file or project.

The exact location may vary between IntelliJ IDEA, WebStorm, PyCharm or other IDEs.

---

## 6. Types of questions you can ask Copilot Chat

Copilot Chat can help you with different types of tasks.

### 6.1. Explanation questions

Use them to understand code.

Examples:

```text
Explain this function step by step.
```

```text
What is the purpose of this file?
```

```text
Explain this code as if I were new to JavaScript modules.
```

---

### 6.2. Generation questions

Use them to create new code.

Examples:

```text
Create a function that validates a registration form.
```

```text
Generate a service class for managing products.
```

```text
Create a controller method that returns all users.
```

---

### 6.3. Refactoring questions

Use them to improve existing code.

Examples:

```text
Refactor this function to reduce duplication.
```

```text
Make this code easier to read without changing its behavior.
```

```text
Split this function into smaller helper functions.
```

---

### 6.4. Testing questions

Use them to generate or improve tests.

Examples:

```text
Generate unit tests for this function using Jest.
```

```text
Add tests for edge cases and invalid input.
```

```text
Review these tests and suggest missing cases.
```

---

### 6.5. Debugging questions

Use them to analyze errors.

Examples:

```text
I get this error when running the project. Explain the likely cause and suggest a fix.
```

```text
Find possible bugs in this function.
```

```text
Why does this code return undefined?
```

---

### 6.6. Documentation questions

Use them to generate explanations or comments.

Examples:

```text
Add JSDoc comments to this function.
```

```text
Create a README section explaining how to use this module.
```

```text
Document the parameters and return value of this method.
```

---

## 7. Working with a selection of code

One of the most useful ways to use Copilot Chat is to select a code snippet before asking.

### Step-by-step guide

1. Open a code file.
2. Select the function or block you want to analyze.
3. Open Copilot Chat.
4. Write a specific instruction.

Example:

```text
Explain the selected code step by step and identify possible edge cases.
```

Advantages of selecting code:

- Copilot knows exactly which part you are referring to.
- The answer is usually more precise.
- You prevent it from analyzing irrelevant parts of the file.
- You can work step by step on small snippets.

---

## 8. Asking about a whole file

You can also ask Copilot to analyze an entire file.

Examples:

```text
Summarize the purpose of this file.
```

```text
Identify the main functions in this file and explain how they are related.
```

```text
Review this file and suggest improvements in readability and maintainability.
```

This option is useful when:

- You open code you are not familiar with.
- You are reviewing legacy code.
- You want to document a file.
- You need an overview before modifying something.

---

## 9. Asking about the project

In some cases, Copilot Chat can use project or workspace context.

You can ask:

```text
Where is the user validation logic implemented in this project?
```

```text
Which files are related to authentication?
```

```text
Explain the general structure of this project.
```

However, you must be careful:

- Copilot may not have all the context.
- It may misinterpret the project's structure.
- It may overlook important files.
- Its answers should be checked by browsing the code.

---

## 10. Copilot Chat to explain code

When using Copilot Chat to explain code, it is a good idea to indicate the level of detail.

Basic prompt:

```text
Explain this code.
```

Improved prompt:

```text
Explain this code step by step. Assume I know basic JavaScript but I am new to asynchronous programming.
```

An even more specific prompt:

```text
Explain this async function step by step. Focus on what await does, how errors are handled and what value the function returns.
```

---

## 11. Copilot Chat for refactoring

Copilot Chat can help you improve code, but you must state clearly that you don't want the behavior to change.

Recommended prompt:

```text
Refactor the selected code to improve readability. Do not change its behavior. Keep the same function names and return values. Explain the changes after showing the code.
```

This prompt is better than:

```text
Improve this.
```

because it states:

- What needs to be improved.
- What should not change.
- What should be kept.
- What explanation is expected.

---

## 12. Guided refactoring example

Initial code:

```javascript
function getUserStatus(user) {
  if (user) {
    if (user.active) {
      if (user.role === "admin") {
        return "Admin user active";
      } else {
        return "Regular user active";
      }
    } else {
      return "Inactive user";
    }
  } else {
    return "No user";
  }
}
```

Prompt for Copilot Chat:

```text
Refactor this function to reduce nested if statements. Do not change the returned messages. Explain why the refactored version is easier to read.
```

Possible result:

```javascript
function getUserStatus(user) {
  if (!user) {
    return "No user";
  }

  if (!user.active) {
    return "Inactive user";
  }

  if (user.role === "admin") {
    return "Admin user active";
  }

  return "Regular user active";
}
```

The refactored version uses early returns to reduce nesting.

---

## 13. Copilot Chat to generate tests

Copilot Chat can generate tests from the selected code.

Recommended prompt:

```text
Generate Jest unit tests for the selected function. Include normal cases, edge cases and invalid input. Do not modify the source code.
```

Example for the previous function:

```javascript
function getUserStatus(user) {
  if (!user) {
    return "No user";
  }

  if (!user.active) {
    return "Inactive user";
  }

  if (user.role === "admin") {
    return "Admin user active";
  }

  return "Regular user active";
}
```

Prompt:

```text
Generate Jest tests for this function. Include cases for null user, inactive user, active admin user and active regular user.
```

Possible result:

```javascript
describe("getUserStatus", () => {
  test("returns No user when user is null", () => {
    expect(getUserStatus(null)).toBe("No user");
  });

  test("returns Inactive user when user is not active", () => {
    expect(getUserStatus({ active: false, role: "admin" })).toBe(
      "Inactive user",
    );
  });

  test("returns Admin user active for active admin users", () => {
    expect(getUserStatus({ active: true, role: "admin" })).toBe(
      "Admin user active",
    );
  });

  test("returns Regular user active for active non-admin users", () => {
    expect(getUserStatus({ active: true, role: "user" })).toBe(
      "Regular user active",
    );
  });
});
```

> The generated tests must be reviewed and run. Copilot may leave out important cases or assume details that are not correct.

---

## 14. Copilot Chat to detect errors

When you get an error, Copilot Chat can help you better if you provide complete information.

Weak prompt:

```text
Fix this error.
```

Recommended prompt:

```text
I am trying to run this function, but I get the following error: [paste error]. Explain the likely cause and suggest a minimal fix. Do not rewrite unrelated parts of the code.
```

The phrase **“Do not rewrite unrelated parts of the code”** is useful to stop Copilot from changing more than it should.

---

## 15. Copilot Chat to document code

You can ask for different types of documentation.

### 15.1. Brief comments

```text
Add short comments to the selected code only where they improve readability. Do not comment obvious lines.
```

### 15.2. Technical documentation

```text
Add JSDoc comments to this function. Include description, parameters, return value and possible errors.
```

### 15.3. README documentation

```text
Write a README section explaining how to use this module. Include installation, usage example and expected output.
```

---

## 16. Copilot Chat to review code

Copilot Chat can also serve as a first code review.

Recommended prompt:

```text
Review this code as if you were doing a code review. Focus on readability, maintainability, possible bugs and missing tests. Do not rewrite the code yet. First, list the issues you find.
```

This prompt is useful because it asks for an analysis first rather than an immediate change.

Then you can ask:

```text
Apply only the two most important improvements and keep the public API unchanged.
```

---

## 17. Copilot Chat to learn concepts

Copilot Chat can also be used as a teaching aid.

Examples:

```text
Explain what a callback is using this code as an example.
```

```text
Explain the difference between map, filter and reduce with examples from this file.
```

```text
Explain this error message in beginner-friendly language.
```

```text
Create a short summary of what I should understand before modifying this file.
```

This usage is especially useful when you are learning a new technology.

---

## 18. Recommended flow for working with Copilot Chat

When using Copilot Chat in a real task, you can follow this flow:

### Step 1: Understand before changing

Before asking for changes, ask what the code does.

```text
Explain what this file does and identify the main responsibilities of each function.
```

### Step 2: Ask for an analysis

```text
Review this code and identify possible improvements. Do not modify it yet.
```

### Step 3: Choose a specific improvement

```text
Refactor only the validation logic to reduce duplication. Keep the rest unchanged.
```

### Step 4: Ask for an explanation of the change

```text
Explain what changed and why.
```

### Step 5: Ask for tests

```text
Generate tests for the changed behavior and include edge cases.
```

### Step 6: Run and review

Run the project or the tests.

Do not accept the solution until you have checked it.

---

## 19. Complete example of using Copilot Chat

Suppose we have this code:

```javascript
function validateUser(user) {
  if (!user.name) {
    return false;
  }
  if (!user.email) {
    return false;
  }
  if (!user.email.includes("@")) {
    return false;
  }
  if (!user.password) {
    return false;
  }
  if (user.password.length < 8) {
    return false;
  }
  return true;
}
```

### Step 1: Ask for an explanation

```text
Explain what this function does step by step.
```

### Step 2: Ask about problems

```text
Identify possible problems or limitations in this validation function.
```

Possible problems:

- It doesn't check whether `user` exists.
- It doesn't return error messages.
- Email validation is very basic.
- All the rules are mixed together in a single function.

### Step 3: Ask for a refactoring

```text
Refactor this function so it returns an object with isValid and errors. Keep the validation rules simple and do not use external libraries.
```

Possible result:

```javascript
function validateUser(user) {
  const errors = [];

  if (!user) {
    return {
      isValid: false,
      errors: ["User is required"],
    };
  }

  if (!user.name) {
    errors.push("Name is required");
  }

  if (!user.email) {
    errors.push("Email is required");
  } else if (!user.email.includes("@")) {
    errors.push("Email is invalid");
  }

  if (!user.password) {
    errors.push("Password is required");
  } else if (user.password.length < 8) {
    errors.push("Password must have at least 8 characters");
  }

  return {
    isValid: errors.length === 0,
    errors,
  };
}
```

### Step 4: Ask for tests

```text
Generate Jest tests for this function. Include valid user, missing user, missing name, invalid email and short password.
```

### Step 5: Review manually

Before accepting the solution, check:

- Does the new function change the return type?
- Are there other parts of the project that expected `true` or `false`?
- Are the error messages appropriate?
- Do the tests cover the important cases?
- Is the solution too complex for the objective?

---

## 20. Best practices when using Copilot Chat

- Select the relevant code before asking.
- Write specific prompts.
- State the language or framework.
- Ask for analysis first and then changes.
- Ask for small, reviewable changes.
- Do not accept large modifications without understanding them.
- Run the code after applying changes.
- Generate or update tests.
- Do not paste secrets, keys or private data in the chat.
- Ask Copilot to explain its changes.

---

## 21. Copilot Chat's limitations

Copilot Chat can be wrong.

It may:

- Invent functions that do not exist.
- Assume dependencies that aren't installed.
- Fail to understand the whole project.
- Propose code that does not compile.
- Miss edge cases.
- Generate insufficient tests.
- Suggest insecure solutions.

That is why it is important to keep a critical attitude.

Copilot Chat should be a support, not the final authority.

---

## 22. Checklist for using Copilot Chat professionally

Before applying a Copilot Chat response, review:

- Have I given enough context?
- Does the answer fit my project?
- Does the generated code compile?
- Do I understand the solution?
- Has it changed parts I didn't want to change?
- Are there edge cases left uncovered?
- Have unnecessary dependencies been added?
- Are there possible security problems?
- Are the tests adequate?
- Does the result keep the project's style?

---

## 23. Summary

In this topic you have learned how to use Copilot Chat as a development assistant.

You have seen how to use it to:

- Explain code.
- Analyze files.
- Refactor functions.
- Generate tests.
- Detect errors.
- Document code.
- Review possible improvements.
- Learn technical concepts.

The main idea is that Copilot Chat is most useful when used conversationally and iteratively.

A good flow would be:

1. Understand the code.
2. Ask for an analysis.
3. Request specific changes.
4. Ask for an explanation.
5. Generate tests.
6. Run and review.

---

## 24. Recommended official documentation

- GitHub Copilot Chat documentation: `https://docs.github.com/copilot/using-github-copilot/asking-github-copilot-questions-in-your-ide`
- Getting started with Copilot Chat in your IDE: `https://docs.github.com/copilot/how-tos/chat-with-copilot/get-started-with-chat-in-your-ide`
- Responsible use of Copilot Chat in your IDE: `https://docs.github.com/copilot/responsible-use/chat-in-your-ide`
- Writing tests with GitHub Copilot: `https://docs.github.com/copilot/tutorials/write-tests`
