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
import { AppConstants } from '../../../shared/constants/app.constants';
import { ToastrService } from 'ngx-toastr';
import { SellerService } from '../../../services/saller.service';
import { CallCenterModel } from '../../../models/callcenter.model';
import { CallCenterService } from '../../../services/callcenter.service';

@Component({
  selector: 'app-pago',
  templateUrl: 'cobranza.pago.component.html'
})

export class CobranzaComponent implements OnInit{

  public formularioPerson: FormGroup;
  public formularioDirection: FormGroup;
  public formularioManager: FormGroup;
  public formularioReference: FormGroup;
  public formularioSavePayActive: FormGroup;
  public formularioSavePayExit: FormGroup;
  public formularioSavePayDelete: FormGroup;
  
  @ViewChild('personModal') public personModal: ModalDirective;
  @ViewChild('directionModal') public directionModal: ModalDirective;
  @ViewChild('referenceModal') public referenceModal: ModalDirective;
  @ViewChild('managerModal') public managerModal: ModalDirective;
  @ViewChild('serviceactiveModal') public serviceactiveModal: ModalDirective;
  @ViewChild('serviceaexitModal') public serviceaexitModal: ModalDirective;
  @ViewChild('servicedeleteModal') public servicedeleteModal: ModalDirective;
  
  personpay: PersonPayModel[];
  personpaydata: PersonByIdPayModel[];
  monthactive:MonthPayModel[];
  monthexit:MonthPayModel[];
  monthdelete:MonthPayModel[];
  servicioview:CallCenterModel[];
  servicioviews:CallCenterModel[];

  itemsPerPage: number = 4;
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
  amountdetailcable:number;
  amountdetailinternet:number;
  amountgeneral:string;
  amountdetailcabledelete:number;
  amountdetailinternetdelete:number;
  amountgeneraldelete:string;
  amountdetailcableexit:number;
  amountdetailinternetexit:number;
  amountgeneralexit:string;
  clientele:string;

  nombrepersonModel:string;
  maternopersonModel:string;
  paternopersonModel:string;
  empresapersonModel:string;

  managerview:ManagerPayModel[];
  directionview:DirectionListModel[];

  listadoActive: boolean = false;
  detalleActive: boolean = false;
  pagoActive: boolean = false;
  pagoDeleteActive: boolean = false;
  pagoExitActive: boolean = false;
  userActive:boolean = false;

  submitted: boolean;
  submittedDirection: boolean;
  submittedManager: boolean;
  submittedReference: boolean;
  submittedSaveActive: boolean;
  submittedSaveExit: boolean;
  submittedSaveDelete: boolean;

  constructor(
    private PersonPayService: PersonPayService,
    private ManagerPayService: ManagerPayService,
    private MonthPayService: MonthPayService,
    private router: Router,
    private formBuilder: FormBuilder,
    private toastr: ToastrService,
    private SellerService: SellerService,
    private CallCenterService: CallCenterService,
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
    this.formularioReference   = this.formBuilder.group({
      documentoreference: [''],
      codereference: [''],
      descriptionreference: ['', Validators.required]
    });
    this.formularioManager   = this.formBuilder.group({
      documentomanager: [''],
      codemanager: [''],
      gestormanagerid: ['', Validators.required]
    });
  }

  formsave(){
    this.formularioSavePayActive = this.formBuilder.group({
      documentosave: [''],
      codesave: [''],
      amountpaySave: ['0', Validators.required],
      userSave: [''],
      selectpaySave: ['0', Validators.required]
    });
  }

  formsaveExit(){
    this.formularioSavePayExit = this.formBuilder.group({
      documentosaveE: [''],
      codesaveE: [''],
      amountpaySaveE: ['0', Validators.required],
      userSaveE: [''],
      selectpaySaveE: ['', Validators.required],
      typesaveE: ['', Validators.required],
      selectserviceSaveE: ['', Validators.required]
    });
  }

  formsaveDelete(){
    this.formularioSavePayDelete = this.formBuilder.group({
      documentosaveE: [''],
      codesaveE: [''],
      amountpaySaveE: ['0', Validators.required],
      userSaveE: [''],
      selectpaySaveE: ['', Validators.required],
      typesaveE: ['', Validators.required],
      selectserviceSaveE: ['', Validators.required]
    });
  }

