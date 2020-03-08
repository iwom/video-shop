import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ApiProvider } from "./api.provider";

const httpOptions = {
  headers: new HttpHeaders({ 'Content-Type': 'application/json' })
};

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private http: HttpClient, private api: ApiProvider) { }

  login(credentials): Observable<any> {
    return this.http.post(this.api.go().login(), {
      username: credentials.username,
      password: credentials.password
    }, httpOptions);
  }

  register(user): Observable<any> {
    return this.http.post(this.api.go().signup(), {
      username: user.username,
      email: user.email,
      password: user.password
    }, httpOptions);
  }
}
