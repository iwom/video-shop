import {Component, OnInit} from '@angular/core';
import {CartService} from "../../services/cart.service";
import {Movie} from "../../models/movie";

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css']
})
export class CartComponent implements OnInit {
  displayedColumns: string[] = ['poster', 'name', 'price', 'amount', 'add', 'remove', 'delete'];
  dataSource = null;

  constructor(private cartService: CartService) {
  }

  ngOnInit(): void {
    this.dataSource = this.cartService.getAsList();
  }

  add(movie: Movie) {
    this.cartService.add(movie, 1);
    this.dataSource = this.cartService.getAsList();
  }

  remove(movie: Movie) {
    this.cartService.remove(movie, 1);
    this.dataSource = this.cartService.getAsList();
  }

  removeAll(movie: Movie) {
    this.cartService.removeAll(movie);
    this.dataSource = this.cartService.getAsList();
  }

  getTotal() {
    return this.cartService.getTotal() + " PLN";
  }

}
