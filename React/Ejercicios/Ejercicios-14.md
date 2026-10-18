# **Exercises - Topic 14: useEffect()**

Below you will find **10 practical exercises** on `useEffect()`.

Try to solve them before looking at the solution.

---

## **Exercise 1: Effect on mount (only once)**

Create a `MountLogger.jsx` component that, when mounted, displays in the console:

- **"Component mounted"**

It must run **only once**.

<details><summary>Show solution</summary>

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

## **Exercise 2: Effect when a variable changes**

Create a `TitleWatcher.jsx` component with:

- A `title` state with initial value `""`.
- A controlled input.
- A `useEffect` that shows in the console: **"Title changed"** every time `title` changes.

<details><summary>Show solution</summary>

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

Create a `Stopwatch.jsx` component that:

- Has a `seconds` state with initial value `0`.
- Uses a `setInterval` to increment `seconds` every second.
- Clears the interval when the component unmounts.

<details><summary>Show solution</summary>

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

## **Exercise 4: `resize` listener with cleanup**

Create a `WindowWidth.jsx` component that:

- Stores the `window.innerWidth` value in a `width` state.
- Adds a listener to `window` for the `resize` event.
- Updates `width` when the window is resized.
- Removes the listener when it unmounts.

<details><summary>Show solution</summary>

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

Create a `NoteSaver.jsx` component with:

- A `note` state with initial value `""`.
- A controlled `textarea`.
- A `useEffect` that stores `note` in `localStorage` with the key `"note"` **every time it changes**.

<details><summary>Show solution</summary>

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

## **Exercise 6: Read `localStorage` on mount**

Create a `NoteLoader.jsx` component that:

- Has a `note` state with initial value `""`.
- On mount, reads `localStorage.getItem("note")`.
- If it exists, stores it in the state.
- Renders a `p` with `note`.

<details><summary>Show solution</summary>

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

## **Exercise 7: Fix the dependencies (typical bug)**

This component has a bug: the effect uses `query`, but the dependency array is empty. Fix it.

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

<details><summary>Show solution</summary>

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

## **Exercise 8: Avoid an infinite loop (updating inside the effect)**

This component gets stuck in a loop because it updates state in a `useEffect` that runs after every render. Fix it so it only runs on mount.

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

<details><summary>Show solution</summary>

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

- Has a `visible` state with initial value `true`.
- Shows a `p` with **"Saved"** only if `visible` is `true`.
- On mount, schedules a `setTimeout` that sets `visible` to `false` after 2 seconds.
- Clears the timeout in the cleanup.

<details><summary>Show solution</summary>

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

## **Exercise 10: Effect with an async function (recommended pattern)**

Create a `UserLoader.jsx` component that simulates asynchronous loading:

- A `status` state with the values: `"idle"`, `"loading"`, `"done"`.
- On mount:

  - Set `status` to `"loading"`.
  - Wait 1 second.
  - Set `status` to `"done"`.

Hint: don't make the `useEffect` callback itself `async`; create a function inside it.

<details><summary>Show solution</summary>

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
