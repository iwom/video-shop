import {Injectable} from '@angular/core';
import {Movie} from "../models/movie";
import {Observable, of, Subject} from "rxjs";
import {HttpClient} from "@angular/common/http";
import {ApiProvider} from "./api.provider";
import {catchError, map} from "rxjs/operators";
import {Cart, CartLine} from "../models/cart";

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
  private cartId: string = null;
  private items: number = 0;
  private subject = new Subject<number>();


  constructor(private http: HttpClient, private api: ApiProvider) {
    this.getAll().subscribe();
  }

  get(): Observable<number> {
    return this.subject.asObservable();
  }

  getAll(): Observable<Cart> {
    return this.http.get(this.api.go().carts()).pipe(
      map(data => {
        this.cartId = data["id"]
        this.items = data["salesOrderLines"].length;
        const lines: Array<CartLine> = [];
        data["salesOrderLines"].forEach(element => {
            const movie = element["movie"]
            const movieData = new Movie(
              movie["id"], movie["title"], movie["year"], movie["runtime"], movie["genre"],
              movie["director"], movie["actors"], movie["plot"], movie["poster"],
              movie["ratings"], movie["price"], null);
            lines.push(new CartLine(movieData, element["quantity"], element["price"]))
          }
        )
        this.subject.next(this.items);
        return new Cart(data["id"], lines, data["totalPrice"])
      })
    )
  }

  add(movie: Movie, amount: number): Observable<any> {
    return this.http.post(this.api.go().carts(), {
      'movie': movie,
      'quantity': amount
    }).pipe(
      catchError(err => {
        console.error(err)
        return err
      }),
      map(result => {
        console.log(result)
        return result
      })
    )
  }

  removeAll(): Observable<any> {
    return this.http.delete(this.api.go().cart(this.cartId)).pipe(
      catchError(err => {
        console.error(err)
        return err
      }),
      map(result => {
        console.log(result)
        return result
      })
    )
  }

  remove(movie: Movie, amount: number): Observable<any> {
    return this.http.request('delete' ,this.api.go().carts(), {
      body: {
        'movie': movie,
        'quantity': amount
      }
    }).pipe(
      catchError(err => {
        console.error(err)
        return err
      }),
      map(result => {
        console.log(result)
        return result
      })
    )
  }
}
