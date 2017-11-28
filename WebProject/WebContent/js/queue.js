function Queue() {
    this.dataStore = []; 
    this.push = push;
    this.pop = pop;
    this.front = front;
    this.rear = rear;
    this.empty = empty;
}

function push(element) {
    this.dataStore.push(element);
}

function pop() {
    return this.dataStore.shift();
}

function front() {
    return this.dataStore[0];
}

function rear() {
    return this.dataStore[this.dataStore.length-1];
}

function empty() {
    return this.dataStore.length==0;
}