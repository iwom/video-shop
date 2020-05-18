import {Component, OnInit} from '@angular/core';
import {Movie} from "../../models/movie";
import {MovieService} from "../../services/movie.service";
import {PageEvent} from "@angular/material/paginator";
import {MatDialog} from "@angular/material/dialog";
import {MovieDialogComponent} from "../movie-dialog/movie-dialog.component";
import {MatSnackBar} from "@angular/material/snack-bar";
import {CartService} from "../../services/cart.service";
import {TokenStorageService} from "../../services/token.service";
import {Router} from "@angular/router";
import {FormControl, FormGroup} from "@angular/forms";
import {debounceTime, map, switchMap} from "rxjs/operators";

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
  pageIndex = 0;
  pageSizeOptions: number[] = [8, 16, 24, 40];

  breakpoint = 4;
  movieList: Movie[] = [];
  searchText = ''

  nameFormControl = new FormControl('')
  movieSearchForm = new FormGroup({
    name: this.nameFormControl
  });

  constructor(
    public dialog: MatDialog,
    private movieService: MovieService,
    private snackBar: MatSnackBar,
    private router: Router,
    private cartService: CartService,
    private tokenStorageService: TokenStorageService
  ) {
  }

  ngOnInit(): void {
    this.resize(window);
    this.movieService.fetch(this.pageSize, 0, this.searchText).subscribe(
      data => {
        this.movieList = data.movies;
        this.length = data.count;
      }
    );
    this.nameFormControl.valueChanges.pipe(
      debounceTime(500),
      map(title => {
        this.pageIndex = 0;
        this.searchText = title;
        return this.searchText;
      }),
      switchMap(title => this.movieService.fetch(this.pageSize, this.pageSize * this.pageIndex, title))
    ).subscribe(
      data => {
        this.movieList = data.movies;
        this.length = data.count;
      }
    )
  }

  openDialog(movie: Movie): void {
    const dialogRef = this.dialog.open(MovieDialogComponent, {
      minWidth: "32rem",
      minHeight: "20rem",
      data: {movie: movie, amount: 0}
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result.amount > 0) {
        this.cartService.add(result.movie, result.amount).pipe(
          switchMap(_ => this.cartService.getAll())
        ).subscribe(_ => {
          this.snackBar.open("\'" + result.movie.title + "\' added to cart", "Dismiss", {duration: 3000});
        });
      }
    });
  }

  onAddToCart(movie: Movie): void {
    this.cartService.add(movie, 1).pipe(
      switchMap(_ => this.cartService.getAll())
    ).subscribe(_ => {
      this.snackBar.open("\'" + movie.title + "\' added to cart", "Dismiss", {duration: 3000});
    });
    this.movieService.fetch(this.pageSize, 0, this.searchText).subscribe(
      data => {
        this.movieList = data.movies;
        this.length = data.count;
      }
    );
  }

  onPageChange(event: PageEvent) {
    this.pageIndex = event.pageIndex;
    this.pageSize = event.pageSize;
    this.movieService.fetch(this.pageSize, this.pageIndex * this.pageSize, this.searchText).subscribe(
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

  isLoggedIn() {
    return !!this.tokenStorageService.getToken()
  }

  isAdmin() {
    if (!this.isLoggedIn()) return false;
    const user = this.tokenStorageService.getUser();
    return user.roles.includes("ADMIN");
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

  goToAdminPanel() {
    this.router.navigate(['/admin-panel'])
  }
}

