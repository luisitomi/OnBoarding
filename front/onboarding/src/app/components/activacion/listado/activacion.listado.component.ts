import { Component, OnInit, ViewChild } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { UserNotiModel, ModuleModel, UserListModel } from '../../../models/user.model';
import { UserService } from '../../../services/user.service';
import { AppConstants } from '../../../shared/constants/app.constants';
import { FormGroup, Validators, FormBuilder } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { ModalDirective} from 'ngx-bootstrap/modal';
import { ResponseModel } from '../../../models/personpay.model';
import { ActivacionModel } from '../../../models/activation.model';
import { ActivationService } from '../../../services/activation.service';

@Component({
  templateUrl: 'activacion.listado.component.html'
})

export class ListadoActivacionComponent implements OnInit{

  public formularioSolution: FormGroup;

  activacion: ActivacionModel[];

  addNotiActive:boolean = false;

  submittedNoti: boolean;

  valueId:number;

  @ViewChild('rptaModal') public rptaModal: ModalDirective;

  constructor(
    private router: Router,
    private formBuilder: FormBuilder,
    private toastr: ToastrService,
    private ActivationService:ActivationService,
  ) {
    this.router.events.subscribe(evt => {
      if (evt instanceof NavigationEnd) {
        this.router.navigated = false;
        window.scrollTo(0, 0);
        this.onReturndata(0);
      }
    })
  }

  itemsPerPage: number = 3;
  currentPage: number = 1;

  initFC() {
    this.formularioSolution = this.formBuilder.group({
      solution: ['', Validators.required],
    });
  }

  ngOnInit() {
    this.onReturndata(0);
  }

  onReturndata(id:number){
    switch(id){
      case 0:
        this.validate();
        this.initFC();
        break;
    }
  }

  validate(){
    if(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 0 ||
    parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 8){
      this.listado();
      this.addNotiActive = true;
    }else{
      this.activacion = [];
      this.addNotiActive = false;
    }
  }

  listado(){
    this.activacion = [];
    this.ActivationService.listadoactivacion().subscribe(
    (result: ActivacionModel[]) => {
      this.activacion = result
    },
    error => {
    })
  }

  openModal(id:number){
    this.valueId = id;
    this.rptaModal.show();
  }

  saveSolution(){
    this.submittedNoti = true;
    let register = this.formularioSolution.value;

    if (!this.formularioSolution.controls.solution.valid) {
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }
  }

  get i() { return this.formularioSolution.controls; }

}
