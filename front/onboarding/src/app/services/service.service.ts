import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ResponseModel } from '../models/personpay.model';
import { ServiceModel, MaterialModel, PendingServiceModel, TecnicoModel,ReclaimPendingModel, CountOnuMdel, ServiceViewModel } from '../models/service.model';
import { OnuModel } from '../models/activation.model';
import { environment } from '../../environments/environment';

@Injectable({
    providedIn: "root"
})

export class ServiceService {
    results: ServiceModel[];

    constructor(private httpClient: HttpClient) { }

    httpOptions = {
        headers: new HttpHeaders({
            
        })
      }

    private BASE_URL: string = environment.serverLocal;

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

    guardarInstalacion2(detaiId: number,nextId: number,tec: number,description: string,mateId: number,counts: number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/servicio/postServiceInstall/`+ 
        detaiId + "/" + nextId + "/" + tec + "/" + description + "/" + mateId +  "/" + counts);
    }

    guardarReclamo(detaiId: number,tec: number,description: string,mateId: number,counts: number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/servicio/postServiceReclaim/`+ 
        detaiId + "/" + tec + "/" + description + "/" + mateId +  "/" + counts);
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

    listarsreclamospendientes(id:number): Observable<ReclaimPendingModel[]> {
        return this.httpClient.get<ReclaimPendingModel[]>(`${this.BASE_URL}/servicio/getListReclaimService/` + id);
    }

    listaronusactivos(): Observable<OnuModel[]> {
        return this.httpClient.get<OnuModel[]>(`${this.BASE_URL}/activacion/getListOnu`);
    }

    guardarOnu(idOnu: number,optio: number,idPk: number,nextId: number,description: string,statusOnu:number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/activacion/putStatusOnu/`+ 
        idOnu + "/" + optio + "/" + idPk + "/" + nextId +  "/" + description+  "/" + "/" + statusOnu);
    }

    listarId(det:number,next:number): Observable<CountOnuMdel[]> {
        return this.httpClient.get<CountOnuMdel[]>(`${this.BASE_URL}/activacion/getListCountOnu/`
        + det + "/" + next);
    }

    listarServiceRange(datei:string,datef:string): Observable<ServiceViewModel[]> {
        return this.httpClient.get<ServiceViewModel[]>(`${this.BASE_URL}/servicio/getListServiceRange/`
        + datei + "/" + datef);
    }

}