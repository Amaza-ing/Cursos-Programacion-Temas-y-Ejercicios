# **Topic 3: Branches in Git - Creating, merging and conflict resolution**

## **1. Introduction**

Branches (**branches**) in Git allow you to work on different versions of a project without affecting the main branch. This makes it easier to collaborate, develop new features, and fix bugs without disturbing stable code.

### **Benefits of using branches in Git**

- They allow you to work on new features without affecting the stable version.
- They facilitate collaboration between developers.
- They help maintain an organized change history.
- They allow you to manage different versions of a project efficiently.

---

## **2. Creation and management of branches**

### **List available branches**

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


Another more modern option is to use:

```bash
git switch nombre-de-la-rama
```


This moves the job to the indicated branch.

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

## **3. Merge branches (Merge)**

To merge changes from one branch to another, use the `merge` command.

### **Steps to merge a branch into `master`**

1. Switch to main branch:
   ```bash
   git checkout master  # O bien: git switch master
   ```

2. Download the latest changes from the remote repository:
   ```bash
   git pull origin master
   ```

3. Merge the child branch:
   ```bash
   git merge nombre-de-la-rama
   ```

4. Delete branch after merge:
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

### **Pull Request to merge a branch to Github**

Another way to push changes to a branch is to make a Pull Request on Github. This is especially useful in collaborative environments, where your colleagues need to see the changes that have been made before merging branches.

---

[![Pull Request](https://img.youtube.com/vi/juBQosR7CIU/0.jpg)](https://www.youtube.com/watch?v=juBQosR7CIU&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Conflict management in Git**

During a merge (`merge`), conflicts can arise if two branches have modified the same part of a file.

### **How to resolve a conflict in Git**

1. Git will flag conflicting files.
   ```bash
   git status
   ```

2. Edit the affected files, looking for the sections marked by `<<<<<<<`, `=======` and `>>>>>>>`.
3. Keep the code correct and remove conflict flags.
4. Add the corrected files to the staging area:
   ```bash
   git add archivo-afectado
   ```

5. Finalize the merger with a commit:
   ```bash
   git commit -m "Resolviendo conflicto en archivo-afectado"
   ```


To avoid conflicts, it is recommended to make `git pull` before making changes and coordinate with the development team.

---

[![Resolve Conflicts](https://img.youtube.com/vi/G2NjhA_ofck/0.jpg)](https://www.youtube.com/watch?v=G2NjhA_ofck&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Rebase: Alternative to Merge**

Another way to integrate changes between branches is by using `rebase`. Instead of creating a merge commit, `rebase` rewrites the history.

```bash
git checkout nombre-de-la-rama
git rebase master
```

This moves the `nombre-de-la-rama` commits over the most recent version of `master`.

To resolve conflicts during an `rebase`, correct the files and continue with:

```bash
git rebase --continue
```


If it is necessary to cancel the process:

```bash
git rebase --abort
```


---

[![Rebase](https://img.youtube.com/vi/UpRMbhWjqHc/0.jpg)](https://www.youtube.com/watch?v=UpRMbhWjqHc&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **6. Good practices with branches in Git**

- Use **descriptive names** for branches (e.g. `feature/nueva-funcionalidad`, `bugfix/error-login`).
- Keep the `master` branch always stable and bug-free.
- Update the `master` branch before starting a new branch with `git pull origin master`.
- Remove obsolete branches to keep the repository clean.
- Resolve conflicts calmly and review well before committing changes.

---

In the next topic, we will learn about **remote repositories, `git push`, `git pull` and collaboration on GitHub**.
