import 'genotype.dart';

class Individual {
  static int _autoNameCount = 1;

  final String name;
  final Genotype genotype;

  Individual(String genotype, [String? name])
      : name = name ?? _generateAutomaticName(),
        genotype = Genotype(genotype) {
    if (name == null) {
      _autoNameCount++;
    }
  }

  Individual.withName(String genotype, String name)
      : name = name,
        genotype = Genotype(genotype);

  static String _generateAutomaticName() {
    return 'Indiv$_autoNameCount';
  }

  @override
  String toString() => '$name(${Genotype.bloodType(genotype)})';
}