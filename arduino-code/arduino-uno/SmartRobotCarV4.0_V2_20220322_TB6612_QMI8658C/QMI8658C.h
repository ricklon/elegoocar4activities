/*
 * @Description: QMI8658C
 * @Author: ELEGOO
 * @Date: 2019-07-10 16:46:17
 * @LastEditTime: 2021-04-27 10:43:15
 * @LastEditors: Changhua
 */

#ifndef _QMI8658C_H_

#define _QMI8658C_H_
#include <Arduino.h>
class QMI8658C
{
public:
  bool QMI8658C_dveInit(void);
  bool QMI8658C_calibration(void);
  bool QMI8658C_dveGetEulerAngles(float *gyro, float *yaw);
  bool QMI8658C_dveGetEulerAngles(float *yaw);
  void QMI8658C_dveGetRawData(int16_t *ax_out, int16_t *ay_out, int16_t *az_out,
                              int16_t *gx_out, int16_t *gy_out, int16_t *gz_out);
  void QMI8658C_Check(void);

public:
  int16_t ax, ay, az, gx, gy, gz;
  float pith, roll, yaw;
  unsigned long now, lastTime = 0;
  float dt;      //微分时间
  float agz = 0; //角度变量
  long gzo = 0;  //陀螺仪偏移量
};

//extern QMI8658C _QMI8658C;
#endif
