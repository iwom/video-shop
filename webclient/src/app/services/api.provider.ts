import {Injectable} from '@angular/core';
import {environment} from '../../environments/environment';

@Injectable()
export class ApiProvider {
  host = environment.host;
  paths = {
    root: () => `/`,
    signIn: () => `${this.host}/auth/signin`,
    signUp: () => `${this.host}/auth/signup`
  };
  go() {
    return this.paths;
  }
}
