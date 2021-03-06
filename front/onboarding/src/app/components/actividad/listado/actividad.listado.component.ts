import { Component, OnInit, ViewChild } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { UserNotiModel, ModuleModel, UserListModel } from '../../../models/user.model';
import { UserService } from '../../../services/user.service';
import { AppConstants } from '../../../shared/constants/app.constants';
import { FormGroup, Validators, FormBuilder } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { ModalDirective} from 'ngx-bootstrap/modal';
import { ResponseModel } from '../../../models/personpay.model';
import { SellerService } from '../../../services/saller.service';

@Component({
  templateUrl: 'actividad.listado.component.html'
})

export class ListadoActividadComponent implements OnInit{

  public formularioIntra: FormGroup;
  public formularioSolution: FormGroup;
  public formularioUser: FormGroup;

  itemsPerPageS: number = 3;
  currentPageS: number = 1;

  actividad:UserNotiModel[];
  user:UserListModel[];
  listViewModule:ModuleModel[];

  addNotiActive:boolean=false;

  submitted: boolean;
  submittedUser:boolean;
  submittedNoti: boolean;

  value:number;
  valueId:number;
  documentSearch:string;
  ventaCondition:number;

  @ViewChild('userModal') public userModal: ModalDirective;
  @ViewChild('rptaModal') public rptaModal: ModalDirective;

  constructor(
    private router: Router,
    private UserService: UserService,
    private formBuilder: FormBuilder,
    private SellerService: SellerService,
    private toastr: ToastrService,
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

  valeuItemId(idL:number){
    this.valueId= idL;
    this.rptaModal.show();
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
    this.formularioSolution = this.formBuilder.group({
      solution: ['', Validators.required],
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
    this.actividad = [];
    this.UserService.notificacionlistado(sessionStorage.getItem(AppConstants.Session.USERNAME)).subscribe(
      (result:UserNotiModel[])=>{
        this.actividad = result
      }
    )
  }

  reconocerFunction(){
    if(sessionStorage.getItem(AppConstants.Session.USERID) == '0'
      || sessionStorage.getItem(AppConstants.Session.USERID) == '4'
      || sessionStorage.getItem(AppConstants.Session.USERID) == '6'
      || sessionStorage.getItem(AppConstants.Session.USERID) == '7'
      || sessionStorage.getItem(AppConstants.Session.USERID) == '8'){
        this.addNotiActive = true;
    }else{
      this.addNotiActive = false;
    }
  }

  seachDocment(){
    if(this.documentSearch.length == 8 || this.documentSearch.length == 11){
      if(this.documentSearch.length == 8){
        let reg = {
          dni:this.documentSearch
        };
        this.SellerService.recuperardni(reg.dni).subscribe(
          (result: any) => {
            this.formularioIntra.patchValue({
              nombre: result.nombres + " " + result.apellidoPaterno + " " + result.apellidoMaterno
            });
            this.ventaCondition =  8;
          }
        )
      }else{
        let reg = {
          ruc:this.documentSearch
        };
        this.SellerService.recuperarruc(reg).subscribe(
          (result: any) => {
            this.formularioIntra.patchValue({
              nombre: result.nombre_o_razon_social
            });
            this.ventaCondition =  11;
          }
        )
      }
    }else{
      this.toastr.warning(
        "Documento necesita un valor de 8 o 11 carácteres",
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
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

  get i() { return this.formularioSolution.controls; }

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
  
    this.UserService.postNotificationSave(registerUser.modulo,
                                        registerUser.codigo,
                                        registerUser.documento,
                                        registerUser.nombre.toUpperCase(),
                                        registerUser.asunto.toUpperCase()).subscribe(
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
          this.listadoNoti();
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.submitted = false;
          this.listadoNoti();
        }
      }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
        this.submitted = false;
        this.listadoNoti();
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
      this.listadoNoti();
    })

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
  
    this.UserService.guardarMensaje(this.valueId,
                                    register.solution.toUpperCase()).subscribe(
    (result: ResponseModel[]) => {
      try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_UPDATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.rptaModal.hide();
          this.submittedNoti = false;
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.rptaModal.hide();
          this.submittedNoti = false;
        }
      }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
        this.rptaModal.hide();
        this.submittedNoti = false;
      }
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.onReturndata(0);
      this.rptaModal.hide();
      this.submittedNoti = false;
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
