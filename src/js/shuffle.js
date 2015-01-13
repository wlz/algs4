seq = [1, 2, 3, 4, 5, 6, 7, 8, 9];

function shuffle(seq) { 
    for(var i = 1; i < seq.length; i++){ 
        ran = getRandom(i);

        tmp = seq[i];
        seq[i] = seq[ran];
        seq[ran] = tmp;
    } 
}

function getRandom(n) {
    return Math.floor(Math.random() * n);
} 

shuffle(seq); 
for(var i = 1; i < seq.length; i++){
    console.log(seq[i]);
}
