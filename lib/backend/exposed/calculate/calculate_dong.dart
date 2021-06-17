import 'package:dong/backend/exposed/calculate/cadu.dart';
import 'package:dong/data/entities.dart';

class CalculateDong {
  final List<Group> groups;

  CalculateDong({this.groups});

  List<CADU> calculateInGroup(Group g) {
    List<CADU> result = [];

    List<Factor> factors = g.factors;

    for (Factor f in factors) {
      List<CADU> cadus = _calculateAccounts(f);
      result = _calculateDCAmongFactors(cadus, result);
    }
    return result;
  }

  List<CADU> show(String userName) {
    List<CADU> resultOfGroups = null;
    for (Group g in groups) {
      List<CADU> result = calculateInGroup(g);
      resultOfGroups = _calculateDCAmongGroups(result, resultOfGroups);
    }
    return resultOfGroups
        .where((element) => element.toString().contains(userName))
        .toList();
  }
}

List<CADU> _calculateDCAmongGroups(List<CADU> l1, List<CADU> l2) {
  if (l2 == null) return l1;
  List<CADU> ret = [];
  for (CADU cadu in l1) {
    if (l2.length > 0 && l2.contains(cadu)) {
      ret.add(new CADU(
          cadu.getCreditorName(),
          cadu.getDebtorName(),
          cadu.getUnitPrice(),
          cadu.getNumber() + l2.elementAt(l2.indexOf(cadu)).getNumber()));
      l2.remove(cadu);
    } else if (l2.length > 0 &&
        l2.contains(new CADU(cadu.getDebtorName(), cadu.getCreditorName(),
            cadu.getUnitPrice(), cadu.getNumber()))) {
      CADU c2 = l2[l2.indexOf(new CADU(cadu.getDebtorName(),
          cadu.getCreditorName(), cadu.getUnitPrice(), cadu.getNumber()))];
      if (cadu.getNumber() > c2.getNumber()) {
        ret.add(new CADU(cadu.getCreditorName(), c2.getCreditorName(),
            cadu.getUnitPrice(), cadu.getNumber() - c2.getNumber()));
      } else {
        ret.add(new CADU(c2.getCreditorName(), c2.getDebtorName(),
            c2.getUnitPrice(), c2.getNumber() - cadu.getNumber()));
      }
      l2.remove(c2);
    } else {
      ret.add(cadu);
    }
  }
  if (l2.length > 0) {
    ret += l2;
  }
  return ret;
}

List<CADU> _calculateAccounts(Factor f) {
  List<CADU> ret = [];
  List<CADU> result = [];
  String creditor = f.buyer.id;
  for (Good g in f.goods) {
    double unit = g.unitPrice;
    for (Consumer c in g.consumers) {
      String debtor = c.user.id;
      double number = c.number;
      CADU cadu = CADU(creditor, debtor, unit, number);
      ret.add(cadu);
    }
  }
  ret.sort((f, s) => f.debtorName.compareTo(s.debtorName));
  double x = 0;
  int index = 0;
  for (CADU cadu in ret) {
    x += cadu.unitPrice * cadu.number;
    if (index < ret.length - 1 &&
        !(ret[index + 1].getDebtorName() == (ret[index].getDebtorName()))) {
      CADU c = CADU(
          cadu.getCreditorName(), cadu.getDebtorName(), cadu.getUnitPrice(), x);
      result.add(c);
      x = 0;
    } else if (index == ret.length - 1) {
      CADU c = CADU(
          cadu.getCreditorName(), cadu.getDebtorName(), cadu.getUnitPrice(), x);
      result.add(c);
    }
    index++;
  }
  return result;
}

List<CADU> _calculateDCAmongFactors(List<CADU> l1, List<CADU> l2) {
  if (l2 == null) {
    return l1;
  }
  List<CADU> ret = [];
  for (CADU cadu in l1) {
    if (l2.length > 0 && l2.contains(cadu)) {
      ret.add(new CADU(
          cadu.getCreditorName(),
          cadu.getDebtorName(),
          cadu.getUnitPrice(),
          cadu.getNumber() + l2[l2.indexOf(cadu)].getNumber()));
      l2.remove(cadu);
    } else if (l2.length > 0 &&
        l2.contains(new CADU(cadu.getDebtorName(), cadu.getCreditorName(),
            cadu.getUnitPrice(), cadu.getNumber()))) {
      CADU c2 = l2[l2.indexOf(new CADU(cadu.getDebtorName(),
          cadu.getCreditorName(), cadu.getUnitPrice(), cadu.getNumber()))];
      if (cadu.getNumber() > c2.getNumber()) {
        ret.add(new CADU(cadu.getCreditorName(), c2.getCreditorName(),
            cadu.getUnitPrice(), cadu.getNumber() - c2.getNumber()));
      } else {
        ret.add(new CADU(c2.getCreditorName(), c2.getDebtorName(),
            c2.getUnitPrice(), c2.getNumber() - cadu.getNumber()));
      }
      l2.remove(c2);
    } else {
      ret.add(cadu);
    }
  }
  if (l2.length > 0) {
    ret += l2;
  }
  return ret;
}
