#ifndef __I2C_LIB_H
#define __I2C_LIB_H

#include <stdint.h>

#ifndef bool
  #define bool uint8_t  // Redefine tipo de variable bit en zona RAM de uC direccionable a bits.
#endif // bool

#define BIT7 0x01<<7

void I2C_start(void)
{
    TRIS_SDA=0;
    TRIS_SCL=0;
    SDA=1;    //"start" function for communicate I2C
    SCL=1;
    SDA=0;
    SCL=0;
}

void I2C_stop(void)
{
    SDA=0;
    SCL=1;
    SDA=1;   //"stop" function for communicate I2C
}

bool I2C_send(uint8_t dato)             //send data to I2C
{
    uint8_t i;
    bool ACKbit;
    //TRIS_SDA=0;
    for(i=0; i<8; i++)
    {
        SDA = (dato & BIT7);
        SCL=1;
        dato<<=1;
        SCL=0;
    }
    SCL=1;
    TRIS_SDA=1;
    ACKbit=SDA;
    SCL=0;
    TRIS_SDA=0;
    return ACKbit;
}

uint8_t I2C_read(bool ACKBit)                      //receive data from I2C
{
    uint8_t i;
    uint8_t dato=0;
    TRIS_SDA=1;
    for(i=0; i<8; i++)
    {
        SCL=1;
        dato<<=1;
        if(SDA) dato|=1;
        SCL=0;
    }
    TRIS_SDA=0;
    SDA=!ACKBit;
    SCL=1;
    SCL=0;
    return dato;
}

#endif  // __I2C_LIB_H
