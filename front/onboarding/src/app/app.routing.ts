import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

// Import Containers
import { DefaultLayoutComponent } from './shared';
import { LoginComponent } from './components/login/login.component';
import { P404Component } from './components/error/404.component';
import { P500Component } from './components/error/500.component';
import { AuthGuard } from './guards/auth.guard';

export const routes: Routes = [
  {
    path: '',
    redirectTo: 'dashboard',
    pathMatch: 'full',
    canActivate: [AuthGuard]
  },
  {
    path: '404',
    component: P404Component,
    data: {
      title: 'Page 404'
    }
  },
  {
    path: '500',
    component: P500Component,
    data: {
      title: 'Page 500'
    }
  },
  {
    path: 'login',
    component: LoginComponent,
    data: {
      title: 'Inicio de Sesión'
    }
  },
  {
    path: '',
    component: DefaultLayoutComponent,
    data: {
      title: 'Inicio'
    },
    children: [
      {
        path: 'cobranza',
        loadChildren: () => import('./components/cobranza/cobranza.module').then(m => m.CobranzaModule)
      },
      {
        path: 'venta',
        loadChildren: () => import('./components/venta/venta.module').then(m => m.VentaModule)
      },
      {
        path: 'atencion',
        loadChildren: () => import('./components/atencion/atencion.module').then(m => m.AtencionModule)
      },
      {
        path: 'dashboard',
        loadChildren: () => import('./components/dashboard/dashboard.module').then(m => m.DashboardModule)
      },
      {
        path: 'actividad',
        loadChildren: () => import('./components/actividad/actividad.module').then(m => m.ActividadModule)
      },
      {
        path: 'servicio',
        loadChildren: () => import('./components/servicio/servicio.module').then(m => m.ServicioModule)
      }
    ]
  },
  { path: '**', component: P404Component , data: { title: "Página No Encontrada" }}
];

@NgModule({
  imports: [ RouterModule.forRoot(routes)],
  exports: [ RouterModule ]
})

export class AppRoutingModule {
}