import { Component, OnInit } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { DatePipe } from '@angular/common';
import { SellerListModel, SellerModel } from '../../../models/seller.model';
import { SellerService } from '../../../services/saller.service';
import { AppConstants } from '../../../shared/constants/app.constants';

@Component({
  templateUrl: 'venta.listado.component.html',
  providers: [DatePipe]
})

export class ListadoVentaComponent implements OnInit{

  itemsPerPageS: number = 3;
  currentPageS: number = 1;

  detalleId:number = 0;
  inicio:string;
  final:string;

  myDate = new Date();

  dateService:SellerListModel[];
  vendedoresview:SellerModel[];

  pdfExportActive:boolean = false;

  constructor(
    private router: Router,
    private datePipe: DatePipe,
    private SellerService: SellerService,
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
  }

  listadoservicioData(){
    this.dateService = [];
    this.SellerService.listadoservicios(this.detalleId,this.inicio,this.final).subscribe(
    (result: SellerListModel[]) => {
      this.dateService = result
      if(result.length > 0){
        this.pdfExportActive = true
      }else{
        this.pdfExportActive = false
      }
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

  generarPdf(){
    if(parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 4 || parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) == 0){
      window.open("http://localhost:8050/vendedorListado","_blank");
    }
  }

}
