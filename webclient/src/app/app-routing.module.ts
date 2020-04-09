import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {LoginComponent} from "./components/login/login.component";
import {SignupComponent} from "./components/signup/signup.component";
import {CartComponent} from "./components/cart/cart.component";
import {MovieListComponent} from "./components/movie-list/movie-list.component";
import {OrderHistoryComponent} from "./components/order-history/order-history.component";
import {AdminPanelComponent} from "./components/admin-panel/admin-panel.component";

const routes: Routes = [
  {path: '', pathMatch: 'full', redirectTo: 'movies'},
  {path: 'login', component: LoginComponent},
  {path: 'signup', component: SignupComponent},
  {path: 'cart', component: CartComponent},
  {path: 'movies', component: MovieListComponent},
  {path: 'order-history', component: OrderHistoryComponent},
  {path: 'admin-panel', component: AdminPanelComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})

export class AppRoutingModule {
}
