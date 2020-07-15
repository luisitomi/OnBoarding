import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { MonthPayModel } from '../models/monthpay.model';
import { ResponseModel } from '../models/personpay.model';
import { environment } from '../../environments/environment';

@Injectable({
    providedIn: "root"
})

export class MonthPayService {
    results: MonthPayModel[];

    constructor(private httpClient: HttpClient) { }

    httpOptions = {
        headers: new HttpHeaders({
            
        })
      }
      
    private BASE_URL: string = environment.serverLocal;
    
    getlistadoactivo(id: string,code:string): Observable<MonthPayModel[]> {
        return this.httpClient.get<MonthPayModel[]>(`${this.BASE_URL}/cobranza/getPayServiceDetailMonth/`+ id+ "/"+code+ "/99");
    }

    getlistadoexit(id: string,code:string): Observable<MonthPayModel[]> {
        return this.httpClient.get<MonthPayModel[]>(`${this.BASE_URL}/cobranza/getPayServiceDetailExitMonth/`+ id+ "/"+code+ "/99");
    }

    getlistadodelete(id: string,code:string): Observable<MonthPayModel[]> {
        return this.httpClient.get<MonthPayModel[]>(`${this.BASE_URL}/cobranza/getPayServiceDetailDeleteMonth/`+ id+ "/"+code);
    }

    postPayServiceactivo(id: string,code:string,amount:number,user:number,manager:number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/cobranza/postPayService/`+
                id + "/" + code + "/" + amount + "/" + user + "/" + manager);
    }

    postPayServiceExits(id: string,code:string,amount:number,user:number,manager:number,type:number,service:number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/cobranza/postPayServiceExit/`+
                id + "/" + code + "/" + amount + "/" + user + "/" + manager + "/" + type + "/" + service);
    }

    postPayServiceDelete(id: string,code:string,amount:number,manager:number,service:number,type:number,user:number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/cobranza/postPayServiceDetailDelete/`+
                id + "/" + code + "/" + amount + "/" + manager + "/" + service + "/" + type + "/" + user);
    }

    deleteDetailCountExit(id: string,code:string,status:number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/cobranza/deleteDetailCount/`+
                id + "/" + code + "/" + status);
    }

}