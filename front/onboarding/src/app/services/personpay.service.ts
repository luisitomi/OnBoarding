import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { PersonPayModel, PersonByIdPayModel, PersonByIdPayDirectionModel, PersonByIdPayReferenceModel, PersonByIdPayMangerModel, PersonByIdPayVoucherModel, PersonByIdPayDetailModel, ResponseModel, DirectionListModel, PersonByIdPayDetailExitModel } from '../models/personpay.model';
import { Observable } from 'rxjs';

@Injectable({
    providedIn: "root"
})

export class PersonPayService {
    results: PersonPayModel[];

    constructor(private httpClient: HttpClient) { }

    private BASE_URL: string = "/api/v2";
    
    getpersonaslistado(id: string): Observable<PersonPayModel[]> {
        return this.httpClient.get<PersonPayModel[]>(`${this.BASE_URL}/cobranza/getPersonByDocument/`+ id);
    }

    getdireccionlistado(): Observable<DirectionListModel[]> {
        return this.httpClient.get<DirectionListModel[]>(`${this.BASE_URL}/cobranza/getListDirection`);
    }

    getpersonasdata(id: string,code: string): Observable<PersonByIdPayModel[]> {
        return this.httpClient.get<PersonByIdPayModel[]>(`${this.BASE_URL}/cobranza/getPersonById/`+ id);
    }

    getpersonasdatas(id: string,code: string): Observable<PersonByIdPayModel[]> {
        return this.httpClient.get<PersonByIdPayModel[]>(`${this.BASE_URL}/cobranza/getPersonById/`+ id);
    }

    getpersonasdatadireccion(id: string,code: string): Observable<PersonByIdPayDirectionModel[]> {
        return this.httpClient.get<PersonByIdPayDirectionModel[]>(`${this.BASE_URL}/cobranza/getDirectionById/`+ id + "/" + code);
    }

    getpersonasdatareferencia(id: string,code: string): Observable<PersonByIdPayReferenceModel[]> {
        return this.httpClient.get<PersonByIdPayReferenceModel[]>(`${this.BASE_URL}/cobranza/getReferenceById/`+ id + "/" + code);
    }

    getpersonasdatagestor(id: string,code: string): Observable<PersonByIdPayMangerModel[]> {
        return this.httpClient.get<PersonByIdPayMangerModel[]>(`${this.BASE_URL}/cobranza/getManagerById/`+ id + "/" + code);
    }

    getpersonasdatavoucher(id: string,code: string): Observable<PersonByIdPayVoucherModel[]> {
        return this.httpClient.get<PersonByIdPayVoucherModel[]>(`${this.BASE_URL}/cobranza/getVoucherById/`+ id + "/" + code);
    }

    getpersonasdatadetalle(id: string,code: string): Observable<PersonByIdPayDetailModel[]> {
        return this.httpClient.get<PersonByIdPayDetailModel[]>(`${this.BASE_URL}/cobranza/getPayServiceDetail/`+ id + "/" + code + "/99");
    }

    getpersonasdatadetalleExit(id: string,code: string): Observable<PersonByIdPayDetailExitModel[]> {
        return this.httpClient.get<PersonByIdPayDetailExitModel[]>(`${this.BASE_URL}/cobranza/getPayServiceDetailExit/`+ id + "/" + code + "/99");
    }

    getpersonasdatadetalleDelete(id: string,code: string): Observable<PersonByIdPayDetailModel[]> {
        return this.httpClient.get<PersonByIdPayDetailModel[]>(`${this.BASE_URL}/cobranza/getPayServiceDetailDelete/`+ id + "/" + code + "/99");
    }

    putPersonByIddetalle(document: string,name: string,last: string,second: string,customer: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/cobranza/putPersonById/`+ document + "/" + name + "/" + last + "/" + second + "/" + customer);
    }

    putDirectionByIddetalle(document: string,code: string,number: string,zone: number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/cobranza/putDirectionById/`+ document + "/" + code + "/" + number + "/" + zone);
    }

}