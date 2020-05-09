import {Component, Input, OnInit} from "@angular/core";


@Component({
  selector: 'app-order-history-lines',
  templateUrl: './order-history-lines.component.html',
  styleUrls: ['./order-history-lines.component.css']
})
export class OrderHistoryLinesComponent implements OnInit {
  displayedColumns: string[] = ['poster', 'name', 'price', 'amount', 'subtotal']
  @Input()
  dataSource = null;

  constructor() {
  }

  ngOnInit(): void {
  }

}
