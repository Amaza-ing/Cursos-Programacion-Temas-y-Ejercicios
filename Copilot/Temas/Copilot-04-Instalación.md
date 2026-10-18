# Topic 04 — Installing and configuring GitHub Copilot in VS Code and JetBrains

## 1. Topic objectives

In this topic you will learn how to set up your work environment to use **GitHub Copilot** in a real development project.

By the end of this topic you should be able to:

- Understand what you need to use GitHub Copilot.
- Install GitHub Copilot in **Visual Studio Code**.
- Install GitHub Copilot in **JetBrains**.
- Sign in with your GitHub account.
- Check whether Copilot is working correctly.
- Enable and disable automatic suggestions.
- Tell the difference between inline suggestions and Copilot Chat.
- Apply a basic configuration that is safe and comfortable to work with.

> This topic is not yet about mastering prompts or Copilot Chat. The goal is to get your environment ready for the following topics.

---

## 2. What GitHub Copilot is within the development environment

**GitHub Copilot** is an AI-based programming assistant that integrates into your editor or IDE.

It can help you:

- Complete lines of code.
- Generate functions.
- Suggest code snippets.
- Explain existing code.
- Propose refactorings.
- Help write tests.
- Answer technical questions right from the editor.
- Detect errors or possible improvements.

The main idea is that Copilot acts as a **development assistant**, not as a replacement for the programmer.

You are still responsible for:

- Understanding the code.
- Reviewing what is generated.
- Testing that it works.
- Checking that it meets the requirements.
- Maintaining the quality and security of the project.

---

## 3. Prerequisites

Before installing GitHub Copilot, make sure you have the following:

### 3.1. GitHub account

You need a GitHub account.

If you don't have one, you can create it from:

```text
https://github.com/
```

### 3.2. Access to GitHub Copilot

GitHub Copilot requires access through a subscription, educational license, enterprise license, or activation within an organization.

Depending on how you take the course, you may be in one of these situations:

- You have an individual subscription.
- Your company or training center has assigned you a license.
- You use an educational account with access to Copilot.
- Your teacher gives you specific instructions to get access during the training.

### 3.3. A supported editor or IDE

In this course we will work mainly with:

- **Visual Studio Code**.
- **JetBrains IDEs**, such as IntelliJ IDEA, WebStorm, PyCharm or PhpStorm.

There are also integrations for other environments, but they will not be the main focus of this topic.

### 3.4. Git installed

Although GitHub Copilot can be used to write code without Git, in a professional development course it is recommended to have Git installed.

To check this, open a terminal and run:

```bash
git --version
```

If a version appears, Git is installed correctly.

Example:

```bash
git version 2.45.0
```

---

## 4. Installing GitHub Copilot in Visual Studio Code

Visual Studio Code is one of the most convenient environments to get started with GitHub Copilot.

### 4.1. Step 1: Open Visual Studio Code

Open Visual Studio Code on your computer.

If you don't have it installed yet, you can download it from:

```text
https://code.visualstudio.com/
```

---

### 4.2. Step 2: Open the extensions panel

In the left sidebar, click the **Extensions** icon.

You can also open it with the shortcut:

```text
Ctrl + Shift + X
```

On macOS:

```text
Cmd + Shift + X
```

---

### 4.3. Step 3: Search for GitHub Copilot

In the extensions search box, type:

```text
GitHub Copilot
```

You should find extensions related to:

- GitHub Copilot.
- GitHub Copilot Chat.

In recent versions of Visual Studio Code, the Copilot experience may be integrated or bundled within the official GitHub extensions.

---

### 4.4. Step 4: Install the extension

Click **Install**.

It is important to install the official GitHub extension.

Check that the publisher is:

```text
GitHub
```

---

### 4.5. Step 5: Sign in with GitHub

After you install the extension, Visual Studio Code may ask you to sign in.

Click:

```text
Sign in to GitHub
```

A browser window will open.

Follow the steps:

1. Sign in with your GitHub account.
2. Authorize Visual Studio Code.
3. Return to the editor.
4. Check that Copilot appears as active.

---

### 4.6. Step 6: Check Copilot's status

In Visual Studio Code, a Copilot icon usually appears at the bottom or top of the editor, depending on the version.

From that icon you can check whether Copilot is:

- Enabled.
- Disabled.
- Waiting for you to sign in.
- Without access because of its license.
- Blocked by the organization.

If Copilot doesn't work, check:

- That you have signed in with the correct account.
- That your account has access to Copilot.
- That the extension is installed and enabled.
- That there are no network or proxy restrictions.
- That Visual Studio Code is up to date.

---

## 5. First test in Visual Studio Code

To check that Copilot works, create a test folder.

For example:

```text
copilot-demo
```

Inside that folder, create a file called:

```text
main.js
```

Write the following comment:

```javascript
// Create a function that receives an array of numbers and returns the average
```

Wait a few seconds.

Copilot should suggest a possible function.

A possible suggestion would be:

