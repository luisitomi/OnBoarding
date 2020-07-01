import { Component, OnInit, ViewChild } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { UserNotiModel, ModuleModel, UserListModel } from '../../../models/user.model';
import { UserService } from '../../../services/user.service';
import { AppConstants } from '../../../shared/constants/app.constants';
import { FormGroup, Validators, FormBuilder } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { ModalDirective} from 'ngx-bootstrap/modal';
import { ResponseModel } from '../../../models/personpay.model';

@Component({
  templateUrl: 'activacion.listado.component.html'
})

export class ListadoActivacionComponent implements OnInit{

  constructor(
    private router: Router,
  ) {
    this.router.events.subscribe(evt => {
      if (evt instanceof NavigationEnd) {
        this.router.navigated = false;
        window.scrollTo(0, 0);
        this.onReturndata(0);
      }
    })
  }

  ngOnInit() {
    this.onReturndata(0);
  }

  onReturndata(id:number){
    switch(id){
      case 0:
        break;
    }
  }

}
