import {Injectable} from '@angular/core';
import {Movie} from "../models/movie";
import {Observable, Subject} from "rxjs";
import {HttpClient} from "@angular/common/http";
import {ApiProvider} from "./api.provider";
import {catchError, map} from "rxjs/operators";

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
  cartId: string = null;
  private subject = new Subject<Map<string, CartData>>();

  constructor(private http: HttpClient, private api: ApiProvider) {
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
      if (currentMovie.movie.inventory >= currentMovie.amount + amount) {
        this.callAdd(movie, amount).subscribe(
          data => {
            console.log(data)
            currentMovie.amount += amount;
            this.items.set(movie.id, currentMovie);
          },
          err => {
            console.error(err);
          }
        );
      }
    } else {
      if (movie.inventory >= amount) {
        this.callAdd(movie, amount).subscribe(
          data => {
            console.log(data);
            this.items.set(movie.id, new CartData(movie, amount));
          },
          err => {
            console.error(err);
          }
        );
      }
    }
    this.subject.next(this.items);
  }

  private callAdd(movie: Movie, amount: number): Observable<any> {
    return this.http.post(this.api.go().carts(), {
      'movie': movie,
      'quantity': amount
    })
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
        let absAmount = Math.abs(this.items.get(movie.id).amount - amount)
        this.callRemove(movie, absAmount).subscribe(
          data => {
            console.log(data)
            this.items.delete(movie.id)
          },
          err => {
            console.error(err);
          }
        )
      } else {
        this.callRemove(movie, amount).subscribe(
          data => {
            console.log(data)
            let currentMovie = this.items.get(movie.id);
            currentMovie.amount -= amount;
            this.items.set(movie.id, currentMovie);
            },
          err => {
            console.error(err);
          }
        )
      }
    }
    this.subject.next(this.items);
  }

  private callRemove(movie: Movie, amount: number): Observable<any> {
    return this.http.request('delete' ,this.api.go().carts(), {
      body: {
        'movie': movie,
        'quantity': amount
      }
    })
  }

  getTotal(): string {
    let total = 0.0;
    this.items.forEach((value) => {
      total += value.amount * value.movie.price
    });
    return total.toFixed(2);
  }

}
