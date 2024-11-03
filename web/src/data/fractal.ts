//type DrawFunction = (canvas: HTMLCanvasElement) => void

export interface FractalInfo {
	name: string;
	id: string;
	descr: string;
	thumbnailPath: string;

	/*
    getShaders() {
        return (Object.keys(shaderTypes) as (keyof typeof shaderTypes)[]).map(
            async (type) => ({
                source: (await import(`../opengl/${this.id}/${this.id}.${shaderTypes[type].extension}?raw`)).default as string,
                type,
            })
        )
    }
    */

	/*
        begin(canvas: HTMLCanvasElement) {
            let gl = canvas.getContext("webgl2")
            if (!gl) {
                alert("El teu navegador no funciona amb WebGL2");
                return
            }

            let program = new Fractal;

        }

    */
}

/*


Fitxa del fractal:

Dimensió

IFS

Sistema de Leidenmeyer

 */
