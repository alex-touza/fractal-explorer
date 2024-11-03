export type Writeable<T> = { -readonly [P in keyof T]: T[P] };

export function cast<T>(it: any): T {
    return it;
}