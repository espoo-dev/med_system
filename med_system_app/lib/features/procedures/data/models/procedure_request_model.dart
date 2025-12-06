class ProcedureRequestModel {
  final String name;
  final String code;
  final String description;
  final String amountCents;

  const ProcedureRequestModel({
    required this.name,
    required this.code,
    required this.description,
    required this.amountCents,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'description': description,
      'amount_cents': int.tryParse(amountCents) ?? 0,
    };
  }
}
