class BaseModel<T>{
  BaseModel(this.data, this.errorCode, this.errorMsg);

  T data;
  int errorCode;
  String errorMsg;
}