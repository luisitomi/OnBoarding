import { BaseModel } from '../shared/models/base.model';

export class PersonPayModel extends BaseModel{
    document:string;
	client:string;
	code:string;
	direction:string;
	reference:string;
}
    
export class PersonByIdPayModel {
    client:string;
	type:number;
	name:string;
	last:string;
	second:string;
	customer:string;
}

export class PersonByIdPayDirectionModel {
    direction:string;
	name:string;
	number:string;
	id:number;
}

export class PersonByIdPayReferenceModel {
    reference:string;
}

export class DirectionListModel{
	id:number;
	name:string;
}

export class PersonByIdPayMangerModel {
    manager:string;
	document:string;
}

export class PersonByIdPayVoucherModel {
	voucherId:number;
	voucher:string;
	name:string;
	service:number;
}

export class PersonByIdPayDetailModel {
	service:string;
	amount:number;
	status:string;
}

export class PersonByIdPayDetailExitModel {
	service:string;
	amount:number;
	status:string;
	code:number;
}

export class ResponseModel{
	id:number;
}