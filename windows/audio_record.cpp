#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>
#include <sstream>

class AudioRecorder {
 public:
  AudioRecorder();
  virtual ~AudioRecorder();

  void StartRecording();
  void StopRecording();

 private:
  // TODO: Добавьте реализацию для записи звука
};

AudioRecorder::AudioRecorder() {
  // Конструктор
}

AudioRecorder::~AudioRecorder() {
  // Деструктор
}

void AudioRecorder::StartRecording() {
  // TODO: Реализуйте метод для начала записи звука
}

void AudioRecorder::StopRecording() {
  // TODO: Реализуйте метод для остановки записи звука
}

// Регистрация плагина
void AudioRecorderRegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
      registrar->messenger(), "com.example.audio/record",
      &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<AudioRecorder>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto& call, auto result) {
        if (call.method_name().compare("startRecording") == 0) {
          plugin_pointer->StartRecording();
          result->Success();
        } else if (call.method_name().compare("stopRecording") == 0) {
          plugin_pointer->StopRecording();
          result->Success();
        } else {
          result->NotImplemented();
        }
      });

  registrar->AddPlugin(std::move(plugin));
}
