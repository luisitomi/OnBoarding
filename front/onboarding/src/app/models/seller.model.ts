import { BaseModel } from '../shared/models/base.model';

export class SellerModel extends BaseModel{
    id:number;
	name:string;
}

export class SellerListModel{
    detail:number;
    next:number;
    document:string;
    code:string;
    client:string;
    agreed:string;
    description:string;
    service:string;
    install:string;
    status:string;
    seller:string;
    active:number;
}