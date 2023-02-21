String formatNumber(double value) {
    if (value >= 1000000000000) {
      return '${(value / 1000000000000).toStringAsFixed(1)}t';
    } else if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1)}b';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}m';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    } else {
      return value.toString();
    }
  }