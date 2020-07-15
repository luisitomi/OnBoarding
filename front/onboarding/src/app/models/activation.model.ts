import { BaseModel } from '../shared/models/base.model';

export class ActivacionModel{
	id:number;
	client:string;
	direction:string;
	tec:string;
	serie:string;
}

export class OnuModel{
	id:number;
	name:string;
}