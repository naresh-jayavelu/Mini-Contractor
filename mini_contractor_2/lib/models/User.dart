class User {
  String email;
  String firstName;
  String lastName;
  String password;
  String dob;
  String phone;
  String status;
  bool isActive;
  String roleId; // Assuming 'Role' is a class defined elsewhere
  String addressId; // Assuming 'Address' is a class defined elsewhere
  String genderId; // Assuming 'Gender' is a class defined elsewhere

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.dob,
    required this.phone,
    required this.status,
    required this.isActive,
    required this.roleId,
    required this.addressId,
    required this.genderId,
  });
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'dob': dob,
      'phone': phone,
      'status': status,
      'isActive': isActive,
      'roleId': roleId,
      'addressId': addressId,
      'genderId': genderId,
    };}
  }