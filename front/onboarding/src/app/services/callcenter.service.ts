import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { CallCenterModel, ReclaimListModel } from '../models/callcenter.model'
import { ResponseModel } from '../models/personpay.model';
import { environment } from '../../environments/environment';

@Injectable({
    providedIn: "root"
})

export class CallCenterService {
    results: CallCenterModel[];

    constructor(private httpClient: HttpClient) { }

    httpOptions = {
        headers: new HttpHeaders({
            
        })
      }

    private BASE_URL: string = environment.serverLocal;
    
    listadoServiciobyid(id:string,code:string): Observable<CallCenterModel[]> {
        return this.httpClient.get<CallCenterModel[]>(`${this.BASE_URL}/atencion/getListServiceActive/`+ id + "/" + code);
    }

    listadoServiciobyidNot(id:string,code:string): Observable<CallCenterModel[]> {
        return this.httpClient.get<CallCenterModel[]>(`${this.BASE_URL}/atencion/getListServiceNotActive/`+ id + "/" + code);
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