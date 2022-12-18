import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/bloc/search/search_tv_bloc.dart';

void main() {
  test('Cek if props same with the input', () {
    expect(['Hail'], const OnQueryChangedEvent('Hail').props);
  });
}
