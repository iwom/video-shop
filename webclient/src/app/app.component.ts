import {Component, OnInit} from '@angular/core';
import {TokenStorageService} from "./services/token.service";
import {Router} from "@angular/router";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  title = 'webclient';

  constructor(
    private tokenStorageService: TokenStorageService,
    private router: Router
  ) {
  }

  ngOnInit() {
    if (this.isLoggedIn()) {
      this.router.navigate(["/movies"]);
    }
  }

  isLoggedIn() {
    return !!this.tokenStorageService.getToken()
  }

  signOut() {
    this.tokenStorageService.signOut();
    this.router.navigate(["/login"]);
  }

  getCurrentUser() {
    if (this.isLoggedIn()) {
      return this.tokenStorageService.getUser().username;
    }
  }
}
