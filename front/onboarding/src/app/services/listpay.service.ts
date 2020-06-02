import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ListPayModel, ListManagerModel } from '../models/listpay.model';
import { ResponseModel } from '../models/personpay.model';

@Injectable({
    providedIn: "root"
})

export class ListPayService {
    results: ListPayModel[];

    constructor(private httpClient: HttpClient) { }

    private BASE_URL: string = "http://localhost:8050/api/v1";

    private BASE_URL_PDF: string = "http://localhost:8050";
    
    getpagoslistado(id: number,fecha: string): Observable<ListPayModel[]> {
        return this.httpClient.get<ListPayModel[]>(`${this.BASE_URL}/cobranza/getListPay/`+ id + "/" + fecha);
    }

    getpagoslistadomanager(id: number): Observable<ListManagerModel[]> {
        return this.httpClient.get<ListManagerModel[]>(`${this.BASE_URL}/cobranza/getManagaerCount/`+ id);
    }

    getpagoslistadoPDFOne(): Observable<ListPayModel[]> {
        return this.httpClient.get<ListPayModel[]>(`${this.BASE_URL_PDF}/planillaCajaUno`);
    }

    getpagoslistadoPDFTwo(): Observable<ListPayModel[]> {
        return this.httpClient.get<ListPayModel[]>(`${this.BASE_URL_PDF}/planillaCajaDos`);
    }

    getpagoslistadoPDFThree(): Observable<ListPayModel[]> {
        return this.httpClient.get<ListPayModel[]>(`${this.BASE_URL_PDF}/planillaCajaTres`);
    }

    deletePayServiceData(id:string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/cobranza/deletePayService/`+ id);
    }

}