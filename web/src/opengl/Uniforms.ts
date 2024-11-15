import { type Fractal } from '@opengl/Fractal.ts';

type GLtypes = GLfloat | GLint;

abstract class UniformBase<T extends [...GLtypes[]]> {
	private values: T | [() => T];
	public name: string;
	public location: WebGLUniformLocation | null = null;
	public isRef: boolean;

	constructor(name: string, ...values: T | [() => T]) {
		this.name = name;
		this.values = values;
		this.isRef = typeof this.values[0] === 'function';
	}

	get value(): T {
		let value = this.values[0];
		return this.isRef ? (value as () => T)() : (this.values as T);
	}

	set value(values: T) {
		if (this.isRef) return;
		this.values = values;
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

export class Uniform3f extends UniformBase<[GLfloat, GLfloat, GLfloat]> {
	protected readonly func = (fractal: Fractal) => fractal.context!.uniform3f;
}

export type Uniforms =
	| Uniform1f
	| Uniform1i
	| Uniform2f
	| Uniform2i
	| Uniform3f;
