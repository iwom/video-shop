import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup} from "@angular/forms";
import {AuthService} from "../../services/auth.service";
import {TokenStorageService} from "../../services/token.service";
import {UserCredentials} from "../../models/user";
import {Router} from "@angular/router";

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  loggedIn = false;
  formValid = true;
  loginForm = new FormGroup({
    username: new FormControl(''),
    password: new FormControl('')
  });

  constructor(
    private authService: AuthService,
    private tokenStorageService: TokenStorageService,
    private router: Router
  ) {
  }

  ngOnInit(): void {
    this.formValid = true;
    if (this.tokenStorageService.getToken()) {
      this.loggedIn = true;
    }
  }

  onSubmit() {
    const userCredentials = new UserCredentials(
      this.loginForm.value.username,
      this.loginForm.value.password
    );
    this.authService.login(userCredentials).subscribe(
      data => {
        this.tokenStorageService.saveToken(data.accessToken);
        this.tokenStorageService.saveUser(data);
        window.location.reload()
        this.router.navigate(["/movies"]);
      },
      err => {
        this.formValid = false;
        console.error(err);
      }
    )
  }

  signUp() {
    this.router.navigate(["/signup"]);
  }

}
