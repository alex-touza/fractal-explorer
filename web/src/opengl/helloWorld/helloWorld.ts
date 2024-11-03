import { Fractal } from '../index.ts';
import { default as vertex } from './helloWorld.vert?raw';
import { default as fragment } from './helloWorld.frag?raw';
import { helloWorld } from '@data/fractals.ts';

export class HelloWorldFractal extends Fractal {
	public constructor() {
		super('helloWorld', helloWorld, [
			['fragment', fragment],
			['vertex', vertex],
		]);
	}

	public override begin(canvas: HTMLCanvasElement) {
		super.begin(canvas);

		if (this.context === null) throw 'context null';

		const attribLoc = this.context.getAttribLocation(
			this.program!,
			'a_position',
		);

		this.newUniform('uResolution');
		this.newUniform('uZoom');
		this.newUniform('uOffset');
		this.newUniform('uMaxIterations');

		let buffer = this.context.createBuffer();

		this.context.bindBuffer(this.context.ARRAY_BUFFER, buffer);

		this.context.bufferData(
			this.context.ARRAY_BUFFER,
			new Float32Array([
				/*Triangle esquerre*/ -1, 1, -1, -1, 1, 1, /*Triangle dret*/ -1, -1, 1,
				-1, 1, 1,
			]),
			this.context.STATIC_DRAW,
		);

		let vertArray = this.context.createVertexArray();

		this.context.bindVertexArray(vertArray);

		this.context.enableVertexAttribArray(attribLoc);

		this.context.vertexAttribPointer(
			attribLoc,
			2,
			this.context.FLOAT,
			false,
			0,
			0,
		);

		this.resizeCanvas();

		this.context.viewport(
			0,
			0,
			this.context.canvas.width,
			this.context.canvas.height,
		);
	}

	public draw() {
		if (this.context === null) throw 'context null';

		this.context.clearColor(0, 0, 0, 0);
		this.context.clear(this.context.COLOR_BUFFER_BIT);

		this.context.useProgram(this.program);

		this.context.uniform2f(
			this.uniforms.get('uResolution')!,
			this.context.canvas.width,
			this.context.canvas.height,
		);
		this.context.uniform2f(this.uniforms.get('uOffset')!, -0.25, 0);
		this.context.uniform1f(this.uniforms.get('uZoom')!, 2.5);
		this.context.uniform1i(this.uniforms.get('uMaxIterations')!, 50);

		// 6 = 2 triangles x 3 punts
		this.context.drawArrays(this.context.TRIANGLES, 0, 6);
	}
}
