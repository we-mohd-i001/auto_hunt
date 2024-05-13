abstract class Filter {
  factory Filter.firestore(
    Eq? eq,
    Neq? neq,
    String? onConflict,
    Gt? gt,
    Gte? gte,
    Lt? lt,
    Lte? lte,
    Like? like,
  ) {
    return FirestoreFilter(eq, neq, onConflict, gt, gte, lt, lte, like);
  }

  factory Filter.supabase(
    Eq? eq,
    Neq? neq,
    String? onConflict,
    Gt? gt,
    Gte? gte,
    Lt? lt,
    Lte? lte,
    Like? like,
  ) {
    return SupabaseFilter(eq, neq, onConflict, gt, gte, lt, lte, like);
  }
}

class SupabaseFilter implements Filter {
  Eq? eq;
  Neq? neq;
  String? onConflict;
  Gt? gt;
  Gte? gte;
  Lt? lt;
  Lte? lte;
  Like? like;

  SupabaseFilter(
    this.eq,
    this.neq,
    this.onConflict,
    this.gt,
    this.gte,
    this.lt,
    this.lte,
    this.like,
  );
}

class FirestoreFilter implements Filter {
  Eq? eq;
  Neq? neq;
  String? onConflict;
  Gt? gt;
  Gte? gte;
  Lt? lt;
  Lte? lte;
  Like? like;

  FirestoreFilter(
    this.eq,
    this.neq,
    this.onConflict,
    this.gt,
    this.gte,
    this.lt,
    this.lte,
    this.like,
  );
}

class Eq {
  final String column;
  final Object value;

  ///[Eq] and [Neq] are the classes used as helpers to apply filters
  ///in a given collection either from [Supabase] or [FirebaseFirestore],
  Eq({required this.column, required this.value});
}

class Neq {
  final String column;
  final Object value;

  ///[Eq] and [Neq] are the classes used as helpers for applying filters
  ///in a given collection either from [Supabase] or [FirebaseFirestore],
  Neq({required this.column, required this.value});
}

class Gt {
  String column;
  Object value;

  /// Finds all rows whose value on the stated [column] is greater than or equal to the specified [value].
  Gt({
    required this.column,
    required this.value,
  });
}

class Gte {
  String column;
  Object value;

  /// Finds all rows whose value on the stated [column] is greater than or equal to the specified [value].

  Gte({
    required this.column,
    required this.value,
  });
}

class Lt {
  String column;
  Object value;

  /// Finds all rows whose value on the stated [column] is less than the specified [value].
  Lt({
    required this.column,
    required this.value,
  });
}

class Lte {
  String column;
  Object value;

  /// Finds all rows whose value on the stated [column] is less than or equal to the specified [value].
  Lte({
    required this.column,
    required this.value,
  });
}

class Like {
  String column;
  String pattern;

  /// Finds all rows whose value in the stated [column] matches the supplied [pattern] (case sensitive).
  Like({
    required this.column,
    required this.pattern,
  });
}
