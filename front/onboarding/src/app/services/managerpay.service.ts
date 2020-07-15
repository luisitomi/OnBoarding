import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ManagerPayModel } from '../models/managerpay.model';
import { ResponseModel } from '../models/personpay.model';
import { environment } from '../../environments/environment';

@Injectable({
    providedIn: "root"
})

export class ManagerPayService {
    results: ManagerPayModel[];

    constructor(private httpClient: HttpClient) { }

    httpOptions = {
        headers: new HttpHeaders({
            
        })
      }
      
    private BASE_URL: string = environment.serverLocal;
    
    getgestoreslistado(): Observable<ManagerPayModel[]> {
        return this.httpClient.get<ManagerPayModel[]>(`${this.BASE_URL}/cobranza/getListManger`);
    }
    
    patchManagerByIddetalle(document: string,code: string,code_manager: number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/cobranza/patchManagerById/`+ document + "/" + code + "/" + code_manager);
    }

    putReferenceByIdIddetalle(document: string,code: string,description: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/cobranza/putReferenceById/`+ document + "/" + code + "/" + description);
    }

}