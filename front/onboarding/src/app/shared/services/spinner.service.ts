    import { Injectable } from '@angular/core';
import { NgxSpinnerService } from "ngx-spinner";
import { Subject, Observable } from 'rxjs';
import { AppConstants } from '../constants/app.constants';

@Injectable()
export class SpinnerService {
    constructor(private spinnerService: NgxSpinnerService) { }
    
    showSpinner(spinnerType:SpinnerType = null){
        this.spinnerService.show()
    }

    hideSpinner(){
        this.spinnerService.hide();
    }

    showSpinnerCharge(){
        this.spinnerService.show(AppConstants.Design.spinnerNameChargeData);
    }

    hideSpinnerCharge(){
        this.spinnerService.hide(AppConstants.Design.spinnerNameChargeData);
    }
}

export enum SpinnerType {
}