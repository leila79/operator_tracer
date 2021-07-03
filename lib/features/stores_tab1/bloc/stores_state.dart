part of 'stores_bloc.dart';

@immutable
abstract class StoresState {}

class StoresInitial extends MasterState {}

class ShowStores extends MasterState {
  List<Store> stores;
  ShowStores(this.stores);
}
