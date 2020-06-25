import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ResponseModel } from '../models/personpay.model';
import { ServiceModel, MaterialModel, PendingServiceModel, TecnicoModel } from '../models/service.model';

@Injectable({
    providedIn: "root"
})

export class ServiceService {
    results: ServiceModel[];

    constructor(private httpClient: HttpClient) { }

    private BASE_URL: string = "/api/v2";

    listadoPendientes(): Observable<ServiceModel[]> {
        return this.httpClient.get<ServiceModel[]>(`${this.BASE_URL}/servicio/getListServicePending`);
    }

    listadomateriales(): Observable<MaterialModel[]> {
        return this.httpClient.get<MaterialModel[]>(`${this.BASE_URL}/servicio/getMaterialAll`);
    }

    listadomaterialesActivo(): Observable<MaterialModel[]> {
        return this.httpClient.get<MaterialModel[]>(`${this.BASE_URL}/servicio/getMaterial`);
    }

    guardarmaterial(name: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/servicio/postMaterial/`+ name);
    }

    editarmaterial(name: string,idMaterial: number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/servicio/putMaterial/`+ name + "/" + idMaterial);
    }

    guardarInstalacion(detaiId: number,nextId: number,tec: number,description: string,mateId: number,counts: number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/servicio/postServiceInstall/`+ 
        detaiId + "/" + nextId + "/" + tec + "/" + description + "/" + mateId +  "/" + counts);
    }

    listarserviciospendientes(id:number): Observable<PendingServiceModel[]> {
        return this.httpClient.get<PendingServiceModel[]>(`${this.BASE_URL}/servicio/getListServicePending/` + id);
    }

    listadotecnicos(): Observable<TecnicoModel[]> {
        return this.httpClient.get<TecnicoModel[]>(`${this.BASE_URL}/servicio/getListTecni`);
    }

    cambiartecnico(optionI: number,tecn: number,idP: number,nextId: number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/servicio/putTecnInstall/`+ 
        optionI + "/" + tecn + "/" + idP + "/" + nextId);
    }

}