import { Component, ViewChild, OnInit } from '@angular/core';
import { PersonPayModel, PersonByIdPayModel, PersonByIdPayDirectionModel, PersonByIdPayReferenceModel, PersonByIdPayMangerModel, PersonByIdPayVoucherModel, PersonByIdPayDetailModel, ResponseModel, DirectionListModel, PersonByIdPayDetailExitModel } from '../../../models/personpay.model';
import { Router, NavigationEnd } from '@angular/router';
import { DatePipe } from '@angular/common';
import { PersonPayService } from '../../../services/personpay.service';
import { ManagerPayService } from '../../../services/managerpay.service';
import { SellerService } from '../../../services/saller.service';
import { ModalDirective} from 'ngx-bootstrap/modal';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { ManagerPayModel } from '../../../models/managerpay.model';
import { MonthPayService } from '../../../services/monthpay.service';
import { MonthPayModel } from '../../../models/monthpay.model';
import { SellerModel, SellerServiceModel } from '../../../models/seller.model';
import { ToastrService } from 'ngx-toastr';
import { AppConstants } from '../../../shared/constants/app.constants';

@Component({
  templateUrl: 'venta.registro.component.html',
  providers: [DatePipe]
})

export class RegistroComponent implements OnInit{

  public formularioPerson: FormGroup;
  public formularioDirection: FormGroup;
  public formularioChangeDirection: FormGroup;
  public formularioReference: FormGroup;
  public formularioContrato: FormGroup;
  
  @ViewChild('personModal') public personModal: ModalDirective;
  @ViewChild('directionModal') public directionModal: ModalDirective;
  @ViewChild('referenceModal') public referenceModal: ModalDirective;
  @ViewChild('serviceaexitModal') public serviceaexitModal: ModalDirective;
  @ViewChild('directionChangeModal') public directionChangeModal: ModalDirective;
  @ViewChild('servicedeleteModal') public servicedeleteModal: ModalDirective;
  
  personpay: PersonPayModel[];
  personpaydata: PersonByIdPayModel[];
  monthexit:MonthPayModel[];

  itemsPerPage: number = 4;
  currentPage: number = 1;

  busqueda:string;
  fecha:string;
  hora:string;
  documentSearch:string;
  ventaCondition:number;

  name:string;
  direction:string;
  reference:string;
  voucher:string;
  voucheri:string;
  manager:string
  document:string;
  code:string;
  service:string;
  servicedelete:string;
  serviceexit:string;
  amountdetailcabledelete:number;
  amountdetailinternetdelete:number;
  amountgeneraldelete:string;
  amountdetailcableexit:number;
  amountdetailinternetexit:number;
  amountgeneralexit:string;
  distIds:number;

  nombrepersonModel:string;
  maternopersonModel:string;
  paternopersonModel:string;
  empresapersonModel:string;

  managerview:ManagerPayModel[];
  directionview:DirectionListModel[];
  distritoview:SellerModel[];
  callesview:SellerModel[];
  vendedoresview:SellerModel[];
  servicioview:SellerServiceModel[];
  monthdelete:MonthPayModel[];

  listadoActive: boolean = false;
  detalleActive: boolean = false;
  registroActive: boolean = false;

  pagoDeleteActive: boolean = false;
  pagoExitActive: boolean = false;
  userActive:boolean = false;

  submitted: boolean;
  submittedDirection: boolean;
  submittedChangeDirection: boolean;
  submittedManager: boolean;
  submittedReference: boolean;
  submittedSaveActive: boolean;

  constructor(
    private PersonPayService: PersonPayService,
    private ManagerPayService: ManagerPayService,
    private MonthPayService: MonthPayService,
    private SellerService: SellerService,
    private datePipe: DatePipe,
    private router: Router,
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
    this.initForms();
  }

