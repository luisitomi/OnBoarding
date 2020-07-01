import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ActivacionModel, OnuModel } from '../models/activation.model';

@Injectable({
    providedIn: "root"
})

export class ActivationService {
    results: ActivacionModel[];

    constructor(private httpClient: HttpClient) { }

    private BASE_URL: string = "/api/v2";
    
    listadoServiciobyid(): Observable<OnuModel[]> {
        return this.httpClient.get<OnuModel[]>(`${this.BASE_URL}/activacion/getListOnu`);
    }

}