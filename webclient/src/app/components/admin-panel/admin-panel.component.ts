import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup} from "@angular/forms";
import {MovieService} from "../../services/movie.service";
import {debounceTime, switchMap} from "rxjs/operators";
import {CartDialogComponent} from "../cart-dialog/cart-dialog.component";
import {MatDialog} from "@angular/material/dialog";
import {AdminDialogComponent} from "../admin-dialog/admin-dialog.component";
import {Router} from "@angular/router";

@Component({
  selector: 'app-admin-panel',
  templateUrl: './admin-panel.component.html',
  styleUrls: ['./admin-panel.component.css']
})
export class AdminPanelComponent implements OnInit {
  movieForm = new FormGroup({
    title: new FormControl(''),
    amount: new FormControl(0),
    price: new FormControl(0.00)
  })
  options = [];
  movie = null;

  constructor(
    private dialog: MatDialog,
    private router: Router,
    private movieService: MovieService
  ) {
  }

  ngOnInit(): void {
    this.movieForm.controls['title'].valueChanges.pipe(
      debounceTime(500),
      switchMap(title => this.movieService.getByTitle(title))
    ).subscribe(
      movie => {
        this.movie = movie;
        this.options = [movie.title]
      }
    )
  }

  onSubmit() {
    this.movieService.add(this.movieForm.value.title, this.movieForm.value.price, this.movieForm.value.amount)
      .subscribe(data => {
        const dialogRef = this.dialog.open(AdminDialogComponent, {
          data: {
            movie: this.movie,
            quantity: this.movieForm.value.amount,
            price: this.movieForm.value.price
          }
        });
        dialogRef.afterClosed().subscribe(_ => this.router.navigate(['/movies']))
      })
  }
}
