import { Component, OnInit, ViewChild } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { ServiceService } from '../../../services/service.service';
import { AppConstants } from '../../../shared/constants/app.constants';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { ModalDirective} from 'ngx-bootstrap/modal';
import { MaterialModel, PendingServiceModel, TecnicoModel } from '../../../models/service.model';
import { ResponseModel } from '../../../models/personpay.model';

@Component({
  templateUrl: 'servicio.listado.component.html'
})

export class ServicioComponent implements OnInit{

  materi:MaterialModel[];
  active:MaterialModel[];
  pnd:PendingServiceModel[];
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

  submitted: boolean;
  submittedE: boolean;
  submittedT: boolean;

  public formlarioSave: FormGroup;
  public formularioEdit: FormGroup;
  public formularioTecnico: FormGroup;

  value:number;
  
  @ViewChild('tecnicoModal') public tecnicoModal: ModalDirective;
  @ViewChild('mateSaveModal') public mateSaveModal: ModalDirective;
  @ViewChild('editSaveModal') public editSaveModal: ModalDirective;

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
    this.formlarioSave = this.formBuilder.group({
      nombre: ['', Validators.required]
    });
    this.formularioEdit = this.formBuilder.group({
      nombre: ['', Validators.required],
      codigo: ['']
    });
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

    this.ServiceService.cambiartecnico(1,
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
        this.ServiceService.guardarInstalacion(
          this.itemdetalleId,
          this.itemnextId,
          parseInt(sessionStorage.getItem(AppConstants.Session.USERID)),
          this.anotacion.toUpperCase(),
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
          this.anotacion.toUpperCase(),
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
        this.listado();
        this.listadoactive();
        this.initFC();
        this.listadopendientes(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)));
        this.validation();
        this.listActie = true;
        this.saveActive = false;
        this.listadotecni();
        break;
      case 1:
        this.listActie = false;
        this.saveActive = true;
        break;
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
    this.ServiceService.listarserviciospendientes(id).subscribe(
    (result: PendingServiceModel[]) => {
      this.pnd = result;
    },
    error => {
    })
  }

  abrir(id:number){
    this.value = id;
    this.bydi(id.toString());
    this.editSaveModal.show();
  }

  validation(){
    if(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) > 6 &&
    parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) < 8){
      this.userActive = true
    }else{
      this.userActive = false
    }
  }

  bydi(id:string){
    this.ServiceService.listadomateriales().subscribe(
      (result: MaterialModel[]) => {
        const searchData = [];
        for (const l of this.materi) {
          if (l.id.toString().indexOf(id) > -1) {
            searchData.push(l)
          }
        }
        if (searchData.length > 0) {
          this.name = searchData[0].name;
        }
      }
    )
  }

  ById(id:number,next:number){
    this.itemnextId = next;
    this.itemdetalleId = id;
    this.ServiceService.listarserviciospendientes(parseInt(sessionStorage.getItem(AppConstants.Session.USERID))).subscribe(
      (result: PendingServiceModel[]) => {
        const searchData = [];
        for (const l of this.pnd) {
          if (l.detalleId.toString().indexOf(id.toString()) > -1) {
            searchData.push(l)
          }
        }
        if (searchData.length > 0) {
          this.nameCli = searchData[0].name;
          this.direCli = searchData[0].district;
        }
      }
    )
  }

  edit(){
    this.submittedE = true;
    let register = this.formularioEdit.value;

    if (!this.formularioEdit.controls.nombre.valid) {
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }

    this.ServiceService.editarmaterial(register.nombre.toUpperCase(),this.value).subscribe(
    (result: ResponseModel[]) => {
       try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_CREATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.editSaveModal.hide();
          this.onReturndata(0);
          this.submittedE = false;
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.editSaveModal.hide();
          this.onReturndata(0);
          this.submittedE = false;
        }
       }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
          this.editSaveModal.hide();
          this.onReturndata(0);
          this.submittedE = false;
       }
     },
     error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.editSaveModal.hide();
      this.onReturndata(0);
      this.submittedE = false;
     })
  }

  save(){
    this.submitted = true;
    let register = this.formlarioSave.value;

    if (!this.formlarioSave.controls.nombre.valid) {
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }

    this.ServiceService.guardarmaterial(register.nombre.toUpperCase()).subscribe(
    (result: ResponseModel[]) => {
       try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_CREATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.mateSaveModal.hide();
          this.onReturndata(0);
          this.submitted = false;
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.mateSaveModal.hide();
          this.onReturndata(0);
          this.submitted = false;
        }
       }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
          this.mateSaveModal.hide();
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
      this.mateSaveModal.hide();
      this.onReturndata(0);
      this.submitted = false;
     })
  }

  get f() { return this.formlarioSave.controls; }

  get g() { return this.formularioTecnico.controls; }

  get h() { return this.formularioEdit.controls; }

}
