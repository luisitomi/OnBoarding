import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ListadoActividadComponent } from './listado/actividad.listado.component';

const routes: Routes = [
  {
    path: '',
    data: {
      title: 'Actividades'
    },
    children: [
      {
        path: '',
        redirectTo: 'listado'
      },
      {
        path: 'listado',
        component: ListadoActividadComponent,
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
export class ActividadRoutingModule {}
