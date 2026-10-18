# **Topic 4: Remote repositories, `git push`, `git pull` and collaboration on GitHub**

## **1. Introduction**

Git allows you to work with **remote repositories**, which makes collaboration between multiple developers easier. Remote repositories store a copy of the project in the cloud, allowing you to share and synchronize changes with other collaborators through commands such as `git push`, `git pull` and `git fetch`.

### **Benefits of remote repositories**

- They facilitate teamwork and collaboration on projects.
- They allow you to keep backup copies of the code on remote servers.
- They make it possible to track changes and versions as a team.
- They help manage code efficiently with GitHub, GitLab or Bitbucket.

---

## **2. Add a remote repository**

To connect a local repository to a remote one, the `git remote add` command is used.

### **Example:**

```bash
git remote add origin https://github.com/usuario/nombre-del-repo.git
```

- `origin` is the default name that Git assigns to the remote repository.
- The URL indicates the location of the repository on GitHub.

To verify that the remote repository was added correctly:

```bash
git remote -v
```

---

## **3. Upload changes with `git push`**

After making changes to the local repository, they can be pushed to the remote repository with `git push`.

### **`git push` example:**

```bash
git push origin master
```

This command pushes changes from the `master` branch to the remote `origin` repository.

If it is the first time that changes are uploaded to a remote repository, you should use:

```bash
git push -u origin master
```

The `-u` option sets the default remote branch, allowing future `git push` to not require specifying `origin master`.

---

[![github & git push](https://img.youtube.com/vi/pp0aC7GvnB0/0.jpg)](https://www.youtube.com/watch?v=pp0aC7GvnB0&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Download changes with `git pull`**

When other collaborators have uploaded changes to the remote repository, it is necessary to synchronize the files with the local repository using `git pull`.

### **`git pull` example:**

```bash
git pull origin master
```

This downloads and merges the changes from the `master` branch to the local repository.

If there are conflicts, Git will request that they be resolved before continuing.

---

[![git pull](https://img.youtube.com/vi/gTU_hWaER1k/0.jpg)](https://www.youtube.com/watch?v=gTU_hWaER1k&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Get information without merging with `git fetch`**

Unlike `git pull`, the `git fetch` command only downloads changes from the remote repository without merging them into the current branch.

### **`git fetch` example:**

```bash
git fetch origin
```

This allows you to review your changes before manually integrating them with `git merge`.

---

[![git fetch](https://img.youtube.com/vi/OI9BJgjNBuo/0.jpg)](https://www.youtube.com/watch?v=OI9BJgjNBuo&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **6. Clone a repository with `git clone`**

To get a copy of a remote repository on the local machine, `git clone` is used.

### **`git clone` example:**

```bash
git clone https://github.com/usuario/nombre-del-repo.git
```

This will download all project history to a new folder with the repository name.

---

[![git clone](https://img.youtube.com/vi/keu_wKoTw4E/0.jpg)](https://www.youtube.com/watch?v=keu_wKoTw4E&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **7. Teamwork with GitHub**

GitHub allows you to collaborate on projects using various tools such as **forks**, **pull requests** and **issues**.
### **Fork and Pull Request**

- A **fork** is a copy of a repository in a personal account, which allows experimentation without affecting the original.

---

[![Fork](https://img.youtube.com/vi/-n8Wildyg8s/0.jpg)](https://www.youtube.com/watch?v=-n8Wildyg8s&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

- A **pull request (PR)** is a request to merge changes to the original repository.

---

[![Pull Request](https://img.youtube.com/vi/juBQosR7CIU/0.jpg)](https://www.youtube.com/watch?v=juBQosR7CIU&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

### **How to create a Pull Request from a Fork:**

1. Fork the repository on GitHub.
2. Clone the fork to the local machine.
3. Create a new branch and make changes.
4. Upload the changes with `git push`.
5. In GitHub, open a Pull Request towards the original repository.

## **8. Good practices in collaboration with Git**

- Keep the `master` branch always updated with `git pull` before making changes.
- Use separate branches for each new feature or fix.
- Write descriptive commit messages.
- Do code reviews on Pull Requests before merging them.
- Resolve conflicts carefully and verify before making `git push`.

---

In the next topic, we will explore **how to work with tags and releases in Git to manage code versions efficiently**.
