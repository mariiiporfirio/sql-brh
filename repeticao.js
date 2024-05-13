for (var a = 1; a <= 50; a++) {
    if(a % 2 == 0) {
        console.log(a + ' é par.');
    } else {
        console.log(a + ' é ímpar.');
    }
}

for (var b = 1; b <= 100; b++) {
    if(b % 3 === 0) {
        console.log(b);
    }
}

for (var c = 100; c >= 0; c-= 2){
    console.log(c);
}

for (var p = 1; p <= 40; p++) {
    if(p % 4 == 0) {
        console.log('PIM');
    } else {
        console.log(p);
    }
}

let pessoa = ['Maria', 78, 'CPF: 87654654309', '1.71', true];

let frase = pessoa [0] + ',' + pessoa [1] + ' anos, tem ' + pessoa[3] + ' de altura e ' + pessoa[2] + '.'
console.log(frase);

let letras = [];

function recebeLetra () {
    let letra = prompt('Digite uma letra');
    letras.push(letra)
}
for (var i = 1; i <= 10; i++) {
    recebeLetra();
}
console.log(letras);
console.log(letras [0]);
console.log(letras [3]);
console.log(letras [4]);
console.log(letras [9]);
console.log(letras.length);