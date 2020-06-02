import { INavData } from '@coreui/angular';

export const navItems: INavData[] = [
  {
    name: 'MENÚ',
    url: '/dashboard',
    icon: 'icon-speedometer',
  },
  {
    title: true,
    name: 'Módulos'
  },
  {
    name: 'Cobranza',
    url: '/cobranza/pago',
    icon: 'icon-credit-card',
    children: [
      {
        name: 'Pago',
        url: '/cobranza/pago',
        icon: 'icon-basket-loaded'
      },
      {
        name: 'Listado',
        url: '/cobranza/listado',
        icon: 'icon-list'
      },
    ]
  }
];
