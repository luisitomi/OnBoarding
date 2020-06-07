import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { UserService } from '../../services/user.service';
import { UserDataModel } from '../../models/user.model';
import { AppConstants } from '../../shared/constants/app.constants';
import { Router } from '@angular/router';

@Component({
  selector: 'app-dashboard',
  templateUrl: 'login.component.html'
})
export class LoginComponent implements OnInit {
  
  userText:string="";
  passwordText:string="";

  codigo:string="";

  submitted: boolean;

  formulariologin: FormGroup;

  ngOnInit(){
    this.formsearch();
    this.validacion(-1);
  }

  constructor(
    private formBuilder: FormBuilder,
    private UserService: UserService,
    private router: Router,
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

  enviodata(){
    this.submitted = true;
    
    let registerlogin = this.formulariologin.value;

    if (!this.formulariologin.controls.uuu.valid ||
      !this.formulariologin.controls.ppp.valid) {
      return false;
    }
    
    this.UserService.usuariodata(registerlogin.uuu,registerlogin.ppp).subscribe(
    (result: UserDataModel[]) => {
      
      try{
       if(result[0].id > 0){
        sessionStorage.setItem(AppConstants.Session.USERID,result[0].code.toString())
        sessionStorage.setItem(AppConstants.Session.USERNAME,this.userText)
        this.router.navigate(['/dashboard']);
       }else{
        this.passwordText = "";
        this.codigo = "";
        this.userText = "";
       }
      }catch{
      }
    },
    error => {
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
