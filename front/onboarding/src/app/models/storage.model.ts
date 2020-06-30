import { BaseModel } from '../shared/models/base.model';

export class AlmacenModel extends BaseModel{
	id:number;/**/
	name:string;
	item:number;
	autorizhe:string;
	impor:string;/**/
	igv:string;
	sumation:string;

	product:string;
	code:string;
	description:string;
	codeProduct:string;
	meditation:string;
	count:number;
	price:string;
	desc:string;
}

export class ProductoModel{
	id:number;
	name:string;
	code:string;
	description:string;
	codeProduct:string;
	meditation:string;
}

export class ProveedorModel{
	id:number;
	name:string;
}

export class ProductoProveedorModel{
	id:string;
	name:string;
	price:string;
	proU:number;
	proV:number
}