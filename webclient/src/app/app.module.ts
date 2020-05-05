import {BrowserModule} from '@angular/platform-browser';
import {CUSTOM_ELEMENTS_SCHEMA, NgModule} from '@angular/core';

import {AppRoutingModule} from './app-routing.module';
import {AppComponent} from './app.component';

import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {FlexModule} from "@angular/flex-layout";

import {authInterceptorProviders} from './interceptors/auth.interceptor';
import {LoginComponent} from './components/login/login.component';
import {SignupComponent} from './components/signup/signup.component';
import {ApiProvider} from "./services/api.provider";

import {AngularMaterialModule} from './modules/material.module';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {MovieListComponent} from './components/movie-list/movie-list.component';
import {CartComponent} from './components/cart/cart.component';
import {MovieService} from "./services/movie.service";
import {OrderHistoryComponent} from './components/order-history/order-history.component';
import {MovieDialogComponent} from "./components/movie-dialog/movie-dialog.component";
import {AdminPanelComponent} from './components/admin-panel/admin-panel.component';
import {CartDialogComponent} from "./components/cart-dialog/cart-dialog.component";

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    SignupComponent,
    MovieListComponent,
    CartComponent,
    CartDialogComponent,
    OrderHistoryComponent,
    MovieDialogComponent,
    AdminPanelComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    AngularMaterialModule,
    FlexModule,
    BrowserAnimationsModule
  ],
  providers: [authInterceptorProviders, ApiProvider, MovieService],
  bootstrap: [AppComponent],
  schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class AppModule {
}
