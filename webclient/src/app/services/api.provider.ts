import {Injectable} from '@angular/core';
import {environment} from '../../environments/environment';

@Injectable()
export class ApiProvider {
  host = environment.host;
  paths = {
    root: () => `/`,
    signIn: () => `${this.host}/auth/signin`,
    signUp: () => `${this.host}/auth/signup`,
    movies: (offset: number, limit: number, title: string) =>
      `${this.host}/movies?offset=${offset}&limit=${limit}&title=${title}`,
    carts: () => `${this.host}/carts`,
    cart: (cartId: string) => `${this.host}/carts/${cartId}`,
    history: () => `${this.host}/carts/historical`,
    finalize: (cartId: string) => `${this.host}/carts/finalize/${cartId}`
  };

  go() {
    return this.paths;
  }
}
