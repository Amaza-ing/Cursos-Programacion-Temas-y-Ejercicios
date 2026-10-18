# **Topic 14: Client-Side Storage with `localStorage` and `sessionStorage`**

## **1. Introduction**

Web storage lets you save information in the user's browser, persistently or temporarily, without needing a database. JavaScript offers two main options:

- **`localStorage`**: Saves data persistently until the user deletes it manually or the browser clears it.
- **`sessionStorage`**: Saves data temporarily, for as long as the browser session lasts.

These methods are useful for storing user preferences, authentication tokens, shopping carts, etc.

---

## **2. `localStorage`: persistent storage**

If we want to look at the `localStorage` in the browser, we can. For example, in Chrome we open `Chrome Devtools` (right-click on the page ➡ Inspect) and then go to ➡ Application ➡ Storage ➡ Local Storage.

### **2.1. Saving a piece of data in `localStorage`**

```js
localStorage.setItem("username", "Carlos");
```

### **2.2. Getting a piece of data from `localStorage`**

```js
const username = localStorage.getItem("username");
console.log(username); // "Carlos"
```

### **2.3. Deleting a specific piece of data**

```js
localStorage.removeItem("username");
```

### **2.4. Clearing the whole `localStorage`**

```js
localStorage.clear();
```

---

## **3. `sessionStorage`: temporary storage**

`sessionStorage` works similarly to `localStorage`, but the data is deleted when the tab or browser is closed.

### **3.1. Saving data in `sessionStorage`**

```js
sessionStorage.setItem("theme", "dark");
```

### **3.2. Getting data from `sessionStorage`**

```js
const theme = sessionStorage.getItem("theme");
console.log(theme); // "dark"
```

### **3.3. Deleting a specific piece of data**

```js
sessionStorage.removeItem("theme");
```

### **3.4. Clearing the whole `sessionStorage`**

```js
sessionStorage.clear();
```

---

## **4. Storing objects in `localStorage` and `sessionStorage`**

`localStorage` and `sessionStorage` only store data as text. To save objects, we have to convert them to JSON. For this we can use `JSON.stringify()`, and to turn the value back into an object when we read it, we can use `JSON.parse()`.

### **4.1. Saving an object**

```js
const user = { name: "Ana", age: 30 };
localStorage.setItem("user", JSON.stringify(user));
```

### **4.2. Retrieving an object**

```js
const storedUser = JSON.parse(localStorage.getItem("user"));
console.log(storedUser.name); // "Ana"
```

---

[![localStorage & sessionStorage](https://img.youtube.com/vi/vJ4Y6EvucF4/0.jpg)](https://www.youtube.com/watch?v=vJ4Y6EvucF4&list=PLzA2VyZwsq__JeA3Xa02uWT08Ljji931m)

---

## **5. Practical applications**

### **5.1. Remembering a user's preference**

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
| Maximum size | Approx. 5MB         | Approx. 5MB             |
| Availability | All tabs | Current tab only |

---

## **7. Conclusion**

Using `localStorage` and `sessionStorage` lets you improve the user experience by storing data quickly and easily, without needing a database. Use them with care, though: the data is accessible from the user's browser, so it shouldn't contain sensitive information such as passwords or security tokens.

In the next topic, we'll look at some curiosities and strange behaviors in JavaScript.
