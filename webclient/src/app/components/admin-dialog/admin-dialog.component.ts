import {Component, Inject} from "@angular/core";
import {MAT_DIALOG_DATA, MatDialogRef} from "@angular/material/dialog";
import {Movie} from "../../models/movie";

export interface AdminDialogData {
  movie: Movie,
  price: number,
  quantity: number
}

@Component({
  selector: 'admin-dialog',
  templateUrl: 'admin-dialog.component.html',
})
export class AdminDialogComponent {

  constructor(
    public dialogRef: MatDialogRef<AdminDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: AdminDialogData
  ) {
  }

  onDismiss(): void {
    this.dialogRef.close();
  }

}
