import { Component, OnInit } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { DatePipe } from '@angular/common';
import { ListPayService } from '../../../services/listpay.service';
import { ListPayModel, ListManagerModel, GestorModel, GestorSegundoModel } from '../../../models/listpay.model';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { AppConstants } from '../../../shared/constants/app.constants';
import { ResponseModel } from '../../../models/personpay.model';
import { ToastrService } from 'ngx-toastr';
import { ManagerPayModel } from '../../../models/managerpay.model';
import { ManagerPayService } from '../../../services/managerpay.service';

@Component({
  templateUrl: 'cobranza.listado.component.html',
  providers: [DatePipe]
})

export class ListadoComponent implements OnInit{

  public formularioSearch: FormGroup;
  
  busqueda:string;
  busquedaS:string;
  busquedapago:string;
  busquedaListado:string;
  valueG:number = 1;

  listpay: ListPayModel[];
  listpaymanager: ListManagerModel[];
  listgestor:GestorModel[];

  gestoresview:ManagerPayModel[];

  submitted: boolean;

  myDate = new Date();

  itemsPerPageS: number = 3;
  currentPageS: number = 1;
  itemsPerPage: number = 3;
  currentPage: number = 1;

  active:number = 1;

  pdfexportActive:boolean = false;
  gestorActive:boolean = false;

  constructor(
    private ListPayService: ListPayService,
    private router: Router,
    private formBuilder: FormBuilder,
    private datePipe: DatePipe,
    private toastr: ToastrService,
    private ManagerPayService: ManagerPayService,
  ) {
    this.router.events.subscribe(evt => {
      if (evt instanceof NavigationEnd) {
        this.router.navigated = false;
        window.scrollTo(0, 0);
      }
    })
  }

  ngOnInit() {
    this.busqueda = this.datePipe.transform(this.myDate, 'yyyy-MM-dd');
    this.busquedaS = this.datePipe.transform(this.myDate, 'yyyy-MM-dd');
    this.formsearch();
    this.searchfech();
    this.validation();
    this.searchfechG();
    this.listgestoresviews();
  }

  listgestoresviews(){
    this.gestoresview = [];
    this.ManagerPayService.getgestoreslistado().subscribe(
      (result: ManagerPayModel[]) => {
        this.gestoresview = result
      },
      error => {
      })
  }

  generarPdf(){
    if(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 1 || parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 0){
      window.open("http://localhost:8050/planillaCajaUno","_blank");
    }else{
      if(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 2 || parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 0){
        window.open("http://localhost:8050/planillaCajaDos","_blank");
      }else{
        window.open("http://localhost:8050/planillaCajaTres","_blank");
      }
    }
  }

  searchfechG(){
    this.currentPage = 1;
    this.itemsPerPage = 3;
    this.listgestor = [];
    this.ListPayService.getlistadogestores(this.valueG).subscribe(
    (result: GestorModel[]) => {
      try{
        if(result.length > 0){
          this.listgestor = result;
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.DATA_EMPTY,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
        }
      }catch{
        this.toastr.warning(
          AppConstants.MessageModal.DATA_EMPTY,
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

  openRedirection(id:string,cod:string,position:number,hoja:number){
    var indices = [];
    var array = [];
    for (let i = 0; i < this.listpay.length; i++) {
      if(parseInt(this.listpay[i].sumation) > 0){
        array = array.concat(this.listpay[i].code)
      }
    }
    var idx = array.indexOf(cod);
    while (idx != -1) {
      indices.push(idx);
      idx = array.indexOf(cod, idx + 1);
    }
    if(parseInt(indices[indices.length-1]) == ((hoja*5 -5)+position)){
      this.ListPayService.deletePayServiceData(id).subscribe(
        (result: ResponseModel[]) => {
          try{
           if(result[0].id == 1){
             this.searchfech();
           }else{
           }
          }catch{
          }
        },
        error => {
        })
    }else{
      
    }
  }

  viewmanagercount(){
    this.listpaymanager = [];
    this.ListPayService.getlistadosegundogestores(1).subscribe(
      (result: GestorSegundoModel[]) => {
        this.ListPayService.getlistadosegundogestores(2).subscribe(
          (result: GestorSegundoModel[]) => {
            this.ListPayService.getlistadosegundogestores(3).subscribe(
              (result: GestorSegundoModel[]) => {
                this.ListPayService.getlistadosegundogestores(4).subscribe(
                  (result: GestorSegundoModel[]) => {
                    this.ListPayService.getlistadosegundogestores(5).subscribe(
                      (result: GestorSegundoModel[]) => {
                        this.ListPayService.getlistadosegundogestores(6).subscribe(
                          (result: GestorSegundoModel[]) => {
                            this.ListPayService.getlistadosegundogestores(7).subscribe(
                              (result: GestorSegundoModel[]) => {
                                this.ListPayService.getlistadosegundogestores(8).subscribe(
                                  (result: GestorSegundoModel[]) => {
                                  }
                                )
                              }
                            )
                          }
                        )
                      }
                    )
                  }
                )
              }
            )
          }
        )
      }
    )
    this.ListPayService.getpagoslistadomanager(1).subscribe(
    (result: ListManagerModel[]) => {
      this.ListPayService.getpagoslistadomanager(2).subscribe(
        (result: ListManagerModel[]) => {
          this.ListPayService.getpagoslistadomanager(3).subscribe(
            (result: ListManagerModel[]) => {
              this.listpaymanager = result
              window.open("http://localhost:8050/sumaGestor","_blank");
            },
            error => {
            })
        },
        error => {
        })
    },
    error => {
    })
  }

  searchfech(){
    this.submitted = true;

    this.listpay = []

    if (!this.formularioSearch.controls.selectdate.valid) {
       
       return false;
    }

    this.ListPayService.getpagoslistado(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)),
                                                 this.busqueda).subscribe(
      (result: ListPayModel[]) => {
        try{
          this.listpay = result
          if(result.length > 1){
            this.pdfexportActive = true;
            if(this.busqueda == this.busquedaS){
              this.active = 0
            }else{
              this.active = 1
            }
          }else{
            this.pdfexportActive = false;
            this.toastr.warning(
              AppConstants.MessageModal.DATA_EMPTY,
              AppConstants.TitleModal.REGISTER_TITLE,
              {closeButton: true}
            );
            this.active = 1
          }
        }catch{
          this.listpay = []
          this.pdfexportActive = false;
          this.toastr.warning(
            AppConstants.MessageModal.DATA_EMPTY,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.active = 1
        }
      },
      error => {
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.REGISTER_TITLE,
          {closeButton: true}
        );
        this.listpay = []
        this.pdfexportActive = false;
        this.active = 1
      })
  }

  formsearch(){
    this.formularioSearch = this.formBuilder.group({
      selectdate: ['', Validators.required]
    });
  }

  validation(){
    if(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 1 || parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 0){
      this.gestorActive = true
    }else{
      if(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 2 || parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 0){
        this.gestorActive = false
      }else{
        this.gestorActive = false
      }
    }
  }

  get f() { return this.formularioSearch.controls; }

}
