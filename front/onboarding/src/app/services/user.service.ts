import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { UserModel, UserDataModel, UserNameModel } from '../models/user.model';
import { ResponseModel } from '../models/personpay.model';

@Injectable({
    providedIn: "root"
})

export class UserService {
    results: UserModel[];

    constructor(private httpClient: HttpClient) { }

    private BASE_URL: string = "http://localhost:8050/api/v1";
    
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

}