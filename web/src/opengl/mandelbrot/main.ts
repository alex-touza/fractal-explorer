import {Fractal} from "@data/fractal.ts";

const INF = 2

function mandelbrot(z: Complex, c: Complex, n: number) {
    --n;

    z.multiply(z)
    z.sum(c)


}

const mandelbrot = new Fractal("Fractal de Mandelbrot", "mandelbrot", "", "", (canvas: HTMLCanvasElement) => {

})