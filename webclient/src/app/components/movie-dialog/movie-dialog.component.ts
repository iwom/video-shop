import {Component, Inject} from "@angular/core";
import {MAT_DIALOG_DATA} from "@angular/material/dialog";
import {MovieDialogData} from "../movie-list/movie-list.component";

@Component({
  selector: 'movie-dialog',
  templateUrl: 'movie-dialog.component.html',
  styleUrls: ['./movie-dialog.component.css']

})
export class MovieDialogComponent {
  amount: number = 0;

  constructor(@Inject(MAT_DIALOG_DATA) public data: MovieDialogData) {
    this.data.amount = this.amount;
  }

  add(): void {
    if (this.amount < this.data.movie.inventory) {
      this.amount += 1;
    }
    this.data.amount = this.amount;
  }

  remove(): void {
    if (this.amount > 0) {
      this.amount -= 1;
    }
    this.data.amount = this.amount;
  }

  getButtonText(): string {
    if (this.amount > 0) {
      return "Order, " + ((this.amount * this.data.movie.price).toFixed(2)).toString() + " PLN"
    }
    return "Order"
  }

  isAvailable(): boolean {
    return this.data.movie.inventory > 0;
  }
}
