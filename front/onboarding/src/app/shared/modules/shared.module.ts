import { NgModule } from '@angular/core';
import { ModalModule } from 'ngx-bootstrap/modal';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { HelperService } from '../services/helper.service';


@NgModule({
  imports: [
    CommonModule,
    ModalModule.forRoot(),
    FormsModule,
    ReactiveFormsModule
  ],
  declarations: [
  ],
  providers: [
    HelperService
  ],
  exports: [
    CommonModule,
    ModalModule,
    FormsModule,
    ReactiveFormsModule,
  ]
})

export class SharedModule {

}
