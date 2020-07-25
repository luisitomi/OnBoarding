import { Component, OnInit, ViewChild } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { AppConstants } from '../../../shared/constants/app.constants';
import { FormGroup, Validators, FormBuilder } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { ModalDirective} from 'ngx-bootstrap/modal';
import { ResponseModel } from '../../../models/personpay.model';
import { ActivacionModel, OnuViewModel, ActivationViewModel } from '../../../models/activation.model';
import { ActivationService } from '../../../services/activation.service';
import { DatePipe } from '@angular/common';

@Component({
  templateUrl: 'activacion.listado.component.html',
  providers: [DatePipe]
})

export class ListadoActivacionComponent implements OnInit{

  public formularioSolution: FormGroup;
  public formularioOnu: FormGroup;
  public formularioOnuChange: FormGroup;
  public formularioOnuNew: FormGroup;

  activacion: ActivacionModel[];
  activacionList: ActivationViewModel[];
  onusview:OnuViewModel[];

  addNotiActive:boolean = false;

  submittedNoti: boolean;
  submittedO: boolean;
  submittedP: boolean;
  submitted: boolean;

  valueId:number;
  onuIdM:number;
  onuSerieM:string;
  onuMacM:string;
  onuSsidM:string;
  onuSpassM:string;
  busqueda:string;
  datei:string;
  datef:string;
  myDate = new Date();

  @ViewChild('rptaModal') public rptaModal: ModalDirective;
  @ViewChild('editModal') public editModal: ModalDirective;
  @ViewChild('passModal') public passModal: ModalDirective;
  @ViewChild('newModal') public newModal: ModalDirective;

