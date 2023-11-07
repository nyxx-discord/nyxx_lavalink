// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filters _$FiltersFromJson(Map<String, dynamic> json) => Filters(
      volume: (json['volume'] as num?)?.toDouble(),
      equalizers: (json['equalizers'] as List<dynamic>?)
          ?.map((e) => Equalizer.fromJson(e as Map<String, dynamic>))
          .toList(),
      karaoke: json['karaoke'] == null
          ? null
          : Karaoke.fromJson(json['karaoke'] as Map<String, dynamic>),
      timescale: json['timescale'] == null
          ? null
          : Timescale.fromJson(json['timescale'] as Map<String, dynamic>),
      tremolo: json['tremolo'] == null
          ? null
          : Tremolo.fromJson(json['tremolo'] as Map<String, dynamic>),
      vibrato: json['vibrato'] == null
          ? null
          : Vibrato.fromJson(json['vibrato'] as Map<String, dynamic>),
      rotation: json['rotation'] == null
          ? null
          : Rotation.fromJson(json['rotation'] as Map<String, dynamic>),
      distortion: json['distortion'] == null
          ? null
          : Distortion.fromJson(json['distortion'] as Map<String, dynamic>),
      channelMix: json['channelMix'] == null
          ? null
          : ChannelMix.fromJson(json['channelMix'] as Map<String, dynamic>),
      lowPass: json['lowPass'] == null
          ? null
          : LowPass.fromJson(json['lowPass'] as Map<String, dynamic>),
      pluginFilters: (json['pluginFilters'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as Map<String, dynamic>),
      ),
    );

Map<String, dynamic> _$FiltersToJson(Filters instance) => <String, dynamic>{
      'volume': instance.volume,
      'equalizers': instance.equalizers,
      'karaoke': instance.karaoke,
      'timescale': instance.timescale,
      'tremolo': instance.tremolo,
      'vibrato': instance.vibrato,
      'rotation': instance.rotation,
      'distortion': instance.distortion,
      'channelMix': instance.channelMix,
      'lowPass': instance.lowPass,
      'pluginFilters': instance.pluginFilters,
    };

Equalizer _$EqualizerFromJson(Map<String, dynamic> json) => Equalizer(
      band: json['band'] as int,
      gain: (json['gain'] as num).toDouble(),
    );

Karaoke _$KaraokeFromJson(Map<String, dynamic> json) => Karaoke(
      level: (json['level'] as num?)?.toDouble(),
      monoLevel: (json['monoLevel'] as num?)?.toDouble(),
      filterBand: (json['filterBand'] as num?)?.toDouble(),
      filterWidth: (json['filterWidth'] as num?)?.toDouble(),
    );

Timescale _$TimescaleFromJson(Map<String, dynamic> json) => Timescale(
      speed: (json['speed'] as num?)?.toDouble(),
      pitch: (json['pitch'] as num?)?.toDouble(),
      rate: (json['rate'] as num?)?.toDouble(),
    );

Tremolo _$TremoloFromJson(Map<String, dynamic> json) => Tremolo(
      frequency: (json['frequency'] as num?)?.toDouble(),
      depth: (json['depth'] as num?)?.toDouble(),
    );

Vibrato _$VibratoFromJson(Map<String, dynamic> json) => Vibrato(
      frequency: (json['frequency'] as num?)?.toDouble(),
      depth: (json['depth'] as num?)?.toDouble(),
    );

Rotation _$RotationFromJson(Map<String, dynamic> json) => Rotation(
      rotationHz: (json['rotationHz'] as num).toDouble(),
    );

Distortion _$DistortionFromJson(Map<String, dynamic> json) => Distortion(
      sinOffset: (json['sinOffset'] as num?)?.toDouble(),
      sinScale: (json['sinScale'] as num?)?.toDouble(),
      cosOffset: (json['cosOffset'] as num?)?.toDouble(),
      cosScale: (json['cosScale'] as num?)?.toDouble(),
      tanOffset: (json['tanOffset'] as num?)?.toDouble(),
      tanScale: (json['tanScale'] as num?)?.toDouble(),
      offset: (json['offset'] as num?)?.toDouble(),
      scale: (json['scale'] as num?)?.toDouble(),
    );

ChannelMix _$ChannelMixFromJson(Map<String, dynamic> json) => ChannelMix(
      leftToLeft: (json['leftToLeft'] as num?)?.toDouble(),
      leftToRight: (json['leftToRight'] as num?)?.toDouble(),
      rightToLeft: (json['rightToLeft'] as num?)?.toDouble(),
      rightToRight: (json['rightToRight'] as num?)?.toDouble(),
    );

LowPass _$LowPassFromJson(Map<String, dynamic> json) => LowPass(
      smoothing: (json['smoothing'] as num?)?.toDouble(),
    );
