import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup} from "@angular/forms";

@Component({
  selector: 'app-admin-panel',
  templateUrl: './admin-panel.component.html',
  styleUrls: ['./admin-panel.component.css']
})
export class AdminPanelComponent implements OnInit {
  movieForm = new FormGroup({
    name: new FormControl(''),
    amount: new FormControl(0)
  })

  constructor() {
  }

  ngOnInit(): void {
  }

  onSubmit() {
    window.alert("Submit!")
  }
}
