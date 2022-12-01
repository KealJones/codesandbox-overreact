import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/react_dom.dart' as react_dom;

// ignore: uri_has_not_been_generated
part 'main.over_react.g.dart';

void main() {
  react_dom.render(Basic()('Instant Squirrels!'), querySelector('#main'));
}

mixin BasicProps on UiProps {}

UiFactory<BasicProps> Basic = uiFunction(
  (props) {
    final toggleGreeting = useState(true);
    final consumedProps = props.staticMeta.forMixins({BasicProps});
    final classes = ClassNameBuilder.fromProps(props)..add('basic-component');
    return (Dom.button()
      ..className = classes.toClassName()
      ..addUnconsumedDomProps(props, consumedProps)
      ..onClick = ((_) => toggleGreeting.set(!toggleGreeting.value))
    )(
      toggleGreeting.value ? 'Hello' : 'Goodbye',
      ', ', 
      props.children,
    );
  },
  _$BasicConfig, // ignore: undefined_identifier
);