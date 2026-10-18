# **Topic 8: Using `git cherry-pick` to select specific commits**

## **1. Introduction**

The `git cherry-pick` command lets you apply a specific commit from one branch to another without merging the entire branch. This is useful when you need to bring individual changes into another branch without affecting its overall history.

### **Benefits of `git cherry-pick`**

- Lets you pick specific changes without merging entire branches.
- Avoids the need to manually duplicate code.
- It's useful for fixing bugs in stable branches without bringing in unwanted changes.

---

## **2. Get the commit identifier**

Before using `git cherry-pick`, you need to identify the commit you want to apply. To do this, you can run:

```bash
git log --oneline
```


This command displays a list of commits with their identifiers (hashes), for example:

```
3f4d2e5 Corrección de bug en el login
b8a1c9d Actualización de la documentación
2a7e6f3 Nueva funcionalidad de exportación
```


You'll need the commit identifier (e.g. `3f4d2e5`) for the next step.

---

## **3. Apply a specific commit with `git cherry-pick`**

Once you have the commit hash, you can apply it to the current branch with:

```bash
git cherry-pick 3f4d2e5
```


This copies the changes made in that commit and adds them to the current branch as a new commit.

---

## **4. Apply multiple commits**

If you want to bring in several commits at once, you can specify multiple hashes:

```bash
git cherry-pick 3f4d2e5 b8a1c9d
```


Or for a range of consecutive commits, from the oldest to the newest:

```bash
git cherry-pick b8a1c9d^..3f4d2e5
```


This will apply all the commits in the range, from `b8a1c9d` to `3f4d2e5`, both included. The `^` makes it include the first one too: without it, `b8a1c9d..3f4d2e5` would leave it out.

---

## **5. Resolve conflicts during a `cherry-pick`**

If the selected commit affects parts of the code that have changed in the current branch, there may be conflicts. To resolve them:

1. Git will pause the process and show the conflicted files.
2. Edit the files to resolve the conflicts.
3. Add the resolved changes with:
   ```bash
   git add archivo-afectado
   ```

4. Continue the process with:
   ```bash
   git cherry-pick --continue
   ```

   If you want to cancel the `cherry-pick` and undo the changes:

```bash
git cherry-pick --abort
```


---

## **6. Apply a commit without creating a new commit**

If you want to apply the changes from a commit without creating a new commit, you can use:

```bash
git cherry-pick -n 3f4d2e5
```


This applies the changes to the working directory without committing them, so you can make adjustments before running `git commit` manually.

---

## **7. Best practices when using `git cherry-pick`**

- Use `git log --oneline` to correctly identify commits before applying them.
- Avoid cherry-picking commits that depend on other commits, to prevent inconsistencies.
- Resolve conflicts calmly and check the changes before committing.
- Use `git cherry-pick -n` if you need to modify the changes before committing them.
- If a cherry-pick runs into an error, use `git cherry-pick --abort` to cancel the operation.

---

In the next topic, we'll explore **how to undo changes with git restore and git revert**.
