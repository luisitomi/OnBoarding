import { Component, OnInit } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { DatePipe } from '@angular/common';
import { ListPayService } from '../../../services/listpay.service';
import { ListPayModel, ListManagerModel } from '../../../models/listpay.model';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { AppConstants } from '../../../shared/constants/app.constants';
import { ResponseModel } from '../../../models/personpay.model';

@Component({
  templateUrl: 'cobranza.listado.component.html',
  providers: [DatePipe]
})

export class ListadoComponent implements OnInit{

  public formularioSearch: FormGroup;
  
  busqueda:string;
  busquedaS:string;
  busquedapago:string

  listpay: ListPayModel[];
  listpaymanager: ListManagerModel[];

  submitted: boolean;

  myDate = new Date();

  itemsPerPageS: number = 3;
  currentPageS: number = 1;

  pdfexportActive:boolean = false;

  constructor(
    private ListPayService: ListPayService,
    private router: Router,
    private formBuilder: FormBuilder,
    private datePipe: DatePipe,
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
             alert("eliminado")
             this.searchfech();
           }else{
            alert("no eliminado")
           }
          }catch{
            alert("ups")
          }
        },
        error => {
          alert("servicio")
        })
    }else{
      
    }
  }

  viewmanagercount(){
    this.listpaymanager = [];
    this.ListPayService.getpagoslistadomanager(1).subscribe(
    (result: ListManagerModel[]) => {
      this.ListPayService.getpagoslistadomanager(2).subscribe(
        (result: ListManagerModel[]) => {
          this.listpaymanager = result
          window.open("http://localhost:8050/sumaGestor","_blank");
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
          }else{
            this.pdfexportActive = false;
          }
        }catch{
          this.listpay = []
          this.pdfexportActive = false;
        }
      },
      error => {
        this.listpay = []
        this.pdfexportActive = false;
      })
  }

  formsearch(){
    this.formularioSearch = this.formBuilder.group({
      selectdate: ['', Validators.required]
    });
  }

  get f() { return this.formularioSearch.controls; }

}
