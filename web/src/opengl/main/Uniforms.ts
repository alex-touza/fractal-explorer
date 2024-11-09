import { type Fractal } from '@opengl/main/Fractal.ts';

type GLtypes = GLfloat | GLint;

class MyClass {
	public MyProp = '';
}

abstract class UniformBase<T extends [...GLtypes[]]> {
	public name: string;
	public values: T | [() => T];
	public location: WebGLUniformLocation | null = null;

	constructor(name: string, ...values: T | [() => T]) {
		this.name = name;
		this.values = values;
	}

	get value() {
		let value = this.values[0];
		return typeof value === 'function' ? value() : value;
	}

	public locate(fractal: Fractal) {
		const loc = fractal.context!.getUniformLocation(
			fractal.program!,
			this.name,
		);
		if (loc === null) throw 'location is null';
		this.location = loc;
	}

	public set(fractal: Fractal) {
		this.func(fractal.context!)(
			this.name,
			...(typeof this.values[0] === 'function'
				? this.values[0]()
				: (this.values as T)),
		);
	}

	protected abstract readonly func: (
		context: WebGL2RenderingContext,
	) => (name: string, ...values: T) => void;
}

export class Uniform1i extends UniformBase<[GLint]> {
	protected readonly func = (context: WebGL2RenderingContext) =>
		context.uniform1i;
}

export class Uniform1f extends UniformBase<[GLfloat]> {
	protected readonly func = (context: WebGL2RenderingContext) =>
		context.uniform1f;
}

export class Uniform2f extends UniformBase<[GLfloat, GLfloat]> {
	protected readonly func = (context: WebGL2RenderingContext) =>
		context.uniform2f;
}

export type Uniforms = Uniform1f | Uniform1i | Uniform2f;
