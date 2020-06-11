import { BaseModel } from '../shared/models/base.model';

export class CallCenterModel extends BaseModel{
    id:number;
	name:string;
}

export class ReclaimListModel{
    id:number;
    service:string;
    code:string;
    client:string;
    direction:string;
    descripcion:string;
    register:string;
    status:number;
}