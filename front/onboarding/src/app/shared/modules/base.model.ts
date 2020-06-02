export abstract class BaseModel {

  constructor() {
  }

  public setAll(_params: any) {
    for (const param in _params) {
      if (_params.hasOwnProperty(param)) {
        this[param] = _params[param];
      }
    }
  }
}
