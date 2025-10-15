export type Json =
  | string
  | number
  | boolean
  | null
  | { [k: string]: Json }
  | Json[];

export type Row = Record<string, Json>;
export type DataSet = Record<string, Row[]>;
