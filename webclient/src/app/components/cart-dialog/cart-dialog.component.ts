import {Component, Inject} from "@angular/core";
import {MAT_DIALOG_DATA, MatDialogRef} from "@angular/material/dialog";

export interface CartDialogData {
  name: string
}

@Component({
  selector: 'cart-dialog',
  templateUrl: 'cart-dialog.component.html',
})
export class CartDialogComponent {

  constructor(
    public dialogRef: MatDialogRef<CartDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: CartDialogData
  ) {
  }

  onDismiss(): void {
    this.dialogRef.close();
  }

}
