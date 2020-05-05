import {Movie} from "./movie";

export class Cart {
  constructor(
    readonly id: string,
    readonly lines: Array<CartLine>,
    readonly total: number
  ) {
  }
}

export class CartLine {
  constructor(
    readonly movie: Movie,
    readonly quantity: number,
    readonly price: number
  ) {
  }
}
