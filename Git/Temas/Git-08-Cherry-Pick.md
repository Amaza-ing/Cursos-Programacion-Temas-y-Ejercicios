# **Topic 8: Using `git cherry-pick` to select specific commits**

## **1. Introduction**

The `git cherry-pick` command allows you to apply a specific commit from one branch to another without merging the entire branch. This is useful when you need to push individual changes to another branch without affecting its overall history.

### **Benefits of `git cherry-pick`**

- Allows you to select specific changes without merging entire branches.
- Avoids the need to manually duplicate code.
- It is useful for fixing bugs in stable branches without bringing unwanted changes.

---

## **2. Get the commit identifier**

Before using `git cherry-pick`, it is necessary to identify the commit you want to apply. To do this, you can execute:

```bash
git log --oneline
```


This command displays a list of commits with their identifiers (hashes), for example:

```
3f4d2e5 Corrección de bug en el login
b8a1c9d Actualización de la documentación
2a7e6f3 Nueva funcionalidad de exportación
```


The commit identifier (e.g. `3f4d2e5`) is necessary for the next step.

---

## **3. Apply a specific commit with `git cherry-pick`**

Once the commit hash is obtained, it can be applied to the current branch with:

```bash
git cherry-pick 3f4d2e5
```


This copies the changes made in that commit and adds them to the current branch as a new commit.

---

## **4. Apply multiple commits**

If you want to bring several commits at the same time, you can specify multiple hashes:

```bash
git cherry-pick 3f4d2e5 b8a1c9d
```


Or for a range of consecutive commits:

```bash
git cherry-pick 3f4d2e5..b8a1c9d
```


This will apply all commits in the selected range.

---

## **5. Resolve conflicts during an `cherry-pick`**

If the selected commit affects parts of the code that have changed in the current branch, there may be conflicts. To solve them:

1. Git will pause the process and display the conflicting files.
2. Edit the files to resolve conflicts.
3. Add the resolved changes with:
   ```bash
   git add archivo-afectado
   ```

4. Continue the process with:
   ```bash
   git cherry-pick --continue
   ```

   If you wish to cancel the `cherry-pick` and undo the changes:

```bash
git cherry-pick --abort
```


---

## **6. Apply a commit without creating a new commit**

If you want to apply the changes from a commit but without generating a new commit, you can use:

```bash
git cherry-pick -n 3f4d2e5
```


This applies the changes to the workspace without committing them, allowing adjustments to be made before doing an `git commit` manually.

---

## **7. Good practices when using `git cherry-pick`**

- Use `git log --oneline` to correctly identify commits before applying them.
- Avoid cherry-picking commits with dependencies on other commits to prevent inconsistencies.
- Resolve conflicts calmly and verify changes before committing.
- Use `git cherry-pick -n` if you need to modify the changes before committing them.
- If a cherry-pick generates an error, use `git cherry-pick --abort` to cancel the operation.

---

In the next topic, we will explore **how to roll back changes with git restore and git revert**.
