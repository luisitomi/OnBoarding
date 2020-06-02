import { Component, OnInit } from '@angular/core';
import { getStyle, hexToRgba } from '@coreui/coreui/dist/js/coreui-utilities';
import { CustomTooltips } from '@coreui/coreui-plugin-chartjs-custom-tooltips';
import { AppConstants } from '../../shared/constants/app.constants';

@Component({
  templateUrl: 'dashboard.component.html'
})
export class DashboardComponent implements OnInit {
  ngOnInit(){
    sessionStorage.setItem(AppConstants.Session.USERNAME, "1");
  }
}
