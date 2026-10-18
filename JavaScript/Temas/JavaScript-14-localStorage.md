# **Topic 14: Client Storage with `localStorage` and `sessionStorage`**

## **1. Introduction**

Web storage allows information to be saved in the user's browser persistently or temporarily without the need for databases. JavaScript offers two main options:

- **`localStorage`**: Persistently saves data until the user manually deletes it or the browser deletes it.
- **`sessionStorage`**: Saves data temporarily, for the duration of the browser session.

These methods are useful for storing user preferences, authentication tokens, shopping carts, etc.

---

## **2. `localStorage`: Persistent Storage**

If we want to observe the `localStorage` in the browser we can do so. For example in Chrome, we must open the `Chrome Devtools` (right click on the page ➡ inspect), then go to ➡ Application ➡ Storage ➡ Local Storage.

### **2.1. Save a data in `localStorage`**

```js
localStorage.setItem("username", "Carlos");
```

### **2.2. Obtain data from `localStorage`**

```js
const username = localStorage.getItem("username");
console.log(username); // "Carlos"
```

### **23. Delete specific data**

```js
localStorage.removeItem("username");
```

### **2.4. Clear all `localStorage`**

```js
localStorage.clear();
```

---

## **3. `sessionStorage`: Temporary Storage**

`sessionStorage` works similarly to `localStorage`, but the data is deleted when the tab or browser is closed.

### **3.1. Save data to `sessionStorage`**

```js
sessionStorage.setItem("theme", "dark");
```

### **3.2. Get data from `sessionStorage`**

```js
const theme = sessionStorage.getItem("theme");
console.log(theme); // "dark"
```

### **3.3. Delete specific data**

```js
sessionStorage.removeItem("theme");
```

### **3.4. Clear all `sessionStorage`**

```js
sessionStorage.clear();
```

---

## **4. Storing Objects in `localStorage` and `sessionStorage`**

`localStorage` and `sessionStorage` only store data in text format. To save objects, we must convert them to JSON. For this we can use `JSON.stringify()` and to go back to the object when we want to collect the value we can use `JSON.parse()`.

### **4.1. Save an object**

```js
const user = { name: "Ana", age: 30 };
localStorage.setItem("user", JSON.stringify(user));
```

### **4.2. Retrieve an object**

```js
const storedUser = JSON.parse(localStorage.getItem("user"));
console.log(storedUser.name); // "Ana"
```

---

[![localStorage & sessionStorage](https://img.youtube.com/vi/vJ4Y6EvucF4/0.jpg)](https://www.youtube.com/watch?v=vJ4Y6EvucF4&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. Practical Applications**

### **5.1. Remember a user's preference**

```js
function saveTheme(theme) {
  localStorage.setItem("theme", theme);
}

function loadTheme() {
  const savedTheme = localStorage.getItem("theme") || "light";
  document.body.className = savedTheme;
}

loadTheme();
```

### **5.2. Visit counter with `localStorage`**

```js
let visits = localStorage.getItem("visits") || 0;
visits++;
localStorage.setItem("visits", visits);
console.log(`Número de visitas: ${visits}`);
```

---

## **6. Differences between `localStorage` and `sessionStorage`**

| Feature | `localStorage` | `sessionStorage` |
| -------------- | ------------------ | ---------------------- |
| Persistence | Permanent | Only during the session |
| Maximum size | 5MB approx.         | 5MB approx.             |
| Availability | All tabs | Current tab only |

---

## **7. Conclusion**

The use of `localStorage` and `sessionStorage` allows you to improve the user experience by storing data quickly and easily without the need for databases. It should be used with caution, as the data is accessible from the user's browser and should not contain sensitive information such as passwords or security tokens.

In the next topic we will see some curiosities and strange behaviors in JavaScript.
