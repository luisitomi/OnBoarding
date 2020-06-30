import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AlmacenComponent } from './registro/almacen.registro.component';

const routes: Routes = [
  {
    path: '',
    data: {
      title: 'Almacén'
    },
    children: [
      {
        path: '',
        redirectTo: 'registro'
      },
      {
        path: 'registro',
        component: AlmacenComponent,
        data: {
          title: 'Remisión'
        }
      },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AlmacenRoutingModule {}
