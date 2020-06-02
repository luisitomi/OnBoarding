import { Injectable } from '@angular/core';
import { ToastrService, ToastrConfig } from 'ngx-toastr';
import { Subject, Observable } from 'rxjs';



@Injectable()
export class AlertService {


  constructor(private toastaService: ToastrService) { }

  private dialogs = new Subject<AlertDialog>();

  public showMessage(title, message, severity, timeout = 7000) {
    var toastOptions = {
      closeButton: true,
      timeOut: timeout
    };
    if (severity == MessageSeverity.info)
      this.toastaService.info(message,title,toastOptions);
    else if (severity == MessageSeverity.success)
      this.toastaService.success(message,title,toastOptions);
    else if (severity == MessageSeverity.error)
      this.toastaService.error(message,title,toastOptions);
    else if (severity == MessageSeverity.warn)
      this.toastaService.warning(message,title,toastOptions);
  }

  showDialog(message: string)
  showDialog(message: string, type: DialogType, okCallback: (val?: any) => any)
  showDialog(message: string, type: DialogType, okCallback?: (val?: any) => any, cancelCallback?: () => any, okLabel?: string, cancelLabel?: string, defaultValue?: string)
  showDialog(message: string, type?: DialogType, okCallback?: (val?: any) => any, cancelCallback?: () => any, okLabel?: string, cancelLabel?: string, defaultValue?: string) {

    if (!type)
      type = DialogType.alert;

    this.dialogs.next({ message: message, type: type, okCallback: okCallback, cancelCallback: cancelCallback, okLabel: okLabel, cancelLabel: cancelLabel, defaultValue: defaultValue });
  }

  getDialogEvent(): Observable<AlertDialog> {
    return this.dialogs.asObservable();
  }

}


export enum MessageSeverity {
  info,
  success,
  error,
  warn,
}


//******************** Dialog ********************//
export class AlertDialog {
  constructor(public message: string, public type: DialogType, public okCallback: (val?: any) => any, public cancelCallback: () => any,
    public defaultValue: string, public okLabel: string, public cancelLabel: string) {

  }
}

export enum DialogType {
  alert,
  confirm,
  prompt
}
//******************** End ********************//


