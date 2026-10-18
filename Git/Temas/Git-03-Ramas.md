# **Topic 3: Branches in Git - Creating, merging and conflict resolution**

## **1. Introduction**

**Branches** in Git let you work on different versions of a project without affecting the main branch. This makes it easier to collaborate, develop new features and fix bugs without touching the stable code.

### **Benefits of using branches in Git**

- They allow you to work on new features without affecting the stable version.
- They make collaboration between developers easier.
- They help keep the change history organized.
- They allow you to manage different versions of a project efficiently.

---

## **2. Creating and managing branches**

### **List the available branches**

```bash
git branch
```


This command shows all branches in the local repository.

### **Create a new branch**

```bash
git branch nombre-de-la-rama
```


This creates a new branch based on the current branch.

### **Switch to a specific branch**

```bash
git checkout nombre-de-la-rama
```


A more modern option is to use:

```bash
git switch nombre-de-la-rama
```


This moves your work to the given branch.

### **Create and switch to a new branch in one step**

```bash
git checkout -b nombre-de-la-rama
```


Or with the new command:

```bash
git switch -c nombre-de-la-rama
```


---

[![Branches](https://img.youtube.com/vi/VgSUKBJE16Q/0.jpg)](https://www.youtube.com/watch?v=VgSUKBJE16Q&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **3. Merging branches (merge)**

To merge the changes from one branch into another, you use the `merge` command.

### **Steps to merge a branch into `master`**

1. Switch to the main branch:
   ```bash
   git checkout master  # O bien: git switch master
   ```

2. Download the latest changes from the remote repository:
   ```bash
   git pull origin master
   ```

3. Merge the secondary branch:
   ```bash
   git merge nombre-de-la-rama
   ```

4. Delete the branch after the merge:
   ```bash
   git branch -d nombre-de-la-rama
   ```


If the branch has been pushed to a remote repository and you want to delete it there as well:

```bash
git push origin --delete nombre-de-la-rama
```


---

[![Merge Branches - git merge](https://img.youtube.com/vi/vtT6gb1tpz8/0.jpg)](https://www.youtube.com/watch?v=vtT6gb1tpz8&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

### **Pull request to merge a branch on GitHub**

Another way to bring changes into a branch is to open a pull request on GitHub. This is especially useful in collaborative environments, where your teammates need to see the changes that have been made before the branches are merged.

---

[![Pull Request](https://img.youtube.com/vi/juBQosR7CIU/0.jpg)](https://www.youtube.com/watch?v=juBQosR7CIU&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Handling conflicts in Git**

During a merge (`merge`), conflicts can arise if two branches have modified the same part of a file.

### **How to resolve a conflict in Git**

1. Git will mark the files that have conflicts.
   ```bash
   git status
   ```

2. Edit the affected files, looking for the sections marked with `<<<<<<<`, `=======` and `>>>>>>>`.
3. Keep the correct code and remove the conflict markers.
4. Add the corrected files to the staging area:
   ```bash
   git add archivo-afectado
   ```

5. Complete the merge with a commit:
   ```bash
   git commit -m "Resolviendo conflicto en archivo-afectado"
   ```


To avoid conflicts, it's a good idea to run `git pull` before making changes and to coordinate with the development team.

---

[![Resolve Conflicts](https://img.youtube.com/vi/G2NjhA_ofck/0.jpg)](https://www.youtube.com/watch?v=G2NjhA_ofck&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Rebase: an alternative to merge**

Another way to integrate changes between branches is by using `rebase`. Instead of creating a merge commit, `rebase` rewrites the history.

```bash
git checkout nombre-de-la-rama
git rebase master
```

This moves the commits of `nombre-de-la-rama` on top of the latest version of `master`.

To resolve conflicts during a `rebase`, fix the files and continue with:

```bash
git rebase --continue
```


If you need to cancel the process:

```bash
git rebase --abort
```


---

[![Rebase](https://img.youtube.com/vi/UpRMbhWjqHc/0.jpg)](https://www.youtube.com/watch?v=UpRMbhWjqHc&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **6. Best practices with branches in Git**

- Use **descriptive names** for branches (e.g. `feature/nueva-funcionalidad`, `bugfix/error-login`).
- Keep the `master` branch always stable and bug-free.
- Update the `master` branch with `git pull origin master` before starting a new branch.
- Delete obsolete branches to keep the repository clean.
- Resolve conflicts calmly and review carefully before committing changes.

---

In the next topic, we'll learn about **remote repositories, `git push`, `git pull` and collaboration on GitHub**.
