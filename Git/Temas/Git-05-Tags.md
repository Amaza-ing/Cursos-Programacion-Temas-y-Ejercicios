# **Topic 5: Using tags and releases in Git**

## **1. Introduction**

In Git, **tags** let you mark specific points in the project's history, such as stable versions or major releases. Tags are useful for identifying specific versions of the code without disrupting the development workflow.

Additionally, on platforms like **GitHub**, tags can be used to create **releases**, making it easier to distribute and document software versions.

### **Benefits of using tags and releases**

- They make version control of the code easier.
- They let you mark important milestones in development.
- They make it easier to create stable versions for production.
- They help collaborators and users find specific versions.

---

## **2. Create tags in Git**

There are two types of tags in Git:

- **Lightweight tags**: They're simply references to specific commits.
- **Annotated tags**: They include metadata such as the author, the date and a descriptive message.

### **2.1. Create a lightweight tag**

```bash
git tag nombre-de-la-etiqueta
```

This command creates a tag with no additional information on the current commit.

### **2.2. Create an annotated tag**

```bash
git tag -a v1.0 -m "Versión 1.0 estable"
```

This creates a tag with the message "Versión 1.0 estable" and associates it with the current commit.

---

## **3. List and manage tags**

To view all the tags created in the repository:

```bash
git tag
```

To view detailed information about an annotated tag:

```bash
git show v1.0
```

To delete a local tag:

```bash
git tag -d nombre-de-la-etiqueta
```

To delete a tag from the remote repository:

```bash
git push origin --delete nombre-de-la-etiqueta
```

---

## **4. Publish tags to a remote repository**

Tags created locally aren't pushed to the remote repository automatically. To push one:

```bash
git push origin nombre-de-la-etiqueta
```

To push all the tags you've created:

```bash
git push --tags
```

---

## **5. Create releases on GitHub**

On GitHub, you can use tags to generate **releases**, which provide compressed files (`.zip`, `.tar.gz`) with the source code and documentation.

### **Steps to create a release on GitHub:**

1. Go to the repository on GitHub.
2. Navigate to the **Releases** tab.
3. Click **Draft a new release**.
4. Select an existing tag or create a new one.
5. Add a release title and description.
6. Attach files if necessary.
7. Publish the release.

---

## **6. Use tags to roll back to a specific version**

If you need to go back to a tagged version:

```bash
git checkout nombre-de-la-etiqueta
```

To create a new branch from a tag:

```bash
git checkout -b nueva-rama nombre-de-la-etiqueta
```

---

## **7. Best practices when using tags and releases**

- Use a clear versioning scheme (e.g. `v1.0`, `v1.1`, `v2.0`).
- Use annotated tags instead of lightweight tags to keep better documentation.
- Publish tags to the remote repository to make previous versions easier to access.
- Create releases with clear descriptions on GitHub to improve code distribution.
- Avoid deleting tags unless it's absolutely necessary.

---
In the next topic, we'll explore **how to work with `git stash` to manage temporary changes without affecting the current branch**.
