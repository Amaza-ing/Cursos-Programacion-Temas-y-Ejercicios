# **Topic 9: Undoing changes with `git restore` and `git revert`**

## **1. Introduction**

In Git, you sometimes need to undo unwanted changes to files or to the commit history. There are two key commands for this:

- `git restore`: Used to discard changes to files without affecting the commit history.
- `git revert`: Used to undo a specific commit without modifying the history, creating a new commit that reverses the previous changes.

---

## **2. Use `git restore` to discard changes to files**

The `git restore` command lets you undo changes to files without altering the repository's history.

### **Discard changes to a file before committing**

```bash
git restore archivo.txt
```

This restores `archivo.txt` to its last committed version in Git.

### **Discard changes to all modified files**

```bash
git restore .
```

This discards any uncommitted changes in the working directory.

### **Restore a file from the staging area**

If you've added a file with `git add` but haven't committed it yet, you can remove it from the staging area with:

```bash
git restore --staged archivo.txt
```

This keeps the changes in the working directory but removes them from the staging area.

---

[![git status & git restore](https://img.youtube.com/vi/mf_wzDC9ouQ/0.jpg)](https://www.youtube.com/watch?v=mf_wzDC9ouQ&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **3. Use `git revert` to undo a commit**

Unlike `git restore`, the `git revert` command creates a new commit that reverses the changes from a previous commit, keeping the history intact.

### **Revert a specific commit**

To undo a commit without losing its history:

```bash
git revert <commit-hash>
```

Example:

```bash
git revert a1b2c3d
```

This will create a new commit that reverts the changes from `a1b2c3d`.

### **Revert multiple commits**

You can revert multiple commits, from the most recent one back to a specific point:

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
| `git restore` | Undoes changes in the working directory without affecting commits.                           |
| `git revert` | Creates a new commit that reverts a previous commit.                                  |
| `git reset` | Moves the branch reference to a previous commit, removing later commits. |

> **Note:** `git reset` is more aggressive and may rewrite history, so it's best to use `git revert` in collaborative environments.

---

## **5. Best practices when undoing changes**

- Use `git restore` to discard local changes without altering previous commits.
- Use `git revert` to undo commits without losing history.
- Avoid `git reset` in shared repositories, as it can rewrite the history and cause problems for other collaborators.
- Check the history with `git log --oneline` before doing a `revert`.

---
In the next topic, we'll see **the difference between public and private repositories and how to delete branches and repositories locally and remotely**.
