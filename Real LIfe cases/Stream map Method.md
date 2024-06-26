### You can transform Stream with [map method](https://api.flutter.dev/flutter/dart-async/Stream/map.html)

#### Imagine this kind of interface in any [AudioPlayer] plugin

```
abstract class AudioPlayerI {
Stream<AudioEvent> get eventStream;

/// ... another methods
}
```

- Additional classes and enum from plugin

```
enum AudioEventType { log, duration, seekComplete, complete, prepared }

@immutable
class AudioEvent {
    final AudioEventType eventType;
    const AudioEvent({required this.eventType});
}

final class AudioPlayer implements AudioPlayerI {
    final _eventStreamController = StreamController<AudioEvent>.broadcast();

    @override
    Stream<AudioEvent> get eventStream => _eventStreamController.stream;

    ...
}
```

- Now we create our own interface based on the provided technical requirements, which includes the
  method [onPrepared] that **is not available in the [AudioPlayer] class**:

```
/// Interface class for communication
abstract class CustomAudioI {
    Stream<AudioEvent> get eventStream;

    Stream<bool> get onPrepared;

    ...
}
```

#### We have 2 solutions:

- 1.1. Write extension for base [AudioPlayer] class:

```
 extension AudioPlayerOnPreparedExtension on AudioPlayer {
   Stream<bool> get onPrepared => eventStream.map(
         (event) => event.eventType == AudioEventType.prepared,
       );
 }
```

- 1.2. Use additional method from [extension]

```
 class CustomAudioImpl implements CustomAudioI {
   final audioPlayer = AudioPlayer();

   @override
   Stream<AudioEvent> get eventStream => audioPlayer.eventStream;

   @override
   Stream<bool> get onPrepared => audioPlayer.onPrepared;
 }
```

- 2.1. Implement an extra method within the [CustomAudioImpl] class to conform to the [CustomAudioI]
  interface:

```
class CustomAudioImpl implements CustomAudioI {
  final audioPlayer = AudioPlayer();

  @override
  Stream<AudioEvent> get eventStream => audioPlayer.eventStream;

  @override
  Stream<bool> get onPrepared => eventStream.map(
        (event) => event.eventType == AudioEventType.prepared,
  );
}
```