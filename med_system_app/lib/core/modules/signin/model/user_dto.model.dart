class UserDTO {
  String? token;
  String? refreshToken;
  int? expiresIn;
  String? tokenType;
  ResourceOwnerDTO? resourceOwner;

  UserDTO(
      {this.token,
      this.refreshToken,
      this.expiresIn,
      this.tokenType,
      this.resourceOwner});

  UserDTO.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refresh_token'];
    expiresIn = json['expires_in'];
    tokenType = json['token_type'];
    resourceOwner = json['resource_owner'] != null
        ? ResourceOwnerDTO.fromJson(json['resource_owner'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['refresh_token'] = refreshToken;
    data['expires_in'] = expiresIn;
    data['token_type'] = tokenType;
    if (resourceOwner != null) {
      data['resource_owner'] = resourceOwner!.toJson();
    }
    return data;
  }
}

class ResourceOwnerDTO {
  int? id;
  String? email;
  String? createdAt;
  String? updatedAt;

  ResourceOwnerDTO({this.id, this.email, this.createdAt, this.updatedAt});

  ResourceOwnerDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
