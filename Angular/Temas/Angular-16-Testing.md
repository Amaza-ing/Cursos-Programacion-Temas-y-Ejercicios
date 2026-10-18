# **Topic 16: Performing Unit Tests with Jasmine and Karma in Angular**

## **1. Introduction**

Unit tests are essential to ensure the quality and correct functioning of the code. Angular uses **Jasmine** as a testing framework and **Karma** as a test executor.

In this topic you will learn:

- How to configure Jasmine and Karma.
- Write basic unit tests.
- Test components and services.
- Simulate dependencies using _spies_.

---

## **2. Initial Configuration**

Angular comes with Jasmine and Karma preconfigured. To verify it, check the files `angular.json` and `package.json` (If some elements or versions are different from the examples, nothing happens).

### **2.1. Verification in `angular.json`**

In the `architect > test` section:

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


### **2.2. Dependencies on `package.json`**

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


To run the tests:

```bash
ng test
```


---

## **3. Structure of a Test with Jasmine**

Jasmine uses functions such as `describe`, `it`, and _matchers_ such as `toBe` and `toEqual`.

### **Basic Example:**

```ts
describe("Funciones Matemáticas", () => {
  it("debería sumar dos números", () => {
    const resultado = 2 + 3;
    expect(resultado).toBe(5);
  });
});
```


- **`describe`**: Groups the tests.
- **`it`**: Defines a test case.
- **`expect`**: Evaluate the result.

---

## **4. Unit Testing in Components**

We will do all the unit tests within the spec.ts files that are generated with each component.

### **4.1. Example Component**

#### **File: `app.component.ts`**

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


### **4.2. Writing Tests for the Component**

Within the `spec.ts` file we will create a suite with several tests using the `describe` function to generate the suit and within it different `it` functions (individual test) and we will import everything necessary to simulate and test the component.

The following example defines the tests that we can perform on the example component, which uses a reactive form and different checks are carried out to verify that everything works.

#### **File: `app.component.spec.ts`**

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

## **5. Simulation of Services with Spies**

Use `spyOn` to simulate external services.

### **Example:**

```ts
describe("Servicio Externo", () => {
  it("debería llamar al método del servicio", () => {
    const servicio = {
      obtenerDatos: () => "datos reales",
    };

    const spy = spyOn(servicio, "obtenerDatos").and.returnValue(
      "datos simulados",
    );

    expect(servicio.obtenerDatos()).toBe("datos simulados");
    expect(spy).toHaveBeenCalled();
  });
});
```


---

## **6. Code Coverage**

To generate a coverage report:

```bash
ng test --code-coverage
```


The report will be available at `coverage/index.html`.

---

[![Testing](https://img.youtube.com/vi/4y9KHXqv3p0/0.jpg)](https://www.youtube.com/watch?v=4y9KHXqv3p0&list=PLzA2VyZwsq_9cD3JIxBymaIVyef07PJ-y)

---

## **7. Conclusion**

- Jasmine and Karma allow for robust unit testing.
- Testing ensures the stability and quality of the code.
- Simulating dependencies is key to isolating code in tests.

In the next topic, we will explore **integration and end-to-end (E2E) testing using Cypress in Angular**.
