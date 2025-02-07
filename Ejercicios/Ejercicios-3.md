# **Ejercicios - Tema 3: Eventos y Binding Bidireccional (`ngModel`)**

## **Ejercicio 1: Manejo de eventos con botones**
**Objetivo:** Implementar un botón que cambie el texto de un párrafo cuando se presiona.

### **Pasos**
1. Crea un nuevo componente llamado `eventos`.
2. Define una variable en `eventos.component.ts` llamada `mensaje`, con un valor inicial `"Texto original"`.
3. Agrega un botón en `eventos.component.html` con `(click)`, que al presionarlo cambie el valor de `mensaje` a `"Texto cambiado!"`.
4. Muestra el mensaje en un `<p>` usando interpolación (`{{ mensaje }}`).

---

## **Ejercicio 2: Captura de eventos con `$event`**
**Objetivo:** Detectar lo que el usuario escribe en un campo de entrada y mostrarlo en pantalla en tiempo real.

### **Pasos**
1. En `eventos.component.html`, agrega un campo de entrada (`<input>`) con el evento `(input)`.
2. Captura el valor ingresado usando `$event.target.value` y pásalo a una función en `eventos.component.ts`.
3. Muestra el texto en un `<p>` debajo del input.
4. La salida esperada debe actualizarse en tiempo real conforme el usuario escribe.

Ejemplo:
[Usuario escribe "Hola"] → Se muestra: "Has escrito: Hola"


---

## **Ejercicio 3: Binding bidireccional con `ngModel`**
**Objetivo:** Crear un formulario donde el usuario escriba su nombre y edad, y se actualicen automáticamente en pantalla.

### **Pasos**
1. En `formulario.component.ts`, define dos variables: `nombre: string` y `edad: number`.
2. En `formulario.component.html`, crea:
   - Un `<input>` con `[(ngModel)]` para el nombre.
   - Un `<input type="number">` con `[(ngModel)]` para la edad.
3. Muestra en pantalla: `"Hola [nombre], tienes [edad] años."`
4. Asegúrate de importar `FormsModule` en `app.module.ts`.

Salida esperada:
Usuario escribe "Ana" y "25" → Se muestra: "Hola Ana, tienes 25 años."


---

## **Ejercicio 4: Contador dinámico con eventos**
**Objetivo:** Implementar un contador que aumente y disminuya al hacer clic en botones.

### **Pasos**
1. En `contador.component.ts`, define una variable `contador` con valor inicial `0`.
2. En `contador.component.html`, agrega:
   - Un botón `+` que incremente el contador en `+1`.
   - Un botón `-` que disminuya el contador en `-1`.
   - Un párrafo `<p>` donde se muestre el valor actual del contador.
3. Implementa lógica para evitar que el contador baje de `0`.
4. Cuando el contador llegue a `10`, muestra una alerta `"Has alcanzado el límite"`.

Salida esperada:
[Usuario hace clic en "+" 3 veces] → Se muestra: "3" [Usuario hace clic en "-" 1 vez] → Se muestra: "2"


---


## **Ejercicio 5: Formulario interactivo con validaciones**
**Objetivo:** Crear un formulario que capture el nombre, email y edad de un usuario con validaciones.

### **Pasos**
1. En `formulario-validado.component.ts`, define:
   - `nombre: string = ''`
   - `email: string = ''`
   - `edad: number | null = null`
   - `mensajeError: string = ''`
2. En `formulario-validado.component.html`, agrega:
   - Un `<input>` para `nombre` con `[(ngModel)]`.
   - Un `<input>` para `email` con `[(ngModel)]`.
   - Un `<input type="number">` para `edad` con `[(ngModel)]`.
   - Un botón "Enviar" que valide los datos cuando el usuario haga clic.
3. Implementa validaciones:
   - Si `nombre` está vacío, muestra `"El nombre es obligatorio"`.
   - Si `email` no contiene `@`, muestra `"Email no válido"`.
   - Si `edad` es menor a `18`, muestra `"Debes ser mayor de edad"`.
4. Si los datos son válidos, muestra `"Formulario enviado correctamente"`.

Salida esperada:
Usuario deja nombre vacío → Se muestra: "El nombre es obligatorio" Usuario escribe "test.com" en email → Se muestra: "Email no válido" Usuario ingresa edad "16" → Se muestra: "Debes ser mayor de edad" Usuario ingresa datos correctos → Se muestra: "Formulario enviado correctamente"