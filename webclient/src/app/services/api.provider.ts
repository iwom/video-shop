import {Injectable} from '@angular/core';
import {environment} from '../../environments/environment';

@Injectable()
export class ApiProvider {
  host = environment.host;
  paths = {
    root: () => `/`,
    login: () => `${this.host}/login`,
    signup: () => `${this.host}/signup`
  };
  go() {
    return this.paths;
  }
}
