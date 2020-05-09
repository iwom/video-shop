import {Component, OnInit} from '@angular/core';
import {CartService} from "../../services/cart.service";
import {animate, state, style, transition, trigger} from "@angular/animations";

@Component({
  selector: 'app-order-history',
  templateUrl: './order-history.component.html',
  styleUrls: ['./order-history.component.css'],
  animations: [
    trigger('detailExpand', [
      state('collapsed', style({height: '0px', minHeight: '0'})),
      state('expanded', style({height: '*'})),
      transition('expanded <=> collapsed', animate('225ms cubic-bezier(0.4, 0.0, 0.2, 1)')),
    ]),
  ],
})
export class OrderHistoryComponent implements OnInit {
  displayedColumns: string[] = ['created', 'items', 'total'];
  dataSource = null;
  expandedElement: null;

  constructor(
    private cartService: CartService
  ) {
  }

  ngOnInit(): void {
    this.cartService.history().subscribe(cartHistory => {
      this.dataSource = cartHistory;
    })
  }

}
