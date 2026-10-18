# **Topic 6: Using `git stash` to manage temporary changes**

## **1. Introduction**

During development, it's common to make changes to the code before you're ready to commit. However, sometimes you need to switch branches or update the code without losing your work in progress. In these cases, Git provides the `git stash` command to save your changes temporarily without committing them.

### **Benefits of `git stash`**

- Lets you save changes temporarily without needing a commit.
- Makes it easier to switch branches without losing uncommitted changes.
- Avoids creating unnecessary commits in the repository's history.

---

## **2. Save changes with `git stash`**

To store the current changes on the `stash` stack:

```bash
git stash
```

This saves the modified files and returns them to the state of the last clean commit.

If you want to add a description to remember the saved changes:

```bash
git stash push -m "Descripción de los cambios"
```

To check the list of stored stashes:

```bash
git stash list
```

Example output:

```
stash@{0}: On master: Corrección de bug en la API
stash@{1}: On master: Inicio de nueva funcionalidad
```

---

## **3. Recover changes from `git stash`**

### **Apply the last saved changes**

```bash
git stash apply
```

This recovers the changes from the last `stash`, but doesn't remove them from the list.

To apply a specific `stash`:

```bash
git stash apply stash@{1}
```

### **Apply and remove a stash**

If you want to recover the changes and remove them from the list automatically:

```bash
git stash pop
```

This is equivalent to `apply` followed by `drop`.

---

[![git stash](https://img.youtube.com/vi/_28_dZxpPQg/0.jpg)](https://www.youtube.com/watch?v=_28_dZxpPQg&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Delete a specific `stash` or all saved ones**

If you no longer need a `stash`, you can delete it with:

```bash
git stash drop stash@{0}
```

To delete all stored stashes:

```bash
git stash clear
```

> **Note:** This operation cannot be undone.

---

## **5. Create a new branch from a `stash`**

If your saved changes need a new branch:

```bash
git stash branch nueva-rama stash@{0}
```

This creates `nueva-rama` with the changes stored in `stash@{0}` and automatically switches to this new branch.

---

## **6. Best practices when using `git stash`**

- Use `git stash push -m "Descripción"` to document the saved changes.
- Before applying a `stash`, check its contents with `git stash show -p`.
- Avoid piling up too many `stash` entries without managing them properly.
- Only use `git stash pop` if you're sure the applied changes won't cause conflicts.

---

In the next topic, we'll explore **how to use `git rebase` to keep a clean and organized commit history**.
