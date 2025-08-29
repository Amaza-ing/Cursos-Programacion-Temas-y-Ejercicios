# **Tema 15: Curiosidades y Comportamientos Extraños en JavaScript**

## **1. Introducción**

JavaScript es un lenguaje flexible y dinámico, pero esta flexibilidad a veces genera comportamientos inesperados o curiosos. En este tema exploraremos algunas de las peculiaridades y cómo manejarlas correctamente.

---

## **2. Comparaciones Extrañas**

JavaScript realiza conversiones implícitas de tipos al comparar valores, lo que puede producir resultados inesperados.

### **2.1. Comparaciones con `==` y `===`**

```js
console.log(0 == "0"); // true (conversión implícita)
console.log(0 === "0"); // false (comparación estricta)
```

### **2.2. `null` y `undefined` en Comparaciones**

```js
console.log(null == undefined); // true (se consideran equivalentes)
console.log(null === undefined); // false (son tipos distintos)
```

### **2.3. ¿Es `NaN` igual a `NaN`?**

```js
console.log(NaN === NaN); // false (NaN nunca es igual a sí mismo)
console.log(Number.isNaN(NaN)); // true (forma correcta de verificar NaN)
```

---

## **3. Comportamiento Extraño de los Arrays**

### **3.1. Arrays con Espacios Vacíos**

```js
const arr = [1, , 3];
console.log(arr.length); // 3 (pero el segundo elemento es `empty`)
console.log(arr[1]); // undefined
```

### **3.2. Sumar Arrays con `+`**

```js
console.log([1, 2, 3] + [4, 5, 6]); // "1,2,34,5,6" (se convierten en strings y se concatenan)
```

---

## **4. Conversión Implícita de Tipos**

JavaScript intenta convertir tipos automáticamente en ciertas operaciones.

### **4.1. Sumando números con strings**

```js
console.log(5 + "5"); // "55" (número convertido a string)
console.log("5" - 2); // 3 (string convertido a número)
```

### **4.2. `true` y `false` como números**

```js
console.log(true + true); // 2 (true se convierte en 1)
console.log(false + 1); // 1 (false se convierte en 0)
```

---

## **5. Objetos y Arrays en Comparaciones**

### **5.1. Objetos Comparados con Sí Mismos**

```js
const obj = {};
console.log(obj === obj); // true (misma referencia en memoria)
console.log({} === {}); // false (diferentes referencias en memoria)
```

### **5.2. `typeof` de Arrays y `null`**

```js
console.log(typeof []); // "object" (aunque es un array)
console.log(typeof null); // "object" (error histórico de JavaScript)
```

---

## **6. `null` y `undefined` en Operaciones Matemáticas**

### **6.1. Suma con `null`**

```js
console.log(null + 1); // 1 (null se convierte en 0)
```

### **6.2. Multiplicación con `undefined`**

```js
console.log(undefined * 5); // NaN (undefined no puede convertirse a un número)
```

---

## **7. Comportamientos extraños con `typeof`**

### **7.1. `typeof` en valores inesperados**

```js
console.log(typeof NaN); // "number" (aunque no representa un número real)
console.log(typeof null); // "object" (error histórico de JavaScript)
console.log(typeof []); // "object" (un array es técnicamente un objeto)
console.log(typeof function () {}); // "function" (pero sigue siendo un objeto)
```

### **7.2. ¿Es un número infinito?**

```js
console.log(typeof Infinity); // "number"
console.log(isFinite(Infinity)); // false
console.log(isFinite(1000)); // true
```

---

## **8. Comportamiento Curioso de los Strings**

### **8.1. `String` convertido a número automáticamente**

```js
console.log("10" * 2); // 20 (convierte el string en número implícitamente)
console.log("10" - 1); // 9 (también convierte el string a número)
console.log("10" + 1); // "101" (pero aquí lo trata como una concatenación de string)
```

### **8.2. Comparación con `>` y `<` en strings**

```js
console.log("2" > "12"); // true (comparación lexicográfica, "2" es mayor que "1")
```

---

## **9. Valores `falsy` y `truthy` Extraños**

### **9.1. Valores `falsy` inesperados**

```js
console.log(Boolean(0)); // false
console.log(Boolean("")); // false
console.log(Boolean(NaN)); // false
console.log(Boolean([])); // true (un array vacío es truthy)
console.log(Boolean({})); // true (un objeto vacío es truthy)
```

### **9.2. ¿Cómo convertir cualquier valor en `true` o `false`?**

```js
console.log(!!"texto"); // true
console.log(!!0); // false
console.log(!!null); // false
```

---

## **10. Rarezas con Arrays y Objetos**

### **10.1. Comparación de Arrays**

```js
console.log([] == []); // false (son referencias distintas en memoria)
console.log([] == ![]); // true (![] se convierte en false que se convierte en 0 implícitamente y [] es también convertido a 0 a efectos de esta comparación)
```

### **10.2. Acceder a índices inexistentes en un array**

```js
const arr = [1, 2, 3];
console.log(arr[10]); // undefined (pero no error)
```

---

## **11. Funciones y su Comportamiento Inusual**

### **11.1. Funciones con parámetros duplicados**

```js
function weird(a, a, a) {
  console.log(a);
}
weird(1, 2, 3); // Salida: 3 (el último valor sobrescribe los anteriores)
```

---

[![Cómo crear un Reloj](https://img.youtube.com/vi/7cQ81kmMIpE/0.jpg)](https://www.youtube.com/watch?v=7cQ81kmMIpE&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **12. Conclusión**

JavaScript es un lenguaje poderoso, pero algunas de sus características pueden llevar a resultados inesperados. Comprender estas peculiaridades ayuda a escribir código más sólido y evitar errores difíciles de detectar.

---

[![Fin de Curso](https://img.youtube.com/vi/pP-bbDGJZZE/0.jpg)](https://www.youtube.com/watch?v=pP-bbDGJZZE&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---
