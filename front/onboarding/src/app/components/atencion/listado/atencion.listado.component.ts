import { Component, OnInit, ViewChild } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { DatePipe } from '@angular/common';
import { CallCenterService } from '../../../services/callcenter.service';
import { ReclaimListModel } from '../../../models/callcenter.model';
import { AppConstants } from '../../../shared/constants/app.constants';
import { ToastrService } from 'ngx-toastr';

@Component({
  templateUrl: 'atencion.listado.component.html',
  providers: [DatePipe]
})

export class ListadoAtencionComponent implements OnInit{
  
  itemsPerPageS: number = 3;
  currentPageS: number = 1;

  myDate = new Date();

  inicio:string;
  final:string;

  reclamoview:ReclaimListModel[];

  constructor(
    private router: Router,
    private datePipe: DatePipe,
    private CallCenterService: CallCenterService,
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
    this.listadoreclamoData();
  }

  listadoreclamoData(){
    this.reclamoview = [];
    this.CallCenterService.listReclaimByIdSave(this.inicio,this.final).subscribe(
    (result: ReclaimListModel[]) => {
      try{
        if(result.length > 0){
          this.reclamoview = result
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
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
    })
  }

}
