import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { MonthPayModel } from '../models/monthpay.model';
import { ResponseModel } from '../models/personpay.model';

@Injectable({
    providedIn: "root"
})

export class MonthPayService {
    results: MonthPayModel[];

    constructor(private httpClient: HttpClient) { }

    private BASE_URL: string = "http://localhost:8050/api/v1";
    
    getlistadoactivo(id: string,code:string): Observable<MonthPayModel[]> {
        return this.httpClient.get<MonthPayModel[]>(`${this.BASE_URL}/cobranza/getPayServiceDetailMonth/`+ id+ "/"+code+ "/99");
    }

    getlistadoexit(id: string,code:string): Observable<MonthPayModel[]> {
        return this.httpClient.get<MonthPayModel[]>(`${this.BASE_URL}/cobranza/getPayServiceDetailExitMonth/`+ id+ "/"+code+ "/99");
    }

    postPayServiceactivo(id: string,code:string,amount:number,user:number,manager:number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/cobranza/postPayService/`+
                id + "/" + code + "/" + amount + "/" + user + "/" + manager);
    }

}