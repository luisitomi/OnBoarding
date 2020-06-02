import { Injectable } from '@angular/core';
import { AbstractControl, FormGroup, ValidatorFn, FormControl } from '@angular/forms';

@Injectable()
export class FormService {
  public markFormGroupTouched(formGroup: FormGroup) {
    (<any>Object).values(formGroup.controls).forEach(control => {
      control.markAsTouched();
      if (control.controls) {
        control.controls.forEach(c => this.markFormGroupTouched(c));
      }
    });
  }

  public resetForm(formGroup: FormGroup) {
    let control: AbstractControl = null;
    formGroup.reset();
    formGroup.markAsUntouched();
    Object.keys(formGroup.controls).forEach((name) => {
      control = formGroup.controls[name];
      control.setErrors(null);
    });
  }

  public validateForm(formToValidate: AbstractControl, formErrors: any, messages: any, checkDirty?: boolean) {
    const form = formToValidate;
    for (const field in formErrors) {
      var messagesT = messages[field];
      if (field) {
        const control = form.get(field);
        if (control.hasOwnProperty('controls')) {
          var formErrorsT = formErrors[field];
          control['controls'].forEach(item => {
            this.validateForm(item, formErrorsT, messagesT);
          });
        }
        else {
          if (control && !control.valid) {
            if (!checkDirty || (control.dirty || control.touched)) {
              for (const key in control.errors) {
                if (key && key !== 'invalid_characters') {
                  formErrors[field] = '';
                  formErrors[field] = formErrors[field] || messagesT[key];
                } else {
                  formErrors[field] = formErrors[field] || messagesT[key](control.errors[key]);
                }
              }
            }
          }
          else {
            formErrors[field] = '';
          }
        }
      }
    }
    return formErrors;
  }

  public noWhiteSpaceValidator(control: FormControl) {
    const isWhitespace = (control.value || '').toString().trim().length === 0;
    const isValid = !isWhitespace;
    return isValid ? null : { 'required': true };
  }

  public mailValidator(control: FormControl) {
    const emailRegexp = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;
    if (!emailRegexp.test(control.value)) {
      return { "email": true };
    }
    return null;
  }

  public passwordValidator(control: FormControl) {
    const passwordRegexp = /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@!%*?&.#/()[\]])[A-Za-z\d$@$!%*?&].{8,}/;
    if (!passwordRegexp.test(control.value)) {
      return { "pattern": true };
    }
    return null;
  }
}
