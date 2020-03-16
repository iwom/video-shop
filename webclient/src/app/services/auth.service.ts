import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ApiProvider } from "./api.provider";
import {User, UserCredentials} from "../models/user";

const httpOptions = {
  headers: new HttpHeaders({ 'Content-Type': 'application/json' })
};

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private http: HttpClient, private api: ApiProvider) { }

  login(userCredentials: UserCredentials): Observable<any> {
    return this.http.post(this.api.go().signIn(), {
      username: userCredentials.username,
      password: userCredentials.password
    }, httpOptions);
  }

  register(user: User): Observable<any> {
    return this.http.post(this.api.go().signUp(), {
      username: user.username,
      email: user.email,
      password: user.password
    }, httpOptions);
  }
}
