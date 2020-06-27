import { Component, OnInit } from '@angular/core';

import { SellerService } from '../../services/saller.service';
import { Router, NavigationEnd } from '@angular/router';

@Component({
  templateUrl: 'dashboard.component.html'
})
export class DashboardComponent implements OnInit {
  
  constructor(
    private SellerService: SellerService,
    private router: Router,
  ) {
    this.router.events.subscribe(evt => {
      if (evt instanceof NavigationEnd) {
        this.router.navigated = false;
        window.scrollTo(0, 0);
      }
    })
  }

  ngOnInit(){
    this.dni();
    this.ruc();
  }

  dni(){
    this.SellerService.recuperardni().subscribe(
      (result: any) => {
        console.log(result);
      }
    )
  }

  ruc(){
    let reg = {
      ruc:"10751347915"
    };
    this.SellerService.recuperarruc(reg).subscribe(
      (result: any) => {
        console.log(result);
      }
    )

  }

}
