export const AppConstants = {
  Paginado: {
    DEFAULT_PAGE_INDEX_PAGINATION: 0,
    DEFAULT_PAGE_SIZE_PAGINATION: 10
  },
  
  TitleModal: {
    LOGIN_TITLE: "Inicio Sesión.",
    REGISTER_TITLE: "Registro.",
    UPDATE_TITLE: "Actualizar",
    ERROR_TITLE: "Error",
    WARNING_TITLE:"Advertencia"
  },

  MessageModal: {
    SOMETHING_WRONG: "Un error interno ha ocurrido.",
    WELCOME_MESSAGE: "Bienvenido!",
    USER_VALIDATE_ERROR: "Número de teléfono requiere 9 dígitos.",
    PASSWORD_VALIDATE_ERROR: "Contraseña requiere 6 dígitos.",

    LOGIN_ERROR_CREDENTIALS: "Tu contraseña es incorrecta.",
    LOGIN_ERROR_ENROLL: "El número de teléfono no se encuentra registrado.",
    LOGIN_ERROR_USER_BLOCK: "Te encuentras bloqueado para acceder a Súper Agente, comunícate con la Banca Telefónica.",
    LOGIN_ERROR_USER_BLOCK_ADMIN: "Te encuentras bloqueado por el Administrador para acceder a Súper Agente, comunícate con la Banca Telefónica.",

    ENTER_USERNAME_PASSWORD_MESSAGE: "Ingresar usuario y contraseña.",
    USERNAME_PASSWORD_ERROR_MESSAGE: "Usuario y/o contraseña incorrecto.",
    USER_REGISTERED: "Usuario registrado satisfactoriamente.",
    REGISTER_UPDATED: "Se actualizó correctamente.",
    REGISTER_CREATED: "Se registró correctamente",
    REQUIRED_FIELDS_MESSAGE: "Faltan campos por completar.",
    REQUIRED_ACCEPT_TERMS_CONDITIONS: "Por favor debe aceptar los términos y condiciones.",
    REQUIRED_LIST: "No ha agregado ningún(a) ",
    REQUIRED_CUSTOM_FIELD: "Faltan campos para agregar ",
    INTERNAL_ERROR_MESSAGE: "Un error interno ha ocurrido.",

    DATA_EMPTY: "No se encontraron resultados",
    DATA_REPET: "Registro ya listado",
    DATA_EMPTY_NULL: "Listado vacio de: ",

  },

  QuestionModal: {
    
  },

  Session: {
    ACCESS_TOKEN: 'ACCESS_TOKEN',
    TOKEN_TYPE: 'TOKEN_TYPE',
    USER_TYPE: 'USER_TYPE',
    REFRESH_TOKEN: 'REFRESH_TOKEN',
    EXPIRATION_TIME: 'EXPIRATION_TIME',
    USERNAME: 'USERNAME',
    USERID: 'USERID',
    LANGUAGE: 'LANGUAGE',
    USERDATA: 'USERDATA',
    LAST_URL: 'LAST_URL',
    DOCUMENT_DATA: 'DOCUMENT_DATA',
    CODE_DATA: 'CODE_DATA',
  },
  
  UserRole:{
    ADMIN: 'ADMIN',
    CLIENT: 'CLIENT',
    ENTERPRISE: 'ENTERPRISE',
    ENTERPRISE_USER: 'ENTERPRISE_USER'
  },

  DocumentType:{
    DNI: '1',
    CE: '2'
  },

  GeneralType:{
    MOVIE: 'MOVIE'
  },

  UserParameter: {
    TIMESECONDS: '2'
  },

  LanguageApp: {
    SPANISH: '1',
    ENGLISH: '2'
  },

  Design:{
    spinnerNameChargeData: 'chargeData'
  }
}
