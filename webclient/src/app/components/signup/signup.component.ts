import { Component, OnInit } from '@angular/core';
import { AuthService } from "../../services/auth.service";
import { FormControl, FormGroup } from "@angular/forms";
import { User } from "../../models/user";
import { Router } from "@angular/router";
import { MatSnackBar } from "@angular/material/snack-bar";

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {
  signUpForm = new FormGroup({
    username: new FormControl(''),
    email: new FormControl(''),
    password: new FormControl('')
  });

  constructor(
    private authService: AuthService,
    private router: Router,
    private snackBar: MatSnackBar
  ) { }

  ngOnInit(): void { }

  onSubmit() {
    const user = new User(
      this.signUpForm.value.email,
      this.signUpForm.value.username,
      this.signUpForm.value.password
    );
    this.authService.register(user).subscribe(
      data => {
        console.log(data);
        this.snackBar.open("Account created successfully!", "Dismiss", { duration: 3000 });
        this.router.navigate(['/login']);
      },
      err => {
        console.error(err);
      }
    )
  }

  login() {
    this.router.navigate(['/login']);
  }

}
