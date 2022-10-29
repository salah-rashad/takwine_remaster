// class FacebookResponse {
//   String? id, name, email, firstName, lastName;

//   FacebookResponse(
//       {this.id, this.name, this.email, this.firstName, this.lastName});

//   FacebookResponse.fromJson(Map<String, dynamic> json) {
//     this.id = json['id'];
//     this.name = json['name'];
//     this.firstName = json['first_name'];
//     this.lastName = json['last_name'];
//     this.email = json['email'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['email'] = this.email;
//     return data;
//   }
// }
