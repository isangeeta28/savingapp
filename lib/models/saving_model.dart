class SavingsModel {
  int compA;
  int compB;
  List<String> history;

  SavingsModel({required this.compA, required this.compB, required this.history});

  factory SavingsModel.fromJson(Map<String, dynamic> json) {
    return SavingsModel(
      compA: json['compA'] ?? 0,
      compB: json['compB'] ?? 0,
      history: List<String>.from(json['history'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'compA': compA,
      'compB': compB,
      'history': history,
    };
  }
}
