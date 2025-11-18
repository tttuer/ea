// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drafts_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DraftState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DraftState()';
}


}

/// @nodoc
class $DraftStateCopyWith<$Res>  {
$DraftStateCopyWith(DraftState _, $Res Function(DraftState) __);
}


/// Adds pattern-matching-related methods to [DraftState].
extension DraftStatePatterns on DraftState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Loading value)?  loading,TResult Function( _Paginated value)?  data,TResult Function( _Single value)?  single,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Paginated() when data != null:
return data(_that);case _Single() when single != null:
return single(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Loading value)  loading,required TResult Function( _Paginated value)  data,required TResult Function( _Single value)  single,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Loading():
return loading(_that);case _Paginated():
return data(_that);case _Single():
return single(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Loading value)?  loading,TResult? Function( _Paginated value)?  data,TResult? Function( _Single value)?  single,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Paginated() when data != null:
return data(_that);case _Single() when single != null:
return single(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( Pagination<Drafts> drafts)?  data,TResult Function( Drafts draft)?  single,TResult Function( Object error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Paginated() when data != null:
return data(_that.drafts);case _Single() when single != null:
return single(_that.draft);case _Error() when error != null:
return error(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( Pagination<Drafts> drafts)  data,required TResult Function( Drafts draft)  single,required TResult Function( Object error)  error,}) {final _that = this;
switch (_that) {
case _Loading():
return loading();case _Paginated():
return data(_that.drafts);case _Single():
return single(_that.draft);case _Error():
return error(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( Pagination<Drafts> drafts)?  data,TResult? Function( Drafts draft)?  single,TResult? Function( Object error)?  error,}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Paginated() when data != null:
return data(_that.drafts);case _Single() when single != null:
return single(_that.draft);case _Error() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Loading implements DraftState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DraftState.loading()';
}


}




/// @nodoc


class _Paginated implements DraftState {
  const _Paginated(this.drafts);
  

 final  Pagination<Drafts> drafts;

/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedCopyWith<_Paginated> get copyWith => __$PaginatedCopyWithImpl<_Paginated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Paginated&&(identical(other.drafts, drafts) || other.drafts == drafts));
}


@override
int get hashCode => Object.hash(runtimeType,drafts);

@override
String toString() {
  return 'DraftState.data(drafts: $drafts)';
}


}

/// @nodoc
abstract mixin class _$PaginatedCopyWith<$Res> implements $DraftStateCopyWith<$Res> {
  factory _$PaginatedCopyWith(_Paginated value, $Res Function(_Paginated) _then) = __$PaginatedCopyWithImpl;
@useResult
$Res call({
 Pagination<Drafts> drafts
});




}
/// @nodoc
class __$PaginatedCopyWithImpl<$Res>
    implements _$PaginatedCopyWith<$Res> {
  __$PaginatedCopyWithImpl(this._self, this._then);

  final _Paginated _self;
  final $Res Function(_Paginated) _then;

/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? drafts = null,}) {
  return _then(_Paginated(
null == drafts ? _self.drafts : drafts // ignore: cast_nullable_to_non_nullable
as Pagination<Drafts>,
  ));
}


}

/// @nodoc


class _Single implements DraftState {
  const _Single(this.draft);
  

 final  Drafts draft;

/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SingleCopyWith<_Single> get copyWith => __$SingleCopyWithImpl<_Single>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Single&&(identical(other.draft, draft) || other.draft == draft));
}


@override
int get hashCode => Object.hash(runtimeType,draft);

@override
String toString() {
  return 'DraftState.single(draft: $draft)';
}


}

/// @nodoc
abstract mixin class _$SingleCopyWith<$Res> implements $DraftStateCopyWith<$Res> {
  factory _$SingleCopyWith(_Single value, $Res Function(_Single) _then) = __$SingleCopyWithImpl;
@useResult
$Res call({
 Drafts draft
});




}
/// @nodoc
class __$SingleCopyWithImpl<$Res>
    implements _$SingleCopyWith<$Res> {
  __$SingleCopyWithImpl(this._self, this._then);

  final _Single _self;
  final $Res Function(_Single) _then;

/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draft = null,}) {
  return _then(_Single(
null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as Drafts,
  ));
}


}

/// @nodoc


class _Error implements DraftState {
  const _Error(this.error);
  

 final  Object error;

/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'DraftState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $DraftStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 Object error
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of DraftState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
null == error ? _self.error : error ,
  ));
}


}

// dart format on
