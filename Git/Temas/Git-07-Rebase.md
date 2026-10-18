# **Topic 7: Using `git rebase` for a clean and organized commit history**

## **1. Introduction**

The `git rebase` command lets you rewrite the commit history to keep it cleaner and more linear. It's used to reorganize, modify or combine commits, avoiding unnecessary branches and making code review easier.

### **Benefits of `git rebase`**

- Keeps the history cleaner and easier to understand.
- Avoids unnecessary merges when integrating changes from a main branch.
- Lets you modify previous commits without affecting the content of the code.

---

## **2. Types of `rebase` in Git**

### **2.1. Interactive rebase**

It lets you modify specific commits, reorder them, combine them or delete them.

```bash
git rebase -i HEAD~3
```


This command opens a text editor listing the last 3 commits, where you can apply changes such as:

- `pick` → Keep the commit.
- `reword` → Modify the commit message.
- `edit` → Change the content of the commit.
- `squash` → Combine several commits into one.
- `drop` → Delete a commit.

### **2.2. Rebasing one branch onto another**

It's used to update a branch with the changes from another one without creating a merge commit.

```bash
git checkout master
git rebase feature-branch
```


This moves all the commits of `feature-branch` onto the latest version of `master`.

---

## **3. Resolve conflicts during a rebase**

If there are conflicts, Git will pause the process so you can resolve them.

1. Identify the conflicted files with:
   ```bash
   git status
   ```

2. Edit the files and resolve the conflicts manually.
3. Add the resolved changes:
   ```bash
   git add archivo-resuelto
   ```

4. Continue the rebase:
   ```bash
   git rebase --continue
   ```

5. If you need to cancel the process:
   ```bash
   git rebase --abort
   ```


---

## **4. Differences between `git rebase` and `git merge`**

| Command | Description |
| ------------ | ----------------------------------------------------------------------- |
| `git merge` | Merges branches, creating additional commits for the combined changes. |
| `git rebase` | Moves commits from one branch onto another, keeping a linear history.  |

---

[![git rebase](https://img.youtube.com/vi/UpRMbhWjqHc/0.jpg)](https://www.youtube.com/watch?v=UpRMbhWjqHc&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Using `git rebase` with `git pull`**

To avoid unnecessary merge commits when updating the current branch, you can use:

```bash
git pull --rebase origin master
```


This downloads the remote changes and applies them before your local commits.

---

## **6. Best practices when using `git rebase`**

- Use `git rebase -i` to clean up the history before pushing commits to a remote repository.
- Avoid `git rebase` on shared branches so you don't rewrite other collaborators' history.
- Always make a backup (`git branch backup`) before a major rebase.
- Use `git rebase --continue` and `git rebase --abort` carefully to handle errors without losing work.

---

In the next topic, we'll explore **how to work with `git cherry-pick` to select specific commits and apply them to other branches**.
