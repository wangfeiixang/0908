


/* function greeter(person: object) {
    return "Hello, " + person;
}

var user = [0, 1, 2];

var app = document.getElementById('app');

app.innerHTML = greeter(user);

console.log( greeter(user) );

// document.body.innerHTML = greeter(user); */

/* interface Person {
    firstName: string;
    lastName: string;
}

function greeter(person: Person) {
    return "Hello, " + person.firstName + " " + person.lastName;
}

var user = { firstName: "Jane", lastName: "User" };

var app = document.getElementById('app');

app.innerHTML = greeter(user); */

class Student {
    fullName: string;
    constructor(public firstName, public middleInitial, public lastName) {
        this.fullName = firstName + " " + middleInitial + " " + lastName;
    }
}

interface Person {
    firstName: string;
    lastName: string;
}

function greeter(person : Person) {
    return "Hello, " + person.firstName + " " + person.lastName;
}

var user = new Student("Jane", "M.", "User")

var app = document.getElementById('app')

app.innerHTML = greeter(user);

let isDone: boolean = false;

let num:number = 99;

let str:string = 'bob';

str = 'aoa';


enum Enum {
    A
}
let a = Enum.A;
let nameOfA = Enum[a]; // "A"
console.log( a,nameOfA  )

const enum Directions {
    Up = 1,
    Down,
    Left,
    Right
}
let directions = [Directions.Up, Directions.Down, Directions.Left, Directions.Right];

console.log( directions )

const enum Enum1 {
    A = 2,
    B = A * 2,
}

let dir = [Enum1.A,Enum1.B]

console.log( dir )
