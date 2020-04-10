import {Injectable} from '@angular/core';
import {Movie} from "../models/movie";
import {Observable, Subject} from "rxjs";
import {map} from "rxjs/operators";

export class CartData {
  constructor(
    public movie: Movie,
    public amount: number
  ) {
  }
}

@Injectable({
  providedIn: 'root'
})
export class CartService {
  items: Map<string, CartData> = new Map();
  private subject = new Subject<Map<string, CartData>>();

  constructor() {
  }

  get(): Observable<Map<string, CartData>> {
    return this.subject.asObservable();
  }

  getAsList(): Array<CartData> {
    let items = [];
    this.items.forEach(cartMap => {
      items.push(cartMap)
    });
    return items;
  }

  add(movie: Movie, amount: number): void {
    if (this.items.has(movie.id)) {
      let currentMovie = this.items.get(movie.id);
      currentMovie.amount += amount;
      this.items.set(movie.id, currentMovie);
    } else {
      this.items.set(movie.id, new CartData(movie, amount));
    }
    this.subject.next(this.items);
  }

  removeAll(movie: Movie): void {
    if (this.items.has(movie.id)) {
      this.items.delete(movie.id);
    }
    this.subject.next(this.items);
  }

  remove(movie: Movie, amount: number): void {
    if (this.items.has(movie.id)) {
      if (this.items.get(movie.id).amount - amount <= 0) {
        this.items.delete(movie.id)
      } else {
        let currentMovie = this.items.get(movie.id);
        currentMovie.amount -= amount;
        this.items.set(movie.id, currentMovie);
      }
    }
    this.subject.next(this.items);
  }

  clear(): void {
    this.items.clear();
    this.subject.next();
  }

  getTotal(): string {
    let total = 0.0;
    this.items.forEach((value) => {
      total += value.amount * value.movie.price
    });
    return total.toFixed(2);
  }

}
