class ModelUser {
  String? token;
  int? id;
  String? username;
  String? email;
  String? phone;
  String? alamat;
  bool? isLogin;

  ModelUser({this.token, this.id, this.username, this.email, this.phone, this.alamat, this.isLogin});

  ModelUser.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['_id'];
    username = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    alamat = json['lokasi'];
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
    data['isLogin'] = isLogin;
    return data;
  }
}
