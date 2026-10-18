# Exercises - Topic 04: Installing and configuring GitHub Copilot

Below, you'll find hands-on exercises on installing, configuring and getting started with GitHub Copilot in a development environment.

## Exercise 1: Check the requirements before installing GitHub Copilot

Before installing GitHub Copilot, list the things you should check to make sure you can use it correctly on your computer.

You should include, at least, aspects related to the account, the code editor, the extension and the connection.

<details>
<summary>Show solution</summary>

Before installing GitHub Copilot, you should check the following:

1. Have an active GitHub account.
2. Have access to a GitHub Copilot subscription, whether individual, educational, enterprise or provided by an organization.
3. Have a compatible editor installed, such as Visual Studio Code or a JetBrains IDE.
4. Have an internet connection, since Copilot needs to communicate with GitHub's services.
5. Check that the editor is up to date.
6. Install the official GitHub Copilot extension.
7. Sign in to GitHub from the editor.
8. Accept the permissions needed to link the editor to the GitHub account.
9. Check whether the organization has specific policies that limit or configure the use of Copilot.

</details>

## Exercise 2: Installing GitHub Copilot in Visual Studio Code

Put in order the steps you would follow to install and activate GitHub Copilot in Visual Studio Code.

Steps, out of order:

- Search for the GitHub Copilot extension.
- Open Visual Studio Code.
- Sign in with the GitHub account.
- Open the extensions panel.
- Install the official extension.
- Check that suggestions appear when writing code.

<details>
<summary>Show solution</summary>

The correct order would be:

1. Open Visual Studio Code.
2. Open the extensions panel.
3. Search for the GitHub Copilot extension.
4. Install the official extension.
5. Sign in with the GitHub account.
6. Check that suggestions appear when writing code.

Once this is done, you can create a test file, for example `app.js`, and write a comment like this:

```javascript
// Crear una función que reciba un array de precios y devuelva el total
```


If Copilot is active, it should propose a possible implementation.

</details>

## Exercise 3: Installing GitHub Copilot in JetBrains

Explain the steps you would follow to install GitHub Copilot in a JetBrains IDE, such as IntelliJ IDEA, WebStorm or PyCharm.

<details>
<summary>Show solution</summary>

The steps would be:

1. Open the JetBrains IDE.
2. Go to `Settings` or `Preferences`.
3. Go to the `Plugins` section.
4. Search for `GitHub Copilot` in the plugin marketplace.
5. Install the official plugin.
6. Restart the IDE if prompted.
7. Sign in with the GitHub account.
8. Authorize the connection between GitHub and the IDE.
9. Open a code file and check that Copilot offers suggestions.

To check it, you can create a file like `ProductService.java` and write:

```java
// Crear un método que calcule el precio final aplicando un descuento
```


If Copilot is correctly enabled, it should suggest an implementation related to that comment.

</details>

## Exercise 4: Tell inline suggestions and Copilot Chat apart

Read the following situations and say whether it would be more appropriate to use inline suggestions or Copilot Chat.

1. You're writing a simple function and want Copilot to complete the code.
2. You have an error in a class and want Copilot to explain what might be going on.
3. You want to quickly generate a condition inside a loop.
4. You want Copilot to compare two possible ways to solve a problem.
5. You want to ask for a general explanation of an entire file.

<details>
<summary>Show solution</summary>

1. **Inline suggestions**. They're suitable for completing code as you type.
2. **Copilot Chat**. It can explain errors and reason about the context.
3. **Inline suggestions**. They give quick help without breaking your typing flow.
4. **Copilot Chat**. It's better for comparing alternatives and asking for reasoning.
5. **Copilot Chat**. It can analyze and explain code conversationally.

Inline suggestions are useful when you already know what you want to write and just need help completing it. Copilot Chat is better suited when you need an explanation, an analysis, a comparison or a more elaborate answer.

</details>

## Exercise 5: Configure Copilot to work with more control

Imagine a student installs GitHub Copilot and starts accepting every suggestion automatically without reviewing it. Write a short list of recommendations for using Copilot in a more controlled way.

<details>
<summary>Show solution</summary>

Recommendations:

1. Always read the generated code before accepting it.
2. Check that the suggestion fits the purpose of the file.
3. Don't accept code you don't understand.
4. Test the code after adding it.
5. Review the names of variables, functions and classes.
6. Check that no unnecessary dependencies have been introduced.
7. Verify that the code doesn't expose sensitive data.
8. Ask Copilot for an explanation if the suggestion isn't clear.
9. Use Copilot as an aid, not as a substitute for human review.

A good way to work would be to accept only the useful parts of a suggestion and manually change whatever doesn't fit the project.

</details>

## Exercise 6: First test file with GitHub Copilot

Create a file called `cart.js` and write an initial comment that helps Copilot generate a function to calculate the total of a shopping cart. The cart will have products with a name, a price and a quantity.

Then, show what code Copilot might generate and how you would review it.

<details>
<summary>Show solution</summary>

An appropriate comment could be:

```javascript
// Crear una función que reciba un array de productos y calcule el total del carrito.
// Cada producto tiene name, price y quantity.
// La función debe devolver el total como número.
```


Copilot could generate something like this:

```javascript
function calculateCartTotal(products) {
  return products.reduce((total, product) => {
    return total + product.price * product.quantity;
  }, 0);
}
```


The review should check:

1. That the function receives the correct parameter.
2. That it uses clear names in English.
3. That it correctly multiplies `price` by `quantity`.
4. That it returns a number.
5. That it doesn't modify the original array.
6. That it works with an empty array.

You could test it with this example:

```javascript
const products = [
  { name: "Keyboard", price: 30, quantity: 2 },
  { name: "Mouse", price: 15, quantity: 1 },
];

console.log(calculateCartTotal(products)); // 75
```


</details>
