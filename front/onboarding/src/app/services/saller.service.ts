import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { SellerModel, SellerListModel, SellerServiceModel } from '../models/seller.model';
import { ResponseModel } from '../models/personpay.model';

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

    putChangeDirectionByIdList(document: string,code: string,number: string,zone :number,reference: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/venta/putChangeDirectionById/`+
        document + "/" + code + "/" + number + "/" + zone + "/" + reference);
    }

    listadoservicioscombo(): Observable<SellerServiceModel[]> {
        return this.httpClient.get<SellerServiceModel[]>(`${this.BASE_URL}/venta/getListService`);
    }

    deletePreInstallSaleSave(detail: number,next: number,description: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/venta/deletePreInstallSale/`+
        detail + "/" + next + "/" + description);
    }
    
    postSaveServiceSaleSave(document: string,
                            code: string,
                            name: string,
                            last: string,
                            second: string,
                            client: string,
                            fech: string,
                            zone: number,
                            number: string,
                            descriptionrefe: string,
                            seller: number,
                            fechadate: string,
                            timedate: string,
                            servicecount: number,
                            amountfirst: string,
                            amountsecond: string,
                            textins: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/venta/postSaveServiceSale/`+
        document + "/" + code + "/" + name + "/" +
        last + "/" + second + "/" + client + "/" +
        fech + "/" + zone + "/" + number + "/" +
        descriptionrefe + "/" + seller + "/" + fechadate + "/" +
        timedate + "/" + servicecount + "/" + amountfirst + "/" +
        amountsecond + "/" + textins);
    }

}