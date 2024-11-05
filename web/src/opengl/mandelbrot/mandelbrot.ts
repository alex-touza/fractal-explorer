import { Fractal, type FractalCanvas, type FractalDataset } from '../index.ts';
import { default as vertex } from './mandelbrot.vert?raw';
import { default as fragment } from './mandelbrot.frag?raw';
import { mandelbrot } from '@data/fractals.ts';

export interface MandelbrotDataset extends FractalDataset {
	maxIterations: string;
}

export class MandelbrotFractal extends Fractal<MandelbrotDataset> {
	private buffer: WebGLBuffer | null = null;

	public constructor() {
		super('mandelbrot', mandelbrot, [
			['fragment', fragment],
			['vertex', vertex],
		]);
	}

	public override begin(canvas: FractalCanvas<MandelbrotDataset>) {
		canvas.dataset.zoom = '2.5';
		canvas.dataset.offsetX = '-0.5';
		canvas.dataset.offsetY = '0';
		canvas.dataset.maxIterations = '10000';
		super.begin(canvas);

		if (this.context === null) throw 'context null';

		this.newAttribute('aPosition');

		this.newUniform('uMaxIterations');

		this.buffer = this.context.createBuffer();
	}

	public override draw() {
		if (this.context === null) throw 'context null';

		super.draw();
		if (this.canvas?.width === 0) throw 'canvas width 0';
		if (!this.canvas?.dataset) throw 'canvas dataset not set';

		this.context.bindBuffer(this.context.ARRAY_BUFFER, this.buffer!);

		this.context.bufferData(
			this.context.ARRAY_BUFFER,
			new Float32Array([
				//Triangle esquerre
				-1, 1, -1, -1, 1, 1,
				//Triangle dret
				-1, -1, 1, -1, 1, 1,
			]),
			this.context.STATIC_DRAW,
		);

		let vertArray = this.context.createVertexArray();

		this.context.bindVertexArray(vertArray);

		const attribLoc = this.attributes.get('aPosition')!;

		this.context.enableVertexAttribArray(attribLoc);

		this.context.vertexAttribPointer(
			attribLoc,
			2,
			this.context.FLOAT,
			false,
			0,
			0,
		);

		// TODO - Assignar uniforms des de la funció superior draw

		console.log(
			'width: ',
			this.context.canvas.width,
			'height: ',
			this.context.canvas.height,
		);

		this.context.uniform1i(
			this.uniforms.get('uMaxIterations')!,
			parseInt(this.canvas.dataset.maxIterations),
		);

		super.assignCanonicalUniforms();

		// 6 = 2 triangles x 3 punts
		this.context.drawArrays(this.context.TRIANGLES, 0, 6);
	}
}
