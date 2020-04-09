import {Component, OnDestroy, OnInit} from '@angular/core';
import {TokenStorageService} from "./services/token.service";
import {Router} from "@angular/router";
import {CartService} from "./services/cart.service";
import {Subscription} from "rxjs";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit, OnDestroy {
  title = 'webclient';
  cartSize = 0;
  subscription: Subscription;

  constructor(
    private tokenStorageService: TokenStorageService,
    private router: Router,
    private cartService: CartService
  ) {
    this.subscription = this.cartService.get().subscribe(cart => {
      this.cartSize = cart.size;
    });
  }

  ngOnInit() {
    if (this.isLoggedIn()) {
      this.router.navigate(["/movies"]);
    }
  }

  ngOnDestroy() {
    this.subscription.unsubscribe();
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

  isAdmin() {
    if (!this.isLoggedIn()) return false;
    const user = this.tokenStorageService.getUser();
    return user.roles.includes("ADMIN");
  }
}
