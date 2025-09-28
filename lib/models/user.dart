class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final List<Address> addresses;
  final List<String> wishlist;
  final DateTime joinedDate;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
    required this.addresses,
    required this.wishlist,
    required this.joinedDate,
  });
}

class Address {
  final String id;
  final String type; // Home, Work, Other
  final String name;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final String landmark;
  final String city;
  final String state;
  final String pinCode;
  final bool isDefault;

  Address({
    required this.id,
    required this.type,
    required this.name,
    required this.phone,
    required this.addressLine1,
    required this.addressLine2,
    required this.landmark,
    required this.city,
    required this.state,
    required this.pinCode,
    this.isDefault = false,
  });

  String get fullAddress {
    return '$addressLine1, $addressLine2, $landmark, $city, $state - $pinCode';
  }
}