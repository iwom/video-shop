import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FlexModule } from "@angular/flex-layout";

import { authInterceptorProviders } from './interceptors/auth.interceptor';
import { LoginComponent } from './components/login/login.component';
import { SignupComponent } from './components/signup/signup.component';
import { ApiProvider } from "./services/api.provider";

import { AngularMaterialModule } from './modules/material.module';
import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {MovieDialog, MovieListComponent} from './components/movie-list/movie-list.component';
import { MovieCardComponent } from './components/movie-card/movie-card.component';
import { CartComponent } from './components/cart/cart.component';
import { MovieService } from "./services/movie.service";
import { OrderHistoryComponent } from './components/order-history/order-history.component';
import { CartSidenavComponent } from './components/cart-sidenav/cart-sidenav.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    SignupComponent,
    MovieListComponent,
    MovieCardComponent,
    CartComponent,
    OrderHistoryComponent,
    CartSidenavComponent,
    MovieDialog
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
export class AppModule { }
