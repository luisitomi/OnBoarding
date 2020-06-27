import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { SellerModel, SellerListModel, SellerServiceModel, ClientPdfModel } from '../models/seller.model';
import { ResponseModel } from '../models/personpay.model';
import { HttpService } from '../shared/services/http.service';

@Injectable({
    providedIn: "root"
})

export class SellerService {
    results: SellerModel[];

    constructor(private httpService: HttpService) { }

    httpOptions = {
        headers: new HttpHeaders({
            'Content-Type': 'application/json',
            'x-auth-token': '1FxmRyxhogwjXwPmLQzdj83HeNz91tdsBFfMdaJm'
        })
      }

    private BASE_URL: string = "/api/v2";
    private BASE_URL_SEND: string = "/api/v1";
    private BASE_URL_DNI: string = "https://dniruc.apisperu.com/api/v1/dni";
    private BASE_URL_RUC: string = "https://api.migoperu.pe/api/v1/ruc";
    
    listadovendedores(): Observable<SellerModel[]> {
        return this.httpService.get<SellerModel[]>(`${this.BASE_URL}/venta/getListSeller`);
    }

    listadodistrito(): Observable<SellerModel[]> {
        return this.httpService.get<SellerModel[]>(`${this.BASE_URL}/venta/getListDistict`);
    }

    listadocalle(id:number): Observable<SellerModel[]> {
        return this.httpService.get<SellerModel[]>(`${this.BASE_URL}/venta/getListStreet/` + id);
    }

    listadoservicios(id:number,datei:string,datef:string): Observable<SellerListModel[]> {
        return this.httpService.get<SellerListModel[]>(`${this.BASE_URL}/venta/getServicePreInstall/` + id + "/" + datei + "/" + datef);
    }

    recuperardatosPdf(detailId:number,nextId:number): Observable<ClientPdfModel[]> {
        return this.httpService.get<ClientPdfModel[]>(`${this.BASE_URL}/venta/getDetailContract/` + detailId + "/" + nextId);
    }

    putChangeDirectionByIdList(document: string,code: string,number: string,zone :number,reference: string): Observable<ResponseModel[]> {
        return this.httpService.get<ResponseModel[]>(`${this.BASE_URL}/venta/putChangeDirectionById/`+
        document + "/" + code + "/" + number + "/" + zone + "/" + reference);
    }

    listadoservicioscombo(): Observable<SellerServiceModel[]> {
        return this.httpService.get<SellerServiceModel[]>(`${this.BASE_URL}/venta/getListService`);
    }

    deletePreInstallSaleSave(detail: number,next: number,description: string): Observable<ResponseModel[]> {
        return this.httpService.get<ResponseModel[]>(`${this.BASE_URL}/venta/deletePreInstallSale/`+
        detail + "/" + next + "/" + description);
    }
    
    postSaveServiceSaleSave(document: string,
                            code: string,
                            name: string,
                            last: string,
                            second: string,
                            client: string,
                            fech: string,
                            email: string,
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
        return this.httpService.get<ResponseModel[]>(`${this.BASE_URL}/venta/postSaveServiceSale/`+
        document + "/" + code + "/" + name + "/" +
        last + "/" + second + "/" + client + "/" + fech + "/" +
        email + "/" + zone + "/" + number + "/" +
        descriptionrefe + "/" + seller + "/" + fechadate + "/" +
        timedate + "/" + servicecount + "/" + amountfirst + "/" +
        amountsecond + "/" + textins);
    }

    createSendEmail(model: any) {
        return this.httpService.post(`${this.BASE_URL_SEND}/send_emails`,model,this.httpOptions);
    }

    recuperardni(){
        return this.httpService.get(`${this.BASE_URL_DNI}/75134791?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFyaWVzXzI1MDM5N0Bob3RtYWlsLmNvbSJ9.QssyDvbk3hh7cp6LesjULBwEzUbWj3EQKoa0iZzJj4w`);
    }

    recuperarruc(model: any){
        return this.httpService.post(`${this.BASE_URL_RUC}?token=09728f7e-5e7e-451d-a5a0-1ee1e878c65e-7236e233-79ac-4f1a-a253-0d6f08f93a40`,model);
    }

}