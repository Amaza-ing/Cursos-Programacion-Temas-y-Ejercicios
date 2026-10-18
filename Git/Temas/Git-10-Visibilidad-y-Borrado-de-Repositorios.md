# **Topic 10: Public vs private repositories and how to delete branches and repositories**

## **1. Introduction**

When working with Git and platforms like GitHub, GitLab or Bitbucket, it is important to know the difference between public and private repositories. Additionally, it is sometimes necessary to delete branches or repositories when they are no longer needed.

---

## **2. Differences between public and private repositories**

### **Public repositories**

- They are accessible to anyone on the internet.
- Any user can view the source code and commit history.
- They are commonly used in open source projects and collaborations.
- They can be forked by other users to make contributions.

### **Private repositories**

- They can only be accessed by users with specific permissions.
- Ideal for personal or business projects that should not be public.
- They cannot be forked by other users without authorization.
- Require payment plans on some platforms for certain equipment and advanced functionalities.

---

[![Public vs Private Repositories](https://img.youtube.com/vi/t_yOKbQkgPo/0.jpg)](https://www.youtube.com/watch?v=t_yOKbQkgPo&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **3. How to delete branches in Git**

As you work on a project, it is common to delete obsolete branches, both in the local and remote repository.

### **Delete a local branch**

To delete a branch in the local repository:

```bash
git branch -d nombre-de-la-rama
```

If the branch has not been merged and you want to force its removal:

```bash
git branch -D nombre-de-la-rama
```

### **Delete a remote branch**

To delete a branch in a remote repository such as GitHub:

```bash
git push origin --delete nombre-de-la-rama
```

If using GitHub, it can also be removed manually from the **Branches** tab in the repository web interface.

---

[![Delete Branches](https://img.youtube.com/vi/k4DycHO3ChQ/0.jpg)](https://www.youtube.com/watch?v=k4DycHO3ChQ&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. How to delete a repository in Git**

If a repository is no longer needed, it can be deleted locally or remotely.

### **Delete a local repository**

To delete a repository on the local machine, simply delete the folder containing the repository:

```bash
rm -rf nombre-del-repositorio
```

### **Delete a remote repository (GitHub, GitLab, etc.)**

1. Go to the repository on the platform (GitHub, GitLab, etc.).
2. Navigate to the repository settings (**Settings**).
3. Look for the **Delete this repository** option.
4. Confirm the deletion by following the instructions.

> **Note:** Once a repository is deleted remotely, it cannot be recovered unless a previous copy has been made.

---

[![Delete Repositories](https://img.youtube.com/vi/_N10RGUFyBg/0.jpg)](https://www.youtube.com/watch?v=_N10RGUFyBg&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Good practices when managing repositories and branches**

- Keep repositories **public** only if you want to share the code openly.
- Use **private repositories** for projects in development or with sensitive information.
- Delete branches that are no longer necessary to maintain a clean repository.
- Before deleting a remote repository, make sure to make a backup if necessary.
- Avoid deleting active branches in use by other collaborators without prior notice.

---

In the next topic, we will explore **What is the README.md and how to work with markdown**.
