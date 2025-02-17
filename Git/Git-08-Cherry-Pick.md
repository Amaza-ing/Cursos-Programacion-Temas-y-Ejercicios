# **Tema 8: Uso de `git cherry-pick` para seleccionar commits específicos**

## **1. Introducción**
El comando `git cherry-pick` permite aplicar un commit específico de una rama a otra sin fusionar toda la rama. Esto es útil cuando se necesita llevar cambios individuales a otra rama sin afectar su historial general.

### **Beneficios de `git cherry-pick`**
- Permite seleccionar cambios específicos sin fusionar ramas completas.
- Evita la necesidad de duplicar código manualmente.
- Es útil para corregir errores en ramas estables sin traer cambios no deseados.

---

## **2. Obtener el identificador del commit**
Antes de usar `git cherry-pick`, es necesario identificar el commit que se desea aplicar. Para ello, se puede ejecutar:
```bash
git log --oneline
```
Este comando muestra una lista de commits con sus identificadores (hashes), por ejemplo:
```
3f4d2e5 Corrección de bug en el login
b8a1c9d Actualización de la documentación
2a7e6f3 Nueva funcionalidad de exportación
```
El identificador del commit (ej. `3f4d2e5`) es necesario para el siguiente paso.

---

## **3. Aplicar un commit específico con `git cherry-pick`**
Una vez obtenido el hash del commit, se puede aplicar en la rama actual con:
```bash
git cherry-pick 3f4d2e5
```
Esto copia los cambios realizados en ese commit y los añade a la rama actual como un nuevo commit.

---

## **4. Aplicar múltiples commits**
Si se desean traer varios commits a la vez, se pueden especificar múltiples hashes:
```bash
git cherry-pick 3f4d2e5 b8a1c9d
```
O para un rango de commits consecutivos:
```bash
git cherry-pick 3f4d2e5..b8a1c9d
```
Esto aplicará todos los commits en el rango seleccionado.

---

## **5. Resolver conflictos durante un `cherry-pick`**
Si el commit seleccionado afecta partes del código que han cambiado en la rama actual, puede haber conflictos. Para resolverlos:
1. Git pausará el proceso y mostrará los archivos en conflicto.
2. Editar los archivos para resolver los conflictos.
3. Añadir los cambios resueltos con:
   ```bash
   git add archivo-afectado
   ```
4. Continuar el proceso con:
   ```bash
   git cherry-pick --continue
   ```
Si se desea cancelar el `cherry-pick` y deshacer los cambios:
```bash
git cherry-pick --abort
```

---

## **6. Aplicar un commit sin crear un nuevo commit**
Si se quiere aplicar los cambios de un commit pero sin generar un nuevo commit, se puede usar:
```bash
git cherry-pick -n 3f4d2e5
```
Esto aplica los cambios al área de trabajo sin confirmarlos, permitiendo hacer ajustes antes de hacer un `git commit` manualmente.

---

## **7. Buenas prácticas al usar `git cherry-pick`**
- Usar `git log --oneline` para identificar correctamente los commits antes de aplicarlos.
- Evitar cherry-pick de commits con dependencias en otros commits para prevenir inconsistencias.
- Resolver conflictos con calma y verificar los cambios antes de confirmar.
- Utilizar `git cherry-pick -n` si se necesita modificar los cambios antes de confirmarlos.
- Si un cherry-pick genera un error, usar `git cherry-pick --abort` para cancelar la operación.

---

En el próximo tema, exploraremos **cómo dar marcha atrás a los cambios con git restore y git revert**.
