import { Component, OnInit } from '@angular/core';
import {Movie} from "../../models/movie";
import {MovieService} from "../../services/movie.service";
import {PageEvent} from "@angular/material/paginator";

@Component({
  selector: 'app-movie-list',
  templateUrl: './movie-list.component.html',
  styleUrls: ['./movie-list.component.css']
})
export class MovieListComponent implements OnInit {
  pageEvent: PageEvent;
  length = 100;
  pageSize = 20;
  pageSizeOptions: number[] = [20, 40, 60, 100];

  breakpoint = 4;
  movieList: Movie[]= [];

  constructor(private movieService: MovieService) {}


  ngOnInit(): void {
    this.resize(window);
    const response = this.movieService.fetch(this.pageSize, 0);
    this.movieList = response.movies;
    this.length = response.count;
  }

  onPageChange(event: PageEvent){
    const response = this.movieService.fetch(event.pageSize, event.pageIndex * event.pageSize);
    this.movieList = response.movies;
    this.length = response.count;
    return event;
  }

  onResize(event) {
    this.resize(event.target);
  }

  private resize(window: Window) {
    if (window.innerWidth > 1400) { this.breakpoint = 4; } else
    if (window.innerWidth > 1100) { this.breakpoint = 3; } else
    if (window.innerWidth > 900) { this.breakpoint = 2; } else
    { this.breakpoint = 1; }
  }

}