  savedeletefunction(){
    this.submittedSaveDelete = true;
    let registerSaveLed = this.formularioSavePayDelete.value;

    registerSaveLed.amountpaySaveE = parseFloat(registerSaveLed.amountpaySaveE).toFixed(2);
    registerSaveLed.selectpaySaveE = parseInt(registerSaveLed.selectpaySaveE);
    registerSaveLed.documentosaveE = this.document
    registerSaveLed.userSaveE = parseInt(sessionStorage.getItem(AppConstants.Session.USERID))
    registerSaveLed.codesaveE = this.code
    registerSaveLed.typesaveE = parseInt(registerSaveLed.typesaveE);
    registerSaveLed.selectserviceSaveE = parseInt(registerSaveLed.selectserviceSaveE);

    if (!this.formularioSavePayDelete.controls.amountpaySaveE.valid ||
      !this.formularioSavePayDelete.controls.selectpaySaveE.valid ||
      !this.formularioSavePayDelete.controls.typesaveE.valid ||
      !this.formularioSavePayDelete.controls.selectserviceSaveE.valid) {
     this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }

    if (registerSaveLed.amountpaySaveE == 0) {
      this.toastr.warning(
        "El monto debe ser mayor a 0",
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;

    }

    if (registerSaveLed.typesaveE == 1 && registerSaveLed.amountpaySaveE <= 10) {
      this.toastr.warning(
        "El monto no cumple como mínimo saldo para reconectar",
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;

    }

    if (registerSaveLed.typesaveE == 1 && registerSaveLed.amountpaySaveE > 10) {
      registerSaveLed.amountpaySaveE = parseFloat(registerSaveLed.amountpaySaveE) - 10
    }

    this.MonthPayService.postPayServiceDelete(this.document,
                                              this.code,
                                              registerSaveLed.amountpaySaveE,
                                              registerSaveLed.selectpaySaveE,
                                              registerSaveLed.selectserviceSaveE,
                                              registerSaveLed.typesaveE,
                                              registerSaveLed.userSaveE).subscribe(
    (resultS: ResponseModel[]) => {
      try{
        if(resultS[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_CREATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
        }else{
          if(resultS[0].id == 2){
            this.toastr.warning(
              AppConstants.MessageModal.REGISTER_NO_CREATED,
              "Monto para reconectar inválido",
              {closeButton: true}
            );
          }else{
            this.toastr.warning(
              AppConstants.MessageModal.REGISTER_NO_CREATED,
              AppConstants.TitleModal.REGISTER_TITLE,
              {closeButton: true}
            );
          }
        }
      }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.REGISTER_TITLE,
          {closeButton: true}
        );
      }
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.REGISTER_TITLE,
        {closeButton: true}
      );
    })

  }

