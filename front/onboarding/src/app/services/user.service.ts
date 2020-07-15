import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { UserModel, UserDataModel, UserNameModel, UserNotiModel, ModuleModel, UserListModel } from '../models/user.model';
import { ResponseModel } from '../models/personpay.model';
import { environment } from '../../environments/environment';

@Injectable({
    providedIn: "root"
})

export class UserService {
    results: UserModel[];

    constructor(private httpClient: HttpClient) { }

    
    httpOptions = {
        headers: new HttpHeaders({
           
        })
      }

      private BASE_URL: string = environment.serverLocal;

    notificacionlistado(user: string): Observable<UserNotiModel[]> {
        return this.httpClient.get<UserNotiModel[]>(`${this.BASE_URL}/usuario/getNotification/`+ user,this.httpOptions);
    }
    
    submodulolistado(user: string): Observable<UserModel[]> {
        return this.httpClient.get<UserModel[]>(`${this.BASE_URL}/usuario/getListSubModule/`+ user,this.httpOptions);
    }

    modulolistado(user: string): Observable<UserModel[]> {
        return this.httpClient.get<UserModel[]>(`${this.BASE_URL}/usuario/getListModule/`+ user,this.httpOptions);
    }

    usuariodata(user: string,pass:string): Observable<UserDataModel[]> {
        return this.httpClient.get<UserDataModel[]>(`${this.BASE_URL}/usuario/getUserData/`+ user + "/" + pass,this.httpOptions);
    }

    usuariodataname(user: string): Observable<UserNameModel[]> {
        return this.httpClient.get<UserNameModel[]>(`${this.BASE_URL}/usuario/getNameUser/`+ user,this.httpOptions);
    }

    patchpassword(user: string,pass: string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/usuario/patchUpdatePassword/`+ user + "/" + pass,this.httpOptions);
    }

    listadoModuleuser(): Observable<ModuleModel[]> {
        return this.httpClient.get<ModuleModel[]>(`${this.BASE_URL}/notificacion/getModule`,this.httpOptions);
    }

    listadouser(id:number): Observable<UserListModel[]> {
        return this.httpClient.get<UserListModel[]>(`${this.BASE_URL}/notificacion/getListUser/` + id,this.httpOptions);
    }

    putChangeAsignationSave(id:number,user:number): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/notificacion/putChangeAsignation/`+ id + "/" + user,this.httpOptions);
    }

    postNotificationSave(id:number,user:number,document:string,client:string,asunt:string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/notificacion/postNotification/`+
        id + "/" + user + "/" + document + "/" + client + "/" + asunt,this.httpOptions);
    }

    guardarMensaje(idTarea:number,solution:string): Observable<ResponseModel[]> {
        return this.httpClient.get<ResponseModel[]>(`${this.BASE_URL}/notificacion/putRptaNotification/`+
        idTarea + "/" + solution,this.httpOptions);
    }

}