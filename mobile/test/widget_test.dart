import 'package:flutter_test/flutter_test.dart';

import 'package:madu_gate_app/main.dart';

void main() {
  testWidgets('Splash renderiza ao iniciar o app', (WidgetTester tester) async {
    await tester.pumpWidget(const MaduGateApp());

    expect(find.text('Carregando...'), findsOneWidget);
  });
}
