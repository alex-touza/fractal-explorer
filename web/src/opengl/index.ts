import { shaderTypes } from './shaderTypes.ts';
import type { FractalInfo } from '@data/fractal.ts';

export abstract class Fractal {
	public id: string;
	public info: FractalInfo;

	protected context: WebGL2RenderingContext | null = null;
	protected canvas: HTMLCanvasElement | null = null;
	protected program: WebGLProgram | null = null;
	public shaders: [keyof typeof shaderTypes, string][];

	protected uniforms: Map<string, WebGLUniformLocation> = new Map();

	private loadShader(shaderType: keyof typeof shaderTypes, source: string) {
		if (this.context === null) throw 'context is null';

		const shader = this.context.createShader(
			shaderTypes[shaderType].constant(),
		)!;

		this.context.shaderSource(shader, source);

		this.context.compileShader(shader);

		if (!this.context.getShaderParameter(shader, this.context.COMPILE_STATUS)) {
			alert(
				`An error occurred compiling the shaders: ${this.context.getShaderInfoLog(shader)}`,
			);
			this.context.deleteShader(shader);
			return null;
		}

		return shader;
	}

	// https://webgl2fundamentals.org/webgl/lessons/webgl-resizing-the-canvas.html
	protected resizeCanvas() {
		if (this.canvas === null) throw 'canvas is null';

		const displayWidth = this.canvas.clientWidth;
		const displayHeight = this.canvas.clientHeight;

		const needResize =
			this.canvas.width !== displayWidth ||
			this.canvas.height !== displayHeight;

		if (needResize) {
			this.canvas.width = displayWidth;
			this.canvas.height = displayHeight;
		}

		return needResize;
	}

	protected newUniform(name: string): WebGLUniformLocation {
		const loc = this.context!.getUniformLocation(this.program!, name);
		if (loc === null) throw 'location is null';

		this.uniforms.set(name, loc);

		return loc;
	}

	protected constructor(
		id: string,
		info: FractalInfo,
		shaders: [keyof typeof shaderTypes, string][],
	) {
		this.id = id;
		this.info = info;
		this.shaders = shaders;
	}

	public begin(canvas: HTMLCanvasElement) {
		this.canvas = canvas;
		this.context = this.canvas.getContext('webgl2')!;
		this.program = this.context.createProgram();

		if (!this.program || !this.context) throw 'program or context null';

		this.shaders.forEach(([type, source]) => {
			let shader = this.loadShader(type, source);
			if (!shader) return;
			this.context!.attachShader(this.program!, shader);
		});

		this.context.linkProgram(this.program);

		if (
			!this.context.getProgramParameter(this.program, this.context.LINK_STATUS)
		) {
			alert(
				`An error occurred linking the program:  ${this.context.getProgramInfoLog(this.program)}`,
			);
			this.context.deleteProgram(this.program);
		}
	}
}
/*
function init(gl: WebGL2RenderingContext) {
    gl.clearColor(0.0, 0.0, 0.0, 1.0);

    gl.clear(gl.COLOR_BUFFER_BIT);
}


function initShaderProgram(gl: WebGL2RenderingContext, vsSource: string, fsSource: string) {
    const vertexShader = loadShader(gl, gl.VERTEX_SHADER, vsSource)!;
    const fragmentShader = loadShader(gl, gl.FRAGMENT_SHADER, fsSource)!;

    // Create the shader program

    const shaderProgram = gl.createProgram()!;
    gl.attachShader(shaderProgram, vertexShader);
    gl.attachShader(shaderProgram, fragmentShader);
    gl.linkProgram(shaderProgram);

    // If creating the shader program failed, alert

    if (!gl.getProgramParameter(shaderProgram, gl.LINK_STATUS)) {
        alert(
            `Unable to initialize the shader program: ${gl.getProgramInfoLog(
                shaderProgram,
            )}`,
        );
        return null;
    }

    return shaderProgram;
}
function loadShader(gl: WebGL2RenderingContext, type: number, source: string) {
    const shader = gl.createShader(type)!;

    gl.shaderSource(shader, source);

    gl.compileShader(shader);

    // See if it compiled successfully

    if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
        alert(
            `An error occurred compiling the shaders: ${gl.getShaderInfoLog(shader)}`,
        );
        gl.deleteShader(shader);
        return null;
    }

    return shader;
}

 */
