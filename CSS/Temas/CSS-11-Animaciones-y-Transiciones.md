# **Topic 11: Animations and Transitions in CSS**

## **1. Introduction to animations and transitions in CSS**

Animations and transitions make a web page more dynamic and improve the user experience. CSS offers specific properties to create visual effects without needing JavaScript.

---

## **2. Transitions in CSS**

Transitions let you change the value of a CSS property smoothly over a period of time.

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

> Note: With `transition: all`, you can affect all properties at once.

---

## **3. Timing functions (`transition-timing-function`)**

They control the speed of the transition while it runs.

- `linear`: Constant speed.
- `ease` (default): Slow start and end, with a medium speed.
- `ease-in`: Starts slowly.
- `ease-out`: Ends slowly.
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

## **4. Animations in CSS**

Animations let you create sequences of style changes that are more complex than transitions.

### **Main properties:**

- `@keyframes`: Defines the animation steps.
- `animation-name`: Name of the animation.
- `animation-duration`: Duration of the animation.
- `animation-timing-function`: Controls the acceleration.
- `animation-delay`: Delay before starting.
- `animation-iteration-count`: Number of repetitions.
- `animation-direction`: Direction of the animation.
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


In this example, the box will move from left to right endlessly.

---

## **5. Advanced animation control**

### **`animation-iteration-count` property**

It defines how many times the animation runs.

- `infinite`: The animation repeats indefinitely.
- Specific number (`1`, `2`, etc.): Number of repetitions.

### **`animation-direction` property**

It controls the direction of the animation.

- `normal`: Standard playback.
- `reverse`: Starts from the end.
- `alternate`: Alternates direction on each iteration.
- `alternate-reverse`: Alternates, starting in reverse.

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


In this example, a spinning loader effect is created.

You can also control the animation in more detail by specifying more percentage values:

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


In this example, besides doing all of the above, the animation now also changes the color to green halfway through.

---

## **6. Combining transitions and animations**

You can combine both effects to get more dynamic results.

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
[![Animations & Transitions](https://img.youtube.com/vi/sTh7iZyxHrw/0.jpg)](https://www.youtube.com/watch?v=sTh7iZyxHrw&list=PLzA2VyZwsq_9hRcJ0nEDQkoI1aK5V74y-)

---

## **7. Best practices for animations and transitions**

- Avoid animating properties that affect performance, such as `width` and `height`.
- Use `transform` and `opacity` for smoother animations.
- Keep durations reasonable to improve the user experience.
- Don't overuse animations, so the interface doesn't feel overloaded.

---

In the next topic, we will explore **media queries and responsive design**, to adapt your designs to different screen sizes.
