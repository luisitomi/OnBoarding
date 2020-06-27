import { Component, OnInit, ViewChild } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { ServiceService } from '../../../services/service.service';
import { AppConstants } from '../../../shared/constants/app.constants';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { ModalDirective} from 'ngx-bootstrap/modal';
import { MaterialModel, PendingServiceModel, TecnicoModel, ReclaimPendingModel } from '../../../models/service.model';
import { ResponseModel } from '../../../models/personpay.model';

@Component({
  templateUrl: 'servicio.reclamo.component.html'
})

export class ServicioReclamoComponent implements OnInit{

  materi:MaterialModel[];
  active:MaterialModel[];
  pnd:ReclaimPendingModel[];
  tecnico:TecnicoModel[];

  saveList = [];

  name:string;
  nameCli:string;
  direCli:string;
  itemnextId:number;
  itemdetalleId:number;
  itemnextIdT:number;
  itemdetalleIdT:number;
  valueId:number;
  countiD:number;
  anotacion:string;

  userActive:boolean = false;
  listActie:boolean = true;
  saveActive:boolean = false;

  submittedT: boolean;

  public formularioTecnico: FormGroup;

  value:number;
  
  @ViewChild('tecnicoModal') public tecnicoModal: ModalDirective;

  itemsPerPageS: number = 3;
  currentPageS: number = 1;
  itemsPerPage: number = 3;
  currentPage: number = 1;

  constructor(
    private router: Router,
    private ServiceService: ServiceService,
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
  }

  initFC() {
    this.formularioTecnico = this.formBuilder.group({
      nombre: ['0', Validators.required]
    });
  }

  change(id:number,next:number){
    this.onReturndata(1);
    this.ById(id,next);
  }

  changeTec(id:number,next:number){
    this.opentecnico(id,next);
    this.tecnicoModal.show();
  }

  opentecnico(id:number,next:number){
    this.itemnextIdT = next;
    this.itemdetalleIdT = id;
  }

  changeTecnico(){
    this.submittedT = true;
    let registerSaveLed = this.formularioTecnico.value;

    if (!this.formularioTecnico.controls.nombre.valid ||
      this.formularioTecnico.controls.nombre.value == 0) {
     this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }

    this.ServiceService.cambiartecnico(2,
                                      registerSaveLed.nombre,
                                      this.itemdetalleIdT,
                                      this.itemnextIdT).subscribe(
    (resultS: ResponseModel[]) => {
    try{
      if(resultS[0].id == 1){
        this.toastr.success(
          AppConstants.MessageModal.REGISTER_UPDATED,
          AppConstants.TitleModal.REGISTER_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
        this.tecnicoModal.hide();
      }else{
        this.toastr.warning(
          AppConstants.MessageModal.REGISTER_NO_CREATED,
          AppConstants.TitleModal.SERVICE_TITLE,
          {closeButton: true}
        );
        this.submittedT = false;
        this.onReturndata(0);
        this.tecnicoModal.hide();
      }
    }catch{
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.REGISTER_TITLE,
        {closeButton: true}
        );
        this.onReturndata(0);
        this.tecnicoModal.hide();
      }
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.REGISTER_TITLE,
        {closeButton: true}
      );
      this.onReturndata(0);
      this.tecnicoModal.hide();
    })

  }

  saveData(){
    if(this.saveList.length < 1 || this.anotacion == "" || this.anotacion == undefined){
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_FIELDS_MESSAGE,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }

    for(let itc = 0;itc < this.saveList.length ;itc++){
      if(itc + 1 == this.saveList.length){
        this.ServiceService.guardarReclamo(
                                              this.itemdetalleId,
                                              parseInt(sessionStorage.getItem(AppConstants.Session.USERID)),
                                              this.anotacion,
                                              this.saveList[itc].materialId,
                                              this.saveList[itc].cantidad
        ).subscribe(
          (result: ResponseModel[]) => {
             try{
              if(result[0].id == 1){
                this.toastr.success(
                  AppConstants.MessageModal.REGISTER_CREATED,
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
             }catch{
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
           })
      }
      else{
        this.ServiceService.guardarInstalacion(
          this.itemdetalleId,
          this.itemnextId,
          parseInt(sessionStorage.getItem(AppConstants.Session.USERID)),
          this.anotacion,
          this.saveList[itc].materialId,
          this.saveList[itc].cantidad
        ).subscribe(
        (result: ResponseModel[]) => {
           try{
            if(result[0].id == 1){
              
            }else{
              
            }
           }catch{
            
           }
          },
          error => {
            
        })
      }
    }
  }

  listado(){
    this.materi = [];
    this.ServiceService.listadomateriales().subscribe(
    (result: MaterialModel[]) => {
      this.materi = result
    },
    error => {
    })
  }

  envio(){
    if(this.valueId == undefined || this.countiD == undefined){
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_FIELDS_MESSAGE,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }
    let searchData = this.saveList.filter(l => l.materialId.toString().startsWith(this.valueId.toString()))
    if (searchData.length == 0) {
      let searchDataM = this.materi.filter(l => l.id.toString().startsWith(this.valueId.toString()))
      this.saveList = this.saveList.concat([{
        detalleId:this.itemdetalleId,
        nextId: this.itemnextId,
        materialId: this.valueId,
        cantidad: this.countiD,
        name:searchDataM[0].name
      }]);
    } else {
      this.toastr.warning(
        AppConstants.MessageModal.DATA_REPET,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
    }
  }

  onReturndata(id:number){
    switch(id){
      case 0:
        this.initFC();
        this.listadopendientes(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)));
        this.validation();
        this.listActie = true;
        this.saveActive = false;
        this.listadotecni();
        this.listadoactive();
        this.listado();
        break;
      case 1:
        this.listActie = false;
        this.saveActive = true;
        break;
    }
  }

  listadotecni(){
    this.tecnico = [];
    this.ServiceService.listadotecnicos().subscribe(
    (result: TecnicoModel[]) => {
      this.tecnico = result
    },
    error => {
    })
  }

  listadoactive(){
    this.active = [];
    this.ServiceService.listadomaterialesActivo().subscribe(
    (result: MaterialModel[]) => {
      this.active = result
    },
    error => {
    })
  }

  listadopendientes(id:number){
    this.pnd = [];
    this.ServiceService.listarsreclamospendientes(id).subscribe(
    (result: ReclaimPendingModel[]) => {
      this.pnd = result;
    },
    error => {
    })
  }

  validation(){
    if(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) > 6 &&
    parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) < 8){
      this.userActive = true
    }else{
      this.userActive = false
    }
  }

  ById(id:number,next:number){
    this.itemnextId = next;
    this.itemdetalleId = id;
    this.ServiceService.listarsreclamospendientes(parseInt(sessionStorage.getItem(AppConstants.Session.USERID))).subscribe(
      (result: ReclaimPendingModel[]) => {
        const searchData = [];
        for (const l of this.pnd) {
          if (l.reclamoD.toString().indexOf(id.toString()) > -1) {
            searchData.push(l)
          }
        }
        if (searchData.length > 0) {
          this.nameCli = searchData[0].client;
          this.direCli = searchData[0].street;
        }
      }
    )
  }

  get g() { return this.formularioTecnico.controls; }

}
