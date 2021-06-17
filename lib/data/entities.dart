import 'package:equatable/equatable.dart';

class User extends Equatable {
  String id;
  String email;
  String name;
  String lastName;
  String phoneNumber;
  String pass; //This is not real, we don't save our users passwords ^^

  User(this.id, String email, String name, String pass, String phoneNumber,
      String lastName) {
    this.email = email;
    this.name = name;
    this.pass = pass;
    this.phoneNumber = phoneNumber;
    this.lastName = lastName;
  }

  String getEmail() {
    return email;
  }

  String getName() {
    return name;
  }

  String getPassWord() {
    return pass;
  }

  @override
  List<Object> get props => [id];
}

class Group {
  String id;
  String name; //name must be uniqe in db so it should be PRIMARYKEY
  User creator;
  List<User> subscribers;
  List<Factor> factors;

  Group(this.id, this.name, this.creator, this.subscribers, this.factors);
}

class Factor {
  String id;
  User buyer;
  List<Good> goods;
  String description;
  DateTime dateTime;

  Factor(this.id, this.buyer, this.description, this.dateTime, this.goods);

  double getCost() {
    double cost = 0;
    goods.forEach((good) {
      cost += good.number * good.unitPrice;
    });
    return cost;
  }
//a field of image
}

class Good {
  String id;
  String name;
  double unitPrice;
  double number;
  List<Consumer> consumers;

  Good(this.id, this.name, this.unitPrice, this.number, this.consumers);
}

class Consumer {
  String id;
  User user;
  double number;

  Consumer({
    this.number,
    this.user,
    this.id,
  });
}
