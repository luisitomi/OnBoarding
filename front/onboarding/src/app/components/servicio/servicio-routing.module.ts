import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ServicioComponent } from './listado/servicio.listado.component';

const routes: Routes = [
  {
    path: '',
    data: {
      title: 'Sevicios'
    },
    children: [
      {
        path: '',
        redirectTo: 'listado'
      },
      {
        path: 'listado',
        component: ServicioComponent,
        data: {
          title: 'Listado de Servicios'
        }
      },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ServicioRoutingModule {}
