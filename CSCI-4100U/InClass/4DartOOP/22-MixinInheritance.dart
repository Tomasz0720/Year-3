// Base class
class Device {
  void powerOn() => print('Device is powered on');
}

// Camera functionality (mixin)
mixin Camera {
  void takePhoto() => print('Taking a photo...');
}

// Music functionality (mixin)
mixin MusicPlayer {
  void playMusic() => print('Playing music...');
}

// Smartphone extends Device, but also mixes in Camera + MusicPlayer
class SmartPhone extends Device with Camera, MusicPlayer {}

void main() {
  SmartPhone phone = SmartPhone();

  // From base class
  phone.powerOn();      // Device is powered on

  // From Camera mixin
  phone.takePhoto();    // Taking a photo...

  // From MusicPlayer mixin
  phone.playMusic();    // Playing music...
}
