import 'package:event_digital/config/api_client.dart';

class ModelProfile {
  int? id;
  String? username;
  String? email;
  String? provider;
  bool? confirmed;
  bool? blocked;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? address;
  String? phoneNo;
  String? image;

  ModelProfile({
    this.id,
    this.image,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.address,
    this.phoneNo,
  });

  ModelProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    address = json['address'];
    phoneNo = json['phone_no'];
    image = getImageUrl(json['image']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['provider'] = provider;
    data['confirmed'] = confirmed;
    data['blocked'] = blocked;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['name'] = name;
    data['address'] = address;
    data['phone_no'] = phoneNo;
    data['image'] = image;
    return data;
  }
}

String? getImageUrl(json) {
  try {
    return AppClient.baseUrlImage + json["url"];
  } catch (e) {
    return null;
  }
}