  constructor(
    private router: Router,
    private formBuilder: FormBuilder,
    private toastr: ToastrService,
    private datePipe: DatePipe,
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
  itemsPerPages: number = 3;
  currentPages: number = 1;
  itemsPerPageV: number = 4;
  currentPageV: number = 1;


  initFC() {
    this.formularioSolution = this.formBuilder.group({
      solution: ['', Validators.required],
    });
    this.formularioOnu= this.formBuilder.group({
      serie: ['', Validators.required],
      mac: ['', Validators.required]
    });
    this.formularioOnuChange= this.formBuilder.group({
      ssid: [''],
      password: ['', Validators.required]
    });
    this.formularioOnuNew= this.formBuilder.group({
      serie: ['', Validators.required],
      mac: ['', Validators.required],
      ssid: ['', Validators.required],
      password: ['', Validators.required]
    });
  }

  ngOnInit() {
    this.onReturndata(0);
    this.datei = this.datePipe.transform(this.myDate, 'yyyy-MM-dd');
    this.datef = this.datePipe.transform(this.myDate, 'yyyy-MM-dd');
  }

  onReturndata(id:number){
    switch(id){
      case 0:
        this.validate();
        this.validateUser();
        this.initFC();
        this.listadoviewmodel();
        break;
      case 1:
        this.validate();
        this.validateUser();
        this.listadoviewmodel();
        break;
    }
  }

  validate(){
    if(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 0 ||
    parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 8){
      this.listado();
      this.lisadoview();
      this.addNotiActive = true;
    }else{
      this.activacion = [];
      this.addNotiActive = false;
    }
  }

  validateUser(){
    if(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 8){
      this.addNotiActive = true;
    }else{
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

  lisadoview(){
    this.activacionList = [];
    this.ActivationService.listadoServiciorange(this.datei,this.datef).subscribe(
    (result: ActivationViewModel[]) => {
      this.activacionList = result
      try{
        if(result.length > 0){
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.DATA_EMPTY,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
        }
      }catch{
        this.toastr.warning(
          AppConstants.MessageModal.DATA_EMPTY,
          AppConstants.TitleModal.WARNING_TITLE,
          {closeButton: true}
        );
      }
    },
    error => {
    })
  }

  changeponu(id:number,serie:string,mac:string){
    this.onuIdM = id;
    this.onuSerieM = serie;
    this.onuMacM = mac;
    this.editModal.show();
  }

  newOnuModal(){
    this.newModal.show();
  }

  changepass(id:number,sid:string,spass:string){
    this.onuIdM = id;
    this.onuSsidM = sid;
    this.onuSpassM = spass;
    this.passModal.show();
  }

  saveOnuM(){

    this.submittedO = true;
    let register = this.formularioOnu.value;

    if (!this.formularioOnu.controls.serie.valid ||
      !this.formularioOnu.controls.mac.valid) {
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }

    this.ActivationService.mputUpdateOnu( this.onuIdM,
                                          register.serie,
                                          register.mac).subscribe(
    (result: ResponseModel[]) => {
    try{
      if(result[0].id == 1){
        this.toastr.success(
          AppConstants.MessageModal.REGISTER_UPDATED,
          AppConstants.TitleModal.REGISTER_TITLE,
          {closeButton: true}
        );
        this.onReturndata(1);
        this.submittedO = false;
        this.editModal.hide();
      }else{
        this.toastr.warning(
          AppConstants.MessageModal.REGISTER_NO_CREATED,
          AppConstants.TitleModal.WARNING_TITLE,
          {closeButton: true}
        );
        this.onReturndata(1);
        this.submittedO = false;
        this.editModal.hide();
      }
    }
    catch{
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.onReturndata(1);
        this.submittedO = false;
        this.editModal.hide();
      }
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.onReturndata(1);
      this.submittedO = false;
      this.editModal.hide();
    })
  }

  save(){
    this.submitted = true;
    let register = this.formularioOnuNew.value;

    if (!this.formularioOnuNew.controls.serie.valid ||
      !this.formularioOnuNew.controls.mac.valid ||
      !this.formularioOnuNew.controls.ssid.valid ||
      !this.formularioOnuNew.controls.password.valid) {
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }

    this.ActivationService.mpostCreateOnu(register.serie,
                                          register.mac,
                                          register.ssid,
                                          register.password).subscribe(
    (result: ResponseModel[]) => {
    try{
      if(result[0].id == 1){
        this.toastr.success(
          AppConstants.MessageModal.REGISTER_UPDATED,
          AppConstants.TitleModal.REGISTER_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
        this.submittedNoti = false;
        this.listado();
        this.newModal.hide();
      }else{
        this.toastr.warning(
          AppConstants.MessageModal.REGISTER_NO_CREATED,
          AppConstants.TitleModal.WARNING_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
        this.submittedNoti = false;
        this.listado();
        this.newModal.hide();
      }
    }
    catch{
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
        this.onReturndata(0);
        this.submittedNoti = false;
        this.listado();
        this.newModal.hide();
      }
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.onReturndata(0);
      this.submittedNoti = false;
      this.listado();
      this.newModal.hide();
    })
  }

  saveOnuChangeM(){

    this.submittedP = true;
    let register = this.formularioOnuChange.value;

    if (!this.formularioOnuChange.controls.password.valid) {
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }

    this.ActivationService.mpatchPasswordOnu( this.onuIdM,
                                              register.ssid,
                                              register.password).subscribe(
    (result: ResponseModel[]) => {
    try{
      if(result[0].id == 1){
        this.toastr.success(
          AppConstants.MessageModal.REGISTER_UPDATED,
          AppConstants.TitleModal.REGISTER_TITLE,
          {closeButton: true}
        );
        this.onReturndata(1);
        this.submittedP = false;
        this.passModal.hide();
      }else{
        this.toastr.warning(
          AppConstants.MessageModal.REGISTER_NO_CREATED,
          AppConstants.TitleModal.WARNING_TITLE,
          {closeButton: true}
        );
        this.onReturndata(1);
        this.submittedP = false;
        this.passModal.hide();
      }
    }
    catch{
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.onReturndata(1);
        this.submittedP = false;
        this.passModal.hide();
      }
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.onReturndata(1);
      this.submittedP = false;
        this.passModal.hide();
    })
  }

  activeOnu(id:number){
    this.ActivationService.mpatchActivationOnu(id).subscribe(
      (result: ResponseModel[]) => {
        try
        {
          if(result[0].id == 1){
            this.toastr.success(
              AppConstants.MessageModal.REGISTER_UPDATED,
              AppConstants.TitleModal.REGISTER_TITLE,
              {closeButton: true}
            );
            this.onReturndata(0);
          }else{
            this.toastr.warning(
              AppConstants.MessageModal.REGISTER_NO_CREATED,
              AppConstants.TitleModal.WARNING_TITLE,
              {closeButton: true}
            );
            this.onReturndata(0);
          }
        }
        catch
        {
          this.toastr.error(
            AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
            AppConstants.TitleModal.ERROR_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
        }
      },
      error => {
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
      }
    )
  }

  listadoviewmodel(){
    this.onusview = [];
    this.ActivationService.mgetListOnuState().subscribe(
    (result: OnuViewModel[]) => {
      this.onusview = result
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

    this.ActivationService.postActivation(this.valueId,
                                          register.solution).subscribe(
    (result: ResponseModel[]) => {
    try{
      if(result[0].id == 1){
        this.toastr.success(
          AppConstants.MessageModal.REGISTER_UPDATED,
          AppConstants.TitleModal.REGISTER_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
        this.submittedNoti = false;
        this.listado();
        this.rptaModal.hide();
      }else{
        this.toastr.warning(
          AppConstants.MessageModal.REGISTER_NO_CREATED,
          AppConstants.TitleModal.WARNING_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
        this.submittedNoti = false;
        this.listado();
        this.rptaModal.hide();
      }
    }
    catch{
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
        this.onReturndata(0);
        this.submittedNoti = false;
        this.listado();
        this.rptaModal.hide();
      }
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.onReturndata(0);
      this.submittedNoti = false;
      this.listado();
      this.rptaModal.hide();
    })

  }

  get i() { return this.formularioSolution.controls; }

  get j() { return this.formularioOnu.controls; }

  get k() { return this.formularioOnuNew.controls; }

}
