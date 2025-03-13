# **Tema 8: Paso por Valor y Paso por Referencia en JavaScript**

## **1. Introducción**

Cuando se asignan valores a variables o se pasan como argumentos a funciones en JavaScript, pueden manejarse de dos maneras:

- **Paso por Valor** (Primtivos)
- **Paso por Referencia** (Objetos y Arrays)

Comprender esta diferencia es clave para evitar efectos inesperados en el código.

---

## **2. Paso por Valor**

El **paso por valor** ocurre cuando se asigna o se pasa una variable que contiene un tipo de dato primitivo:

- Números (`Number`)
- Cadenas (`String`)
- Booleanos (`Boolean`)
- `null`, `undefined`
- `Symbol`
- `BigInt`

Cada vez que una variable de tipo primitivo se asigna a otra variable, se crea una **copia independiente** del valor original.

### **Ejemplo de Paso por Valor**

```js
let a = 10;
let b = a; // Se copia el valor de 'a' en 'b'

b = 20; // Modificamos 'b', pero 'a' sigue siendo 10

console.log(a); // Salida: 10
console.log(b); // Salida: 20
```

> **Nota:** La variable `b` obtiene una copia del valor de `a`, por lo que modificar `b` no afecta a `a`.

---

## **3. Paso por Referencia**

El **paso por referencia** ocurre cuando se asigna o se pasa una variable que contiene un tipo de dato no primitivo:

- Objetos (`Object`)
- Arrays (`Array`)
- Funciones (`Function`)

En estos casos, en lugar de copiar el valor, **se copia la referencia** en memoria. Es decir, ambas variables apuntan al mismo objeto.

### **Ejemplo de Paso por Referencia**

```js
let person1 = { name: "Ana", age: 25 };
let person2 = person1; // Ambas variables apuntan al mismo objeto

person2.age = 30; // Modificamos 'person2', pero también afecta a 'person1'

console.log(person1.age); // Salida: 30
console.log(person2.age); // Salida: 30
```

> **Nota:** Cambios en `person2` afectan a `person1` porque ambas variables hacen referencia al mismo objeto en memoria.

---

## **4. Copiar Objetos y Arrays sin modificar el original**

Para evitar modificaciones no deseadas en objetos y arrays, es necesario hacer **copias independientes**.

### **4.1. Copia superficial (Shallow Copy) con `Object.assign()`**

```js
const original = { name: "Carlos", age: 40 };
const copy = Object.assign({}, original);

copy.age = 45;
console.log(original.age); // Salida: 40 (no se modifica)
```

### **4.2. Copia superficial con el operador Spread (`...`)**

```js
const copy2 = { ...original };
copy2.age = 50;
console.log(original.age); // Salida: 40
```

### **4.3. Copia profunda (Deep Copy) con `JSON.parse(JSON.stringify())`**

Si el objeto tiene anidaciones, `Object.assign()` y `spread` **no** copian los objetos internos.

```js
const nestedObject = {
  name: "Laura",
  details: {
    age: 30,
  },
};
const deepCopy = JSON.parse(JSON.stringify(nestedObject));

deepCopy.details.age = 35;
console.log(nestedObject.details.age); // Salida: 30 (no se modifica)
```

> **Nota:** `JSON.stringify()` no funciona bien con funciones o valores `undefined`.

### **4.4. Copia profunda con `structuredClone()` (ES2021)**

```js
const deepClone = structuredClone(nestedObject);
deepClone.details.age = 40;
console.log(nestedObject.details.age); // Salida: 30
```

---

## **5. Copiando Arrays**

### **5.1. Copia superficial con `slice()`**

```js
const numbers = [1, 2, 3, 4];
const numbersCopy = numbers.slice();
numbersCopy.push(5);

console.log(numbers); // [1, 2, 3, 4]
console.log(numbersCopy); // [1, 2, 3, 4, 5]
```

### **5.2. Copia superficial con el operador Spread (`...`)**

```js
const newNumbers = [...numbers];
```

### **5.3. Copia superficial con `map()`**

```js
const newNumbers = numbers.map((number) => number);
```

### **5.4. Copia profunda con `JSON.parse(JSON.stringify())`**

```js
const nestedArray = [
  [1, 2],
  [3, 4],
];
const deepArrayCopy = JSON.parse(JSON.stringify(nestedArray));
deepArrayCopy[0][0] = 99;

console.log(nestedArray[0][0]); // Salida: 1 (no se modifica)
```

### **5.5. Copia profunda con `structuredClone()` (ES2021)**

```js
const originalArray = [
  [1, 2],
  [3, 4],
];

const deepCopyArray = structuredClone(originalArray);
deepCopyArray[0][0] = 99;

console.log(originalArray[0][0]); // 1 (no se modifica)
console.log(deepCopyArray[0][0]); // 99 (copia independiente)
```

---

## **6. Buenas Prácticas**

- **Usar paso por valor** para tipos primitivos cuando no se necesita compartir referencia.
- **Evitar modificar objetos compartidos** al usar paso por referencia.
- **Hacer copias independientes** con `Object.assign()`, `spread (...)`, `JSON.parse(JSON.stringify())` o `structuredClone()`.
- **Cuidado con copias superficiales**: No copian objetos anidados.

---

## **7. Conclusión**

Comprender la diferencia entre **paso por valor** y **paso por referencia** ayuda a escribir código más predecible y a evitar errores inesperados al modificar objetos y arrays en JavaScript.

En el siguiente tema veremos algunos operadores menos conocidos, como spread operator, optional chaining y otros.
