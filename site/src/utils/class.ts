interface IStyles {
  readonly [key: string]: string;
}

export const multiclass = (styles: IStyles, ...classes: (string | undefined)[]): string => classes
  .filter((v) => !!v)
  .map((v) => styles[v as string])
  .join(' ')
