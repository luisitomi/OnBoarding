import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { CallCenterModel, ReclaimListModel } from '../models/callcenter.model'
import { ResponseModel } from '../models/personpay.model';

@Injectable({
    providedIn: "root"
})

export class CallCenterService {
    results: CallCenterModel[];

    constructor(private httpClient: HttpClient) { }

    private BASE_URL: string = "/api/v2";
    
    listadoServiciobyid(id:string,code:string): Observable<CallCenterModel[]> {
        return this.httpClient.get<CallCenterModel[]>(`${this.BASE_URL}/atencion/getListServiceActive/`+ id + "/" + code);
    }

    listadoreclamo(): Observable<CallCenterModel[]> {
        return this.httpClient.get<CallCenterModel[]>(`${this.BASE_URL}/atencion/getListReclaim`);
    }

    listReclaimByIdSave(datei: string,datef: string): Observable<ReclaimListModel[]> {
        return this.httpClient.get<ReclaimListModel[]>(`${this.BASE_URL}/atencion/getReclaimStatus/`+ datei + "/" + datef );
    }

    postReclaimByIdSave(document: string,code: string,service: number,reclaim: number,description: number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/atencion/postReclaimById/`+ document + "/" + code + "/" + service + "/" + reclaim + "/" + description);
    }

}