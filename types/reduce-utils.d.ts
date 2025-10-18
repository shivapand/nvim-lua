// Utility types for better reduce callback inference
type InferReduceCallback<T, U> = T extends (infer R)[] 
  ? (memo: R[], current: T[number], index: number, array: T[]) => R[]
  : never;

// Helper type to infer reduce callback from initial value
type InferFromInitial<T> = T extends (infer U)[] 
  ? U[] 
  : never;

// More specific reduce type that preserves array inference
type ArrayReduce<T, U> = T extends (infer R)[] 
  ? (memo: R[], current: T[number], index: number, array: T[]) => R[]
  : (memo: U[], current: T[number], index: number, array: T[]) => U[];

// Global declaration to make these available
declare global {
  type ReduceCallback<T, U> = ArrayReduce<T, U>;
  type InferMemo<T> = InferFromInitial<T>;
}