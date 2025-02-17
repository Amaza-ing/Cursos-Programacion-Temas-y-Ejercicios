# **Tema 10: Repositorios públicos vs privados y cómo borrar ramas y repositorios**

## **1. Introducción**
Al trabajar con Git y plataformas como GitHub, GitLab o Bitbucket, es importante conocer la diferencia entre repositorios públicos y privados. Además, en ocasiones es necesario eliminar ramas o repositorios cuando ya no se necesitan.

---

## **2. Diferencias entre repositorios públicos y privados**
### **Repositorios públicos**
- Son accesibles para cualquier persona en internet.
- Cualquier usuario puede ver el código fuente y el historial de commits.
- Se usan comúnmente en proyectos de código abierto y colaboraciones.
- Pueden ser bifurcados (**forks**) por otros usuarios para hacer contribuciones.

### **Repositorios privados**
- Solo pueden ser accedidos por usuarios con permisos específicos.
- Ideales para proyectos personales o empresariales que no deben ser públicos.
- No pueden ser bifurcados por otros usuarios sin autorización.
- Requieren planes de pago en algunas plataformas para ciertos equipos y funcionalidades avanzadas.

---

[![Repositorios Públicos vs Privados](https://img.youtube.com/vi/t_yOKbQkgPo/0.jpg)](https://www.youtube.com/watch?v=t_yOKbQkgPo&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **3. Cómo borrar ramas en Git**
A medida que se trabaja en un proyecto, es común eliminar ramas obsoletas, tanto en el repositorio local como en el remoto.

### **Eliminar una rama local**
Para eliminar una rama en el repositorio local:
```bash
git branch -d nombre-de-la-rama
```
Si la rama no ha sido fusionada y se desea forzar su eliminación:
```bash
git branch -D nombre-de-la-rama
```

### **Eliminar una rama remota**
Para eliminar una rama en un repositorio remoto como GitHub:
```bash
git push origin --delete nombre-de-la-rama
```
Si se usa GitHub, también se puede eliminar manualmente desde la pestaña **Branches** en la interfaz web del repositorio.

---

[![Borrar Ramas](https://img.youtube.com/vi/k4DycHO3ChQ/0.jpg)](https://www.youtube.com/watch?v=k4DycHO3ChQ&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **4. Cómo borrar un repositorio en Git**
Si un repositorio ya no es necesario, se puede eliminar en local o en remoto.

### **Eliminar un repositorio local**
Para borrar un repositorio en la máquina local, simplemente eliminar la carpeta que contiene el repositorio:
```bash
rm -rf nombre-del-repositorio
```

### **Eliminar un repositorio remoto (GitHub, GitLab, etc.)**
1. Ir al repositorio en la plataforma (GitHub, GitLab, etc.).
2. Navegar a la configuración del repositorio (**Settings**).
3. Buscar la opción **Delete this repository**.
4. Confirmar la eliminación siguiendo las instrucciones.

> **Nota:** Una vez eliminado un repositorio en remoto, no se puede recuperar a menos que se haya realizado una copia previa.

---

[![Eliminar Repositorios](https://img.youtube.com/vi/_N10RGUFyBg/0.jpg)](https://www.youtube.com/watch?v=_N10RGUFyBg&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---

## **5. Buenas prácticas al manejar repositorios y ramas**
- Mantener los repositorios **públicos** solo si se desea compartir el código abiertamente.
- Usar **repositorios privados** para proyectos en desarrollo o con información sensible.
- Eliminar ramas que ya no sean necesarias para mantener un repositorio limpio.
- Antes de eliminar un repositorio remoto, asegurarse de hacer una copia de seguridad si es necesario.
- Evitar eliminar ramas activas en uso por otros colaboradores sin previo aviso.

---

En el próximo tema, exploraremos **Qué es el README.md y cómo trabajar con markdown**.
