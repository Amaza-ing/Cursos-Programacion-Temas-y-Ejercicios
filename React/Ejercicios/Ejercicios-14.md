# **Exercises - Topic 14: useEffect()**

Below you will find **10 practical exercises** on `useEffect()`.

Try to solve them before consulting the solution.

---

## **Exercise 1: Riding effect (only once)**

Create an `MountLogger.jsx` component that, when mounted, displays in the console:

- **"Component mounted"**

It must be run **only once**.

<details><summary>Show Solution</summary>

```js
import { useEffect } from "react";

function MountLogger() {
  useEffect(() => {
    console.log("Component mounted");
  }, []);

  return <p>MountLogger</p>;
}

export default MountLogger;
```

</details>

---

## **Exercise 2: Effect of changing a variable**

Create an `TitleWatcher.jsx` component with:

- Initial `title` state `""`.
- A controlled input.
- An `useEffect` that shows in the console: **"Title changed"** every time `title` changes.

<details><summary>Show Solution</summary>

```js
import { useEffect, useState } from "react";

function TitleWatcher() {
  const [title, setTitle] = useState("");

  useEffect(() => {
    console.log("Title changed");
  }, [title]);

  return (
    <div>
      <input
        value={title}
        onChange={(event) => setTitle(event.target.value)}
        placeholder="Title"
      />
    </div>
  );
}

export default TitleWatcher;
```

</details>

---

## **Exercise 3: `setInterval` with cleanup**

Create an `Stopwatch.jsx` component that:

- Have initial status `seconds` `0`.
- Use an `setInterval` to increment `seconds` every 1 second.
- Clean the gap when disassembling the component.

<details><summary>Show Solution</summary>

```js
import { useEffect, useState } from "react";

function Stopwatch() {
  const [seconds, setSeconds] = useState(0);

  useEffect(() => {
    const intervalId = setInterval(() => {
      setSeconds((prevSeconds) => prevSeconds + 1);
    }, 1000);

    return () => {
      clearInterval(intervalId);
    };
  }, []);

  return <p>Seconds: {seconds}</p>;
}

export default Stopwatch;
```

</details>

---

## **Exercise 4: `resize` Listener with cleanup**

Create an `WindowWidth.jsx` component that:

- Save the `window.innerWidth` value in state `width`.
- Add a listener to `window` for the `resize` event.
- Update `width` when resizing.
- Clean the listener when disassembling.

<details><summary>Show Solution</summary>

```js
import { useEffect, useState } from "react";

function WindowWidth() {
  const [width, setWidth] = useState(window.innerWidth);

  useEffect(() => {
    const handleResize = () => {
      setWidth(window.innerWidth);
    };

    window.addEventListener("resize", handleResize);

    return () => {
      window.removeEventListener("resize", handleResize);
    };
  }, []);

  return <p>Width: {width}px</p>;
}

export default WindowWidth;
```

</details>

---

## **Exercise 5: Save state to `localStorage`**

Create an `NoteSaver.jsx` component with:

- Initial `note` state `""`.
- A controlled `textarea`.
- An `useEffect` that stores `note` in `localStorage` with the key `"note"` **every time it changes**.

<details><summary>Show Solution</summary>

```js
import { useEffect, useState } from "react";

function NoteSaver() {
  const [note, setNote] = useState("");

  useEffect(() => {
    localStorage.setItem("note", note);
  }, [note]);

  return (
    <textarea
      value={note}
      onChange={(event) => setNote(event.target.value)}
      placeholder="Write a note"
    />
  );
}

export default NoteSaver;
```

</details>

---

## **Exercise 6: Read `localStorage` when mounting**

Create an `NoteLoader.jsx` component that:

- Have initial status `note` `""`.
- When mounting, read `localStorage.getItem("note")`.
- If it exists, save it to the state.
- Render an `p` with `note`.

<details><summary>Show Solution</summary>

```js
import { useEffect, useState } from "react";

function NoteLoader() {
  const [note, setNote] = useState("");

  useEffect(() => {
    const savedNote = localStorage.getItem("note");
    if (savedNote) {
      setNote(savedNote);
    }
  }, []);

  return <p>{note}</p>;
}

export default NoteLoader;
```

</details>

---

## **Exercise 7: Correct dependencies (typical bug)**

This component has a bug: the effect uses `query`, but the dependencies array is empty. Correct it.

```js
import { useEffect, useState } from "react";

function SearchLogger() {
  const [query, setQuery] = useState("");

  useEffect(() => {
    console.log("Searching:", query);
  }, []);

  return <input value={query} onChange={(e) => setQuery(e.target.value)} />;
}

export default SearchLogger;
```

<details><summary>Show Solution</summary>

```js
import { useEffect, useState } from "react";

function SearchLogger() {
  const [query, setQuery] = useState("");

  useEffect(() => {
    console.log("Searching:", query);
  }, [query]);

  return <input value={query} onChange={(e) => setQuery(e.target.value)} />;
}

export default SearchLogger;
```

</details>

---

## **Exercise 8: Avoid infinite loop (updating within the effect)**

This component enters a loop because it updates state in an `useEffect` that is executed after each render. Fix it so it only runs when mounting.

```js
import { useEffect, useState } from "react";

function InitFlag() {
  const [ready, setReady] = useState(false);

  useEffect(() => {
    setReady(true);
  });

  return <p>Ready: {ready ? "Yes" : "No"}</p>;
}

export default InitFlag;
```

<details><summary>Show Solution</summary>

```js
import { useEffect, useState } from "react";

function InitFlag() {
  const [ready, setReady] = useState(false);

  useEffect(() => {
    setReady(true);
  }, []);

  return <p>Ready: {ready ? "Yes" : "No"}</p>;
}

export default InitFlag;
```

</details>

---

## **Exercise 9: `setTimeout` with cleanup**

Create an `AutoHideMessage.jsx` component that:

- Have initial state `visible` `true`.
- Show an `p` with **"Saved"** only if `visible` is `true`.
- When mounting, program an `setTimeout` to set `visible` to `false` after 2 seconds.
- Clean the timeout in the cleanup.

<details><summary>Show Solution</summary>

```js
import { useEffect, useState } from "react";

function AutoHideMessage() {
  const [visible, setVisible] = useState(true);

  useEffect(() => {
    const timeoutId = setTimeout(() => {
      setVisible(false);
    }, 2000);

    return () => {
      clearTimeout(timeoutId);
    };
  }, []);

  return <div>{visible && <p>Saved</p>}</div>;
}

export default AutoHideMessage;
```

</details>

---

## **Exercise 10: Effect with async function (recommended pattern)**

Create an `UserLoader.jsx` component that simulates asynchronous loading:

- `status` status with values: `"idle"`, `"loading"`, `"done"`.
- When riding:

  - Put `status` in `"loading"`.
  - Wait 1 second.
  - Put `status` in `"done"`.

Hint: don't do `async` directly in the `useEffect` callback, create a function inside it.

<details><summary>Show Solution</summary>

```js
import { useEffect, useState } from "react";

function UserLoader() {
  const [status, setStatus] = useState("idle");

  useEffect(() => {
    const run = async () => {
      setStatus("loading");
      await new Promise((resolve) => setTimeout(resolve, 1000));
      setStatus("done");
    };

    run();
  }, []);

  return <p>Status: {status}</p>;
}

export default UserLoader;
```

</details>
