import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { UserModel, UserDataModel, UserNameModel, UserNotiModel, ModuleModel, UserListModel } from '../models/user.model';
import { ResponseModel } from '../models/personpay.model';

@Injectable({
    providedIn: "root"
})

export class UserService {
    results: UserModel[];

    constructor(private httpClient: HttpClient) { }

    private BASE_URL: string = "/api/v2";

    notificacionlistado(user: string): Observable<UserNotiModel[]> {
        return this.httpClient.get<UserNotiModel[]>(`${this.BASE_URL}/usuario/getNotification/`+ user);
    }
    
    submodulolistado(user: string): Observable<UserModel[]> {
        return this.httpClient.get<UserModel[]>(`${this.BASE_URL}/usuario/getListSubModule/`+ user);
    }

    modulolistado(user: string): Observable<UserModel[]> {
        return this.httpClient.get<UserModel[]>(`${this.BASE_URL}/usuario/getListModule/`+ user);
    }

    usuariodata(user: string,pass:string): Observable<UserDataModel[]> {
        return this.httpClient.get<UserDataModel[]>(`${this.BASE_URL}/usuario/getUserData/`+ user + "/" + pass);
    }

    usuariodataname(user: string): Observable<UserNameModel[]> {
        return this.httpClient.get<UserNameModel[]>(`${this.BASE_URL}/usuario/getNameUser/`+ user);
    }

    patchpassword(user: string,pass: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/usuario/patchUpdatePassword/`+ user + "/" + pass);
    }

    listadoModuleuser(): Observable<ModuleModel[]> {
        return this.httpClient.get<ModuleModel[]>(`${this.BASE_URL}/notificacion/getModule`);
    }

    listadouser(id:number): Observable<UserListModel[]> {
        return this.httpClient.get<UserListModel[]>(`${this.BASE_URL}/notificacion/getListUser/` + id);
    }

    putChangeAsignationSave(id:number,user:number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/notificacion/putChangeAsignation/`+ id + "/" + user);
    }

    postNotificationSave(id:number,user:number,document:string,client:string,asunt:string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/notificacion/postNotification/`+
        id + "/" + user + "/" + document + "/" + client + "/" + asunt);
    }

}