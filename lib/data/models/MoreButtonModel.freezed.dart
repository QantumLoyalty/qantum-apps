// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'MoreButtonModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MoreButtonModel {
  String get name;
  String get link;
  int get position;

  /// Create a copy of MoreButtonModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MoreButtonModelCopyWith<MoreButtonModel> get copyWith =>
      _$MoreButtonModelCopyWithImpl<MoreButtonModel>(
          this as MoreButtonModel, _$identity);

  /// Serializes this MoreButtonModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MoreButtonModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, link, position);

  @override
  String toString() {
    return 'MoreButtonModel(name: $name, link: $link, position: $position)';
  }
}

/// @nodoc
abstract mixin class $MoreButtonModelCopyWith<$Res> {
  factory $MoreButtonModelCopyWith(
          MoreButtonModel value, $Res Function(MoreButtonModel) _then) =
      _$MoreButtonModelCopyWithImpl;
  @useResult
  $Res call({String name, String link, int position});
}

/// @nodoc
class _$MoreButtonModelCopyWithImpl<$Res>
    implements $MoreButtonModelCopyWith<$Res> {
  _$MoreButtonModelCopyWithImpl(this._self, this._then);

  final MoreButtonModel _self;
  final $Res Function(MoreButtonModel) _then;

  /// Create a copy of MoreButtonModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? link = null,
    Object? position = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _self.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [MoreButtonModel].
extension MoreButtonModelPatterns on MoreButtonModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MoreButtonModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MoreButtonModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MoreButtonModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MoreButtonModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MoreButtonModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MoreButtonModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String name, String link, int position)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MoreButtonModel() when $default != null:
        return $default(_that.name, _that.link, _that.position);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String name, String link, int position) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MoreButtonModel():
        return $default(_that.name, _that.link, _that.position);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String name, String link, int position)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MoreButtonModel() when $default != null:
        return $default(_that.name, _that.link, _that.position);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MoreButtonModel implements MoreButtonModel {
  _MoreButtonModel(
      {required this.name, required this.link, required this.position});
  factory _MoreButtonModel.fromJson(Map<String, dynamic> json) =>
      _$MoreButtonModelFromJson(json);

  @override
  final String name;
  @override
  final String link;
  @override
  final int position;

  /// Create a copy of MoreButtonModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MoreButtonModelCopyWith<_MoreButtonModel> get copyWith =>
      __$MoreButtonModelCopyWithImpl<_MoreButtonModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MoreButtonModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MoreButtonModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, link, position);

  @override
  String toString() {
    return 'MoreButtonModel(name: $name, link: $link, position: $position)';
  }
}

/// @nodoc
abstract mixin class _$MoreButtonModelCopyWith<$Res>
    implements $MoreButtonModelCopyWith<$Res> {
  factory _$MoreButtonModelCopyWith(
          _MoreButtonModel value, $Res Function(_MoreButtonModel) _then) =
      __$MoreButtonModelCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String link, int position});
}

/// @nodoc
class __$MoreButtonModelCopyWithImpl<$Res>
    implements _$MoreButtonModelCopyWith<$Res> {
  __$MoreButtonModelCopyWithImpl(this._self, this._then);

  final _MoreButtonModel _self;
  final $Res Function(_MoreButtonModel) _then;

  /// Create a copy of MoreButtonModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? link = null,
    Object? position = null,
  }) {
    return _then(_MoreButtonModel(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _self.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
