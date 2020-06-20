import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { UserService } from '../../services/user.service';
import { UserDataModel, UserNameModel } from '../../models/user.model';
import { AppConstants } from '../../shared/constants/app.constants';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-dashboard',
  templateUrl: 'login.component.html'
})
export class LoginComponent implements OnInit {
  
  userText:string="";
  passwordText:string="";
  userName=[];

  codigo:string="";

  submitted: boolean;

  formulariologin: FormGroup;

  ngOnInit(){
    sessionStorage.clear();
    this.formsearch();
    this.validacion(-1);
  }

  constructor(
    private formBuilder: FormBuilder,
    private UserService: UserService,
    private router: Router,
    private toastr: ToastrService
  ) {
  }

  validacion(id:number){
    if(id== -1){
      this.codigo = "";
      this.passwordText = "";
    }else{
      if(this.codigo.length < 6){
        this.codigo = this.codigo + "" + id;
        this.passwordText = this.codigo
      }
    }
  }

  process(){
    try{
      this.UserService.usuariodataname(this.userText).subscribe(
        (result: UserNameModel[]) => {
          this.userName = result;
      })
    }catch{
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.REGISTER_TITLE,
        {closeButton: true}
      );
    }
  }
  
  enviodata(){
    this.submitted = true;

    let registerlogin = this.formulariologin.value;
    
    if (!this.formulariologin.controls.uuu.valid ||
      !this.formulariologin.controls.ppp.valid) {
        this.toastr.warning(
          AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
          AppConstants.TitleModal.WARNING_TITLE,
          {closeButton: true}
        );
      return false;
    }
    
    this.UserService.usuariodata(registerlogin.uuu,registerlogin.ppp).subscribe(
    (result: UserDataModel[]) => {
      
      try{
       if(result[0].id > 0){
         
        this.process();
        sessionStorage.setItem(AppConstants.Session.USERID,result[0].code.toString())
        sessionStorage.setItem(AppConstants.Session.USERNAME,this.userText)
        sessionStorage.setItem(AppConstants.Session.USERLASTNAME,this.userName[0].name)
        this.router.navigate(['/dashboard']);
       }else{
        this.toastr.warning(
          AppConstants.MessageModal.USERNAME_PASSWORD_ERROR_MESSAGE,
          AppConstants.TitleModal.REGISTER_TITLE,
          {closeButton: true}
        );
        this.validacion(-1);
       }
      }catch{
        this.enviodata();
      }
    
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.REGISTER_TITLE,
        {closeButton: true}
      );
    })

  }

  get f() { return this.formulariologin.controls; }

  formsearch(){
    this.formulariologin = this.formBuilder.group({
      uuu: [' ', Validators.required],
      ppp: [' ', Validators.required]
    });
  }

}
