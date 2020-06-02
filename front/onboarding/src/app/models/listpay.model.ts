import { BaseModel } from '../shared/models/base.model';

export class ListPayModel extends BaseModel{
    id:string;
	code:string;
	client:string;
	amountOne:string;
	amountTwo:string;
	amountThree:string;
	sumation:string;
}

export class ListManagerModel{
	manager:string;
	amount:string;
}