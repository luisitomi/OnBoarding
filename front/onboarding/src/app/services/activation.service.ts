import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ActivacionModel, OnuModel } from '../models/activation.model';
import { environment } from '../../environments/environment';

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

    listadoactivacion(): Observable<ActivacionModel[]> {
        return this.httpClient.get<ActivacionModel[]>(`${this.BASE_URL}/activacion/getListActivation`);
    }

}