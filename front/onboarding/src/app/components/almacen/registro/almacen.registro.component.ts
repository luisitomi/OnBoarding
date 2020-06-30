import { Component, ViewChild, OnInit } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { StorageService } from '../../../services/storage.service';
import { ProductoModel, ProveedorModel, ProductoProveedorModel, AlmacenModel } from '../../../models/storage.model';
import { ToastrService } from 'ngx-toastr';
import { AppConstants } from '../../../shared/constants/app.constants';
import { ModalDirective} from 'ngx-bootstrap/modal';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { ResponseModel } from '../../../models/personpay.model';

@Component({
  templateUrl: 'almacen.registro.component.html'
})

export class AlmacenComponent implements OnInit{

  itemsPerPageS: number = 3;
  currentPageS: number = 1;
  itemsPerPage: number = 3;
  currentPage: number = 1;
  itemsPerPageL: number = 3;
  currentPageL: number = 1;
  itemsPerPageRe: number = 8;
  currentPageRe: number = 1;

  product:ProductoModel[];
  provider:ProveedorModel[];
  productProvider:ProductoProveedorModel[];
  listpp:ProductoProveedorModel[];
  remisiones:AlmacenModel[];
  Idremisiones:AlmacenModel[];

  idProducto:number;  
  nombreProducto:string;
  codigoProducto:string;
  descripcionProducto:string;
  codigoProductoValue:string;
  mediaProducto:string;
  idProveedor:number;
  nombreProveedor:string;
  ppproducto:number;
  ppproveedor:number;

  submittedProductoSave:boolean;
  submittedProductoEdit:boolean;
  submitteddProviderSave:boolean;
  submittedProviderEdit:boolean;
  submitted:boolean;
  submittedRemision:boolean;

  addNotiActive:boolean;
  addNotiActiveView:boolean;

  public formularioSaveProducto: FormGroup;
  public formularioeditProducto: FormGroup;
  public formularioSaveProvider: FormGroup;
  public formularioEditProvider: FormGroup;
  public formulario: FormGroup;
  public formularioRevision : FormGroup;
  
  @ViewChild('saveProduct') public saveProduct: ModalDirective;
  @ViewChild('editProduct') public editProduct: ModalDirective;
  @ViewChild('saveProvider') public saveProvider: ModalDirective;
  @ViewChild('editProvider') public editProvider: ModalDirective;
  @ViewChild('ListModal') public ListModal: ModalDirective;

  constructor(
    private router: Router,
    private StorageService:StorageService,
    private formBuilder: FormBuilder,
    private toastr: ToastrService,
  ) {
    this.router.events.subscribe(evt => {
      if (evt instanceof NavigationEnd) {
        this.router.navigated = false;
        window.scrollTo(0, 0);
        this.onReturndata(0);
      }
    })
  }

  ngOnInit() {
    this.onReturndata(0);
    this.initForms();
  }

  initForms() {
    this.formularioSaveProducto = this.formBuilder.group({
      nombre: ['', Validators.required],
      codigo: ['', Validators.required],
      descripcion: ['', Validators.required],
      codigoproducto: ['', Validators.required],
      medida: ['', Validators.required],
    });
    this.formularioeditProducto = this.formBuilder.group({
      id: [''],
      nombre: ['', Validators.required],
      codigo: ['', Validators.required],
      descripcion: ['', Validators.required],
      codigoproducto: ['', Validators.required],
      medida: ['', Validators.required],
    });
    this.formularioSaveProvider = this.formBuilder.group({
      nombre: ['', Validators.required]
    });
    this.formularioEditProvider = this.formBuilder.group({
      id: [''],
      nombre: ['', Validators.required]
    });
    this.formulario = this.formBuilder.group({
      productoId: ['', Validators.required],
      proveedorId: ['', Validators.required],
      precioId: ['', Validators.required]
    });
  }

  form(){
    this.formulario = this.formBuilder.group({
      productoId: ['', Validators.required],
      proveedorId: ['', Validators.required],
      precioId: ['', Validators.required]
    });
  }

  onReturndata(id:number){
    switch(id){
      case 0:
        this.listarProductos();
        this.listarProveedor();
        this.validacionUser();
        this.validacionUserView();
        this.listarProveedorProducto();
        this.form();
        this.listarremision();
        break;
      case 1:
        this.openModalProductSave();
        break;
      case 2:
        this.openModalProviderSave();
        break;
    }
  }

