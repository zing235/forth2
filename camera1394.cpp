#include "camera1394.h"
#include <QPainter>
#include <stdio.h>
#include <vector>

#include "UniControl.h"
#include "UniTransform.h"
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;
UINT32_TYPE                 cnt(64);
std::vector<UINT32_TYPE>    CamIds(cnt);
UINT32_TYPE          imagewidth,imageheight;
QImage cameraframe;

#define UINT8P_CAST(x) reinterpret_cast<UINT8*>(x)
//![0]
Camera1394::Camera1394(QQuickItem *parent)
    : QQuickPaintedItem(parent)
{
}
//![0]

void Camera1394::startcamera(void)
{

    UINT32_TYPE Result;
    UINT32_TYPE depth,Code;

    //1.initial the camera
    Result=UCC_Init();
    if(S_OK!=Result)
        {
            std::cout<<"Can not initial camera"<<endl;
        }


    // 2.get list of cameras found on the bus;
    Result = UCC_GetCameras(&cnt,&*CamIds.begin());
    if( S_OK!= Result && UNI_RESULT_MORE_DATA != Result)
    {
        std::cout<<"Get Cameras failed"<<endl;
    }
//    setCameraID(quint32::CamIds[0]);


    //3.OpenCamera(CamIds[0]);
    Result=UCC_OpenCamera(CamIds[0]);
    if(S_OK!=Result)
    {
        std::cout<<"Could not openCamera"<<endl;
    }


    //4.GetCurrentImageFormat;
    Result=UCC_GetCurrentImageFormat(CamIds[0],&imagewidth,&imageheight,&Code,&depth);
    if(S_OK!=Result)
    {
        std::cout<<"Could not get image format"<<endl;
    }


    //5.start the image stream
    Result= UCC_GrabStart(CamIds[0],1000);
    if(S_OK!=Result)
    {
        std::cout<<"Could not start Grab image"<<endl;
    }


    //6.creat image conventor
    cameraframe=QImage(imagewidth,imageheight,QImage::Format_RGB888);
}
void Camera1394::updatecamera(void)
{
    update();
}


void Camera1394::paint(QPainter *painter)
{
//    QRect camerarec(0,0,300,300);
    UCC_GetBitmapImage(CamIds[0],UINT8P_CAST(cameraframe.bits()),10);
    painter->drawImage(boundingRect().adjusted(1, 1, -1, -1),cameraframe);
}

quint32 Camera1394::getCameraID(void) const
{
    return CamIds[0];
}
quint32 Camera1394::getimagewidth(void) const
{
    return imagewidth;
}
quint32 Camera1394::getimageheight(void) const
{
    return imageheight;
}

