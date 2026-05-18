import 'package:flutter/material.dart';
LinearGradient gradient= const LinearGradient(
  colors: [Color(0xFF00C9A7), Color(0xFF007CF0)],
);

String data="""# Introduction to C++

## What is C++?

C++ is a **high-performance programming language** created by **Bjarne Stroustrup** in 1979 as an extension of the C language.

It supports:

- Procedural Programming
- Object-Oriented Programming (OOP)
- Generic Programming
- Functional Programming

C++ is widely used in:

| Field | Examples |
|---|---|
| Game Development | Unreal Engine |
| Operating Systems | Windows |
| Embedded Systems | Arduino |
| Competitive Programming | Algorithms & Data Structures |
| Desktop Applications | Adobe Software |
| Databases | MySQL |

---

# Why Learn C++?

C++ gives programmers:

- High performance
- Direct memory access
- Fast execution speed
- Better control over hardware
- Strong foundation for DSA

---

# Features of C++

| Feature | Description |
|---|---|
| Fast | Executes very quickly |
| Portable | Runs on many platforms |
| Object-Oriented | Supports classes and objects |
| Compiled | Converts code to machine language |
| Powerful STL | Contains useful libraries |

---

# First C++ Program

```cpp
#include <iostream>
using namespace std;

int main() {
cout << "Hello World!";
return 0;
}
```

---

# Output

```text
Hello World!
```

---

# Understanding the Code

| Line | Explanation |
|---|---|
| `#include <iostream>` | Imports input/output library |
| `using namespace std;` | Allows use of standard library |
| `int main()` | Starting point of program |
| `cout` | Prints output |
| `return 0;` | Ends the program |

---

# Important Syntax Rules

## 1. Semicolon

Every statement usually ends with a semicolon.

```cpp
int age = 20;
```

---

## 2. Curly Braces

Curly braces define blocks of code.

```cpp
{
// code here
}
```

---

## 3. Case Sensitivity

C++ is case-sensitive.

```cpp
int age;
int Age;
```

These are considered different variables.

---

# Variables in C++

Variables are used to store data.

## Example

```cpp
int age = 19;
string name = "Ali";
float cgpa = 3.5;
```

---

# Data Types

| Data Type | Example | Description |
|---|---|---|
| `int` | `5` | Integer numbers |
| `float` | `5.5` | Decimal numbers |
| `double` | `5.55555` | Large decimal values |
| `char` | `'A'` | Single character |
| `string` | `"Hello"` | Text |
| `bool` | `true` | True/False |

---

# Taking Input

C++ uses `cin` for input.

## Example

```cpp
#include <iostream>
using namespace std;

int main() {

string name;

cout << "Enter your name: ";
cin >> name;

cout << "Welcome " << name;

return 0;
}
```

---

# Input and Output Operators

| Operator | Purpose |
|---|---|
| `<<` | Output |
| `>>` | Input |

---

# Arithmetic Operators

| Operator | Meaning |
|---|---|
| `+` | Addition |
| `-` | Subtraction |
| `*` | Multiplication |
| `/` | Division |
| `%` | Modulus |

---

# Example of Arithmetic

```cpp
#include <iostream>
using namespace std;

int main() {

int a = 10;
int b = 3;

cout << a + b << endl;
cout << a - b << endl;
cout << a * b << endl;
cout << a / b << endl;
cout << a % b << endl;

return 0;
}
```

---

# Comments in C++

Comments are ignored by compiler.

## Single Line Comment

```cpp
// This is a comment
```

## Multi Line Comment

```cpp
/*
This is
multi-line comment
*/
```

---

# Escape Characters

| Escape Character | Meaning |
|---|---|
| `\n` | New line |
| `\t` | Tab |
| `\"` | Double quote |

---

# Example

```cpp
cout << "Hello\nWorld";
```

Output:

```text
Hello
World
```

---

# Conditional Statements

Conditional statements allow decision making.

## if Statement

```cpp
if(age >= 18){
cout << "Adult";
}
```

---

## if-else Statement

```cpp
if(age >= 18){
cout << "Adult";
}
else{
cout << "Minor";
}
```

---

# Comparison Operators

| Operator | Meaning |
|---|---|
| `==` | Equal |
| `!=` | Not Equal |
| `>` | Greater Than |
| `<` | Less Than |
| `>=` | Greater Than Equal |
| `<=` | Less Than Equal |

---

# Loops in C++

Loops repeat code multiple times.

---

## for Loop

```cpp
for(int i = 0; i < 5; i++){
cout << i << endl;
}
```

---

## while Loop

```cpp
int i = 0;

while(i < 5){
cout << i << endl;
i++;
}
```

---

# Functions in C++

Functions help organize code.

## Example

```cpp
#include <iostream>
using namespace std;

void greet(){
cout << "Welcome!";
}

int main(){

greet();

return 0;
}
```

---

# Advantages of Functions

- Code reusability
- Cleaner code
- Easier debugging
- Better organization

---

# Arrays in C++

Arrays store multiple values.

## Example

```cpp
int numbers[5] = {1, 2, 3, 4, 5};
```

---

# Accessing Array Elements

```cpp
cout << numbers[0];
```

Output:

```text
1
```

---

# Object-Oriented Programming

C++ supports OOP concepts.

Main OOP concepts:

| Concept | Description |
|---|---|
| Class | Blueprint of object |
| Object | Instance of class |
| Inheritance | Reuse code |
| Encapsulation | Hide data |
| Polymorphism | Multiple behaviors |

---

# Example of Class

```cpp
#include <iostream>
using namespace std;

class Student {

public:
string name;
int age;

void display(){
cout << name << endl;
cout << age << endl;
}
};

int main(){

Student s1;

s1.name = "Ali";
s1.age = 20;

s1.display();

return 0;
}
```

---

# Standard Template Library (STL)

STL provides ready-made data structures and algorithms.

Popular STL containers:

| Container | Use |
|---|---|
| vector | Dynamic array |
| stack | LIFO structure |
| queue | FIFO structure |
| map | Key-value pairs |
| set | Unique values |

---

# Example of Vector

```cpp
#include <iostream>
#include <vector>

using namespace std;

int main(){

vector<int> nums = {1,2,3};

nums.push_back(4);

for(int n : nums){
cout << n << " ";
}

return 0;
}
```

---

# Memory Management

C++ supports dynamic memory allocation.

## Example

```cpp
int* ptr = new int(5);

cout << *ptr;

delete ptr;
```

---

# Advantages of C++

- Very fast
- Used in real-world systems
- Great for competitive programming
- Strong OOP support
- Industry standard

---

# Disadvantages of C++

- Complex syntax
- Manual memory management
- Harder for beginners
- Pointers can be confusing

---

# Real-World Applications

| Industry | Usage |
|---|---|
| Gaming | Unreal Engine |
| Finance | Trading systems |
| Robotics | Embedded systems |
| Browsers | Chrome components |
| Operating Systems | Windows |

---

# Summary

In this lesson you learned:

- What C++ is
- Features of C++
- Syntax basics
- Variables and data types
- Input/output
- Conditions and loops
- Functions
- Arrays
- OOP concepts
- STL basics

---

# Practice Questions

1. What is C++?
2. Difference between `int` and `float`
3. What does `cout` do?
4. Why are loops useful?
5. What is a function?

---

# Mini Challenge

Write a C++ program that:

1. Takes user name
2. Takes age
3. Prints welcome message
4. Checks if user is adult or minor

Example Output:

```text
Enter name: Ali
Enter age: 19

Welcome Ali
You are an adult
```

---

# Final Note

C++ is one of the most important programming languages for:

- Problem solving
- DSA
- Competitive programming
- System programming
- Game development

Mastering C++ builds strong programming fundamentals for learning advanced technologies later.""";