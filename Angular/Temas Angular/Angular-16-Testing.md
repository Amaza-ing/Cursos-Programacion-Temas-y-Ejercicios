# **Tema 16: Realización de Tests Unitarios con Jasmine y Karma en Angular**

## **1. Introducción**

Las pruebas unitarias son esenciales para garantizar la calidad y el correcto funcionamiento del código. Angular utiliza **Jasmine** como framework de pruebas y **Karma** como ejecutor de las mismas.

En este tema aprenderás:

- Cómo configurar Jasmine y Karma.
- Escribir pruebas unitarias básicas.
- Probar componentes y servicios.
- Simular dependencias usando _spies_.

---

## **2. Configuración Inicial**

Angular viene con Jasmine y Karma preconfigurados. Para verificarlo, revisa los archivos `angular.json` y `package.json` (Si algunos elementos o versiones son diferentes a los ejemplos no pasa nada).

### **2.1. Verificación en `angular.json`**

En la sección `architect > test`:

```json
"test": {
  "builder": "@angular-devkit/build-angular:karma",
  "options": {
    "polyfills": ["zone.js", "zone.js/testing"],
    "tsConfig": "tsconfig.spec.json",
    "assets": ["src/favicon.ico", "src/assets"],
    "styles": ["src/styles.css"],
    "scripts": []
  }
}
```

### **2.2. Dependencias en `package.json`**

```json
"devDependencies": {
  "@types/jasmine": "~5.1.0",
  "jasmine-core": "~5.1.0",
  "karma": "~6.4.0",
  "karma-chrome-launcher": "~3.2.0",
  "karma-coverage": "~2.2.0",
  "karma-jasmine": "~5.1.0",
  "karma-jasmine-html-reporter": "~2.1.0"
}
```

Para ejecutar los tests:

```bash
ng test
```

---

## **3. Estructura de un Test con Jasmine**

Jasmine utiliza funciones como `describe`, `it`, y _matchers_ como `toBe` y `toEqual`.

### **Ejemplo Básico:**

```ts
describe("Funciones Matemáticas", () => {
  it("debería sumar dos números", () => {
    const resultado = 2 + 3;
    expect(resultado).toBe(5);
  });
});
```

- **`describe`**: Agrupa las pruebas.
- **`it`**: Define un caso de prueba.
- **`expect`**: Evalúa el resultado.

---

## **4. Pruebas Unitarias en Componentes**

Todas las pruebas unitarias las haremos dentro de los fichero spec.ts que se generan con cada componente.

### **4.1. Componente Ejemplo**

#### **Archivo: `app.component.ts`**

```ts
import { Component } from "@angular/core";
import { FormBuilder, FormGroup, Validators } from "@angular/forms";

@Component({
  selector: "app-root",
  templateUrl: "./app.component.html",
})
export class AppComponent {
  movieForm: FormGroup;
  sentMsg = "";

  constructor(private fb: FormBuilder) {
    this.movieForm = this.fb.group({
      name: ["", Validators.required],
      duration: ["", [Validators.required, Validators.max(300)]],
      director: [""],
    });
  }

  handleSubmit() {
    if (this.movieForm.valid) {
      this.sentMsg = "Movie Created Successfully!";
    }
  }
}
```

### **4.2. Escribiendo Pruebas para el Componente**

Dentro del fichero `spec.ts` crearemos una suite con varios tests utilizando la función `describe` para generar la suit y dentro de ella diferentes funciones `it` (individual test) e importaremos todo lo necesario para simular y testear el componente.

En el siguiente ejemplo se definen los tests que podemos realizar sobre el componente de ejemplo, que usa un formulario reactivo y se realizan diferentes comprobaciones para corroborar que todo funciona.

#### **Archivo: `app.component.spec.ts`**

```ts
import { ComponentFixture, TestBed } from "@angular/core/testing";
import { ReactiveFormsModule } from "@angular/forms";
import { AppComponent } from "./app.component";

describe("AppComponent", () => {
  let component: AppComponent;
  let fixture: ComponentFixture<AppComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [AppComponent],
      imports: [ReactiveFormsModule],
    }).compileComponents();

    fixture = TestBed.createComponent(AppComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it("debería crear el componente", () => {
    expect(component).toBeTruthy();
  });

  it("debería mostrar el mensaje al enviar el formulario válido", () => {
    component.movieForm.setValue({
      name: "Inception",
      duration: 148,
      director: "Christopher Nolan",
    });

    component.handleSubmit();
    expect(component.sentMsg).toBe("Movie Created Successfully!");
  });

  it("debería marcar el formulario como inválido si falta el nombre", () => {
    component.movieForm.setValue({
      name: "",
      duration: 120,
      director: "N/A",
    });

    expect(component.movieForm.valid).toBeFalse();
  });
});
```

---

## **5. Simulación de Servicios con Spies**

Usa `spyOn` para simular servicios externos.

### **Ejemplo:**

```ts
describe("Servicio Externo", () => {
  it("debería llamar al método del servicio", () => {
    const servicio = {
      obtenerDatos: () => "datos reales",
    };

    const spy = spyOn(servicio, "obtenerDatos").and.returnValue(
      "datos simulados"
    );

    expect(servicio.obtenerDatos()).toBe("datos simulados");
    expect(spy).toHaveBeenCalled();
  });
});
```

---

## **6. Cobertura de Código**

Para generar un reporte de cobertura:

```bash
ng test --code-coverage
```

El reporte estará disponible en `coverage/index.html`.

---

[![Testing](https://img.youtube.com/vi/4y9KHXqv3p0/0.jpg)](https://www.youtube.com/watch?v=4y9KHXqv3p0&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **7. Conclusión**

- Jasmine y Karma permiten realizar pruebas unitarias robustas.
- Las pruebas aseguran la estabilidad y calidad del código.
- Simular dependencias es clave para aislar el código en las pruebas.

En el próximo tema, exploraremos **pruebas de integración y de extremo a extremo (E2E) usando Cypress en Angular**.
