import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent } from '@angular/common/http';
import { Observable, from } from 'rxjs';
import { environment } from 'src/environments/environment';
import { AppConstants } from '../shared/constants/app.constants';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {

  constructor() { }

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    let token = sessionStorage.getItem(AppConstants.Session.ACCESS_TOKEN);
    return from(this.handleAccess(request, next));
  }

  private async handleAccess(request: HttpRequest<any>, next: HttpHandler): Promise<HttpEvent<any>> {
    let token = sessionStorage.getItem(AppConstants.Session.ACCESS_TOKEN);
    if (token != "" && token != null && token != "undefined") {
      let tokenValue = 'Bearer ' + token;
      request = request.clone({
        setHeaders: {
          'Authorization': tokenValue,
          'Content-Type': 'application/json; charset=utf-8',
          //'Accept': 'application/json'
        }
      });
    }
    return next.handle(request).toPromise();
  }
}
