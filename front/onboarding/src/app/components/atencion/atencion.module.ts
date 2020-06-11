import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { ChartsModule } from 'ng2-charts';

import { CommonModule } from '@angular/common';
import { NgxPaginationModule } from 'ngx-pagination';
import { Ng2SearchPipeModule } from 'ng2-search-filter';
import { AlertModule } from 'ngx-bootstrap/alert';
import { ModalModule } from 'ngx-bootstrap/modal';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { TabsModule } from 'ngx-bootstrap/tabs';
import { RegistroAtenciónComponent } from './registro/atencion.registro.component';
import { AtencionRoutingModule } from './atencion-routing.module';
import { ListadoAtencionComponent } from './listado/atencion.listado.component';

@NgModule({
  imports: [
    AtencionRoutingModule,
    ChartsModule,
    CommonModule,
    NgxPaginationModule,
    Ng2SearchPipeModule,
    FormsModule,
    ReactiveFormsModule,
    AlertModule.forRoot(),
    ModalModule.forRoot(),
    TabsModule,
  ],schemas: [ CUSTOM_ELEMENTS_SCHEMA ],
  exports: [],
  declarations: [
    RegistroAtenciónComponent,
    ListadoAtencionComponent
  ],
})
export class AtencionModule {
  
 }
