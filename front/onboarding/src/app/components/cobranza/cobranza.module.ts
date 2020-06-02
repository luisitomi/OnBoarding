import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { ChartsModule } from 'ng2-charts';

import { CobranzaComponent } from './pago/cobranza.pago.component';
import { CobranzaRoutingModule } from './cobranza-routing.module';
import { CommonModule } from '@angular/common';
import { NgxPaginationModule } from 'ngx-pagination';
import { Ng2SearchPipeModule } from 'ng2-search-filter';
import { AlertModule } from 'ngx-bootstrap/alert';
import { AlertsComponent } from './pago/alerts.component';
import { BadgesComponent } from './pago/badges.component';
import { ModalsComponent } from './pago/modals.component';
import { ModalModule } from 'ngx-bootstrap/modal';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ListadoComponent } from './listado/cobranza.listado.component';
import { TabsModule } from 'ngx-bootstrap/tabs';

@NgModule({
  imports: [
    CobranzaRoutingModule,
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
    CobranzaComponent,
    ListadoComponent,
    AlertsComponent,
    BadgesComponent,
    ModalsComponent,
  ],
})
export class CobranzaModule {
  
 }
