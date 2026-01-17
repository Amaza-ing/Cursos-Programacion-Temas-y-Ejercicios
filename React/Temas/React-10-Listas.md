# **Tema 10: Listas, Index y Listas de Objetos**

## **1. Introducción**

En una aplicación real, rara vez renderizas elementos “a mano” uno por uno. Lo habitual es tener una colección de datos (array) y generar la interfaz dinámicamente.

En React, esto se hace renderizando **listas** con `.map()`.

En este tema aprenderás:

- Cómo renderizar listas con `.map()`.
- Qué es la prop `key` y por qué es importante.
- Cuándo usar el **index** como `key` y cuándo evitarlo.
- Cómo renderizar **listas de objetos**.

---

## **2. Renderizar una lista simple con `.map()`**

Un patrón típico:

- Tienes un array.
- Lo recorres con `.map()`.
- Devuelves JSX por cada elemento.

Ejemplo con una lista de strings:

```js
function FruitsList() {
  const fruits = ["Apple", "Banana", "Orange"];

  return (
    <ul>
      {fruits.map((fruit) => (
        <li key={fruit}>{fruit}</li>
      ))}
    </ul>
  );
}

export default FruitsList;
```

Detalles importantes:

- `.map()` devuelve un **nuevo array**.
- Cada elemento de la lista en React debe tener una `key`.

---

## **3. La prop `key` (muy importante)**

Cuando React renderiza una lista, necesita una forma estable de identificar cada elemento. Para eso sirve `key`.

- `key` debe ser **única** dentro de esa lista.
- Debe ser **estable** (idealmente no cambia entre renders).

Ejemplo recomendado:

```js
<li key={fruit}>{fruit}</li>
```

---

[![Listas](https://img.youtube.com/vi/c8j6TtAqTYQ/0.jpg)](https://www.youtube.com/watch?v=c8j6TtAqTYQ&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

## **4. Listas con `index` (Listas Index)**

A veces se usa el **index** del `.map()` como `key`:

```js
function ColorsList() {
  const colors = ["Blue", "Gray", "Purple"];

  return (
    <ul>
      {colors.map((color, index) => (
        <li key={index}>{color}</li>
      ))}
    </ul>
  );
}

export default ColorsList;
```

### **4.1. ¿Cuándo se puede usar el index como `key`?**

Puedes usar `index` si se cumplen estas condiciones:

- La lista es **estática** (no se reordena).
- No se eliminan ni insertan elementos en medio.
- Cada elemento no tiene un id estable.

Ejemplo típico: una lista fija de pasos de un tutorial.

### **4.2. ¿Cuándo NO deberías usar el index como `key`?**

Evítalo si:

- Puedes reordenar la lista.
- Puedes eliminar/añadir elementos.
- Los elementos tienen estado o inputs asociados.

Si React identifica mal los elementos, puede:

- Reutilizar un elemento donde no toca.
- Mostrar datos “cambiados de sitio”.
- Mantener estados en el item equivocado.

---

[![Listas Index](https://img.youtube.com/vi/HFp69Sp1bR0/0.jpg)](https://www.youtube.com/watch?v=HFp69Sp1bR0&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

## **5. Renderizar listas de objetos (Listas de Objetos)**

Lo más común es que tu lista sea un array de objetos.

Ejemplo:

```js
function UsersList() {
  const users = [
    { id: 101, name: "Alex", role: "Admin" },
    { id: 102, name: "Marta", role: "User" },
    { id: 103, name: "Leo", role: "User" },
  ];

  return (
    <ul>
      {users.map((user) => (
        <li key={user.id}>
          {user.name} - {user.role}
        </li>
      ))}
    </ul>
  );
}

export default UsersList;
```

Aquí la `key` ideal es `user.id` porque:

- Es única.
- No cambia.
- React puede identificar cada item correctamente.

---

[![Listas de Objetos](https://img.youtube.com/vi/RxJ-8PTAuBY/0.jpg)](https://www.youtube.com/watch?v=RxJ-8PTAuBY&list=PLzA2VyZwsq_-dE3Jvunglxq8a6UcH6gnF)

---

## **6. Renderizar componentes dentro de una lista**

Un patrón muy común es tener un componente “item” y renderizarlo en el `.map()`.

### **6.1. `UserItem.jsx`**

```js
function UserItem({ name, role }) {
  return (
    <li>
      <strong>{name}</strong> - {role}
    </li>
  );
}

export default UserItem;
```

### **6.2. `UsersList.jsx`**

```js
import UserItem from "./UserItem";

function UsersList() {
  const users = [
    { id: 1, name: "Alex", role: "Admin" },
    { id: 2, name: "Marta", role: "User" },
  ];

  return (
    <ul>
      {users.map((user) => (
        <UserItem key={user.id} name={user.name} role={user.role} />
      ))}
    </ul>
  );
}

export default UsersList;
```

Observa que:

- La `key` se pone en el **componente que se repite** (`UserItem`).
- `UserItem` recibe datos por props.

---

## **7. Buenas prácticas con listas**

- Usa una `key` estable (idealmente un `id`).
- Evita usar `index` como `key` si la lista puede cambiar.
- Si el JSX dentro del `.map()` se vuelve grande, crea un componente para cada item.
- Mantén las listas simples y legibles.

---

## **8. A tener en cuenta**

- Para renderizar listas en React se usa `.map()`.
- Cada item debe tener una `key`.
- `index` como `key` solo en listas estáticas.
- En listas de objetos, usa `id` como `key`.

En el próximo tema veremos **Props Padre a Hijo** para compartir información dinámica entre componentes.
