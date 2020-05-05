import {Component, OnInit} from '@angular/core';
import {CartService} from "../../services/cart.service";
import {Movie} from "../../models/movie";
import {switchMap} from "rxjs/operators";

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css']
})
export class CartComponent implements OnInit {
  displayedColumns: string[] = ['poster', 'name', 'price', 'amount', 'subtotal', 'add', 'remove', 'delete'];
  dataSource = null;
  total: number = 0;

  constructor(private cartService: CartService) {
  }

  ngOnInit(): void {
    this.cartService.getAll().subscribe(data => {
      console.log(data)
      this.dataSource = data.lines;
      this.total = data.total;
    })
  }

  add(movie: Movie) {
    this.cartService.add(movie, 1).pipe(
      switchMap(_ => this.cartService.getAll())
    ).subscribe(data => {
      console.log(data);
      this.dataSource = data.lines;
      this.total = data.total;
    });
  }

  remove(movie: Movie) {
    this.cartService.remove(movie, 1).pipe(
      switchMap(_ => this.cartService.getAll())
    ).subscribe(data => {
      console.log(data);
      this.dataSource = data.lines;
      this.total = data.total;
    });
  }

  removeAll(movie: Movie) {
    const line = this.dataSource.find(element => element.movie.id == movie.id);
    this.cartService.remove(movie, line.quantity).pipe(
      switchMap(_ => this.cartService.getAll())
    ).subscribe(data => {
      console.log(data);
      this.dataSource = data.lines;
      this.total = data.total;
    });
  }

  getTotal() {
    return this.total.toString() + " PLN";
  }

}
