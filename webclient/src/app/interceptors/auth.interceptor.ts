import {HTTP_INTERCEPTORS, HttpEvent, HttpHandler, HttpInterceptor, HttpRequest} from "@angular/common/http";
import {TokenStorageService} from "../services/token.service";
import {Observable} from "rxjs";
import {Injectable} from "@angular/core";

const HEADER_AUTH = 'Authorization';
const TOKEN_PREFIX = 'Bearer ';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {
  constructor(private tokenStorageService: TokenStorageService) { }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    let tokenRequest = req;
    const token = this.tokenStorageService.getToken();
    if (token != null) {
      tokenRequest = req.clone(
        {
          headers: req.headers.set(HEADER_AUTH, TOKEN_PREFIX + token)
        }
      );
    }
    return next.handle(tokenRequest);
  }
}

export const authInterceptorProviders = [
  {
    provide: HTTP_INTERCEPTORS,
    useClass: AuthInterceptor,
    multi: true
  }
];
