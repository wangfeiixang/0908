


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

/* class Student {
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

console.log( dir ) */

/* try {
    throw "oh no!";
}
catch (e) {
    console.log("Oh well.");
}

// Error: 'e' doesn't exist here
console.log(e); */

/* function warnUser(): void {
    alert("This is my warning message");
}

function printLabel(labelledObj: { label: string }) {
    console.log(labelledObj.label);
  }
  
let myObj = { size: 10, label: "Size 10 Object" };
printLabel(myObj); */

     //可选属性
   /*  interface SquareConfig {
        color?: string;
        width?: number;
    }
  
    function createSquare(config: SquareConfig): {color: string; area: number} {

        let newSquare = {color: "white", area: 100};
        if (config.color) {
            newSquare.color = config.color;
        }
        if (config.width) {
            newSquare.area = config.width * config.width;
        }
        return newSquare;
    }

    let mySquare = createSquare({color: "black"});

    console.log( mySquare ) */

    //只读属性
   /*  interface Point {
        readonly x: number;
        readonly y: number;
    }

    let p1: Point = { x: 10, y: 20 };
    p1.x = 5; // error! */

   /*  let a: number[] = [1, 2, 3, 4];
    let ro: ReadonlyArray<number> = a;
    ro[0] = 12; // error!
    ro.push(5); // error!
    ro.length = 100; // error!
    a = ro; // error!

    a = ro as number[]; */

    //类
 /*    class Greeter {
        greeting: string;
        constructor(message: string) {
            this.greeting = message;
        }
        greet() {
            return "Hello, " + this.greeting;
        }
    }
    let greeter = new Greeter("world");
    console.log( greeter ) */

    //类的继承
    class Animal {
        name:string;
        constructor(theName: string) { this.name = theName; }
        move(distanceInMeters: number = 0) {
            console.log(`${this.name} moved ${distanceInMeters}m.`);
        }
    }
    

    class Snake extends Animal {
        constructor(name: string) { super(name); }
        move(distanceInMeters = 5) {
            console.log("Slithering...");  
            super.move(distanceInMeters);
        }
    }
    
    class Horse extends Animal {
        constructor(name: string) { super(name); }
        move(distanceInMeters = 45) {
            console.log("Galloping...");
            super.move(distanceInMeters);
        }
    }

    let sam = new Snake("Sammy the Python");
    let tom: Animal = new Horse("Tommy the Palomino");
    
    sam.move();
    tom.move(34);