import { BaseModel } from './base.model';
import { AppConstants } from '../constants/app.constants';

export class PageDatatableModel extends BaseModel {
  //The number of elements in the page
  size: number = AppConstants.Paginado.DEFAULT_PAGE_SIZE_PAGINATION;
  //The total number of elements
  totalElements: number = 0;
  //The total number of pages
  totalPages: number = 0;
  //The current page number
  pageNumber: number = 1;
  // The current page number loaded
  currentPageClient: number = 0;
  // Total pending requests
  totalPending: number = 0;
}
