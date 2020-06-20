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
  templateUrl: 'actividad.listado.component.html'
})

export class ListadoActividadComponent implements OnInit{

  public formularioIntra: FormGroup;
  public formularioUser: FormGroup;

  itemsPerPageS: number = 3;
  currentPageS: number = 1;

  actividad:UserNotiModel[];
  user:UserListModel[];
  listViewModule:ModuleModel[];

  addNotiActive:boolean=false;

  submitted: boolean;
  submittedUser:boolean;

  value:number;

  @ViewChild('userModal') public userModal: ModalDirective;

  constructor(
    private router: Router,
    private UserService: UserService,
    private formBuilder: FormBuilder,
    private toastr: ToastrService
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
    this.reconocerFunction();
  }

  onReturndata(id:number){
    switch(id){
      case 0:
        this.initFC();
        this.listado();
        this.listadoUsers();
        this.listadoNoti();
        break;
    }
  }

  valeuItem(idL:number){
    this.value= idL;
    this.userModal.show();
  }

  initFC() {
    this.formularioIntra = this.formBuilder.group({
      modulo: ['', Validators.required],
      codigo: [''],
      documento: ['', Validators.required],
      nombre: ['', Validators.required],
      asunto: ['', Validators.required],
    });
    this.formularioUser = this.formBuilder.group({
      user: ['', Validators.required],
    });
  }

  listadoUsers(){
    this.UserService.listadouser(parseInt(sessionStorage.getItem(AppConstants.Session.USERID))).subscribe(
      (result:UserListModel[])=>{
        this.user = result
      }
    )
  }

  listadoNoti(){
    this.UserService.notificacionlistado(sessionStorage.getItem(AppConstants.Session.USERNAME)).subscribe(
      (result:UserNotiModel[])=>{
        this.actividad = result
      }
    )
  }

  reconocerFunction(){
    if(sessionStorage.getItem(AppConstants.Session.USERID) == '0'
      || sessionStorage.getItem(AppConstants.Session.USERNAME) == '4'){
        this.addNotiActive = true;
    }else{
      this.addNotiActive = false;
    }
  }

  listado(){
    this.listViewModule = [];
    this.UserService.listadoModuleuser().subscribe(
    (result: ModuleModel[]) => {
      this.listViewModule = result
    },
    error => {
    })
  }

  get f() { return this.formularioIntra.controls; }

  get h() { return this.formularioUser.controls; }

  savenoti(){
    this.submitted = true;
    let registerUser = this.formularioIntra.value;

    registerUser.modulo = parseInt(registerUser.modulo);
    registerUser.codigo = 1 + parseInt(sessionStorage.getItem(AppConstants.Session.USERID))

    if (!this.formularioIntra.controls.modulo.valid ||
      !this.formularioIntra.controls.documento.valid ||
      !this.formularioIntra.controls.nombre.valid ||
      !this.formularioIntra.controls.asunto.valid) {
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
    return false;
  }
  console.log(registerUser)
  this.UserService.postNotificationSave(registerUser.modulo,
                                        registerUser.codigo,
                                        registerUser.documento,
                                        registerUser.nombre,
                                        registerUser.asunto).subscribe(
    (result: ResponseModel[]) => {
      try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_UPDATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.submitted = false;
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.submitted = false;
        }
      }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
        this.submitted = false;
      }
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.onReturndata(0);
      this.submittedUser = false;
    })

  }

  changeUser(){
    this.submittedUser = true;
    let registerUser = this.formularioUser.value;

    registerUser.user = parseInt(registerUser.user);

    if (!this.formularioUser.controls.user.valid) {
        this.toastr.warning(
          AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
          AppConstants.TitleModal.WARNING_TITLE,
          {closeButton: true}
        );
      return false;
      
    }

    this.UserService.putChangeAsignationSave(this.value,
                                            parseInt(registerUser.user)).subscribe(
      (result: ResponseModel[]) => {
        try{
          if(result[0].id == 1){
            this.toastr.success(
              AppConstants.MessageModal.REGISTER_UPDATED,
              AppConstants.TitleModal.REGISTER_TITLE,
              {closeButton: true}
            );
            this.userModal.hide();
            this.onReturndata(0);
            this.submittedUser = false;
          }else{
            this.toastr.warning(
              AppConstants.MessageModal.REGISTER_NO_CREATED,
              AppConstants.TitleModal.WARNING_TITLE,
              {closeButton: true}
            );
            this.userModal.hide();
            this.onReturndata(0);
            this.submittedUser = false;
          }
        }catch{
          this.toastr.error(
            AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
            AppConstants.TitleModal.ERROR_TITLE,
            {closeButton: true}
          );
          this.userModal.hide();
          this.onReturndata(0);
          this.submittedUser = false;
        }
      },
      error => {
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
        this.userModal.hide();
        this.onReturndata(0);
        this.submittedUser = false;
      })
  }

}
