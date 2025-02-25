const num1 = parseFloat(prompt("Introduce el primer número:"));
const num2 = parseFloat(prompt("Introduce el segundo número:"));
const operation = prompt("Introduce la operación (+, -, *, /):");

let result;

switch (operation) {
  case "+":
    result = num1 + num2;
    break;
  case "-":
    result = num1 - num2;
    break;
  case "*":
    result = num1 * num2;
    break;
  case "/":
    result = num2 !== 0 ? num1 / num2 : "Error: división por cero";
    break;
  default:
    result = "Operación no válida";
}

console.log(`Resultado: ${result}`);