#include <Arduino.h>

namespace
{
constexpr int kUartRxPin = 3;
constexpr int kUartTxPin = 1;
constexpr unsigned long kProbeIntervalMs = 1000;
const char *kProbeFrame = "{\"N\":23,\"H\":\"GR\"}";

unsigned long lastProbeAt = 0;
bool ledState = false;
}

void setup()
{
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, LOW);

  Serial.begin(115200);
  delay(200);
  Serial.println();
  Serial.println("ESP32-S3 Serial Diagnostic");
  Serial.printf("Serial2 RX=%d TX=%d\n", kUartRxPin, kUartTxPin);

  Serial2.begin(9600, SERIAL_8N1, kUartRxPin, kUartTxPin);
  delay(50);

  Serial.println("Starting periodic UNO probe");
}

void loop()
{
  const unsigned long now = millis();
  if (now - lastProbeAt >= kProbeIntervalMs)
  {
    lastProbeAt = now;
    Serial.print("TX -> ");
    Serial.println(kProbeFrame);
    Serial2.print(kProbeFrame);
    ledState = !ledState;
    digitalWrite(LED_BUILTIN, ledState ? HIGH : LOW);
  }

  while (Serial2.available() > 0)
  {
    const int value = Serial2.read();
    Serial.write(value);
  }

  while (Serial.available() > 0)
  {
    const int value = Serial.read();
    Serial2.write(value);
  }
}
