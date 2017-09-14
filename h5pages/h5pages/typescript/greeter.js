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
var Student = /** @class */ (function () {
    function Student(firstName, middleInitial, lastName) {
        this.firstName = firstName;
        this.middleInitial = middleInitial;
        this.lastName = lastName;
        this.fullName = firstName + " " + middleInitial + " " + lastName;
    }
    return Student;
}());
function greeter(person) {
    return "Hello, " + person.firstName + " " + person.lastName;
}
var user = new Student("Jane", "M.", "User");
var app = document.getElementById('app');
app.innerHTML = greeter(user);
var isDone = false;
var num = 99;
var str = 'bob';
str = 'aoa';
var Enum;
(function (Enum) {
    Enum[Enum["A"] = 0] = "A";
})(Enum || (Enum = {}));
var a = Enum.A;
var nameOfA = Enum[a]; // "A"
console.log(a, nameOfA);
var directions = [1 /* Up */, 2 /* Down */, 3 /* Left */, 4 /* Right */];
console.log(directions);
var dir = [2 /* A */, 4 /* B */];
console.log(dir);
