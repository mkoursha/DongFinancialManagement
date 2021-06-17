import 'package:equatable/equatable.dart';

class CADU extends Equatable {
  String creditorName, debtorName;
  double unitPrice, number;

  @override
  List<Object> get props => [creditorName, debtorName];

  @override
  String toString() {
    return "<" +
        "creditorName='" +
        creditorName +
        '\'' +
        ", debtorName='" +
        debtorName +
        '\'' +
        ", number=" +
        number.toString() +
        '>';
  }

  CADU(
      String creditorName, String debtorName, double unitPrice, double number) {
    this.creditorName = creditorName;
    this.debtorName = debtorName;
    this.unitPrice = unitPrice;
    this.number = number;
  }

  String getCreditorName() {
    return creditorName;
  }

  void setCreditorName(String creditorName) {
    this.creditorName = creditorName;
  }

  String getDebtorName() {
    return debtorName;
  }

  void setDebtorName(String debtorName) {
    this.debtorName = debtorName;
  }

  double getUnitPrice() {
    return unitPrice;
  }

  void setUnitPrice(double unitPrice) {
    this.unitPrice = unitPrice;
  }

  double getNumber() {
    return number;
  }

  void setNumber(double number) {
    this.number = number;
  }
}
