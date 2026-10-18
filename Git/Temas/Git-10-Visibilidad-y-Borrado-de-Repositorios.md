# **Topic 10: Public vs private repositories and how to delete branches and repositories**

## **1. Introduction**

When working with Git and platforms like GitHub, GitLab or Bitbucket, it's important to know the difference between public and private repositories. Also, you'll sometimes need to delete branches or repositories when they're no longer needed.

---

## **2. Differences between public and private repositories**

### **Public repositories**

- They are accessible to anyone on the internet.
- Any user can view the source code and commit history.
- They are commonly used in open source projects and collaborations.
- They can be **forked** by other users to make contributions.

### **Private repositories**

- They can only be accessed by users with specific permissions.
- They're ideal for personal or business projects that shouldn't be public.
- They cannot be forked by other users without authorization.
- On some platforms, they require paid plans for certain teams and advanced features.

---

[![Public vs Private Repositories](https://img.youtube.com/vi/t_yOKbQkgPo/0.jpg)](https://www.youtube.com/watch?v=t_yOKbQkgPo&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **3. How to delete branches in Git**

As you work on a project, it's common to delete obsolete branches, both in the local repository and in the remote one.

### **Delete a local branch**

To delete a branch in the local repository:

```bash
git branch -d nombre-de-la-rama
```

If the branch hasn't been merged and you want to force its deletion:

```bash
git branch -D nombre-de-la-rama
```

### **Delete a remote branch**

To delete a branch in a remote repository such as GitHub:

```bash
git push origin --delete nombre-de-la-rama
```

If you're using GitHub, you can also delete it manually from the **Branches** tab in the repository's web interface.

---

[![Delete Branches](https://img.youtube.com/vi/k4DycHO3ChQ/0.jpg)](https://www.youtube.com/watch?v=k4DycHO3ChQ&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. How to delete a repository in Git**

If you no longer need a repository, you can delete it locally or remotely.

### **Delete a local repository**

To delete a repository on your local machine, simply delete the folder that contains it:

```bash
rm -rf nombre-del-repositorio
```

### **Delete a remote repository (GitHub, GitLab, etc.)**

1. Go to the repository on the platform (GitHub, GitLab, etc.).
2. Open the repository's settings (**Settings**).
3. Look for the **Delete this repository** option.
4. Confirm the deletion by following the instructions.

> **Note:** Once a repository has been deleted remotely, it can't be recovered unless you made a copy beforehand.

---

[![Delete Repositories](https://img.youtube.com/vi/_N10RGUFyBg/0.jpg)](https://www.youtube.com/watch?v=_N10RGUFyBg&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Best practices when managing repositories and branches**

- Keep repositories **public** only if you want to share the code openly.
- Use **private repositories** for projects in development or with sensitive information.
- Delete branches you no longer need to keep the repository clean.
- Before deleting a remote repository, make sure you have a backup if you need one.
- Avoid deleting active branches that other collaborators are using without warning them first.

---

In the next topic, we'll explore **what the README.md is and how to work with Markdown**.
