import { Component, OnInit, ViewChild } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { DatePipe } from '@angular/common';
import { SellerListModel, SellerModel } from '../../../models/seller.model';
import { SellerService } from '../../../services/saller.service';
import { AppConstants } from '../../../shared/constants/app.constants';
import { FormGroup, Validators, FormBuilder } from '@angular/forms';
import { ModalDirective } from 'ngx-bootstrap/modal';
import { ResponseModel } from '../../../models/personpay.model';
import { ToastrService } from 'ngx-toastr';

@Component({
  templateUrl: 'venta.listado.component.html',
  providers: [DatePipe]
})

export class ListadoVentaComponent implements OnInit{

  public formularioCancelacion: FormGroup;
  
  @ViewChild('cancelacionModal') public cancelacionModal: ModalDirective;
  
  itemsPerPageS: number = 3;
  currentPageS: number = 1;

  detalleId:number = 0;
  inicio:string;
  final:string;

  detallePro:number;
  consecutivoPro:number;

  myDate = new Date();

  dateService:SellerListModel[];
  vendedoresview:SellerModel[];

  pdfExportActive:boolean = false;

  submitted: boolean;

  constructor(
    private router: Router,
    private datePipe: DatePipe,
    private SellerService: SellerService,
    private formBuilder: FormBuilder,
    private toastr: ToastrService
  ) {
    this.router.events.subscribe(evt => {
      if (evt instanceof NavigationEnd) {
        this.router.navigated = false;
        window.scrollTo(0, 0);
      }
    })
  }

  ngOnInit() {
    this.inicio = this.datePipe.transform(this.myDate, 'yyyy-MM-dd');
    this.final = this.datePipe.transform(this.myDate, 'yyyy-MM-dd');
    this.listadoservicioData();
    this.listvendedores();
    this.initForms();
  }

  listadoservicioData(){
    this.dateService = [];
    this.SellerService.listadoservicios(this.detalleId,this.inicio,this.final).subscribe(
    (result: SellerListModel[]) => {
      this.dateService = result
      try{
        if(result.length > 0){
          this.pdfExportActive = true
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.DATA_EMPTY,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.pdfExportActive = false
        }
      }catch{
        this.toastr.warning(
          AppConstants.MessageModal.DATA_EMPTY,
          AppConstants.TitleModal.REGISTER_TITLE,
          {closeButton: true}
        );
        this.pdfExportActive = false
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

  listvendedores(){
    this.vendedoresview = [];
    this.SellerService.listadovendedores().subscribe(
    (result: SellerModel[]) => {
      this.vendedoresview = result
    },
    error => {
    })
  }

  generarPdf(){
    if(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 4 || parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 0){
      window.open("http://localhost:8050/vendedorListado","_blank");
    }
  }

  openRedirection(detalle:number,siguiente:number){
    this.detallePro = detalle;
    this.consecutivoPro = siguiente;
    this.cancelacionModal.show();
  }

  registerCancel(){
    this.submitted = true;
    let registerC = this.formularioCancelacion.value;

    if (!this.formularioCancelacion.controls.cancelacion.valid) {

      return false;
    }

    this.SellerService.deletePreInstallSaleSave(this.detallePro,this.consecutivoPro,registerC.cancelacion.toUpperCase()).subscribe(
      (result: ResponseModel[]) => {
         try{
          if(result[0].id == 1){
            this.toastr.success(
              AppConstants.MessageModal.REGISTER_CREATED,
              AppConstants.TitleModal.REGISTER_TITLE,
              {closeButton: true}
            );
            this.cancelacionModal.hide();
            this.onReturndata(0);
            this.submitted = false;
          }else{
            this.toastr.warning(
              AppConstants.MessageModal.REGISTER_NO_CREATED,
              AppConstants.TitleModal.REGISTER_TITLE,
              {closeButton: true}
            );
            this.cancelacionModal.hide();
            this.onReturndata(0);
            this.submitted = false;
          }
         }catch{
            this.cancelacionModal.hide();
            this.onReturndata(0);
            this.submitted = false;
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
        this.cancelacionModal.hide();
        this.onReturndata(0);
        this.submitted = false;
       })
  }

  get f() { return this.formularioCancelacion.controls; }

  initForms() {
    this.formularioCancelacion = this.formBuilder.group({
      cancelacion: ['', Validators.required]
    });
  }

  onReturndata(id:number){
    switch(id){
      case 0:
        this.listadoservicioData();
      break;
    }
  }

}