  saveexitfunction(){
    this.submittedSaveExit = true;
    let registerSaveLed = this.formularioSavePayExit.value;

    registerSaveLed.amountpaySaveE = parseFloat(registerSaveLed.amountpaySaveE).toFixed(2);
    registerSaveLed.selectpaySaveE = parseInt(registerSaveLed.selectpaySaveE);
    registerSaveLed.documentosaveE = this.document
    registerSaveLed.userSaveE = parseInt(sessionStorage.getItem(AppConstants.Session.USERID))
    registerSaveLed.codesaveE = this.code
    registerSaveLed.typesaveE = parseInt(registerSaveLed.typesaveE);
    registerSaveLed.selectserviceSaveE = parseInt(registerSaveLed.selectserviceSaveE);

    if (!this.formularioSavePayExit.controls.amountpaySaveE.valid ||
      !this.formularioSavePayExit.controls.selectpaySaveE.valid ||
      !this.formularioSavePayExit.controls.typesaveE.valid ||
      !this.formularioSavePayExit.controls.selectserviceSaveE.valid) {
     this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }

    if (registerSaveLed.amountpaySaveE == 0) {
      this.toastr.warning(
        "El monto debe ser mayor a 0",
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;

    }

    if (registerSaveLed.typesaveE == 2 && registerSaveLed.amountpaySaveE <= 10) {
      this.toastr.warning(
        "El monto no cumple como mínimo saldo",
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;

    }

    if (registerSaveLed.typesaveE == 2 && registerSaveLed.amountpaySaveE > 10) {
      registerSaveLed.amountpaySaveE = parseFloat(registerSaveLed.amountpaySaveE) - 10
    }


    if (registerSaveLed.amountpaySaveE == 3 && registerSaveLed.amountpaySaveE <= 20) {
      this.toastr.warning(
        "El monto no cumple como mínimo saldo",
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;

    }

    if (registerSaveLed.typesaveE == 3 && registerSaveLed.amountpaySaveE > 20) {
      registerSaveLed.amountpaySaveE = parseFloat(registerSaveLed.amountpaySaveE) - 20
    }
    
    this.MonthPayService.postPayServiceExits(this.document,
                                            this.code,
                                            registerSaveLed.amountpaySaveE,
                                            registerSaveLed.userSaveE,
                                            registerSaveLed.selectpaySaveE,
                                            registerSaveLed.typesaveE,
                                            registerSaveLed.selectserviceSaveE).subscribe(
      (resultS: ResponseModel[]) => {
        try{
          if(resultS[0].id == 1){
            this.toastr.success(
              AppConstants.MessageModal.REGISTER_CREATED,
              AppConstants.TitleModal.REGISTER_TITLE,
              {closeButton: true}
            );
            this.MonthPayService.deleteDetailCountExit( this.document,
                                                        this.code,
                                                        registerSaveLed.selectserviceSaveE).subscribe(
            (result: ResponseModel[]) => {
              try{
                if(result[0].id == 1){
                  this.toastr.success(
                    AppConstants.MessageModal.REGISTER_UPDATED,
                    AppConstants.TitleModal.SERVICE_TITLE,
                    {closeButton: true}
                  );
                  this.onReturndata(8);
                  this.onReturndata(5);
                  this.submittedSaveExit = false;

                  if(parseInt(registerSaveLed.typesaveE) == 2){
                    let envioData = {};
                    envioData = {
                      "from": {
                        "email": "Luismiguel.larosa@gestionysistemas.com",
                        "name": "Cable Color - Internet Color!!!"
                      },
                      "to": [
                        {
                          "email": "martinmejia@internetcolor.net",
                          "name": "Corte del Servicio de Internet"
                        },
                        {
                          "email": "aries_250397@hotmail.com",
                          "name": "Corte del Servicio de Internet"
                        }
                      ],
                      "subject": "Envio de contrato",
                      "html_part":  "<h2 style='color:red'>AVISO...!</h2><br /> <p>Cortar servicio del cliente "+this.clientele+"</p>",
                      "text_part": "My first Mailjet emai",
                      "text_part_auto": false,
                      "CustomID": "AppGettingStartedTest",
                      "headers": {},
                      "smtp_tags": [
                        "string"
                      ]
                    };
                    this.SellerService.createSendEmail(envioData).subscribe(
                      (result: any) => {
                        this.toastr.success(
                          AppConstants.MessageModal.EMAIL_MESSAGE,
                          AppConstants.TitleModal.ENVIAR_TITLE,
                          {closeButton: true}
                        );
                      }
                    ),
                    error => {
                      this.toastr.error(
                        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
                        AppConstants.TitleModal.ERROR_TITLE,
                        {closeButton: true}
                      );
                    }
                  }

                }else{
                  this.toastr.warning(
                    AppConstants.MessageModal.REGISTER_NO_CREATED,
                    AppConstants.TitleModal.SERVICE_TITLE,
                    {closeButton: true}
                  );
                  this.onReturndata(8);
                  this.onReturndata(5);
                  this.submittedSaveExit = false;
                }
              }catch{
                this.toastr.error(
                  AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
                  AppConstants.TitleModal.SERVICE_TITLE,
                  {closeButton: true}
                );
                this.onReturndata(8);
                this.onReturndata(5);
                this.submittedSaveExit = false;
              }
            },
            error => {
              this.toastr.error(
              AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
              AppConstants.TitleModal.SERVICE_TITLE,
              {closeButton: true}
              );
              this.onReturndata(8);
              this.onReturndata(5);
              this.submittedSaveExit = false;
            })
          }else{
            this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
            );
          }
        }catch{
          this.toastr.error(
            AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
        }
      },
      error => {
        this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.REGISTER_TITLE,
        {closeButton: true}
        );
      })

  }

  savepayFunction(){
    this.submittedSaveActive = true;
    let registerSaveLed = this.formularioSavePayActive.value;
    
    registerSaveLed.amountpaySave = parseFloat(registerSaveLed.amountpaySave).toFixed(2);
    registerSaveLed.selectpaySave = parseInt(registerSaveLed.selectpaySave);
    registerSaveLed.documentosave = this.document
    registerSaveLed.userSave = parseInt(sessionStorage.getItem(AppConstants.Session.USERID))
    registerSaveLed.codesave = this.code

    if (!this.formularioSavePayActive.controls.amountpaySave.valid ||
        !this.formularioSavePayActive.controls.selectpaySave.valid) {
       this.toastr.warning(
          AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
          AppConstants.TitleModal.WARNING_TITLE,
          {closeButton: true}
        );
       return false;
    }

    if (registerSaveLed.amountpaySave == 0) {
      this.toastr.warning(
        "El monto debe ser mayor a 0",
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;

    }
  
    this.MonthPayService.postPayServiceactivo(this.document,
                                               this.code,
                                               registerSaveLed.amountpaySave,
                                               registerSaveLed.userSave,
                                               registerSaveLed.selectpaySave).subscribe(
    (result: ResponseModel[]) => {
      try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_CREATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.onReturndata(8);
          this.submittedSaveActive = false;
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.onReturndata(8);
          this.submittedSaveActive = false;
        }
      }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
        this.onReturndata(8);
        this.submittedSaveActive = false;
      }
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.onReturndata(8);
      this.submittedSaveActive = false;
    })

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

  registerManager(){
    this.submittedManager = true;
    let registerManager = this.formularioManager.value;

    registerManager.documentomanager = this.document
    registerManager.codemanager = this.code
    registerManager.gestormanagerid = parseInt(registerManager.gestormanagerid);

    if (!this.formularioManager.controls.gestormanagerid.valid) {
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }

    this.ManagerPayService.patchManagerByIddetalle(this.document,this.code,registerManager.gestormanagerid).subscribe(
    (result: ResponseModel[]) => {
       try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_CREATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.managerModal.hide();
          this.onReturndata(4);
          this.submittedManager = false;
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.managerModal.hide();
          this.onReturndata(4);
          this.submittedManager = false;
        }
       }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
          this.managerModal.hide();
          this.onReturndata(4);
          this.submittedManager = false;
       }
     },
     error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.managerModal.hide();
      this.onReturndata(4);
      this.submittedManager = false;
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
    this.toastr.warning(
      AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
      AppConstants.TitleModal.REGISTER_TITLE,
      {closeButton: true}
    );
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

