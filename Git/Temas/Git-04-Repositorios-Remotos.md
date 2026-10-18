# **Topic 4: Remote repositories, `git push`, `git pull` and collaboration on GitHub**

## **1. Introduction**

Git lets you work with **remote repositories**, which makes collaboration between multiple developers easier. Remote repositories store a copy of the project in the cloud, so you can share and synchronize changes with other collaborators through commands such as `git push`, `git pull` and `git fetch`.

### **Benefits of remote repositories**

- They make teamwork and collaboration on projects easier.
- They allow you to keep backup copies of the code on remote servers.
- They make it possible to track changes and versions as a team.
- They help manage code efficiently with GitHub, GitLab or Bitbucket.

---

## **2. Add a remote repository**

To connect a local repository to a remote one, you use the `git remote add` command.

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

After making changes in the local repository, you can push them to the remote repository with `git push`.

### **`git push` example:**

```bash
git push origin master
```

This command pushes changes from the `master` branch to the remote `origin` repository.

If it's the first time you're pushing changes to a remote repository, you should use:

```bash
git push -u origin master
```

The `-u` option sets the default remote branch, so future `git push` commands don't need you to specify `origin master`.

---

[![github & git push](https://img.youtube.com/vi/pp0aC7GvnB0/0.jpg)](https://www.youtube.com/watch?v=pp0aC7GvnB0&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Download changes with `git pull`**

When other collaborators have pushed changes to the remote repository, you need to synchronize the files with your local repository using `git pull`.

### **`git pull` example:**

```bash
git pull origin master
```

This downloads the changes from the `master` branch and merges them into the local repository.

If there are conflicts, Git will ask you to resolve them before continuing.

---

[![git pull](https://img.youtube.com/vi/gTU_hWaER1k/0.jpg)](https://www.youtube.com/watch?v=gTU_hWaER1k&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Get changes without merging them using `git fetch`**

Unlike `git pull`, the `git fetch` command only downloads changes from the remote repository without merging them into the current branch.

### **`git fetch` example:**

```bash
git fetch origin
```

This lets you review the changes before integrating them manually with `git merge`.

---

[![git fetch](https://img.youtube.com/vi/OI9BJgjNBuo/0.jpg)](https://www.youtube.com/watch?v=OI9BJgjNBuo&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **6. Clone a repository with `git clone`**

To get a copy of a remote repository on your local machine, you use `git clone`.

### **`git clone` example:**

```bash
git clone https://github.com/usuario/nombre-del-repo.git
```

This will download the project's entire history into a new folder named after the repository.

---

[![git clone](https://img.youtube.com/vi/keu_wKoTw4E/0.jpg)](https://www.youtube.com/watch?v=keu_wKoTw4E&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **7. Working as a team with GitHub**

GitHub lets you collaborate on projects through various tools, such as **forks**, **pull requests** and **issues**.
### **Fork and pull request**

- A **fork** is a copy of a repository in your personal account, which lets you experiment without affecting the original.

---

[![Fork](https://img.youtube.com/vi/-n8Wildyg8s/0.jpg)](https://www.youtube.com/watch?v=-n8Wildyg8s&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

- A **pull request (PR)** is a request to merge changes into the original repository.

---

[![Pull Request](https://img.youtube.com/vi/juBQosR7CIU/0.jpg)](https://www.youtube.com/watch?v=juBQosR7CIU&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

### **How to create a pull request from a fork:**

1. Fork the repository on GitHub.
2. Clone the fork to your local machine.
3. Create a new branch and make changes.
4. Push the changes with `git push`.
5. On GitHub, open a pull request to the original repository.

## **8. Best practices for collaborating with Git**

- Always keep the `master` branch up to date with `git pull` before making changes.
- Use separate branches for each new feature or fix.
- Write descriptive commit messages.
- Do code reviews on pull requests before merging them.
- Resolve conflicts carefully and double-check before running `git push`.

---

In the next topic, we'll explore **how to work with tags and releases in Git to manage code versions efficiently**.
