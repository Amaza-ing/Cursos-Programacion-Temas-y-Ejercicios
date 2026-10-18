# **Topic 11: Animations and Transitions in CSS**

## **1. Introduction to animations and transitions in CSS**

Animations and transitions add dynamism and improve the user experience on a web page. CSS offers specific properties to create visual effects without the need for JavaScript.

---

## **2. Transitions in CSS**

Transitions allow you to smoothly change the value of a CSS property over a period of time.

### **Main properties:**

- `transition-property`: Defines which property will be animated.
- `transition-duration`: Specifies the duration of the transition.
- `transition-timing-function`: Controls the acceleration of the transition.
- `transition-delay`: Defines a delay before starting the transition.

### **Basic example:**

```css
.button {
  background-color: blue;
  color: white;
  padding: 10px 20px;
  transition: background-color 0.3s ease;
}

.button:hover {
  background-color: red;
}
```


In this example, the button background smoothly changes from blue to red when you hover over it.

> Note: With `transition: all` all properties can be affected at the same time.

---

## **3. Timing functions (`transition-timing-function`)**

They control the speed of the transition during its execution.

- `linear`: Constant speed.
- `ease` (default): Slow start and end with medium speed.
- `ease-in`: Start slowly.
- `ease-out`: End slowly.
- `ease-in-out`: Slow start and end.
- `cubic-bezier(n,n,n,n)`: Defines a custom Bézier curve.

### **Example:**

```css
.box {
  width: 100px;
  height: 100px;
  background-color: green;
  transition: transform 0.5s ease-in-out;
}

.box:hover {
  transform: scale(1.2);
}
```


---

## **4. CSS animations**

Animations allow you to create sequences of style changes that are more complex than transitions.

### **Main properties:**

- `@keyframes`: Defines the animation steps.
- `animation-name`: Name of the animation.
- `animation-duration`: Duration of the animation.
- `animation-timing-function`: Controls acceleration.
- `animation-delay`: Delay before starting.
- `animation-iteration-count`: Number of repetitions.
- `animation-direction`: Animation direction.
- `animation`: Shorthand for the rest of the properties.

### **Basic example:**

```css
@keyframes mover {
  0% {
    transform: translateX(0);
  }
  100% {
    transform: translateX(200px);
  }
}

.box {
  width: 100px;
  height: 100px;
  background-color: orange;
  animation: mover 2s infinite alternate;
}
```


In this example, the box will move from left to right infinitely.

---

## **5. Advanced animation control**

### **`animation-iteration-count` property**

Defines how many times the animation is executed.

- `infinite`: The animation repeats indefinitely.
- Specific number (`1`, `2`, etc.): Number of repetitions.

### **`animation-direction` property**

Controls the direction of the animation.

- `normal`: Standard execution.
- `reverse`: Start from the end.
- `alternate`: Alternate addresses in each iteration.
- `alternate-reverse`: Toggle starting in reverse.

### **Example:**

```css
@keyframes girar {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.spinner {
  width: 50px;
  height: 50px;
  border: 5px solid lightgray;
  border-top: 5px solid blue;
  border-radius: 50%;
  animation: girar 1s linear infinite;
}
```


In this example, a rotating magazine effect is created.

You can also control the animation more closely by specifying more percentage values:

```css
@keyframes mover {
  0% {
    transform: translateX(0);
  }
  50% {
    background-color: green;
  }
  100% {
    transform: translateX(200px);
  }
}
```


In this example, the animation now causes, in addition to the above, to change color to green halfway through.

---

## **6. Combine transitions and animations**

It is possible to combine both effects to achieve more dynamic results.

### **Example:**

```css
.button {
  background-color: blue;
  color: white;
  padding: 10px 20px;
  transition: background-color 0.3s;
  animation: pulsar 1.5s infinite alternate;
}

.button:hover {
  background-color: red;
}

@keyframes pulsar {
  from {
    transform: scale(1);
  }
  to {
    transform: scale(1.1);
  }
}
```


Here, the button grows and shrinks while changing color on hover.

---
[![Animations & Transitions](https://img.youtube.com/vi/D9DoH8gLsXY/0.jpg)](https://www.youtube.com/watch?v=D9DoH8gLsXY&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **7. Good practices with animations and transitions**

- Avoid animating properties that affect performance, such as `width` and `height`.
- Use `transform` and `opacity` for smoother animations.
- Maintain adequate durations to improve the user experience.
- Do not abuse animations so as not to overload the interface.

---

In the next topic, we will explore **media queries and responsive design**, to adapt your designs to different screen sizes.
