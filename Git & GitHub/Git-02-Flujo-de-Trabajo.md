# **Tema 2: Flujo de trabajo en Git**

## **1. Introducción**

Git sigue un flujo de trabajo basado en la gestión de cambios mediante **commits**, **ramas** y **repositorios remotos**. Comprender este flujo es fundamental para aprovechar al máximo las capacidades del sistema de control de versiones.

### **Conceptos clave**

- **Área de trabajo**: Directorio donde se encuentran los archivos editables del proyecto.
- **Área de preparación (staging area)**: Espacio donde se almacenan los cambios antes de ser confirmados.
- **Commit**: Punto de control del repositorio.
- **Repositorio local**: Historial de cambios almacenado en la máquina del usuario.
- **Repositorio remoto**: Copia del proyecto en un servidor, como GitHub, GitLab o Bitbucket.

---

## **2. Flujo básico de Git**

Un flujo de trabajo típico en Git sigue estos pasos:

1. **Modificar archivos** en el directorio de trabajo.
2. **Añadir cambios** al área de preparación (`git add`).
3. **Confirmar los cambios** en el historial (`git commit`).
4. **Enviar los cambios al repositorio remoto** (`git push`).
5. **Descargar cambios del repositorio remoto** (`git pull`).

### **Diagrama del flujo de trabajo**

```
[Modificación] → git add → [Staging Area] → git commit → [Repositorio Local] → git push → [Repositorio Remoto]
```

---

## **3. Comandos fundamentales del flujo de trabajo**

| Comando                   | Descripción                                                    |
| ------------------------- | -------------------------------------------------------------- |
| `git status`              | Muestra el estado actual del repositorio.                      |
| `git add <archivo>`       | Añade un archivo específico al área de preparación.            |
| `git add .`               | Añade todos los archivos modificados al área de preparación.   |
| `git commit -m "mensaje"` | Guarda los cambios en el historial con un mensaje descriptivo. |
| `git log`                 | Muestra el historial de commits del repositorio.               |
| `git pull`                | Descarga y fusiona cambios desde el repositorio remoto.        |
| `git push`                | Sube los cambios locales al repositorio remoto.                |

---

## **4. Ejemplo de flujo de trabajo**

Si quieres subir tus cambios a un repositorio remoto como github, necesitas crearte una cuenta y vincularla con tu ordenador.



### **1. Crear y modificar archivos**

- Crea una carpeta. Ej: `mi_proyecto`.
- Añade algún fichero. Ej: `archivo.txt`.
- Haz cambios en el fichero y abre una terminal.

### **2. Iniciar un repositorio y realizar el primer commit**

```bash
git init
git add archivo.txt
git commit -m "Primer commit"
```

### **3. Subir los cambios a GitHub**

```bash
git remote add origin https://github.com/usuario/mi_proyecto.git
git branch -M master
git push -u origin master
```

---

[![github & git push](https://img.youtube.com/vi/pp0aC7GvnB0/0.jpg)](https://www.youtube.com/watch?v=pp0aC7GvnB0&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Buenas prácticas en el flujo de trabajo de Git**

- Realizar **commits pequeños y frecuentes** para facilitar el seguimiento de cambios.
- Escribir mensajes de commit **claros y descriptivos**.
- Evitar hacer `git commit -m "Cambios"`, ya que no es informativo.
- Utilizar **ramas** para desarrollar nuevas funcionalidades sin afectar la rama principal.
- Sincronizar cambios con `git pull` antes de hacer `git push` para evitar conflictos.
- Añadir un archivo `.gitignore` para evitar subir archivos innecesarios.

---

En el próximo tema, aprenderemos sobre **ramas en Git**, cómo crearlas, fusionarlas y gestionar conflictos de manera eficiente.
