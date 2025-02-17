# **Tema 13: Workflows y estrategias de ramas en Git**

## **1. Introducción**
El uso de workflows (flujos de trabajo) y estrategias de ramas en Git es fundamental para organizar el desarrollo de software en equipos y mantener un historial limpio y estructurado. Existen varias metodologías que permiten gestionar el desarrollo de código de manera eficiente, dependiendo del tamaño del equipo y la complejidad del proyecto.

---

## **2. Estrategias de ramas en Git**
Las ramas en Git permiten trabajar en nuevas funcionalidades, corregir errores y experimentar sin afectar la versión principal del código. Algunas estrategias comunes son:

### **2.1. Estrategia de rama única (`main` o `master` only)**
- Todo el trabajo se realiza directamente en la rama `master`.
- Se recomienda solo para proyectos pequeños o personales.
- No permite una buena separación entre desarrollo y producción.

### **2.2. Ramas por funcionalidad (Feature Branches)**
- Cada nueva funcionalidad o mejora se desarrolla en una rama separada.
- Una vez finalizada, se fusiona con la rama principal (`master`).
- Facilita la revisión de código mediante Pull Requests.

Ejemplo:
```bash
git checkout -b feature/nueva-funcionalidad
git commit -m "Añadir nueva funcionalidad"
git push origin feature/nueva-funcionalidad
```

### **2.3. Git Flow**
- Usa múltiples ramas para gestionar el desarrollo, la integración y el despliegue.
- Separa `master` (producción) y `develop` (desarrollo), además de ramas auxiliares:
  - `feature/*`: Para desarrollar nuevas funcionalidades.
  - `release/*`: Para preparar versiones antes del lanzamiento.
  - `hotfix/*`: Para corregir errores críticos en producción.

Ejemplo de flujo con Git Flow:
```bash
git flow init
```
Para iniciar una nueva funcionalidad:
```bash
git flow feature start nueva-funcionalidad
git commit -m "Desarrollando nueva funcionalidad"
git flow feature finish nueva-funcionalidad
```

### **2.4. GitHub Flow**
- Más simple que Git Flow, recomendado para desarrollo ágil y continuo.
- Se trabaja exclusivamente con ramas `feature/*` y `master`.
- No usa `develop`; cada cambio se revisa y fusiona con `master`.

Ejemplo:
```bash
git checkout -b feature/nueva-funcionalidad
git push origin feature/nueva-funcionalidad
# Crear un Pull Request y fusionarlo en GitHub
```

### **2.5. Trunk-Based Development**
- Todo el desarrollo ocurre en una única rama (`master` o `trunk`).
- Se hacen commits pequeños y frecuentes.
- Evita ramas largas para minimizar conflictos.

Ejemplo:
```bash
git checkout master
git pull origin master
git commit -m "Pequeño cambio incremental"
git push origin master
```

---

## **3. Comparación de estrategias de ramas**
| Estrategia | Ventajas | Desventajas |
|------------|---------|------------|
| **Single Branch** | Simple, fácil de mantener | No escala bien, riesgo de conflictos |
| **Feature Branches** | Permite pruebas y revisiones | Puede generar muchas ramas pendientes |
| **Git Flow** | Separación clara entre desarrollo y producción | Requiere más mantenimiento |
| **GitHub Flow** | Flujo rápido y simple | Menos control sobre releases |
| **Trunk-Based** | Integración continua y rápida | Puede generar inestabilidad si no se controla |

---

## **4. Elección de la estrategia adecuada**
La estrategia ideal depende del equipo y el tipo de proyecto:
- **Proyectos pequeños** → `master` only o GitHub Flow.
- **Equipos medianos** → Feature Branches o Trunk-Based Development.
- **Empresas y proyectos grandes** → Git Flow.

---

## **5. Buenas prácticas**
- Mantener nombres descriptivos en las ramas (`feature/login-form`, `bugfix/api-error`).
- Eliminar ramas una vez fusionadas para evitar acumulación innecesaria.
- Hacer revisiones de código en Pull Requests antes de fusionar cambios.
- Mantener ramas cortas y actualizarlas frecuentemente con `master` o `develop`.

---

[![Git Workflows](https://img.youtube.com/vi/67fWC193sBc/0.jpg)](https://www.youtube.com/watch?v=67fWC193sBc&list=PLzA2VyZwsq_8nVw1G6L9PehvqSoGjTjsX)

---
