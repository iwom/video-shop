import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from "./components/login/login.component";
import { SignupComponent } from "./components/signup/signup.component";
import { CartComponent } from "./components/cart/cart.component";
import { MovieListComponent } from "./components/movie-list/movie-list.component";
import { MovieCardComponent } from "./components/movie-card/movie-card.component";

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'login' },
  { path: 'login', component: LoginComponent },
  { path: 'signup', component: SignupComponent },
  { path: 'cart', component: CartComponent},
  { path: 'movies', component: MovieListComponent},
  { path: 'movies/:id', component: MovieCardComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})

export class AppRoutingModule { }
