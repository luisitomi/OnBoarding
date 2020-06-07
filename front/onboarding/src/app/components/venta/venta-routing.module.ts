import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RegistroComponent } from './registro/venta.registro.component';
import { ListadoVentaComponent } from './listado/venta.listado.component';

const routes: Routes = [
  {
    path: '',
    data: {
      title: 'Venta'
    },
    children: [
      {
        path: '',
        redirectTo: 'registro'
      },
      {
        path: 'registro',
        component: RegistroComponent,
        data: {
          title: 'Registro de Clientes'
        }
      },
      {
        path: 'listado',
        component: ListadoVentaComponent,
        data: {
          title: 'Listado'
        }
      },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class VentaRoutingModule {}
