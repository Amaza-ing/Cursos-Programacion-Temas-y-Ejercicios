# **Tema 11: Props Padre a Hijo**

## **1. Introducción**

Hasta ahora hemos creado componentes y hemos renderizado listas, pero todavía falta algo esencial para construir interfaces reales: **pasar datos entre componentes**.

En React, los datos normalmente “bajan” desde componentes padres hacia componentes hijos. Esta comunicación se hace mediante **props**.

En este tema aprenderás:

- Qué son las props y para qué sirven.
- Cómo pasar props de un componente padre a uno hijo.
- Cómo leer props en el componente hijo.
- Cómo usar `props` con destructuring.
- Buenas prácticas y errores típicos.

---

## **2. ¿Qué son las props?**

**Props** (properties) son valores que un componente recibe desde fuera.

- Un componente **padre** envía datos.
- Un componente **hijo** los recibe.
- El hijo no debería modificar esas props.

Piensa en un componente como una función:

- Le pasas argumentos.
- Devuelve un resultado.

En React:

- Le pasas props.
- Devuelve JSX.

---

## **3. Pasar props desde el padre**

Para pasar props, escribes atributos en el componente hijo:

```js
<UserCard name="Alex" role="Admin" />
```

Aquí:

- `name` y `role` son props.
- Sus valores se envían desde el padre.

---

## **4. Recibir props en el hijo**

### **4.1. Forma 1: Recibir `props` como objeto**

```js
function UserCard(props) {
  return (
    <div>
      <h3>{props.name}</h3>
      <p>{props.role}</p>
    </div>
  );
}

export default UserCard;
```

Esta forma funciona, pero cuando hay muchas props puede ser menos cómoda.

---

### **4.2. Forma 2: Destructuring (recomendado)**

```js
function UserCard({ name, role }) {
  return (
    <div>
      <h3>{name}</h3>
      <p>{role}</p>
    </div>
  );
}

export default UserCard;
```

Ventajas:

- Código más limpio.
- No repites `props.`.

---

## **5. Ejemplo completo: Padre → Hijo**

### **5.1. `UserCard.jsx`**

```js
function UserCard({ name, role }) {
  return (
    <div>
      <h3>{name}</h3>
      <p>Role: {role}</p>
    </div>
  );
}

export default UserCard;
```

### **5.2. `App.jsx`**

```js
import UserCard from "./components/UserCard";

function App() {
  return (
    <div>
      <UserCard name="Alex" role="Admin" />
      <UserCard name="Marta" role="User" />
    </div>
  );
}

export default App;
```

Observa que:

- `App` es el padre.
- `UserCard` es el hijo.
- El padre reutiliza el mismo componente con distintos valores.

---

## **6. Pasar valores dinámicos (variables) como props**

No siempre pasarás strings “a mano”. Lo normal es pasar variables.

Ejemplo:

```js
function App() {
  const userName = "Sara";
  const userRole = "Editor";

  return <UserCard name={userName} role={userRole} />;
}
```

Aquí:

- Las llaves `{}` indican que estás pasando una **expresión JavaScript**.
- No se ponen comillas.

---

## **7. Pasar números, booleanos y objetos**

Las props pueden ser de cualquier tipo.

### **7.1. Número**

```js
<ProductPrice price={19} />
```

### **7.2. Booleano**

```js
<Badge isNew={true} />
```

En booleanos, puedes usar la versión corta:

```js
<Badge isNew />
```

### **7.3. Objeto**

```js
const user = { name: "Leo", role: "User" };

<UserCard name={user.name} role={user.role} />;
```

---

## **8. Props y listas (patrón muy común)**

Un caso típico: renderizas una lista y pasas cada item como props a un componente.

### **8.1. Componente hijo `TaskItem.jsx`**

```js
function TaskItem({ text, done }) {
  return (
    <li>
      {text} - {done ? "Done" : "Pending"}
    </li>
  );
}

export default TaskItem;
```

### **8.2. Componente padre `TasksList.jsx`**

```js
import TaskItem from "./TaskItem";

function TasksList() {
  const tasks = [
    { id: 1, text: "Study", done: true },
    { id: 2, text: "Practice", done: false },
  ];

  return (
    <ul>
      {tasks.map((task) => (
        <TaskItem key={task.id} text={task.text} done={task.done} />
      ))}
    </ul>
  );
}

export default TasksList;
```

Aquí:

- El `key` va en el componente que se repite.
- El resto de datos se pasan como props.

---

## **9. Errores típicos**

### **9.1. Olvidar las llaves en valores dinámicos**

Incorrecto:

```js
<UserCard name=userName />
```

Correcto:

```js
<UserCard name={userName} />
```

---

### **9.2. Intentar modificar props en el hijo**

Las props son de solo lectura.

Incorrecto:

```js
function UserCard({ name }) {
  name = "Other";
  return <p>{name}</p>;
}
```

Si necesitas cambiar algo, eso suele indicar que debe ser **estado** (useState) o que el padre debe enviar valores distintos.

---

## **10. Buenas prácticas**

- Nombra props con intención: `title`, `isOpen`, `price`.
- Mantén los componentes hijos lo más “presentacionales” posible.
- Usa destructuring cuando el componente reciba varias props.
- Si pasas muchas props, quizá necesites reorganizar componentes (o usar Context más adelante).

---

## **11. A tener en cuenta**

- Props = datos que un padre envía a un hijo.
- El flujo habitual es de arriba a abajo.
- Las props no se modifican en el hijo.
- Puedes pasar cualquier tipo de dato.

---

En el próximo tema veremos **`className` y `htmlFor`**, dos atributos clave en React cuando trabajas con CSS y formularios.
