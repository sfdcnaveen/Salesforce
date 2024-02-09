console.log('Test javascript file')

//objects
let student1 = {'Name':'Naveen', 'Age' :27, 'Degree':'B.tech', 'class':undefined, 'State':'AP', 'feesPaid':true, 'Address':{'Street':'SaiRam Street', 'Pincode':'524201'}}
let student2 = {'Name':'Nageswari', 'Age' :26, 'Degree':'B.Com','class':undefined, 'State':'Telangana','feesPaid':false, 'Address':{'Street':'Narasinghrao Peta', 'Pincode':'524101'}}
let students =[student1,student2, {'Name':'Sai Krupa', 'Age' :24, 'Degree':'B.Sc','class':undefined, 'State':'MP', 'feesPaid':true, 'Address':{'Street':'BC Colony', 'Pincode':'524101'}}]
//console.log(students);
//HW3
let printStudents = (stud) => {
  return [stud.Name,stud.Age,stud.Degree,stud.feesPaid];
}
let mapStudent = students.map(x=>
  printStudents(x));
console.log(mapStudent);
//console.log(students.forEach())

/*
//HW4 Print string Length without inbuilt function
let str = "Naveen Pasupuleti";
let strLength = 0;

for (let i = 0; str[i] !== undefined; i++) {
  strLength++;
}
console.log("The length of the string is " + strLength);
*/
/*
//HW5
let ArrObj = [{Name : 'Manoj',Age : 25},{Name : 'Reena',Age : 22}];
let result = ArrObj.map(obj => {
  
  let entries = Object.entries(obj);
  let key = entries[0][1];
  let value = entries[1][1];
  return {[key]: value};
});
for (let i = 0; i < result.length; i++) {
  console.log(result[i]);
}
*/

// HW6
/*
let input = [1,8,5,2,6,4,9,5,2,10];
let output = [];
for (let i = 0; i < input.length; i++) {
  if (i === 0) {
    output.push(input[i]);
  } else {
    output.push(input[i] + input[i-1]);
  }
}
console.log(output);
*/
/*
//HW7 using for loop
const students2 = [{ name: "Saurabh", age: 22 },{ name: "Maheshwari", age: 25 }, { name: "Pratiksha", age: 30 },{ name: "Nilesh", age: 20 },{ name: "Aaditya", age: 25 },{ name: "Priyanka", age: 30 },{ name: "Rohan", age: 22 },{ name: "Seema", age: 28 },{ name: "Vikram", age: 20 },{ name: "Anushka", age: 24 },];
const studentsByAge = {};
for (const student of students2) {
  const age = student.age;
  if (!studentsByAge[age]) {
    studentsByAge[age] = student.name;
  } else {
    studentsByAge[age] += `, ${student.name}`;
  }
}
console.log(studentsByAge);
*/
// hw8 using map
let inputArr = [10, 20, 30, 40, 8, 45];
console.log(inputArr);
let n=0;
let temp = 5;
let outputArr = inputArr.map(x =>{
  n= x+temp;
  (temp+=15);
  return n;
});
console.log(outputArr);

//HW8 using for-loop
let k=5;
let out=[];
inputArr.forEach((x) => {
  out = ([x+k]);
  (k+=15);
  console.log(out);
});

/*
for (const [key, value] of Object.entries(students)) {
    console.log(key + ": " + value);
  }

//var num1, num2;
const num1 = 20;
const num2 =3;
let addition = () => {
    return num1 + num2;
}

let subtraction = () => {
    return num1-num2;
}

let multiplication = () => {
    return num1* num2;
}

let division = () => {
    if (num2!=0) {
        return num1/num2;
    } else {
        console.log('Can not divide by zero')
    }
    
}

console.log(addition(num1,num2));
console.log(subtraction(num1,num2));
console.log(multiplication(num1,num2));
console.log(division(num1,num2));


console.log(addition(10,20));
console.log(subtraction(30,40));
console.log(multiplication(2,3));
console.log(division(20,2));
console.log(division(2,0));


a = 21;
a++;
++a;
console.log(a++);
a+=9;
console.log(++a);

*/
/*
let num1 = 5
let num2 = 7
let num3 = 12
let num4 = 2
let num5 = 16


let capitalNumber = (num1>num2 && num1 > num3 && num1>num4 && num1 > num5 ) ? 'num1' :
(num2>num1 && num2 > num3 && num2>num4 && num2 > num5 ) ? 'num2' :
(num3>num1 && num3 > num2 && num3>num4 && num3 > num5 ) ? 'num3' :
(num4>num1 && num4 > num2 && num4>num3 && num4 > num5 ) ? 'num4' : 'num5'
console.log('greater number is '+ capitalNumber);


let capitalNumber = (num1 > num2 && num1 > num3 && num1 > num4 && num1 > num5) ? num1 : 
(num2 > num3 && num2 > num4 && num2 > num5) ? num2 : 
(num3 > num4 && num3 > num5)? num3: 
(num4 > num5)? num4 : num5;

console.log('The greater number is ' + capitalNumber);

 */