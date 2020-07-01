import { BaseModel } from '../shared/models/base.model';

export class ServiceModel extends BaseModel{
    detalleId:number;
	nextId:number;
	name:string;
	client:string;
	sale:string;
	document:string;
	code:string;
	dateP:string;
	asunt:string;
}

export class MaterialModel{
	id:number;
	name:string;
	active:number;
}

export class PendingServiceModel{
	detalleId:number;
	nextId:number;
	name:string;/*NOMBRES DEL CLIENTE*/
	client:string;/*SERVICIO INSTALADO*/
	sale:string;
	document:string;
	code:string;
	dateP:string;
	asunt:string;
	district:string;
	user:string;
	serie:string;
}

export class TecnicoModel{
	id:number;
	name:string;
}

export class ReclaimPendingModel{
	reclamoD:number;
	client:string;
	street:string;
	fecha:string;
	descripcion:string;
	tecn:string;
}

export class CountOnuMdel{
	id:number;
}