#ifndef AUDIO_RECORDER_H_
#define AUDIO_RECORDER_H_

#include <windows.h>
#include <audioclient.h>
#include <mmdeviceapi.h>
#include <wrl.h>
#include <thread>
#include <mutex>
#include <vector>
#include <string>

class AudioRecorder {
 public:
  AudioRecorder();
  ~AudioRecorder();

  bool StartRecording(const std::wstring& outputFilePath);
  void StopRecording();

 private:
  void RecordingThread();

  Microsoft::WRL::ComPtr<IMMDeviceEnumerator> deviceEnumerator_;
  Microsoft::WRL::ComPtr<IMMDevice> device_;
  Microsoft::WRL::ComPtr<IAudioClient> audioClient_;
  Microsoft::WRL::ComPtr<IAudioCaptureClient> audioCaptureClient_;

  std::thread recordingThread_;
  std::mutex mutex_;
  bool isRecording_;
  std::wstring outputFilePath_;
  HANDLE stopEvent_;
};

#endif  // AUDIO_RECORDER_H_
