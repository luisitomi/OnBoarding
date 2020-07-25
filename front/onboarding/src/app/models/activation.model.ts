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

export class OnuViewModel{
	id:number;
	serie:string;
	mac:string;
	ssid:string;
	pass:string;
	activo:number;
}

export class ActivationViewModel{
	document:string;
	code:string;
	client:string;
	direction:string;
	fech:string;
}