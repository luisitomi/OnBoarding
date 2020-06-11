import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RegistroAtenciónComponent } from './registro/atencion.registro.component';
import { ListadoAtencionComponent } from './listado/atencion.listado.component';

const routes: Routes = [
  {
    path: '',
    data: {
      title: 'Atención al Cliente'
    },
    children: [
      {
        path: '',
        redirectTo: 'registro'
      },
      {
        path: 'registro',
        component: RegistroAtenciónComponent,
        data: {
          title: 'Clientes'
        }
      },
      {
        path: 'listado',
        component: ListadoAtencionComponent,
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
export class AtencionRoutingModule {}
