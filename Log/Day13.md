# :white_check_mark: Day 13: Review

This day was reserved to review all the content we absorbed up until now, so I decided to do a brief sum up on each topic.

## Variables and constants

Variables are like a box where you can store anything you want, in programming more specificaly you store data. Constants are a type of variable that can't have its value changed.

When declaring your variable, you can specify the type of data that will hold, or just go ahead and give it a value and Swift will do something called type inference, which means that it will "guess" what kind of data it holds based on the value you assigned to it.

## Types of data

There are pre-defined types of data in programming, the most common are:

* String
* Integer
* Double
* Boolean

## Operators

Basic operators are used in programming just the same as they are used on mathematical calculations, but you can only perform these operations with data of the same type, you can't sum up an integer and a double, or a string and an integer, etc.

Comparison operators are also used very often, specially to compare variables and values, and to check if something returns a boolean.

## String interpolation

This is a resource used to place data inside of strings. This data can be any data type (including another string), and when put inside the string it will be merged into it. The most common way to use is placing variables that are declared outside.

## Arrays

Arrays are a collection type where you can place groups of any type of data inside. When declaring  an array you have to also declare what kind of data it will hold, and then you can only put that specific type inside, unless you declare the data inside as *Any*.

Each value inside an array has a index number, which can be used later to acess that value. The index number starts counting from 0, so that's the index of your first value and so it goes.

## Dictionaries

Dictionaries are similar to arrays because it's also a collection type, but the difference is that dictionaries can have it's values accessed by a *key* value instead of an index. This makes it more viable to store complex groups of data.

## Conditional statements

Conditional statements are used to control the flow of your code, executing a block of code only when a specified condition it's true. 

## Loops

Loops are very useful for executing a block of code many number of times without having to copy that code as many times as you want to execute it. You put the code inside of the loop and tell it how many times you want it to run.

## Switch case

Switch case it's a type of conditional statement that groups together many conditions to be checked and performs only the code inside the one that is true. It's a way better approach when checking for multiple things, because otherwise you would end up with lots of *if* and *else if* statements.

