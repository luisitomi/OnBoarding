import {Component, OnInit, ViewChild} from '@angular/core';
import { navItems } from '../../_nav';
import { AppConstants } from '../constants/app.constants';
import { Router } from '@angular/router';
import { UserService } from '../../services/user.service';
import { UserModel } from '../../models/user.model';
import {NgbModal, ModalDismissReasons} from '@ng-bootstrap/ng-bootstrap';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { ResponseModel } from '../../models/personpay.model';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-dashboard',
  templateUrl: './default-layout.component.html'
})

export class DefaultLayoutComponent implements OnInit{

  public formularioPassword: FormGroup;

  public sidebarMinimized = false;
  public navItems = navItems;

  itemsAdd = [];
  childrenAdd = [];

  closeResult: string;

  userImage:string;
  
  count:UserModel[];
  counts:UserModel[];

  submitted: boolean;

  ngOnInit(): void {
    this.validation();
  }

  savepass(){
    this.submitted = true;
    let changepass = this.formularioPassword.value;

    if (!this.formularioPassword.controls.passnew.valid) {
       
       return false;
    }
    this.UserService.patchpassword(sessionStorage.getItem(AppConstants.Session.USERNAME),
                                   changepass.passnew).subscribe(
    (result: ResponseModel[]) => {
      try{
        if(result[0].id == 1){
          this.modalService.dismissAll()
          this.submitted = false;
        }else{
          this.modalService.dismissAll()
          this.submitted = false;
        }
      }catch{
        this.submitted = false;
        this.modalService.dismissAll()
      }
    },
    error => {
      this.modalService.dismissAll()
      this.submitted = false;
    })
  }

  open(content) {
    this.formsave();
    this.modalService.open(content, {ariaLabelledBy: 'modal-basic-title'}).result.then((result) => {
      this.closeResult = `Closed with: ${result}`;
    }, (reason) => {
      this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
    });
  }
  
  private getDismissReason(reason: any): string {
    if (reason === ModalDismissReasons.ESC) {
      return 'by pressing ESC';
    } else if (reason === ModalDismissReasons.BACKDROP_CLICK) {
      return 'by clicking on a backdrop';
    } else {
      return  `with: ${reason}`;
    }
  }

  formsave(){
    this.formularioPassword = this.formBuilder.group({
      passnew: ['', Validators.required]
    });
  }

  get f() { return this.formularioPassword.controls; }

  constructor(
    private router: Router,
    private UserService: UserService,
    private modalService: NgbModal,
    private formBuilder: FormBuilder,
    private toastr: ToastrService
  ) {
  }

  toggleMinimize(e) {
    this.sidebarMinimized = e;
  }

  logout(){
    sessionStorage.clear();
    this.router.navigate(['/login']);
  }

  validation(){
    if (!sessionStorage.getItem(AppConstants.Session.USERID) ||
      sessionStorage.getItem(AppConstants.Session.USERID) == "-1"){
      this.router.navigate(['/login']);
    }else{
      
      this.toastr.success(
        sessionStorage.getItem(AppConstants.Session.USERLASTNAME),
        AppConstants.MessageModal.WELCOME_MESSAGE,
        {closeButton: true}
      );

      this.router.navigate(['dashboard']);
      try{
        this.userImage = './assets/img/imgusu/' + parseInt(sessionStorage.getItem(AppConstants.Session.USERID)) + '.JPG'
      }catch{
        this.userImage = './assets/img/imgusu/1.JPG'
      }
      this.opciones();
    }
  }

  j:number =0;

  opciones(){
    this.UserService.modulolistado(sessionStorage.getItem(AppConstants.Session.USERNAME)).subscribe(
      (result:UserModel[])=>{
        this.count = result;
        for(let i = 0;this.count.length > i;i++){
          this.UserService.submodulolistado(sessionStorage.getItem(AppConstants.Session.USERNAME)).subscribe(
            (results:UserModel[])=>{
              this.counts = results;
              this.childrenAdd = [];
              this.itemsAdd = [];
              let searchData = [];
              searchData =this.counts.filter(s => s.id.toString().toLowerCase().startsWith(this.count[i].id.toString().toLowerCase()));
              for(this.j;searchData.length > this.j;this.j++){
                this.childrenAdd = this.childrenAdd.concat([{name:searchData[this.j].decription,url:searchData[this.j].ruta,icon:searchData[this.j].icon}])
              }
              this.j = 0;
              this.itemsAdd = [{children: this.childrenAdd, icon: this.count[i].icon,name: this.count[i].description,url:this.count[i].ruta}]
              this.navItems = this.navItems.concat(this.itemsAdd);
            }
          )
        }
      }
    )
  }

}
