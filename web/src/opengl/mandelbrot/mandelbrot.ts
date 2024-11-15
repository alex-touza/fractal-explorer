import { Fractal, type FractalCanvas } from '../Fractal.ts';
import { default as vertex } from './mandelbrot.vert?raw';
import { default as fragment } from './mandelbrot.frag?raw';
import { mandelbrot } from '@data/fractals.ts';
import { Uniform1f, Uniform1i } from '@opengl/Uniforms.ts';

export class MandelbrotFractal extends Fractal {
	private buffer: WebGLBuffer | null = null;

	public constructor() {
		super(
			'mandelbrot',
			mandelbrot,
			[
				['fragment', fragment],
				['vertex', vertex],
			],
			[
				new Uniform1i('uMaxIterations', () => [
					parseInt(
						(document.getElementById('iterationsSlider') as HTMLInputElement)
							.value as string,
					),
				]),
				new Uniform1f('uColor', 0.1),
			],
		);
	}

	public override begin(canvas: FractalCanvas) {
		super.begin(canvas);

		this.home();

		if (this.context === null) throw 'context null';

		this.newAttribute('aTriPosition'); // Posició dels vèrtexs dels triangles

		this.buffer = this.context.createBuffer();

		this.canvas?.addEventListener('click', (event: MouseEvent) => {
			console.log('mouse screen pos', event.clientX, event.clientY);
			console.log(
				'mouse plane pos',
				this.screenToPlane(event.clientX, event.clientY),
			);
		});

		document
			.getElementById('iterationsSlider')!
			.addEventListener('change', () => {
				if (Date.now() - this.lastDraw > 200) {
					this.draw();
				}
			});
	}

	public override draw() {
		if (this.context === null) throw 'context null';

		super.draw();

		if (this.canvas?.width === 0) throw 'canvas width 0';
		if (!this.canvas?.dataset) throw 'canvas dataset not set';

		this.context.bindBuffer(this.context.ARRAY_BUFFER, this.buffer!);

		this.context.bufferData(
			this.context.ARRAY_BUFFER,
			new Float32Array([-1, 1, -1, -1, 1, 1, 1, -1]),
			this.context.STATIC_DRAW,
		);

		let vertArray = this.context.createVertexArray();

		this.context.bindVertexArray(vertArray);

		const attribLoc = this.attributes.get('aTriPosition')!;

		this.context.enableVertexAttribArray(attribLoc);

		this.context.vertexAttribPointer(
			attribLoc,
			2,
			this.context.FLOAT,
			false,
			0,
			0,
		);

		super.assignUniforms();
		this.context.drawArrays(this.context.TRIANGLE_STRIP, 0, 4);
	}

	public override home() {
		this.uPosition.value = [-0.5, 0];
		this.uPlaneWidth.value = [4];
	}
}
