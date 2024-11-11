import { type Fractal } from '@opengl/main/Fractal.ts';

type GLtypes = GLfloat | GLint;

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
		if (!this.location) throw 'location is null';

		this.func(fractal).bind(fractal.context!)(
			this.location,
			...(typeof this.values[0] === 'function'
				? this.values[0]()
				: (this.values as T)),
		);
	}

	protected abstract readonly func: (
		fractal: Fractal,
	) => (location: WebGLUniformLocation, ...values: T) => void;
}

export class Uniform1i extends UniformBase<[GLint]> {
	protected readonly func = (fractal: Fractal) => fractal.context!.uniform1i;
}

export class Uniform1f extends UniformBase<[GLfloat]> {
	protected readonly func = (fractal: Fractal) => fractal.context!.uniform1f;
}

export class Uniform2f extends UniformBase<[GLfloat, GLfloat]> {
	protected readonly func = (fractal: Fractal) => fractal.context!.uniform2f;
}

export class Uniform2i extends UniformBase<[GLfloat, GLfloat]> {
	protected readonly func = (fractal: Fractal) => fractal.context!.uniform2i;
}

export type Uniforms = Uniform1f | Uniform1i | Uniform2f | Uniform2i;
