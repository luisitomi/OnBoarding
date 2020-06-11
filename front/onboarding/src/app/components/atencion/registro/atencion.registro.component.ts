import { Component, ViewChild, OnInit } from '@angular/core';
import { PersonPayModel, PersonByIdPayModel, PersonByIdPayDirectionModel, PersonByIdPayReferenceModel, PersonByIdPayMangerModel, PersonByIdPayVoucherModel, PersonByIdPayDetailModel, ResponseModel, DirectionListModel, PersonByIdPayDetailExitModel } from '../../../models/personpay.model';
import { Router, NavigationEnd } from '@angular/router';
import { PersonPayService } from '../../../services/personpay.service';
import { ManagerPayService } from '../../../services/managerpay.service';
import { ModalDirective} from 'ngx-bootstrap/modal';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { ManagerPayModel } from '../../../models/managerpay.model';
import { MonthPayService } from '../../../services/monthpay.service';
import { MonthPayModel } from '../../../models/monthpay.model';
import { CallCenterModel } from '../../../models/callcenter.model';
import { CallCenterService } from '../../../services/callcenter.service';
import { ToastrService } from 'ngx-toastr';
import { AppConstants } from '../../../shared/constants/app.constants';

@Component({
  templateUrl: 'atencion.registro.component.html'
})

export class RegistroAtenciónComponent implements OnInit{
  public formularioPerson: FormGroup;
  public formularioDirection: FormGroup;
  public formularioChangeDirection: FormGroup;
  public formularioReference: FormGroup;
  public formularioReclamo: FormGroup;
  
  @ViewChild('personModal') public personModal: ModalDirective;
  @ViewChild('directionModal') public directionModal: ModalDirective;
  @ViewChild('referenceModal') public referenceModal: ModalDirective;
  @ViewChild('serviceaexitModal') public serviceaexitModal: ModalDirective;
  @ViewChild('reclamoSaveModal') public reclamoSaveModal: ModalDirective;
  
  personpay: PersonPayModel[];
  personpaydata: PersonByIdPayModel[];
  monthexit:MonthPayModel[];

  itemsPerPage: number = 5;
  currentPage: number = 1;

  busqueda:string;

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
  servicioview:CallCenterModel[];
  reclamoview:CallCenterModel[];

  listadoActive: boolean = false;
  detalleActive: boolean = false;
  registroActive: boolean = false;

  pagoDeleteActive: boolean = false;
  pagoExitActive: boolean = false;

  submitted: boolean;
  submittedDirection: boolean;
  submittedChangeDirection: boolean;
  submittedManager: boolean;
  submittedReference: boolean;
  submittedSaveActive: boolean;
  submittedReclamoActive: boolean;

  constructor(
    private PersonPayService: PersonPayService,
    private ManagerPayService: ManagerPayService,
    private MonthPayService: MonthPayService,
    private CallCenterService: CallCenterService,
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
    this.formularioReclamo   = this.formBuilder.group({
      documentoreclamo: [''],
      codereclamo: [''],
      servicioreclamo: ['', Validators.required],
      idreclamo: ['', Validators.required],
      descripcionreclamo: ['', Validators.required]
    });
  }

  registerReclamo(){
    this.submittedDirection = true;
    let registerReclamo = this.formularioReclamo.value;

    registerReclamo.documentodirection = this.document
    registerReclamo.codedirection = this.code
    registerReclamo.servicioreclamo = parseInt(registerReclamo.servicioreclamo);
    registerReclamo.idreclamo = parseInt(registerReclamo.idreclamo);

    if (!this.formularioReclamo.controls.servicioreclamo.valid ||
      !this.formularioReclamo.controls.idreclamo.valid ||
      !this.formularioReclamo.controls.descripcionreclamo.valid ) {

      return false;
    }

    this.CallCenterService.postReclaimByIdSave(this.document,
                                              this.code,
                                              registerReclamo.servicioreclamo,
                                              registerReclamo.idreclamo,
                                              registerReclamo.descripcionreclamo).subscribe(
    (result: ResponseModel[]) => {
       try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_CREATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.reclamoSaveModal.hide();
          this.submittedReclamoActive = false;
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.reclamoSaveModal.hide();
          this.submittedReclamoActive = false;
        }
       }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.REGISTER_TITLE,
          {closeButton: true}
        );
          this.reclamoSaveModal.hide();
          this.submittedReclamoActive = false;
       }
     },
     error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.REGISTER_TITLE,
        {closeButton: true}
      );
      this.reclamoSaveModal.hide();
      this.submittedReclamoActive = false;
     })
  }

  cerrarModal(){
    this.reclamoSaveModal.hide();
  }

  registerReference(){
    this.submittedReference = true;
    let registerReference = this.formularioReference.value;

    registerReference.documentoreference = this.document
    registerReference.codereference = this.code

    if (!this.formularioReference.controls.descriptionreference.valid) {

      return false;
    }

    this.referenceModal.hide();
    
  }

  registerDirection(){
    this.submittedDirection = true;
    let registerDirection = this.formularioDirection.value;

    registerDirection.documentodirection = this.document
    registerDirection.codedirection = this.code
    registerDirection.zonedirection = parseInt(registerDirection.zonedirection);

    if (!this.formularioDirection.controls.numberdirection.valid ||
      !this.formularioDirection.controls.zonedirection.valid ) {

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
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.directionModal.hide();
          this.onReturndata(2);
          this.submittedDirection = false;
        }
       }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.REGISTER_TITLE,
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
        AppConstants.TitleModal.REGISTER_TITLE,
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
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.personModal.hide();
          this.onReturndata(1);
          this.submitted = false;
        }
       }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.REGISTER_TITLE,
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
        AppConstants.TitleModal.REGISTER_TITLE,
        {closeButton: true}
      );
      this.personModal.hide();
      this.onReturndata(1);
      this.submitted = false;
     })
  }

  get f() { return this.formularioPerson.controls; }

  get g() { return this.formularioDirection.controls; }

  get i() { return this.formularioReference.controls; }

  get j() { return this.formularioReclamo.controls; }

  listadoclientes(){
    this.personpay = [];
    this.PersonPayService.getpersonaslistado("&").subscribe(
    (result: PersonPayModel[]) => {
      this.personpay = result
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

  listadoservice(){
    this.servicioview = [];
    this.CallCenterService.listadoServiciobyid(this.document,this.code).subscribe(
    (result: CallCenterModel[]) => {
      this.servicioview = result
    },
    error => {
    })
  }

  listadoreclaim(){
    this.reclamoview = [];
    this.CallCenterService.listadoreclamo().subscribe(
    (result: CallCenterModel[]) => {
      this.reclamoview = result
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
      break;
      case 1:
        this.listadoActive = false;
        this.registroActive = false;
        this.detalleActive = true;
        this.listadoclientesdatabyid();
        this.listadoclientesdata();
        this.limipiarinputs();
        this.listadoservice();
        this.listadoreclaim();
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
    }
  }

  openMonthExit(){
    this.itemsPerPage = 5;
    this.currentPage = 1;
    this.serviceaexitModal.show(),
    this.onReturndata(9);
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
