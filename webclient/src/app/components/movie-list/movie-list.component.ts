import {Component, OnInit} from '@angular/core';
import {Movie} from "../../models/movie";
import {MovieService} from "../../services/movie.service";
import {PageEvent} from "@angular/material/paginator";
import {MatDialog} from "@angular/material/dialog";
import {MovieDialogComponent} from "../movie-dialog/movie-dialog.component";
import {MatSnackBar} from "@angular/material/snack-bar";
import {CartService} from "../../services/cart.service";


export interface MovieDialogData {
  movie: Movie,
  amount: number
}

@Component({
  selector: 'app-movie-list',
  templateUrl: './movie-list.component.html',
  styleUrls: ['./movie-list.component.css']
})
export class MovieListComponent implements OnInit {
  pageEvent: PageEvent;
  length = 100;
  pageSize = 16;
  pageSizeOptions: number[] = [8, 16, 24, 40];

  breakpoint = 4;
  movieList: Movie[] = [];

  constructor(
    public dialog: MatDialog,
    private movieService: MovieService,
    private snackBar: MatSnackBar,
    private cartService: CartService
  ) {
  }


  ngOnInit(): void {
    this.resize(window);
    this.movieService.fetch(this.pageSize, 0).subscribe(
      data => {
        this.movieList = data.movies;
        this.length = data.count;
      }
    );
  }

  openDialog(movie: Movie): void {
    const dialogRef = this.dialog.open(MovieDialogComponent, {
      minWidth: "32rem",
      minHeight: "20rem",
      data: {movie: movie, amount: 0}
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result.amount > 0) {
        this.cartService.add(result.movie, result.amount);
        this.snackBar.open("\'" + result.movie.title + "\' added to cart", "Dismiss", {duration: 3000});
      }
    });
  }

  onAddToCart(movie: Movie): void {
    this.cartService.add(movie, 1);
    this.snackBar.open("\'" + movie.title + "\' added to cart", "Dismiss", {duration: 3000});
  }

  onPageChange(event: PageEvent) {
    this.movieService.fetch(event.pageSize, event.pageIndex * event.pageSize).subscribe(
      data => {
        this.movieList = data.movies;
        this.length = data.count;
      }
    );
    return event;
  }

  onResize(event) {
    this.resize(event.target);
  }

  trimPlot(plot: string): string {
    let sliced = plot.slice(0, 150);
    if (plot.length > 150) {
      return sliced + " (...)";
    } else {
      return sliced;
    }
  }

  private resize(window: Window) {
    if (window.innerWidth > 1400) {
      this.breakpoint = 4;
    } else if (window.innerWidth > 1100) {
      this.breakpoint = 3;
    } else if (window.innerWidth > 900) {
      this.breakpoint = 2;
    } else {
      this.breakpoint = 1;
    }
  }

}

