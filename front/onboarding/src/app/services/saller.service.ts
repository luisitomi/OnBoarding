import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { SellerModel, SellerListModel } from '../models/seller.model';

@Injectable({
    providedIn: "root"
})

export class SellerService {
    results: SellerModel[];

    constructor(private httpClient: HttpClient) { }

    private BASE_URL: string = "http://localhost:8050/api/v1";
    
    listadovendedores(): Observable<SellerModel[]> {
        return this.httpClient.get<SellerModel[]>(`${this.BASE_URL}/venta/getListSeller`);
    }

    listadodistrito(): Observable<SellerModel[]> {
        return this.httpClient.get<SellerModel[]>(`${this.BASE_URL}/venta/getListDistict`);
    }

    listadocalle(id:number): Observable<SellerModel[]> {
        return this.httpClient.get<SellerModel[]>(`${this.BASE_URL}/venta/getListStreet/` + id);
    }

    listadoservicios(id:number,datei:string,datef:string): Observable<SellerListModel[]> {
        return this.httpClient.get<SellerListModel[]>(`${this.BASE_URL}/venta/getServicePreInstall/` + id + "/" + datei + "/" + datef);
    }

}