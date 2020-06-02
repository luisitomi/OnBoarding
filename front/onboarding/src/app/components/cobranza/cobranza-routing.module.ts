import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { CobranzaComponent } from './pago/cobranza.pago.component';
import { ListadoComponent } from './listado/cobranza.listado.component';

const routes: Routes = [
  {
    path: '',
    data: {
      title: 'Cobranza'
    },
    children: [
      {
        path: '',
        redirectTo: 'pago'
      },
      {
        path: 'pago',
        component: CobranzaComponent,
        data: {
          title: 'Pago'
        }
      },
      {
        path: 'listado',
        component: ListadoComponent,
        data: {
          title: 'Listado de Pagos'
        }
      },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CobranzaRoutingModule {}
