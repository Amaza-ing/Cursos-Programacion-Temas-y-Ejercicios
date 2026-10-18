# **Topic 9: Reverse changes with `git restore` and `git revert`**

## **1. Introduction**

In Git, it is sometimes necessary to undo unwanted changes to files or commit history. To do this, there are two key commands:

- `git restore`: Used to discard changes to files without affecting the commit history.
- `git revert`: Used to undo a specific commit without modifying the history, creating a new commit that overrides previous changes.

---

## **2. Use `git restore` to discard file changes**

The `git restore` command allows you to undo changes to files without altering the repository history.

### **Discard changes to a file before committing**

```bash
git restore archivo.txt
```

This reverts `archivo.txt` to its latest committed version in Git.

### **Discard changes to all modified files**

```bash
git restore .
```

This removes any uncommitted changes to the workspace.

### **Restore a file from the staging area**

If a file has been added with `git add` but has not yet been committed, it can be removed from the staging area with:

```bash
git restore --staged archivo.txt
```

This keeps the changes in the work area but removes them from the staging area.

---

[![git status & git restore](https://img.youtube.com/vi/mf_wzDC9ouQ/0.jpg)](https://www.youtube.com/watch?v=mf_wzDC9ouQ&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **3. Use `git revert` to undo a commit**

Unlike `git restore`, the `git revert` command creates a new commit that overrides changes from a previous commit, keeping the history intact.

### **Revert a specific commit**

To undo a commit without losing its history:

```bash
git revert <commit-hash>
```

Example:

```bash
git revert a1b2c3d
```

This will create a new commit that reverts the `a1b2c3d` changes.

### **Revert multiple commits**

Multiple commits can be reverted from the most recent to a specific point:

```bash
git revert HEAD~2..HEAD
```

This reverts the last two commits.

---

[![git revert](https://img.youtube.com/vi/TPnX7_nXkfw/0.jpg)](https://www.youtube.com/watch?v=TPnX7_nXkfw&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Differences between `git restore`, `git revert` and `git reset`**

| Command | Description |
| ------------- | ------------------------------------------------------------------------------------ |
| `git restore` | Undoes changes in the workspace without affecting commits.                           |
| `git revert` | Creates a new commit that reverts a previous commit.                                  |
| `git reset` | Moves the branch reference to a previous commit, removing later commits. |

> **Note:** `git reset` is more aggressive and may rewrite history, so it is recommended to use `git revert` in collaborative environments.

---

## **5. Best practices when undoing changes**

- Use `git restore` to discard local changes without altering previous commits.
- Use `git revert` to undo commits without losing history.
- Avoid `git reset` in shared repositories, as it can rewrite the history and cause problems for other collaborators.
- Check the history before making an `revert` with `git log --oneline`.

---
In the next topic, we will see **what is the difference between public and private repositories and how to delete branches and repositories locally and remotely**.
