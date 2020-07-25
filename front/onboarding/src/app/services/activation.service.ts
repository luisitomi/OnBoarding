import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ActivacionModel, OnuModel, OnuViewModel, ActivationViewModel } from '../models/activation.model';
import { environment } from '../../environments/environment';
import { ResponseModel } from '../models/personpay.model';

@Injectable({
    providedIn: "root"
})

export class ActivationService {
    results: ActivacionModel[];

    constructor(private httpClient: HttpClient) { }

    httpOptions = {
        headers: new HttpHeaders({
            
        })
      }

    private BASE_URL: string = environment.serverLocal;
    
    listadoServiciobyid(): Observable<OnuModel[]> {
        return this.httpClient.get<OnuModel[]>(`${this.BASE_URL}/activacion/getListOnu`);
    }

    listadoServiciorange(datei:string,datef:string): Observable<ActivationViewModel[]> {
        return this.httpClient.get<ActivationViewModel[]>(`${this.BASE_URL}/activacion/getListActivaationRange/`+ datei + "/" + datef);
    }

    listadoactivacion(): Observable<ActivacionModel[]> {
        return this.httpClient.get<ActivacionModel[]>(`${this.BASE_URL}/activacion/getListActivation`);
    }

    postActivation(activationId: number,dateinfo: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/activacion/patchActivationService/`+ activationId + "/" + dateinfo);
    }

    mpostCreateOnu(nameSerie: string,namemac: string,nameId: string,namePass: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/activacion/postCreateOnu/`
        + nameSerie + "/" + namemac + "/" + nameId + "/" + namePass);
    }

    mputUpdateOnu(idOnu: number,nameSerie: string,namemac: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/activacion/putUpdateOnu/`
        + idOnu + "/" + nameSerie + "/" + namemac);
    }

    mpatchPasswordOnu(idOnu: number,nameId: string,namePass: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/activacion/patchPasswordOnu/`
        + idOnu + "/" + nameId + "/" + namePass);
    }

    mpatchActivationOnu(idOnu: number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/activacion/patchActivationOnu/`
        + idOnu );
    }

    mgetListOnuState(): Observable<OnuViewModel[]> {
        return this.httpClient.get<OnuViewModel[]>(`${this.BASE_URL}/activacion/getListOnuState`);
    }

}