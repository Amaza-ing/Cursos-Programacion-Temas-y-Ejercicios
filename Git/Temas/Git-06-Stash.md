# **Topic 6: Using `git stash` to manage temporary changes**

## **1. Introduction**

During development, it is common to make changes to the code before it is ready for a commit. However, sometimes it is necessary to switch branches or update code without losing work in progress. In these cases, Git provides the `git stash` command to temporarily save the changes without committing them.

### **Benefits of `git stash`**

- Allows you to save changes temporarily without the need for a commit.
- Facilitates switching between branches without losing uncommitted modifications.
- Avoid creating unnecessary commits in the history of the repository.

---

## **2. Save changes with `git stash`**

To store the current changes to the `stash` stack:

```bash
git stash
```

This saves the modified files and restores them to the last clean commit.

If you want to add a description to remember the saved changes:

```bash
git stash push -m "Descripción de los cambios"
```

To check the list of stored stashes:

```bash
git stash list
```

Output example:

```
stash@{0}: On master: Corrección de bug en la API
stash@{1}: On master: Inicio de nueva funcionalidad
```

---

## **3. Recover changes from `git stash`**

### **Apply last saved changes**

```bash
git stash apply
```

This recovers the changes from the last `stash`, but does not remove them from the list.

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

If an `stash` is no longer needed, it can be removed with:

```bash
git stash drop stash@{0}
```

To delete all stored stashes:

```bash
git stash clear
```

> **Note:** This operation cannot be undone.

---

## **5. Create a new branch from an `stash`**

If your saved changes need a new branch:

```bash
git stash branch nueva-rama stash@{0}
```

This creates `nueva-rama` with the changes stored in `stash@{0}` and automatically switches to this new branch.

---

## **6. Good practices when using `git stash`**

- Use `git stash push -m "Descripción"` to document saved changes.
- Before applying an `stash`, verify its content with `git stash show -p`.
- Avoid accumulating too many `stash` without managing them properly.
- Use `git stash pop` only if you are sure that the changes applied will not generate conflicts.

---

In the next topic, we will explore **how to use `git rebase` to maintain a clean and organized commit history**.
