// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShoppingCartAdapter extends TypeAdapter<ShoppingCart> {
  @override
  final int typeId = 1;

  @override
  ShoppingCart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShoppingCart(
      reference: fields[0] as String?,
      brand: fields[1] as String,
      imageUrl: fields[3] as String,
      price: fields[5] as int,
      quantity: fields[6] as int,
      symbol: fields[7] as String,
      title: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShoppingCart obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.reference)
      ..writeByte(1)
      ..write(obj.brand)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.symbol)
      ..writeByte(8)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShoppingCartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
