# **Tema 8: Operadores Avanzados en JavaScript**

## **1. Introducción**

JavaScript incluye una serie de operadores menos conocidos pero muy útiles para escribir código más limpio y eficiente. En este tema, exploraremos algunos de los más importantes:

- Spread Operator (`...`)
- Rest Operator (`...`)
- Optional Chaining (`?.`)
- Nullish Coalescing (`??`)
- Operador Ternario (`? :`)

---

## **2. Spread Operator (`...`)**

El **spread operator** permite expandir elementos de un iterable (arrays, objetos, strings) en otro lugar donde se esperan valores individuales.

### **Ejemplo con Arrays**

```js
const numbers = [1, 2, 3];
const newNumbers = [...numbers, 4, 5];
console.log(newNumbers); // Salida: [1, 2, 3, 4, 5]
```

### **Ejemplo con Objetos**

```js
const user = { name: "Ana", age: 25 };
const newUser = { ...user, city: "Madrid" };
console.log(newUser); // Salida: { name: "Ana", age: 25, city: "Madrid" }
```

### **Ejemplo con Strings**

```js
const word = "Hola";
const letters = [...word];
console.log(letters); // Salida: ["H", "o", "l", "a"]
```

---

## **3. Rest Operator (`...`)**

El operador **rest** se usa en funciones para agrupar múltiples argumentos en un array.

```js
function sum(...numbers) {
  return numbers.reduce((acc, num) => acc + num, 0);
}

console.log(sum(1, 2, 3, 4)); // Salida: 10
```

También se usa para extraer elementos de un array u objeto.

```js
const [first, ...rest] = [10, 20, 30, 40];
console.log(first); // 10
console.log(rest); // [20, 30, 40]
```

---

## **4. Optional Chaining (`?.`)**

El operador **Optional Chaining** (`?.`) permite acceder a propiedades de un objeto sin causar errores si alguna propiedad intermedia es `null` o `undefined`.

### **Ejemplo sin Optional Chaining**

```js
const person = { name: "Carlos", address: null };
// console.log(person.address.street); // Error: No se puede leer 'street' de null
```

### **Ejemplo con Optional Chaining**

```js
console.log(person.address?.street); // Salida: undefined (sin error)
```

También funciona con llamadas a métodos:

```js
const user = {
  getName: () => "Pedro",
};
console.log(user.getName?.()); // Salida: "Pedro"
console.log(user.getAge?.()); // Salida: undefined
```

---

## **5. Nullish Coalescing (`??`)**

El operador **Nullish Coalescing** (`??`) devuelve el primer operando si **no es `null` ni `undefined`**, de lo contrario devuelve el segundo.

```js
const name = null;
const defaultName = name ?? "Invitado";
console.log(defaultName); // Salida: "Invitado"
```

Diferencia con `||` (OR lógico):

```js
const age = 0;
console.log(age || 18); // Salida: 18 (porque 0 es falsy)
console.log(age ?? 18); // Salida: 0 (porque no es null ni undefined)
```

---

## **6. Operador Ternario (`? :`)**

El operador **ternario** permite escribir una estructura condicional de forma compacta.

```js
const age = 20;
const message = age >= 18 ? "Mayor de edad" : "Menor de edad";
console.log(message); // Salida: "Mayor de edad"
```

Se pueden anidar operadores ternarios:

```js
const score = 85;
const grade = score >= 90 ? "A" : score >= 80 ? "B" : "C";
console.log(grade); // Salida: "B"
```

> **Nota:** Evita anidar ternarios para no perder legibilidad.

---

## **7. Conclusión**

Estos operadores avanzados permiten escribir código más conciso y eficiente en JavaScript. Usarlos correctamente puede mejorar la legibilidad y reducir la necesidad de estructuras más largas y complejas.

En el próximo tema, profundizaremos en el manejo de **funciones avanzadas** y técnicas para escribir código más limpio y modular.
