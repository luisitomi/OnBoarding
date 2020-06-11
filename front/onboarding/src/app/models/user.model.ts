import { BaseModel } from '../shared/models/base.model';

export class UserModel extends BaseModel{
    id:number;
	ruta:string;
	icon:string;
	description:string;
	decription:string;
}

export class UserDataModel{
	id:number;
	code:number;
}

export class UserNameModel{
	name:string;
}