import 'package:json_annotation/json_annotation.dart';

part 'filters.g.dart';

/// Information about the filters a [Player] is using.
@JsonSerializable(createToJson: true)
class Filters {
  /// The volume modifier.
  final double? volume;

  /// A list of equalizers applied.
  final List<Equalizer>? equalizers;

  /// The karaoke effect applied.
  final Karaoke? karaoke;

  /// The timescale applied.
  final Timescale? timescale;

  /// The tremolo applied.
  final Tremolo? tremolo;

  /// The vibrato applied.
  final Vibrato? vibrato;

  /// The rotation effect applied.
  final Rotation? rotation;

  /// The distortion applied.
  final Distortion? distortion;

  /// The channel mix effect applied.
  final ChannelMix? channelMix;

  /// The low-pass filter applied.
  final LowPass? lowPass;

  /// Filters provided by plugins.
  final Map<String, Map<String, Object?>>? pluginFilters;

  /// Create a new [Filters].
  Filters({
    this.volume,
    this.equalizers,
    this.karaoke,
    this.timescale,
    this.tremolo,
    this.vibrato,
    this.rotation,
    this.distortion,
    this.channelMix,
    this.lowPass,
    this.pluginFilters,
  });

  factory Filters.fromJson(Map<String, Object?> json) => _$FiltersFromJson(json);

  Map<String, Object?> toJson() => _$FiltersToJson(this);
}

/// Information about an equalizer.
@JsonSerializable()
class Equalizer {
  /// The band this equalizer targets.
  final int band;

  /// The applied gain.
  final double gain;

  /// Create a new [Equalizer].
  Equalizer({required this.band, required this.gain});

  factory Equalizer.fromJson(Map<String, Object?> json) => _$EqualizerFromJson(json);
}

/// Information about a karaoke effect
@JsonSerializable()
class Karaoke {
  /// The level of the effect.
  final double? level;

  /// The mono level of the effect.
  final double? monoLevel;

  /// The filter band used.
  final double? filterBand;

  /// The filter width used.
  final double? filterWidth;

  /// Create a new [Karaoke].
  Karaoke({
    required this.level,
    required this.monoLevel,
    required this.filterBand,
    required this.filterWidth,
  });

  factory Karaoke.fromJson(Map<String, Object?> json) => _$KaraokeFromJson(json);
}

/// Information about a timescale effect.
@JsonSerializable()
class Timescale {
  /// The speed of the effect.
  final double? speed;

  /// The pitch of the effect.
  final double? pitch;

  /// The rate of the effect.
  final double? rate;

  /// Create a new [Timescale].
  Timescale({required this.speed, required this.pitch, required this.rate});

  factory Timescale.fromJson(Map<String, Object?> json) => _$TimescaleFromJson(json);
}

/// Information about a tremolo effect.
@JsonSerializable()
class Tremolo {
  /// The frequency of the effect.
  final double? frequency;

  /// The depth of the effect.
  final double? depth;

  /// Create a new [Tremolo].
  Tremolo({required this.frequency, required this.depth});

  factory Tremolo.fromJson(Map<String, Object?> json) => _$TremoloFromJson(json);
}

/// Information about a vibrato effect.
@JsonSerializable()
class Vibrato {
  /// The frequency of the effect.
  final double? frequency;

  /// The depth of the effect.
  final double? depth;

  /// Create a new [Vibrato].
  Vibrato({required this.frequency, required this.depth});

  factory Vibrato.fromJson(Map<String, Object?> json) => _$VibratoFromJson(json);
}

/// Information about a rotation effect.
@JsonSerializable()
class Rotation {
  /// The frequency of the effect in hertz.
  final double rotationHz;

  /// Create a new [Rotation].
  Rotation({required this.rotationHz});

  factory Rotation.fromJson(Map<String, Object?> json) => _$RotationFromJson(json);
}

/// Information about a distortion effect.
@JsonSerializable()
class Distortion {
  final double? sinOffset;
  final double? sinScale;
  final double? cosOffset;
  final double? cosScale;
  final double? tanOffset;
  final double? tanScale;
  final double? offset;
  final double? scale;

  /// Create a new [Distortion].
  Distortion({
    required this.sinOffset,
    required this.sinScale,
    required this.cosOffset,
    required this.cosScale,
    required this.tanOffset,
    required this.tanScale,
    required this.offset,
    required this.scale,
  });

  factory Distortion.fromJson(Map<String, Object?> json) => _$DistortionFromJson(json);
}

/// Information about a channel mix effect.
@JsonSerializable()
class ChannelMix {
  final double? leftToLeft;
  final double? leftToRight;
  final double? rightToLeft;
  final double? rightToRight;

  /// Create a new [ChannelMix].
  ChannelMix({
    required this.leftToLeft,
    required this.leftToRight,
    required this.rightToLeft,
    required this.rightToRight,
  });

  factory ChannelMix.fromJson(Map<String, Object?> json) => _$ChannelMixFromJson(json);
}

/// Information about a low pass filter effect.
@JsonSerializable()
class LowPass {
  final double? smoothing;

  /// Create a new [LowPass].
  LowPass({required this.smoothing});

  factory LowPass.fromJson(Map<String, Object?> json) => _$LowPassFromJson(json);
}
