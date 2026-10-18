# **Exercises - Topic 7: Pass by Value and Pass by Reference**

Below you'll find 5 practical exercises on pass by value and pass by reference in JavaScript.

Try to solve them before looking at the solution.

---

### **Exercise 1: Pass by Value with Primitive Variables**

Create two variables, `x` and `y`, assigning `y` the value of `x`. Then, change the value of `y` and check whether `x` has changed.

<details><summary>Show solution</summary>

```js
let x = 42;
let y = x;
y = 100;

console.log(x); // Salida: 42
console.log(y); // Salida: 100
```

</details>

---

### **Exercise 2: Modifying an Object by Reference**

Create a `car` object with `brand` and `year` properties. Then, assign this object to a new variable `carCopy` and modify `year` in `carCopy`. What happens to `car`?

<details><summary>Show solution</summary>

```js
const car = { brand: "Toyota", year: 2020 };
const carCopy = car;
carCopy.year = 2025;

console.log(car.year); // Salida: 2025
console.log(carCopy.year); // Salida: 2025
```

</details>

---

### **Exercise 3: Create an Independent Copy of an Object**

Given the following `user` object, create an independent copy and modify only the `age` property in the copy without affecting the original object.

<details><summary>Show solution</summary>

```js
const user = { name: "Elena", age: 30 };
const userCopy = { ...user };
userCopy.age = 35;

console.log(user.age); // Salida: 30
console.log(userCopy.age); // Salida: 35
```

</details>

---

### **Exercise 4: Copy an Array without Modifying the Original**

Given a `numbers` array, create a copy of the array and add a new number to the copy without affecting the original.

<details><summary>Show solution</summary>

```js
const numbers = [10, 20, 30];
const numbersCopy = [...numbers];
numbersCopy.push(40);

console.log(numbers); // Salida: [10, 20, 30]
console.log(numbersCopy); // Salida: [10, 20, 30, 40]
```

</details>

---

### **Exercise 5: Deep Copy of an Object with Nested Objects**

Given the following `student` object, make a deep copy and modify the `grade` property without affecting the original.

```js
const student = {
  name: "Pedro",
  info: {
    grade: "A",
    age: 21,
  },
};
```

<details><summary>Show solution</summary>

```js
const student = {
  name: "Pedro",
  info: {
    grade: "A",
    age: 21,
  },
};

const studentCopy = JSON.parse(JSON.stringify(student));
studentCopy.info.grade = "B";

console.log(student.info.grade); // Salida: A
console.log(studentCopy.info.grade); // Salida: B
```

</details>
