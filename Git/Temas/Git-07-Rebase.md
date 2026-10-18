# **Topic 7: Using `git rebase` for a clean and organized commit history**

## **1. Introduction**

The `git rebase` command allows you to rewrite the commit history to keep it cleaner and more linear. It is used to reorganize, modify or combine commits, avoiding unnecessary branches and facilitating code review.

### **Benefits of `git rebase`**

- Maintains a cleaner and easier to understand history.
- Avoid unnecessary merges when integrating changes from a main branch.
- Allows you to modify previous commits without affecting the content of the code.

---

## **2. Types of `rebase` in Git**

### **2.1. Interactive rebase**

Allows you to modify specific commits, reorder them, combine them or delete them.

```bash
git rebase -i HEAD~3
```


This command opens a text editor with the last 3 commits listed, where changes can be applied such as:

- `pick` → Keep the commit.
- `reword` → Modify the commit message.
- `edit` → Change the content of the commit.
- `squash` → Combine several commits into one.
- `drop` → Delete a commit.

### **2.2. Removing one branch over another**

Used to update one branch with changes from another without creating a merge commit.

```bash
git checkout master
git rebase feature-branch
```


This moves all `feature-branch` commits onto the most recent version of `master`.

---

## **3. Resolve conflicts during a rebase**

If there are conflicts, Git will pause the process to allow them to be resolved.

1. Identify files in conflict with:
   ```bash
   git status
   ```

2. Edit the files and resolve conflicts manually.
3. Add the resolved changes:
   ```bash
   git add archivo-resuelto
   ```

4. Continue rebasing:
   ```bash
   git rebase --continue
   ```

5. If it is necessary to cancel the process:
   ```bash
   git rebase --abort
   ```


---

## **4. Differences between `git rebase` and `git merge`**

| Command | Description |
| ------------ | ----------------------------------------------------------------------- |
| `git merge` | Merge branches, creating additional commits for the merged changes. |
| `git rebase` | Move commits from one branch to another, maintaining a linear history.  |

---

[![git rebase](https://img.youtube.com/vi/UpRMbhWjqHc/0.jpg)](https://www.youtube.com/watch?v=UpRMbhWjqHc&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Using `git rebase` with `git pull`**

To avoid unnecessary merge commits when updating the current branch, you can use:

```bash
git pull --rebase origin master
```


This downloads remote changes and applies them before local commits.

---

## **6. Good practices when using `git rebase`**

- Use `git rebase -i` to clear history before pushing commits to a remote repository.
- Avoid `git rebase` in shared branches to avoid rewriting the history of other collaborators.
- Always make a backup (`git branch backup`) before a major rebase.
- Use `git rebase --continue` and `git rebase --abort` carefully to handle errors without losing work.

---

In the next topic, we will explore **how to work with `git cherry-pick` to select specific commits and apply them to other branches**.
