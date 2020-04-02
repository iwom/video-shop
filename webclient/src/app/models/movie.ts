export class Movie {
  constructor(
    readonly id: string,
    readonly title: string,
    readonly year: string,
    readonly runtime: string,
    readonly genre: string,
    readonly director: string,
    readonly actors: string,
    readonly plot: string,
    readonly posterUrl: string,
    readonly ratings: Array<Rating>,
    readonly price: number
  ) {}
}

export class Rating {
  constructor(
    readonly source: string,
    readonly value: string
  ) {}
}
