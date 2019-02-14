# :white_check_mark: Day 14: Review part two

## Functions

Functions are grouped pieces of code that can be reused as many time as you want. You declare a function when define what will perform, and then call (execute) the function later on.

Functions can accept parameters, which is data passed into the function to be used, and can also return data.

## Optionals

An optional is a data that might or might not exist, and is declared by putting a question mark in front of the variables declaration. To use an optional you have to unwrap it, which means checking if the value exists, because it might be nil. You can also force unwrap an optional by putting an exclamation mark in front of it's name, that will tell Swift that you are sure that there will be a value in it, but it's not recommended because it's unsafe.

Optional chaining is a resource for unwrapping the optional without using *if let* or *guard*, and it works by putting a question mark after the optional name, then some method to execute. Swift will check if the optional has any valid value, and if it does will continue on to the method, otherwise will just return nil.

## Enumerations

Enums are a way of defining your own type of data, when creating a enum, you give it a name and all it's possible values, and then can use it as a data type for a variable. They can also have values attached to them, which gives extra funcionality.

## Structs

Structs are complex data types that can have it's own properties and methods (functions). They have built in initializers, that are used for creating instances of that struct and assigning those values to each property. 
Since they are value types, when you assign a struct to a variable and then assign another that variable to a new one, you are creating a copy, and changes made in one won't affect the other.
You can also create your own personalized initializer, but by doing so you have to guarantee that all the properties will have values.

## Classes

Classes are similar to structs because they are also used to create complex pieces of data, but there are some major differences between them. 
First of all, classes don't have built in initializers, so you have to remember to create it when you declare a class, and the initializers must also assign values to all the properties.
Classes also have something called inheritance, which means that a class can have child classes, and all it's child will inherit the parent class properties and methods. When creating a class that inherits from another, you can override the parent class functions, and add new properties and methods to the child.
Instances of a class are called *objects* which are reference types, therefore copying an object and making a change will affect both the original and the copy, because they are poiting to the same location in memory.

