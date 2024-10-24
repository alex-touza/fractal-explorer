class Complex {
    a: number;
    b: number;


    constructor(a: number, b: number) {
        this.a = a;
        this.b = b;
    }

    multiply(other: Complex) {
        return new Complex(this.a*other.a - this.b * other.b, this.a*other.b + other.a * this.b)
    }

    sum(other: Complex) {
        this.a = this.a + other.a
        this.b = this.b + other.b
    }
}