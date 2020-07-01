import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ListadoActivacionComponent } from './listado/activacion.listado.component';

const routes: Routes = [
  {
    path: '',
    data: {
      title: 'Activación'
    },
    children: [
      {
        path: '',
        redirectTo: 'listado'
      },
      {
        path: 'listado',
        component: ListadoActivacionComponent,
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
export class ActivacionRoutingModule {}