  validation(){
    if(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) > 3 &&
    parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) < 6){
      this.userActive = true
    }else{
      this.userActive = false
    }
  }

  initForms() {
    this.formularioPerson = this.formBuilder.group({
      documentoperson: [''],
      nombresperson: ['', Validators.required],
      paternoperson: ['', Validators.required],
      maternoperson: ['', Validators.required],
      empresaperson: ['']
    });
    this.formularioDirection   = this.formBuilder.group({
      documentodirection: [''],
      codedirection: [''],
      numberdirection: ['', Validators.required],
      zonedirection: ['', Validators.required]
    });
    this.formularioChangeDirection   = this.formBuilder.group({
      documentodirection: [''],
      codedirection: [''],
      numberdirection: ['', Validators.required],
      zonedirection: ['', Validators.required],
      referencedirection: ['', Validators.required]
    });
    this.formularioReference   = this.formBuilder.group({
      documentoreference: [''],
      codereference: [''],
      descriptionreference: ['', Validators.required]
    });
  }
  
  initFC() {
    this.formularioContrato = this.formBuilder.group({
      documento: ['', Validators.required],
      codigo: ['', Validators.required],
      nombre: ['', Validators.required],
      paterno: ['', Validators.required],
      fecha: ['', Validators.required],
      materno: ['', Validators.required],
      empresa: [''],
      email: ['', Validators.required],
      vendedor: ['', Validators.required],
      distrito: ['', Validators.required],
      calle: ['', Validators.required],
      numero: ['', Validators.required],
      referencia: ['', Validators.required],
      detalle: ['', Validators.required],
      servicio: ['', Validators.required],
      hora: ['', Validators.required],
      inicial: ['', Validators.required],
      mensual: ['', Validators.required]
    });
  }

  registerReference(){
    this.submittedReference = true;
    let registerReference = this.formularioReference.value;

    registerReference.documentoreference = this.document
    registerReference.codereference = this.code

    if (!this.formularioReference.controls.descriptionreference.valid) {
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }

    this.ManagerPayService.putReferenceByIdIddetalle(this.document,this.code,registerReference.descriptionreference.toUpperCase()).subscribe(
    (result: ResponseModel[]) => {
       try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_CREATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.referenceModal.hide();
          this.onReturndata(3);
          this.submittedReference = false;
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.referenceModal.hide();
          this.onReturndata(3);
          this.submittedReference = false;
        }
       }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
          this.referenceModal.hide();
          this.onReturndata(3);
          this.submittedReference = false;
       }
     },
     error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.referenceModal.hide();
      this.onReturndata(3);
      this.submittedReference = false;
     })
  }

  registerChangeDirection(){
    this.submittedChangeDirection = true;
    let registerDirection = this.formularioChangeDirection.value;

    registerDirection.documentodirection = this.document
    registerDirection.codedirection = this.code
    registerDirection.zonedirection = parseInt(registerDirection.zonedirection);

    if (!this.formularioChangeDirection.controls.numberdirection.valid ||
      !this.formularioChangeDirection.controls.zonedirection.valid||
      !this.formularioChangeDirection.controls.referencedirection.valid ) {
        this.toastr.warning(
          AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
          AppConstants.TitleModal.WARNING_TITLE,
          {closeButton: true}
        );
      return false;
    }
    
    this.SellerService.putChangeDirectionByIdList(this.document,
                                              this.code,
                                              registerDirection.numberdirection.toUpperCase(),
                                              registerDirection.zonedirection,
                                              registerDirection.referencedirection.toUpperCase()).subscribe(
    (result: ResponseModel[]) => {
       try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_CREATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.directionChangeModal.hide();
          this.onReturndata(2);
          this.onReturndata(3);
          this.submittedChangeDirection = false;
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.directionChangeModal.hide();
          this.onReturndata(2);
          this.onReturndata(3);
          this.submittedChangeDirection = false;
        }
       }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
          this.directionChangeModal.hide();
          this.onReturndata(2);
          this.onReturndata(3);
          this.submittedChangeDirection = false;
       }
     },
     error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.directionChangeModal.hide();
      this.onReturndata(2);
      this.onReturndata(3);
      this.submittedChangeDirection = false;
     })
  }

  registerDirection(){
    this.submittedDirection = true;
    let registerDirection = this.formularioDirection.value;

    registerDirection.documentodirection = this.document
    registerDirection.codedirection = this.code
    registerDirection.zonedirection = parseInt(registerDirection.zonedirection);

    if (!this.formularioDirection.controls.numberdirection.valid ||
      !this.formularioDirection.controls.zonedirection.valid ) {
        this.toastr.warning(
          AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
          AppConstants.TitleModal.WARNING_TITLE,
          {closeButton: true}
        );
      return false;
    }

    this.PersonPayService.putDirectionByIddetalle(this.document,
                                              this.code,
                                              registerDirection.numberdirection.toUpperCase(),
                                              registerDirection.zonedirection).subscribe(
    (result: ResponseModel[]) => {
       try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_CREATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.directionModal.hide();
          this.onReturndata(2);
          this.submittedDirection = false;
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.directionModal.hide();
          this.onReturndata(2);
          this.submittedDirection = false;
        }
       }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
          this.directionModal.hide();
          this.onReturndata(2);
          this.submittedDirection = false;
       }
     },
     error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.directionModal.hide();
      this.onReturndata(2);
      this.submittedDirection = false;
     })
  }

  registerPerson(){
    this.submitted = true;
    let registerPerson = this.formularioPerson.value;

    registerPerson.documentoperson = this.document

    if (!this.formularioPerson.controls.nombresperson.valid ||
      !this.formularioPerson.controls.paternoperson.valid ||
      !this.formularioPerson.controls.maternoperson.valid ) {
        this.toastr.warning(
          AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
          AppConstants.TitleModal.WARNING_TITLE,
          {closeButton: true}
        );
      return false;
    }
    
    if(registerPerson.empresaperson == null || registerPerson.empresaperson == undefined ||
      registerPerson.empresaperson.length < 2){
      registerPerson.empresaperson = "a"
    }

    this.PersonPayService.putPersonByIddetalle(this.document,
                                              registerPerson.nombresperson.toUpperCase(),
                                              registerPerson.paternoperson.toUpperCase(),
                                              registerPerson.maternoperson.toUpperCase(),
                                              registerPerson.empresaperson.toUpperCase()).subscribe(
    (result: ResponseModel[]) => {
       try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_CREATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.personModal.hide();
          this.onReturndata(1);
          this.submitted = false;
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.personModal.hide();
          this.onReturndata(1);
          this.submitted = false;
        }
       }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
          this.personModal.hide();
          this.onReturndata(1);
          this.submitted = false;
       }
     },
     error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.personModal.hide();
      this.onReturndata(1);
      this.submitted = false;
     })
  }

  savec(){
    this.submittedSaveActive = true;
    let registerContrato = this.formularioContrato.value;

    registerContrato.calle = parseInt(registerContrato.calle);
    registerContrato.servicio = parseInt(registerContrato.servicio);
    registerContrato.vendedor = parseInt(registerContrato.vendedor);

    if(this.ventaCondition == 8 || this.ventaCondition == 11){
      if (!this.formularioContrato.controls.documento.valid ||
        !this.formularioContrato.controls.codigo.valid ||
        !this.formularioContrato.controls.paterno.valid ||
        !this.formularioContrato.controls.fecha.valid ||
        !this.formularioContrato.controls.email.valid ||
        !this.formularioContrato.controls.materno.valid ||
        !this.formularioContrato.controls.vendedor.valid ||
        !this.formularioContrato.controls.distrito.valid ||
        !this.formularioContrato.controls.calle.valid ||
        !this.formularioContrato.controls.numero.valid ||
        !this.formularioContrato.controls.referencia.valid ||
        !this.formularioContrato.controls.detalle.valid ||
        !this.formularioContrato.controls.servicio.valid ||
        !this.formularioContrato.controls.hora.valid ||
        !this.formularioContrato.controls.inicial.valid ||
        !this.formularioContrato.controls.mensual.valid) {
          this.toastr.warning(
            AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
        return false;
      }
    }else{
      if (!this.formularioContrato.controls.documento.valid ||
        !this.formularioContrato.controls.codigo.valid ||
        !this.formularioContrato.controls.nombre.valid ||
        !this.formularioContrato.controls.paterno.valid ||
        !this.formularioContrato.controls.fecha.valid ||
        !this.formularioContrato.controls.email.valid ||
        !this.formularioContrato.controls.materno.valid ||
        !this.formularioContrato.controls.vendedor.valid ||
        !this.formularioContrato.controls.distrito.valid ||
        !this.formularioContrato.controls.calle.valid ||
        !this.formularioContrato.controls.numero.valid ||
        !this.formularioContrato.controls.referencia.valid ||
        !this.formularioContrato.controls.detalle.valid ||
        !this.formularioContrato.controls.servicio.valid ||
        !this.formularioContrato.controls.hora.valid ||
        !this.formularioContrato.controls.inicial.valid ||
        !this.formularioContrato.controls.mensual.valid) {
          this.toastr.warning(
            AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
        return false;
      }
    }

    if(registerContrato.empresa == null || registerContrato.empresa == undefined ||
      registerContrato.empresa.length < 2){
        registerContrato.empresa = "a"
    }

    this.fecha = this.datePipe.transform(registerContrato.hora, 'yyyy-MM-dd');
    this.hora = this.datePipe.transform(registerContrato.hora, 'HH-mm');

    this.SellerService.postSaveServiceSaleSave( registerContrato.documento.toUpperCase(),
                                                registerContrato.codigo.toUpperCase(),
                                                registerContrato.nombre.toUpperCase(),
                                                registerContrato.paterno.toUpperCase(),
                                                registerContrato.materno.toUpperCase(),
                                                registerContrato.empresa.toUpperCase(),
                                                registerContrato.fecha,
                                                registerContrato.email,
                                                registerContrato.calle,
                                                registerContrato.numero.toUpperCase(),
                                                registerContrato.referencia.toUpperCase(),
                                                registerContrato.vendedor,
                                                this.fecha,
                                                this.hora,
                                                registerContrato.servicio,
                                                registerContrato.inicial,
                                                registerContrato.mensual,
                                                registerContrato.detalle.toUpperCase()).subscribe(
      (result: ResponseModel[]) => {
        try{
          if(result[0].id == 1){
            this.toastr.success(
              AppConstants.MessageModal.REGISTER_CREATED,
              AppConstants.TitleModal.REGISTER_TITLE,
              {closeButton: true}
            );
            this.onReturndata(0);
            this.submittedSaveActive = false;
          }else{
            this.toastr.warning(
              AppConstants.MessageModal.REGISTER_NO_CREATED,
              AppConstants.TitleModal.WARNING_TITLE,
              {closeButton: true}
            );
            this.onReturndata(0);
            this.submittedSaveActive = false;
          }
        }catch{
          this.toastr.error(
            AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
            AppConstants.TitleModal.ERROR_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.submittedSaveActive = false;
        }
      },
      error => {
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
        this.submittedSaveActive = false;
      })
   
  }

  get f() { return this.formularioPerson.controls; }

  get g() { return this.formularioDirection.controls; }

  get i() { return this.formularioReference.controls; }

  get j() { return this.formularioChangeDirection.controls; }

  get k() { return this.formularioContrato.controls; }



  listadoclientes(){
    this.personpay = [];
    this.PersonPayService.getpersonaslistado("&").subscribe(
    (result: PersonPayModel[]) => {
      this.personpay = result
    },
    error => {
    })
  }

  listservicios(){
    this.servicioview = [];
    this.SellerService.listadoservicioscombo().subscribe(
    (result: SellerServiceModel[]) => {
      this.servicioview = result
    },
    error => {
    })
  }

  listvendedores(){
    this.vendedoresview = [];
    this.SellerService.listadovendedores().subscribe(
    (result: SellerModel[]) => {
      this.vendedoresview = result
    },
    error => {
    })
  }

  listdistritos(){
    this.distritoview = [];
    this.SellerService.listadodistrito().subscribe(
    (result: SellerModel[]) => {
      this.distritoview = result
    },
    error => {
    })
  }

  listcalles(){
    this.callesview = [];
    this.SellerService.listadocalle(this.distIds).subscribe(
    (result: SellerModel[]) => {
      this.callesview = result
    },
    error => {
    })
  }

  listadoclientesdata(){
    this.personpaydata = [];
    this.PersonPayService.getpersonasdata(this.document,this.code).subscribe(
    (result: PersonByIdPayModel[]) => {
      this.personpaydata = result
      this.name = this.personpaydata[0].client;
    },
    error => {
    })
  }

  listadoclientesdatabyid(){
    this.PersonPayService.getpersonasdatas(this.document,this.code).subscribe(
    (result: PersonByIdPayModel[]) => {
      this.formularioPerson.patchValue({
        nombresperson: result[0].name,
        paternoperson: result[0].last,
        maternoperson: result[0].second,
        empresaperson: result[0].customer
      });
    },
    error => {
    })
  }

  listadoclientesdatadirecccion(){
    this.PersonPayService.getpersonasdatadireccion(this.document,this.code).subscribe(
    (result: PersonByIdPayDirectionModel[]) => {
      this.direction = result[0].direction
    },
    error => {
    })
  }

  listadoclientesdatadirecccionById(){
    this.PersonPayService.getpersonasdatadireccion(this.document,this.code).subscribe(
      (result: PersonByIdPayDirectionModel[]) => {
        this.formularioDirection.patchValue({
          numberdirection: result[0].number,
          zonedirection: result[0].id
        });
      },
    error => {
    })
  }

  listadoclientesdatareferencia(){
    this.PersonPayService.getpersonasdatareferencia(this.document,this.code).subscribe(
    (result: PersonByIdPayReferenceModel[]) => {
      this.reference = result[0].reference
    },
    error => {
    })
  }

  listadoclientesdatareferenciaById(){
    this.PersonPayService.getpersonasdatareferencia(this.document,this.code).subscribe(
      (result: PersonByIdPayReferenceModel[]) => {
        this.formularioReference.patchValue({
          descriptionreference: result[0].reference
        });
      },
    error => {
    })
  }

  listadoclientesdatagestor(){
    this.PersonPayService.getpersonasdatagestor(this.document,this.code).subscribe(
    (result: PersonByIdPayMangerModel[]) => {
      try{
        this.manager = result[0].manager
      }catch{
        this.manager = "No tiene asignado aun gestor"
      }
    },
    error => {
    })
  }

  listadoclientesdatapagoDelete(){
    let sum;
    this.PersonPayService.getpersonasdatadetalleDelete(this.document,this.code).subscribe(
    (result: PersonByIdPayDetailModel[]) => {
      try{
        if(result.length > 1){
          if(result[1].service == "Cable"){
            this.amountdetailinternetdelete = result[0].amount
            this.amountdetailcabledelete = result[1].amount
            sum = this.amountdetailcabledelete*1 + this.amountdetailinternetdelete*1
            this.amountgeneralexit = parseFloat(sum).toFixed(2)
            if(sum > 0){
              this.pagoDeleteActive = true;
              this.servicedelete = "DEUDA ATRASADA DE:" + "CABLE - INTERNET"
            }else{
              this.pagoDeleteActive = false;
              this.servicedelete = "NO EXISTE SERVICIOS CORTADOS"
            }
          }else{
            this.amountdetailinternetdelete = result[1].amount
            this.amountdetailcabledelete = result[0].amount
            sum = this.amountdetailcabledelete*1 + this.amountdetailinternetdelete*1
            this.amountgeneralexit = parseFloat(sum).toFixed(2)
            if(sum > 0){
              this.pagoDeleteActive = true;
              this.servicedelete = "DEUDA ATRASADA DE:" + "CABLE - INTERNET"
            }else{
              this.pagoDeleteActive = false;
              this.servicedelete = "NO EXISTE SERVICIOS CORTADOS"
            }
          }
        }else{
          try{
            this.amountdetailinternetdelete = result[0].amount
            this.servicedelete = "DEUDA ATRASADA DE:" + result[0].service
          }catch{
            this.amountdetailinternetdelete = 0
          }
          try{
            this.amountdetailcabledelete = result[1].amount
            this.servicedelete = "DEUDA ATRASADA DE:" + result[1].service
          }catch{
            this.amountdetailcabledelete = 0
          }
          sum = this.amountdetailinternetdelete + this.amountdetailcabledelete
          this.amountgeneraldelete = parseFloat(sum).toFixed(2)
          if(sum > 0){
            this.pagoDeleteActive = true;
          }else{
            this.pagoDeleteActive = false;
            this.servicedelete = "NO EXISTE SERVICIOS CORTADOS"
          }
        }
      }catch{
        this.amountdetailcabledelete= 0
        this.amountdetailinternetdelete = 0
        sum = this.amountdetailinternetdelete + this.amountdetailcabledelete
        this.amountgeneraldelete = parseFloat(sum).toFixed(2)
        this.pagoDeleteActive = false;
        this.servicedelete = "NO EXISTE SERVICIOS CORTADOS"
      }
    },
    error => {
      
      this.amountdetailcabledelete= 0
      this.amountdetailinternetdelete = 0
      sum = this.amountdetailinternetdelete + this.amountdetailcabledelete
      this.amountgeneraldelete = parseFloat(sum).toFixed(2)
      this.pagoDeleteActive = false;
      this.servicedelete = "NO EXISTE SERVICIOS CORTADOS"
    })
  }

  listadoclientesdatapagoExit(){
    let sum;
    this.PersonPayService.getpersonasdatadetalleExit(this.document,this.code).subscribe(
    (result: PersonByIdPayDetailExitModel[]) => {
      try{
        if(result.length > 1){
          if(result[1].service == "Cable"){
            this.amountdetailinternetexit = result[0].amount
            this.amountdetailcableexit = result[1].amount
            sum = this.amountdetailinternetexit*1 + this.amountdetailcableexit*1
            this.amountgeneralexit = parseFloat(sum).toFixed(2)
            if(sum > 0){
              this.pagoExitActive = true;
            }else{
              this.pagoExitActive = false;
            }
          }else{
            this.amountdetailinternetexit = result[1].amount
            this.amountdetailcableexit = result[0].amount
            sum = this.amountdetailinternetexit*1 + this.amountdetailcableexit*1
            this.amountgeneralexit = parseFloat(sum).toFixed(2)
            if(sum > 0){
              this.pagoExitActive = true;
            }else{
              this.pagoExitActive = false;
            }
          }
        }else{
          try{
            this.amountdetailinternetexit = result[1].amount
          }catch{
            this.amountdetailinternetexit = 0
          }
          try{
            this.amountdetailcableexit= result[0].amount
          }catch{
            this.amountdetailcableexit = 0
          }
          sum = this.amountdetailinternetexit + this.amountdetailcableexit
          this.amountgeneralexit = parseFloat(sum).toFixed(2)
          if(sum > 0){
            this.pagoExitActive = true;
          }else{
            this.pagoExitActive = false;
          }
        }
      }catch{
        this.amountdetailcableexit= 0
        this.amountdetailinternetexit = 0
        sum = this.amountdetailinternetexit + this.amountdetailcableexit
        this.amountgeneralexit = parseFloat(sum).toFixed(2)
        this.pagoExitActive = false;
      }
    },
    error => {
      
      this.amountdetailcabledelete= 0
      this.amountdetailinternetdelete = 0
      sum = this.amountdetailinternetdelete + this.amountdetailcabledelete
      this.amountgeneraldelete = parseFloat(sum).toFixed(2)
      this.pagoDeleteActive = false;
    })
  }

  listadoclientesdatavoucher(){
    this.PersonPayService.getpersonasdatavoucher(this.document,this.code).subscribe(
    (result: PersonByIdPayVoucherModel[]) => {
      try{
        if(result.length == 1){
          this.service = "DEUDA DE: " + result[0].name
          this.serviceexit = "Servicios disponibles: " + result[0].name
          this.voucher = result[0].name + ": " + result[0].voucher
          this.voucheri =""
        }else{
          this.voucher = result[0].name + ": " + result[0].voucher
          this.voucheri = result[1].name + ": " + result[1].voucher
          this.service = "DEUDA DE: " + result[0].name + " - " +result[1].name
          this.serviceexit = "Servicios disponibles: " + result[0].name + " - " +result[1].name
      }
      }catch{
        this.voucher ="Ningún Servicio Activo"
        this.voucheri =""
        this.service = "NINGÚN SERVICIO ACTIVO"
        this.serviceexit = "NINGÚN SERVICIO ACTIVO"
      }
    },
    error => {
    })
  }

  listadomesesexit(){
    this.monthexit = [];
    this.MonthPayService.getlistadoexit(this.document,this.code).subscribe(
    (result: MonthPayModel[]) => {
      this.monthexit = result
    },
    error => {
    })
  }

  listadogestores(){
    this.managerview = [];
    this.ManagerPayService.getgestoreslistado().subscribe(
    (result: ManagerPayModel[]) => {
      this.managerview = result
    },
    error => {
    })
  }

  listadodirecciones(){
    this.directionview = [];
    this.PersonPayService.getdireccionlistado().subscribe(
    (result: DirectionListModel[]) => {
      this.directionview = result
    },
    error => {
    })
  }

  back(){
    this.onReturndata(0);
  }

  onReturndata(id:number){
    switch(id){
      case 0:
        this.document= "";
        this.code = "";
        this.listadoActive = true;
        this.detalleActive = false;
        this.registroActive = false;
        this.busqueda="";
        this.listadoclientes();
        this.initForms();
        this.validation();
      break;
      case 1:
        this.listadoActive = false;
        this.registroActive = false;
        this.detalleActive = true;
        this.listadoclientesdatabyid();
        this.listadoclientesdata();
        this.limipiarinputs();
      break;
      case 2:
        this.listadoclientesdatadirecccion();
        this.listadoclientesdatadirecccionById();
        this.listadodirecciones();
      break;
      case 3:
        this.listadoclientesdatareferencia();
        this.listadoclientesdatareferenciaById();
      break;
      case 4:
        this.listadoclientesdatagestor();
        this.listadogestores();
      break;
      case 5:
        this.listadoclientesdatavoucher();
      break;
      case 6:
        this.listadoclientesdatapagoDelete();
        this.listadoclientesdatapagoExit();
      break;
      case 7:
      break;
      case 8:  
        this.listadoclientesdatapagoExit(); 
      break;
      case 9:
        this.listadomesesexit();
      break;
      case 10:
        this.listadoActive = false;
        this.detalleActive = false;
        this.registroActive = true;
        this.initFC();
        this.listservicios();
        this.listvendedores();
        this.listdistritos();
      break;
      case 11:
        this.listadomesesdelete();
      break;
    }
  }

  listadomesesdelete(){
    this.monthdelete = [];
    this.MonthPayService.getlistadodelete(this.document,this.code).subscribe(
    (result: MonthPayModel[]) => {
      this.monthdelete = result
    },
    error => {
    })
  }

  openMonthDelete(){
    this.itemsPerPage = 4;
    this.currentPage = 1;
    this.servicedeleteModal.show();
    this.onReturndata(11);
  }

  openMonthExit(){
    this.itemsPerPage = 4;
    this.currentPage = 1;
    this.serviceaexitModal.show();
    this.onReturndata(9);
  }

  seachDocment(){
    if(this.documentSearch.length == 8 || this.documentSearch.length == 11){
      if(this.documentSearch.length == 8){
        let reg = {
          dni:this.documentSearch
        };
        this.SellerService.recuperardni(reg.dni).subscribe(
          (result: any) => {
            this.formularioContrato.patchValue({
              nombre: result.nombres,
              paterno: result.apellidoPaterno,
              materno: result.apellidoMaterno
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
            this.formularioContrato.patchValue({
              empresa: result.nombre_o_razon_social
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

  personamodal(){
    this.personModal.show();
  }

  openRedirection(documento:string,codigo:string){
    this.document= documento;
    this.code = codigo;
    this.onReturndata(1);
    this.onReturndata(2);
    this.onReturndata(3);
    this.onReturndata(4);
    this.onReturndata(5);
    this.onReturndata(6);
  }

  keypressletras(event: any) {
    var regex = new RegExp("^[a-zA-Z ]+$");
    var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
    if (!regex.test(key)) {
      event.preventDefault();
      return false;
    }else{
      this.nombrepersonModel = this.nombrepersonModel.toUpperCase();
      this.paternopersonModel = this.paternopersonModel.toUpperCase();
      this.maternopersonModel = this.maternopersonModel.toUpperCase();
      this.empresapersonModel = this.empresapersonModel.toUpperCase();
    }
  }

  limipiarinputs(){
      this.nombrepersonModel = "";
      this.paternopersonModel = "";
      this.maternopersonModel = "";
      this.empresapersonModel = "";
  }

}
