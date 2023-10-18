class Genotype {
  final String _genotype;

  static List<String> _validGenotypes = ['Ai', 'AA', 'Bi', 'BB', 'AB', 'ii'];

  Genotype(String allele)
      : _genotype = _validateGenotype(_validGenotypes, allele);

  static String _validateGenotype(List<String> validGenotypes, String allele) {
    if (validGenotypes.contains(allele)) {
      return allele;
    } else {
      throw ArgumentError('Invalid allele: $allele');
    }
  }

  static String bloodType(Genotype genotype) {
    final String _bloodtype;

    switch (genotype._genotype) {
      case 'A':
      case 'AA':
      case 'Ai':
        _bloodtype = 'A';
        break;

      case 'B':
      case 'BB':
      case 'Bi':
        _bloodtype = 'B';
        break;

      case 'AB':
        _bloodtype = 'AB';
        break;

      case 'ii':
        _bloodtype = 'O';
        break;

      default:
        _bloodtype = 'Allele Invalid';
    }
    return _bloodtype;
  }

  List<String> get alleles {
    Set<String> alleleSet = _genotype.split('').toSet();
    List<String> alleleList = alleleSet.toList();
    return alleleList;
  }

  List<String> get agglutinogens {
  List<String> list = _genotype.split('');
  
  if (list.isNotEmpty) {
    if (list.length > 1 && list[1] == 'i') {
      list.removeAt(1);
      if (list[0] == 'i') {
        list.removeAt(0);
      }
    }
  } else {
    throw ArgumentError('List Void');
  }
  
  list = list.toSet().toList();
  return list;
}

  List<String> get agglutinins {
    Set<String> agglutininsSet = {};
    var alleles = _genotype.split('');

    if (alleles[0] == 'A' && alleles[1] != 'B') {
      agglutininsSet.add('B');
    }

    if (alleles[0] == 'B' && alleles[1] != 'A') {
      agglutininsSet.add('A');
    }

    if (alleles[0] == 'A' && alleles[1] == 'B') {
      return agglutininsSet.toList();
    }

    if (alleles[0] == 'i') {
      agglutininsSet.add('A');
      agglutininsSet.add('B');
    }
    return agglutininsSet.toList();
  }

  List<String> offsprings(Genotype other) {
  List<String> result = [];

  List<String> gen1 = this._genotype.split('');
  List<String> gen2 = other._genotype.split('');

  List<String> combinations = [
    '${gen1[0] + gen2[0]}', 
    '${gen1[0] + gen2[1]}', 
    '${gen1[1] + gen2[0]}', 
    '${gen1[1] + gen2[1]}'
  ];

  for (String combination in combinations) {
    if (combination.contains('iA')) {
      result.add(combination.replaceAll('iA', 'Ai'));
    } else if (combination.contains('iB')) {
      result.add(combination.replaceAll('iB', 'Bi'));
    } else if (combination.contains('BA')) {
      result.add(combination.replaceAll('BA', 'AB'));
    } else {
      result.add(combination);
    }
  }
  return result.toSet().toList();
}

  bool compatible(Genotype other) {
    String bloodType1 = Genotype.bloodType(this);
    String bloodType2 = Genotype.bloodType(other);

    if (bloodType1 == 'O') {
      return true;
    } else if (bloodType1 == 'AB') {
      return bloodType2 == 'AB';
    } else {
      if (bloodType1 == 'A') {
        return bloodType2 == 'A' || bloodType2 == 'AB';
      } else if (bloodType1 == 'B') {
        return bloodType2 == 'B' || bloodType2 == 'AB';
      }
    }
    return false;
  }

  @override
  String toString() {
    return _genotype;
  }
}