  validacionUser(){
    if(sessionStorage.getItem(AppConstants.Session.USERID) == '0'
      || sessionStorage.getItem(AppConstants.Session.USERID) == '10'){
        this.addNotiActive = true;
    }else{
      this.addNotiActive = false;
    }
  }

  validacionUserView(){
    if(sessionStorage.getItem(AppConstants.Session.USERID) == '10'){
        this.addNotiActiveView = true;
    }else{
      this.addNotiActiveView = false;
    }
  }

  saveProducto(){
    this.submittedProductoSave = true;
    let register = this.formularioSaveProducto.value;
    
    if (!this.formularioSaveProducto.controls.nombre.valid ||
      !this.formularioSaveProducto.controls.codigo.valid ||
      !this.formularioSaveProducto.controls.descripcion.valid ||
      !this.formularioSaveProducto.controls.medida.valid ||
      !this.formularioSaveProducto.controls.codigoproducto.valid) {
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }
  
    this.StorageService.guardarProducto(register.nombre.toUpperCase(),
                                        register.codigo.toUpperCase(),
                                        register.descripcion.toUpperCase(),
                                        register.codigoproducto.toUpperCase(),
                                        register.medida.toUpperCase()).subscribe(
    (result: ResponseModel[]) => {
      try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_UPDATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.submittedProductoSave = false;
          this.saveProduct.hide();
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.submittedProductoSave = false;
          this.saveProduct.hide();
        }
      }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
        this.submittedProductoSave = false;
        this.saveProduct.hide();
      }
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.onReturndata(0);
      this.submittedProductoSave = false;
      this.saveProduct.hide();
    })

  }

  editProducto(){
    this.submittedProductoEdit = true;
    let register = this.formularioeditProducto.value;
    
    if (!this.formularioeditProducto.controls.nombre.valid ||
      !this.formularioeditProducto.controls.codigo.valid ||
      !this.formularioeditProducto.controls.descripcion.valid ||
      !this.formularioeditProducto.controls.medida.valid ||
      !this.formularioeditProducto.controls.codigoproducto.valid) {
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }
  
    this.StorageService.editarProducto(this.idProducto,
                                        register.nombre.toUpperCase(),
                                        register.codigo.toUpperCase(),
                                        register.descripcion.toUpperCase(),
                                        register.codigoproducto.toUpperCase(),
                                        register.medida.toUpperCase()).subscribe(
    (result: ResponseModel[]) => {
      try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_UPDATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.submittedProductoEdit = false;
          this.editProduct.hide();
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.submittedProductoEdit = false;
          this.editProduct.hide();
        }
      }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
        this.submittedProductoEdit = false;
        this.editProduct.hide();
      }
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.onReturndata(0);
      this.submittedProductoEdit = false;
      this.editProduct.hide();
    })

  }

  saveProvide(){
    this.submitteddProviderSave = true;
    let register = this.formularioSaveProvider.value;
    
    if (!this.formularioSaveProvider.controls.nombre.valid) {
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }
  
    this.StorageService.guardarProveedor(register.nombre.toUpperCase()).subscribe(
    (result: ResponseModel[]) => {
      try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_UPDATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.submitteddProviderSave = false;
          this.saveProvider.hide();
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.submitteddProviderSave = false;
          this.saveProvider.hide();
        }
      }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
        this.submitteddProviderSave = false;
        this.saveProvider.hide();
      }
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.onReturndata(0);
      this.submitteddProviderSave = false;
      this.saveProvider.hide();
    })

  }

  editarProoveedor(){
    this.submittedProviderEdit = true;
    let register = this.formularioEditProvider.value;
    
    if (!this.formularioEditProvider.controls.nombre.valid) {
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }
  
    this.StorageService.editarProoveedor(this.idProveedor,
                                        register.nombre.toUpperCase()).subscribe(
    (result: ResponseModel[]) => {
      try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_UPDATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.submittedProviderEdit = false;
          this.editProvider.hide();
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.submittedProviderEdit = false;
          this.editProvider.hide();
        }
      }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
        this.submittedProviderEdit = false;
        this.editProvider.hide();
      }
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.onReturndata(0);
      this.submittedProviderEdit = false;
      this.editProvider.hide();
    })

  }

  savec(){
    this.submitted = true;
    let register = this.formulario.value;
    
    if (!this.formulario.controls.productoId.valid ||
      !this.formulario.controls.proveedorId.valid ||
      !this.formulario.controls.precioId.valid) {
      this.toastr.warning(
        AppConstants.MessageModal.REQUIRED_CUSTOM_FIELD,
        AppConstants.TitleModal.WARNING_TITLE,
        {closeButton: true}
      );
      return false;
    }
  
    this.StorageService.edita(register.productoId,
                              register.proveedorId,
                              register.precioId).subscribe(
    (result: ResponseModel[]) => {
      try{
        if(result[0].id == 1){
          this.toastr.success(
            AppConstants.MessageModal.REGISTER_UPDATED,
            AppConstants.TitleModal.REGISTER_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.submitted = false;
        }else{
          this.toastr.warning(
            AppConstants.MessageModal.REGISTER_NO_CREATED,
            AppConstants.TitleModal.WARNING_TITLE,
            {closeButton: true}
          );
          this.onReturndata(0);
          this.submitted = false;
        }
      }catch{
        this.toastr.error(
          AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
          AppConstants.TitleModal.ERROR_TITLE,
          {closeButton: true}
        );
        this.onReturndata(0);
        this.submitted = false;
      }
    },
    error => {
      this.toastr.error(
        AppConstants.MessageModal.INTERNAL_ERROR_MESSAGE,
        AppConstants.TitleModal.ERROR_TITLE,
        {closeButton: true}
      );
      this.onReturndata(0);
      this.submitted = false;
    })
  }

  returnProducto(id:number){
    this.idProducto = id;
    this.editProduct.show();
    this.byidProducto(id);
  }

  returnProveedor(id:number){
    this.idProveedor = id;
    this.editProvider.show();
    this.byidProveedor(id);
  }

  returnRemisiones(id:number){
    this.listarremisionByid(id);
    this.ListModal.show();
  }

  get f() { return this.formularioSaveProducto.controls; }
  get g() { return this.formularioeditProducto.controls; }
  get h() { return this.formularioSaveProvider.controls; }
  get i() { return this.formularioEditProvider.controls; }

  get k() { return this.formulario.controls; }

  byidProducto(idP:number){
    this.StorageService.listarproducto().subscribe(
      (result: ProductoModel[]) => {
        const searchData = [];
        for (const l of this.product) {
          if (l.id.toString().indexOf(idP.toString()) > -1) {
            searchData.push(l)
          }
        }
        if (searchData.length == 1) {
          this.nombreProducto = searchData[0].name;
          this.codigoProducto = searchData[0].code;
          this.descripcionProducto = searchData[0].description;
          this.codigoProductoValue = searchData[0].codeProduct;
          this.mediaProducto = searchData[0].meditation;
        }
      }
    )
  }

  byidProveedor(idP:number){
    this.StorageService.listarproveedor().subscribe(
      (result: ProveedorModel[]) => {
        const searchData = [];
        for (const l of this.provider) {
          if (l.id.toString().indexOf(idP.toString()) > -1) {
            searchData.push(l)
          }
        }
        if (searchData.length == 1) {
          this.nombreProveedor = searchData[0].name;
        }
      }
    )
  }

  listarProductos(){
    this.product = [];
    this.StorageService.listarproducto().subscribe(
      (result:ProductoModel[])=>{
        this.product = result
      }
    )
  }

  listarProveedor(){
    this.provider = [];
    this.StorageService.listarproveedor().subscribe(
      (result:ProveedorModel[])=>{
        this.provider = result
      }
    )
  }

  listarProveedorProducto(){
    this.productProvider = [];
    this.StorageService.listarproveedorproducto(0,0).subscribe(
      (result:ProductoProveedorModel[])=>{
        this.productProvider = result
      }
    )
  }

  listarremision(){
    this.remisiones = [];
    this.StorageService.listarremisiones().subscribe(
      (result:AlmacenModel[])=>{
        this.remisiones = result
      }
    )
  }

  listarremisionByid(id:number){
    this.Idremisiones = [];
    this.StorageService.listarremisionesById(id).subscribe(
      (result:AlmacenModel[])=>{
        this.Idremisiones = result
      }
    )
  }

  openModalProductSave(){
    this.saveProduct.show();
  }

  openModalProviderSave(){
    this.saveProvider.show();
  }

}