```javascript
function calculateAverage(numbers) {
  if (numbers.length === 0) {
    return 0;
  }

  const sum = numbers.reduce((total, number) => total + number, 0);
  return sum / numbers.length;
}
```

> The exact code may vary. Copilot doesn't always generate the same response.

---

## 6. How to accept, reject or change suggestions

When Copilot displays a suggestion, it typically appears in light gray within the editor.

### Accept a suggestion

In Visual Studio Code, you can usually accept the suggestion with:

```text
Tab
```

### Reject a suggestion

You can continue typing or press:

```text
Esc
```

### See another suggestion

Depending on your editor settings, you can move between suggestions with keyboard shortcuts.

You can also open the Command Palette:

```text
Ctrl + Shift + P
```

On macOS:

```text
Cmd + Shift + P
```

Then search for commands related to Copilot.

---

## 7. Turn Copilot on and off in VS Code

There are times when you may want to temporarily disable Copilot.

For example:

- When you are taking a test without help.
- When you are working with sensitive information.
- When suggestions distract you.
- When you want to write a solution by hand.

### From the Copilot icon

1. Click the Copilot icon.
2. Select the option to turn Copilot on or off.
3. Choose whether you want to disable it globally or only for a specific language.

### From the settings

You can also open VS Code settings and search for:

```text
Copilot
```

From there you can modify options related to:

- Inline suggestions.
- Enabling it per language.
- Chat behavior.
- Shortcuts.

---

## 8. Turn Copilot on or off per language

Sometimes you don't want Copilot to work in all languages.

For example, you may want to use it in JavaScript, Java, or Python, but disable it in Markdown, JSON, or sensitive configuration files.

In VS Code you can access the Copilot settings and modify the allowed languages.

An example configuration could be:

```json
{
  "github.copilot.enable": {
    "*": true,
    "markdown": false,
    "plaintext": false
  }
}
```

This example means:

- Copilot is enabled by default.
- Copilot is disabled in Markdown.
- Copilot is disabled in plain text.

> The exact settings may vary depending on the version of the extension and the editor.

---

## 9. Installing GitHub Copilot in JetBrains

GitHub Copilot can also be installed in JetBrains IDEs.

Some examples are:

- IntelliJ IDEA.
- WebStorm.
- PyCharm.
- PhpStorm.
- RubyMine.
- GoLand.

---

### 9.1. Step 1: Open the IDE

Open your JetBrains IDE.

For example:

```text
IntelliJ IDEA
```

---

### 9.2. Step 2: Open the plugin settings

On Windows or Linux:

```text
File > Settings > Plugins
```

On macOS:

```text
IntelliJ IDEA > Settings > Plugins
```

---

### 9.3. Step 3: Search for GitHub Copilot

In the Marketplace tab, search for:

```text
GitHub Copilot
```

Check that the plugin is the one published by GitHub.

---

### 9.4. Step 4: Install the plugin

Click:

```text
Install
```

After installing it, the IDE may ask you to restart.

If that message appears, restart the IDE.

---

### 9.5. Step 5: Sign in

After restarting, the IDE may ask you to sign in to GitHub.

Follow these steps:

1. Click the sign-in option.
2. The browser will open.
3. Sign in with your GitHub account.
4. Authorize the plugin.
5. Return to the IDE.

---

### 9.6. Step 6: Check that it works

Create a test file.

For example:

```text
Main.java
```

Write this comment:

```java
// Create a method that receives a list of integers and returns the highest value
```

Copilot should suggest a possible implementation.

Example:

```java
public static int getHighestValue(List<Integer> numbers) {
    if (numbers == null || numbers.isEmpty()) {
        throw new IllegalArgumentException("The list cannot be null or empty");
    }

    int max = numbers.get(0);

    for (int number : numbers) {
        if (number > max) {
            max = number;
        }
    }

    return max;
}
```

---

## 10. Difference between inline suggestions and Copilot Chat

GitHub Copilot can help you in two main ways within the editor.

### 10.1. Inline suggestions

These are suggestions that appear while you write code.

They are useful to:

- Complete a line.
- Generate a function.
- Continue a pattern.
- Fill in repetitive code.
- Suggest an implementation.

Example:

```javascript
function formatPrice(price) {
```

Copilot can suggest the rest of the function.

---

### 10.2. Copilot Chat

Copilot Chat allows you to write questions or instructions in natural language.

It is useful to:

- Ask what a file does.
- Ask it to explain a function.
- Request a refactoring.
- Ask for tests.
- Analyze errors.
- Generate documentation.
- Compare alternatives.

Example prompt:

```text
Explain what this function does and suggest how to make it easier to read.
```

---

## 11. When to use inline suggestions and when to use Chat

Use **inline suggestions** when:

- You already know what you want to write.
- You are completing repetitive code.
- You want to speed up a simple implementation.
- The surrounding context in the file is enough.

Use **Copilot Chat** when:

