interface ShaderType {
    name: string;
    extension: string;
    constant: () => number;
}

export const shaderTypes = {
    fragment: {
        name: "fragment",
        extension: "frag",
        constant: () => WebGL2RenderingContext.FRAGMENT_SHADER
    },
    vertex: {
        name: "vertex",
        extension: "vert",
        constant: () => WebGL2RenderingContext.VERTEX_SHADER
    }
} as const satisfies Record<string, ShaderType>;

