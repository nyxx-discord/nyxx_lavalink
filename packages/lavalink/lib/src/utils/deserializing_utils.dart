/// Helper function that converts [ms] to a [DateTime].
DateTime dateTimeFromMilliseconds(int ms) => DateTime.fromMillisecondsSinceEpoch(ms);

/// Helper function that converts [ms] to a [Duration].
Duration durationFromMilliseconds(int ms) => Duration(milliseconds: ms);
