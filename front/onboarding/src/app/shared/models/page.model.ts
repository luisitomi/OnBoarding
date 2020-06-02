import { BaseModel } from './base.model';

export class PageModel extends BaseModel {
  pagina: number;
  records: number;
  total: number;
}
