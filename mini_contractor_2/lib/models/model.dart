class User {
  final String userId;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String dob;
  final String phone;
  final String status;
  final bool isActive;
  final Role role;
  final Address address;
  final Gender gender;

  const User({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.dob,
    required this.phone,
    required this.status,
    required this.isActive,
    required this.role,
    required this.address,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'dob': dob,
      'phone': phone,
      'status': status,
      'isActive': isActive,
      'role': role.toJson(),
      'address': address.toJson(),
      'gender': gender.toJson(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      password: json['password'] ?? '',
      dob: json['dob'] ?? '',
      phone: json['phone'] ?? '',
      status: json['status'] ?? '',
      isActive: json['isActive'] ?? false,
      role: Role.fromJson(json['roolId'] ?? {}),
      address: Address.fromJson(json['addressId'] ?? {}),
      gender: Gender.fromJson(json['genderId'] ?? {}),
    );
  }
}

class Role {
  final String roleCode;
  final String roleName;
  final String roleDescription;
  final bool isActive;
  final String id;

  const Role({
    required this.roleCode,
    required this.roleName,
    required this.roleDescription,
    required this.isActive,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'roleCode': roleCode,
      'roleName': roleName,
      'roleDescription': roleDescription,
      'isActive': isActive,
      'id': id,
    };
  }

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roleCode: json['RoleCode'] ?? '',
      roleName: json['RoleName'] ?? '',
      roleDescription: json['RoleDescription'] ?? '',
      isActive: json['isActive'] ?? false,
      id: json['id'] ?? '',
    );
  }
}

class Gender {
  final String genderCode;
  final String genderName;
  final String genderDescription;
  final bool isActive;
  final String genderId;

  const Gender({
    required this.genderCode,
    required this.genderName,
    required this.genderDescription,
    required this.isActive,
    required this.genderId,
  });

  Map<String, dynamic> toJson() {
    return {
      'genderCode': genderCode,
      'genderName': genderName,
      'genderDescription': genderDescription,
      'isActive': isActive,
      'genderId': genderId,
    };
  }

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      genderCode: json['genderCode'] ?? '',
      genderName: json['genderName'] ?? '',
      genderDescription: json['genderDescription'] ?? '',
      isActive: json['isActive'] ?? false,
      genderId: json['genderId'] ?? '',
    );
  }
}

class Address {
  final String addressLine1;
  final String addressLine2;
  final String pincode;
  final String city;
  final String state;
  final String country;
  final String latitude;
  final String longitude;
  final bool isActive;
  final String addressId;

  const Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.pincode,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.isActive,
    required this.addressId,
  });

  Map<String, dynamic> toJson() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'pincode': pincode,
      'city': city,
      'state': state,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'isActive': isActive,
      'addressId': addressId,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressLine1: json['addressLine1'] ?? '',
      addressLine2: json['addressLine2'] ?? '',
      pincode: json['pincode'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      isActive: json['isActive'] ?? false,
      addressId: json['addressId'] ?? '',
    );
  }
}


class Login {
  final String userId;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String dob;
  final String phone;
  final String status;
  final bool isActive;
  final String role;
  final String address;
  final String gender;

  const Login({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.dob,
    required this.phone,
    required this.status,
    required this.isActive,
    required this.role,
    required this.address,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'dob': dob,
      'phone': phone,
      'status': status,
      'isActive': isActive,
      'role': role,
      'address': address,
      'gender': gender,
    };
  }

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      password: json['password'] ?? '',
      dob: json['dob'] ?? '',
      phone: json['phone'] ?? '',
      status: json['status'] ?? '',
      isActive: json['isActive'] ?? false,
      role: json['roolId'] ?? {},
      address:json['addressId'] ?? {},
      gender: json['genderId'] ?? {},
    );
  }
}
