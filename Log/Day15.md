# :white_check_mark: Day 15: Review part three

## Properties

Properties are variables that remain inside of a struct or a class, and are used to store value when an instance is created.

Property observers watch for any changes in the property and then let you execute some code when it happens, there are two types: *willSet* and *didSet*.

Computed properties are properties that perform some code in order to get it's value, for that you use the *get* or *set* keyword.

## Static properties and methods

When creating an instance of a struct or a class, all the values of the properties are stored in that instance and are independent of the values of others instances. Static properties and methods belong to the struct itself, so it's a value that will be shared across all instances.

## Acess control

You can choose who get's to acess properties and methods on your code by using acess control keywords right before the declaration of them. There are four types of acess: public, internal, file private and private.

## Polymorphism and Typecasting

Polymorphism on classes means that when a class inherits from it's parent class, it can be treated as being the type of the parent or it's own type, because it inherits all the properties and methods from the parent class.

You can tell Swift to consider a class being it's parent class type by using the keyword *as* and an exclamation mark after, that is called typecasting.

## Closures

Closures are functions that can be passed as parameters for others functions and returned from other functions too. They can also have their own parameters and return values.




