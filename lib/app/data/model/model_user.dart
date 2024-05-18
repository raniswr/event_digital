class ModelUser {
  String? token;
  int? id;
  String? username;
  String? email;
  String? phone;
  String? alamat;
  String? password;
  bool? isLogin;

  ModelUser({this.token, this.id, this.username, this.email, this.phone, this.alamat, this.isLogin, this.password});

  ModelUser.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['_id'];
    username = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    alamat = json['lokasi'];
    password = json['password'];
    isLogin = json['isLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['_id'] = id;
    data['fullname'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['lokasi'] = alamat;
    data['password'] = password;
    data['isLogin'] = isLogin;
    return data;
  }
}
