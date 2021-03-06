import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ListPayModel, ListManagerModel, GestorModel, GestorSegundoModel } from '../models/listpay.model';
import { ResponseModel } from '../models/personpay.model';
import { environment } from '../../environments/environment';

@Injectable({
    providedIn: "root"
})

export class ListPayService {
    results: ListPayModel[];

    constructor(private httpClient: HttpClient) { }

    httpOptions = {
        headers: new HttpHeaders({
            
        })
      }
      
    private BASE_URL: string = environment.serverLocal;
    
    getpagoslistado(id: number,fecha: string): Observable<ListPayModel[]> {
        return this.httpClient.get<ListPayModel[]>(`${this.BASE_URL}/cobranza/getListPay/`+ id + "/" + fecha);
    }

    getpagoslistadomanager(id: number): Observable<ListManagerModel[]> {
        return this.httpClient.get<ListManagerModel[]>(`${this.BASE_URL}/cobranza/getManagaerCount/`+ id);
    }

    getlistadogestores(id:number): Observable<GestorModel[]> {
        return this.httpClient.get<GestorModel[]>(`${this.BASE_URL}/cobranza/getListManagerReport/`+ id);
    }

    deletePayServiceData(id:string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/cobranza/deletePayService/`+ id);
    }

    getlistadosegundogestores(id:number): Observable<GestorSegundoModel[]> {
        return this.httpClient.get<GestorSegundoModel[]>(`${this.BASE_URL}/cobranza/getListlienteByManager/`+ id);
    }

}