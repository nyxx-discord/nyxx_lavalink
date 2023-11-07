import 'package:json_annotation/json_annotation.dart';

part 'filters.g.dart';

@JsonSerializable(createToJson: true)
class Filters {
  final double? volume;
  final List<Equalizer>? equalizers;
  final Karaoke? karaoke;
  final Timescale? timescale;
  final Tremolo? tremolo;
  final Vibrato? vibrato;
  final Rotation? rotation;
  final Distortion? distortion;
  final ChannelMix? channelMix;
  final LowPass? lowPass;
  final Map<String, Map<String, Object?>>? pluginFilters;

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

@JsonSerializable()
class Equalizer {
  final int band;
  final double gain;

  Equalizer({required this.band, required this.gain});

  factory Equalizer.fromJson(Map<String, Object?> json) => _$EqualizerFromJson(json);
}

@JsonSerializable()
class Karaoke {
  final double? level;
  final double? monoLevel;
  final double? filterBand;
  final double? filterWidth;

  Karaoke({
    required this.level,
    required this.monoLevel,
    required this.filterBand,
    required this.filterWidth,
  });

  factory Karaoke.fromJson(Map<String, Object?> json) => _$KaraokeFromJson(json);
}

@JsonSerializable()
class Timescale {
  final double? speed;
  final double? pitch;
  final double? rate;

  Timescale({required this.speed, required this.pitch, required this.rate});

  factory Timescale.fromJson(Map<String, Object?> json) => _$TimescaleFromJson(json);
}

@JsonSerializable()
class Tremolo {
  final double? frequency;
  final double? depth;

  Tremolo({required this.frequency, required this.depth});

  factory Tremolo.fromJson(Map<String, Object?> json) => _$TremoloFromJson(json);
}

@JsonSerializable()
class Vibrato {
  final double? frequency;
  final double? depth;

  Vibrato({required this.frequency, required this.depth});

  factory Vibrato.fromJson(Map<String, Object?> json) => _$VibratoFromJson(json);
}

@JsonSerializable()
class Rotation {
  final double rotationHz;

  Rotation({required this.rotationHz});

  factory Rotation.fromJson(Map<String, Object?> json) => _$RotationFromJson(json);
}

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

@JsonSerializable()
class ChannelMix {
  final double? leftToLeft;
  final double? leftToRight;
  final double? rightToLeft;
  final double? rightToRight;

  ChannelMix({
    required this.leftToLeft,
    required this.leftToRight,
    required this.rightToLeft,
    required this.rightToRight,
  });

  factory ChannelMix.fromJson(Map<String, Object?> json) => _$ChannelMixFromJson(json);
}

@JsonSerializable()
class LowPass {
  final double? smoothing;

  LowPass({required this.smoothing});

  factory LowPass.fromJson(Map<String, Object?> json) => _$LowPassFromJson(json);
}
