import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { AlmacenModel, ProductoModel, ProveedorModel, ProductoProveedorModel } from '../models/storage.model';
import { ResponseModel } from '../models/personpay.model';
import { environment } from '../../environments/environment';

@Injectable({
    providedIn: "root"
})

export class StorageService {
    results: AlmacenModel[];

    constructor(private httpClient: HttpClient) { }

    httpOptions = {
        headers: new HttpHeaders({
            
        })
      }

    private BASE_URL: string = environment.serverLocal;

    listarproducto(): Observable<ProductoModel[]> {
        return this.httpClient.get<ProductoModel[]>(`${this.BASE_URL}/almacen/getProdct`);
    }

    guardarProducto(name: string,code:string,description:string,codeP:number,medi:string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/almacen/postSaveProduc/`+
        name + "/" + code + "/" + description + "/" + codeP + "/" + medi);
    }

    editarProducto(producId:number,name: string,code:string,description:string,codeP:number,medi:string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/almacen/putSaveProduct/`+
        producId + "/" +name + "/" + code + "/" + description + "/" + codeP + "/" + medi);
    }

    listarproveedor(): Observable<ProveedorModel[]> {
        return this.httpClient.get<ProveedorModel[]>(`${this.BASE_URL}/almacen/getProvider`);
    }

    guardarProveedor(name: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/almacen/postSaveProvide/`+ name);
    }

    editarProoveedor(provideId:number,name: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/almacen/putSaveProvide/`+name + "/" +provideId);
    }

    listarproveedorproducto(optio:number,productoE:number): Observable<ProductoProveedorModel[]> {
        return this.httpClient.get<ProductoProveedorModel[]>(`${this.BASE_URL}/almacen/getProductProvider`
        + "/" + optio + "/" + productoE);
    }

    edita(productId:number,provideId: number,price: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/almacen/postProductP/`
        +productId + "/" +provideId+ "/" +price);
    }

    guardar(){

    }

    listarremisiones(): Observable<AlmacenModel[]> {
        return this.httpClient.get<AlmacenModel[]>(`${this.BASE_URL}/almacen/getListRemision`);
    }

    listarremisionesById(id:number): Observable<AlmacenModel[]> {
        return this.httpClient.get<AlmacenModel[]>(`${this.BASE_URL}/almacen/getListRemisionById/` + id);
    }

}