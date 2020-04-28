import {Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {ApiProvider} from "./api.provider";
import {Observable, of} from "rxjs";
import {catchError, map} from "rxjs/operators";
import {Movie} from "../models/movie";

@Injectable()
export class MovieService {
  constructor(private http: HttpClient, private api: ApiProvider) { }

  public fetch(limit: number, offset: number, title: string = ""): Observable<any> {
    return this.http.get(this.api.go().movies(offset, limit, title)).pipe(
      map(data => {
        let movies: Array<Movie> = [];
        data["movies"].forEach(element => {
          let movie = element["movie"];
          let inventory = element["inventory"];
          movies.push(
            new Movie(
              movie["id"], movie["title"], movie["year"], movie["runtime"], movie["genre"],
              movie["director"], movie["actors"], movie["plot"], movie["poster"],
              movie["ratings"], movie["price"], inventory["value"])
          )
        });
        return {
          "movies": movies,
          "count": data["total"]
        }
      }),
      catchError(err => {
        console.error(err);
        return of({})
      })
    )
  }
}