- You need a question explained.
- You want to analyze an error.
- You need to compare alternatives.
- You want to modify several parts of the code.
- You need an explanation before accepting the code.
- You want to generate tests or documentation with specific instructions.

---

## 12. Recommended setup for class

For this course, it is recommended to work with the following initial configuration:

### In VS Code

- Have the official GitHub Copilot extension installed.
- Have Copilot Chat available.
- Have Git installed.
- Have a test project open as a folder.
- Have inline suggestions enabled.
- Have the Chat panel visible.

### In JetBrains

- Have the official GitHub Copilot plugin installed.
- Have signed in with GitHub.
- Have tried an inline suggestion.
- Have a test project open.
- Know where the Copilot options are in Settings.

---

## 13. Sample project to try things out during the course

Over the next topics you can use a simple project.

Create a folder called:

```text
copilot-course-demo
```

Inside, create this structure:

```text
copilot-course-demo/
├── README.md
├── src/
│   ├── calculator.js
│   ├── users.js
│   └── validators.js
└── tests/
    └── calculator.test.js
```

The project does not have to be complex.

The idea is to have enough files to try out:

- Function generation.
- Refactoring.
- Documentation.
- Tests.
- Code explanation.
- Error detection.

---

## 14. Example starter file

In the file:

```text
src/calculator.js
```

you can write:

```javascript
function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

function multiply(a, b) {
  return a * b;
}

function divide(a, b) {
  return a / b;
}

module.exports = {
  add,
  subtract,
  multiply,
  divide,
};
```

With this code we will be able to ask Copilot to:

- Add validations.
- Document functions.
- Generate tests.
- Detect errors.
- Suggest improvements.

---

## 15. Common errors when setting up Copilot

### Error 1: No suggestions appear

Possible causes:

- You are not signed in.
- The extension is not installed.
- Copilot is disabled.
- Your account does not have access to Copilot.
- The file is empty or does not have enough context.
- There are connection problems.

Recommended solution:

1. Check the status of Copilot in the editor.
2. Check that you are using the right GitHub account.
3. Close and reopen the editor.
4. Update the extension.
5. Try it in a simple file.

---

### Error 2: Copilot generates code that does not fit the project

Possible causes:

- The project does not have a clear structure.
- The prompt is too ambiguous.
- The file does not contain enough context.
- Existing code does not follow consistent patterns.

Recommended solution:

- Use clear function names.
- Write specific comments.
- Open related files.
- Use Copilot Chat to give more context.
- Always review and adapt the result.

---

### Error 3: Copilot suggests wrong code

This can happen.

Copilot does not guarantee that the code is correct.

Recommended solution:

- Read the code before accepting it.
- Run the project.
- Add tests.
- Check edge cases.
- Don't accept code you don't understand.

---

### Error 4: Copilot does not respond in Chat

Possible causes:

- You do not have access to Copilot Chat.
- There is a session problem.
- The IDE is not up to date.
- There are network restrictions.

Recommended solution:

- Sign out and sign in again.
- Update the IDE.
- Update the extension.
- Check the official documentation.
- Check whether your organization has restricted any features.

---

## 16. Configuration best practices

To work better with Copilot:

- Keep the editor updated.
- Use the official extension.
- Sign in with the correct account.
- Work with well-organized projects.
- Use clear names for files, functions and variables.
- Do not paste sensitive data in prompts.
- Always review the generated code.
- Disable Copilot on sensitive files if necessary.
- Use Chat for complex tasks and inline suggestions for small tasks.

---

## 17. Final topic checklist

Before moving on to the next topic, check that you can answer yes to these questions:

- Do I have an active GitHub account?
- Do I have access to GitHub Copilot?
- Have I installed Copilot in VS Code or JetBrains?
- Have I signed in correctly?
- Have I tried an inline suggestion?
- Do I know how to accept or reject a suggestion?
- Do I know how to open Copilot Chat?
- Do I know how to turn Copilot on or off if I need to?
- Do I understand that the generated code needs to be reviewed?

---

## 18. Summary

In this topic you have prepared your environment to work with GitHub Copilot.

You have seen:

- What you need to use Copilot.
- How to install it in VS Code.
- How to install it in JetBrains.
- How to check that it works.
- What inline suggestions are.
- What Copilot Chat is.
- When to use each mode.
- What configuration errors may appear.
- Which best practices to apply from the start.

In the next topic we will start working on one of the most important parts of the course: **how to write good prompts for programming with Copilot**.

---

## 19. Recommended official documentation

- GitHub Copilot documentation: `https://docs.github.com/copilot`
- Installing the GitHub Copilot extension: `https://docs.github.com/copilot/managing-copilot/configure-personal-settings/installing-the-github-copilot-extension-in-your-environment`
- Getting code suggestions in your IDE: `https://docs.github.com/copilot/using-github-copilot/getting-code-suggestions-in-your-ide-with-github-copilot`
- Troubleshooting GitHub Copilot: `https://docs.github.com/copilot/troubleshooting-github-copilot/troubleshooting-common-issues-with-github-copilot`