  get f() { return this.formularioPerson.controls; }

  get g() { return this.formularioDirection.controls; }

  get h() { return this.formularioManager.controls; }

  get i() { return this.formularioReference.controls; }

  get j() { return this.formularioSavePayActive.controls; }

  get k() { return this.formularioSavePayExit.controls; }

  get l() { return this.formularioSavePayDelete.controls; }

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

  listadoclientesdatagestorById(){
    this.PersonPayService.getpersonasdatagestor(this.document,this.code).subscribe(
      (result: PersonByIdPayMangerModel[]) => {
        this.formularioManager.patchValue({
          gestormanagerid: result[0].document
        });
      },
    error => {
    })
  }

  listadoclientesdatapago(){
    let sum;
    this.PersonPayService.getpersonasdatadetalle(this.document,this.code).subscribe(
    (result: PersonByIdPayDetailModel[]) => {
      try{
        if(result.length > 1){
          if(result[1].service == "Cable"){
            this.amountdetailinternet = result[0].amount
            this.amountdetailcable = result[1].amount
            sum = this.amountdetailinternet*1 + this.amountdetailcable*1
            this.amountgeneral = parseFloat(sum).toFixed(2)
            if(sum > 0){
              this.pagoActive = true;
            }else{
              this.pagoActive = false;
              this.servicedelete = "No existe servicios Cortados"
            }
          }else{
            this.amountdetailinternet = result[1].amount
            this.amountdetailcable = result[0].amount
            sum = this.amountdetailinternet*1 + this.amountdetailcable*1
            this.amountgeneral = parseFloat(sum).toFixed(2)
            if(sum > 0){
              this.pagoActive = true;
            }else{
              this.pagoActive = false;
              this.servicedelete = "No existe servicios Cortados"
            }
          }
        }else{
          if(result[0].service == "Cable"){
            this.amountdetailinternet = result[0].amount
            this.amountdetailcable = 0
          }else{
            this.amountdetailcable = result[0].amount
            this.amountdetailinternet = 0
          }
          sum = this.amountdetailinternet + this.amountdetailcable
          this.amountgeneral = parseFloat(sum).toFixed(2)
          if(sum > 0){
            this.pagoActive = true;
          }else{
            this.pagoActive = false;
            this.servicedelete = "No existe servicios Cortados"
          }
        }
      }catch{
        this.amountdetailcable = 0
        this.amountdetailinternet = 0
        sum = this.amountdetailinternet + this.amountdetailcable
        this.amountgeneral = parseFloat(sum).toFixed(2)
        this.servicedelete = "No existe servicios Cortados"
        this.pagoActive = false;
      }
    },
    error => {
      this.amountdetailcable = 0
      this.amountdetailinternet = 0
      sum = this.amountdetailinternet + this.amountdetailcable
      this.amountgeneral = parseFloat(sum).toFixed(2)
      this.servicedelete = "No existe servicios Cortados"
      this.pagoActive = false;
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
          if(result[0].service == "Cable"){
            this.amountdetailcabledelete = result[0].amount
            this.servicedelete = "DEUDA ATRASADA DE:" + result[0].service
            this.amountdetailinternetdelete = 0
          }else{
            this.amountdetailinternetdelete = result[0].amount
            this.servicedelete = "DEUDA ATRASADA DE:" + result[0].service
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
          if(result[0].service == "Cable"){
            this.amountdetailcableexit = result[0].amount
            this.amountdetailinternetexit = 0
          }else{
            this.amountdetailinternetexit = result[0].amount
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

  listadomesesactivos(){
    this.monthactive = [];
    this.MonthPayService.getlistadoactivo(this.document,this.code).subscribe(
    (result: MonthPayModel[]) => {
      this.monthactive = result
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

  listadomesesdelete(){
    this.monthdelete = [];
    this.MonthPayService.getlistadodelete(this.document,this.code).subscribe(
    (result: MonthPayModel[]) => {
      this.monthdelete = result
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
        this.busqueda="";
        this.listadoclientes();
        this.initForms();
      break;
      case 1:
        this.listadoActive = false;
        this.detalleActive = true;
        this.listadoclientesdatabyid();
        this.listadoclientesdata();
        this.limipiarinputs();
        this.validation();
        this.listadoservice();
        this.listadoserviceNot();
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
        this.listadoclientesdatagestorById();
      break;
      case 5:
        this.listadoclientesdatavoucher();
      break;
      case 6:
        this.listadoclientesdatapago();        
        this.formsave();
        this.formsaveExit();
        this.formsaveDelete();
        this.listadoclientesdatapagoDelete();
        this.listadoclientesdatapagoExit();
      break;
      case 7:
        this.listadomesesactivos();
      break;
      case 8:
        this.listadoclientesdatapago();   
        this.listadoclientesdatapagoExit();  
        this.listadoclientesdatapagoDelete();   
        this.formsave();
        this.listadomesesdelete();
      break;
      case 9:
        this.listadomesesexit();
      break;
      case 10:
        this.formsaveExit();
      break;
      case 11:
        this.listadomesesdelete();
      break;
    }
  }

  openMonthActive(){
    this.itemsPerPage = 4;
    this.currentPage = 1;
    this.serviceactiveModal.show();
    this.onReturndata(7);
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

  listadoserviceNot(){
    this.servicioviews = [];
    this.CallCenterService.listadoServiciobyidNot(this.document,this.code).subscribe(
    (result: CallCenterModel[]) => {
      this.servicioviews = result
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

  personamodal(){
    this.personModal.show();
  }

  openRedirection(documento:string,codigo:string,clienteElegid:string){
    this.document= documento;
    this.code = codigo;
    this.clientele = clienteElegid
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

  validation(){
    if(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) > 0 &&
    parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) < 4){
      this.userActive = true
    }else{
      this.userActive = false
    }
  }

}
