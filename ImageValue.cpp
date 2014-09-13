#include "ImageValue.h"
#include <opencv2/opencv.hpp>
#include<Histogram.h>
#include<WaterShedAlgorithm.h>
#include<WatershedPixel.h>
#include<WatershedStructure.h>
#include <QUrl>
#include"camera1394.h"
#include "UniControl.h"
#include "UniTransform.h"
#define UINT8P_CAST(x) reinterpret_cast<UINT8*>(x)

ImageValue::ImageValue(QObject *parent):
    QObject(parent),m_BubbleNumber("Number"),m_BubbleSize("Size"),m_GrayMean("Mean")
{
}
QString ImageValue::getBubbleNumber(void) const
{
    return m_BubbleNumber;
}
void ImageValue::setBubbleNumber(const QString BubbleNumber)
{
    m_BubbleNumber=BubbleNumber;
    emit BubbleNumberChanged();
}

QString ImageValue::getBubbleSize(void) const
{
    return m_BubbleSize;
}
void ImageValue::setBubbleSize(const QString BubbleSize)
{
    m_BubbleSize=BubbleSize;
    emit BubbleSizeChanged();
}

QString ImageValue::getGrayMean(void) const
{
    return m_GrayMean;
}
void ImageValue::setGrayMean(const QString GrayMean)
{
    m_GrayMean=GrayMean;
    emit GrayMeanChanged();
}


//void ImageValue::getImageValue(QUrl url)
void ImageValue::getImageValue(void)
{
    Histogram h;//创建图像增强算法实例;
    WatershedAlgorithm myWatershed;	// 创建分水岭算法实例;
    Camera1394 camerazz;
    int nr=camerazz.getimageheight();
    int nc=camerazz.getimagewidth();
    int imagesize=nc*nr;
   cv::Mat  opencvimage(nr,nc,CV_8UC3);
   UCC_GetBitmapImage(camerazz.getCameraID(),UINT8P_CAST(opencvimage.data),1000);

    double GlobleBubbleNumber=0;
    double GlobleBubbleSize=0;
    double GlobleGrayMean=0;
    double sumgrayvalue=0;


    //3.define image container which will be used later
    cv::Mat  opencvimage_gray;
    cv::Mat  opencvimage_imadjust;
    cv::Mat  element=getStructuringElement( MORPH_ELLIPSE,cv::Size(7,7), Point(-1,-1));
    cv::Mat  opencvimage_imopen;
    cv::Mat  opencvimage_imdilated;
    cv::Mat  opencvimage_not;
    cv::Mat  WSS;


    //4.image processing:image gray-image adjust-image open-image dilate-image not- watershed
    cv::cvtColor(opencvimage,opencvimage_gray,CV_RGB2GRAY);
   // imshow("Gray image",opencvimage_gray);//only run in debug

    opencvimage_imadjust=h.stretch1(opencvimage_gray,3000);
  //  imshow("adjust image",opencvimage_imadjust);

    cv::morphologyEx(opencvimage_imadjust,opencvimage_imopen,MORPH_OPEN,element);
   // imshow("open image",opencvimage_imopen);

    cv::dilate(opencvimage_imopen,opencvimage_imdilated,element);
   // imshow("dilatedimage",opencvimage_imdilated);

    cv::bitwise_not(opencvimage_imdilated,opencvimage_not);
   // imshow("notimage",opencvimage_not);

    WSS=myWatershed.run(opencvimage_not);//return WSS as the result of watershed;
   // imshow("wtershed result1",WSS);
//    imshow("wtershed result2",WSS+opencvimage_gray);//显示分割效果




    //5.caculate the value of image:1>BubbleNumber;2>BubbleSize;3>GrayMean
    //5.1 BubbleNumber
    std::vector<std::vector<cv::Point> >contours;
    cv::findContours(WSS,contours,CV_RETR_LIST,CV_CHAIN_APPROX_NONE);
    GlobleBubbleNumber=contours.size();

    //5.2 BubbleSize
    GlobleBubbleSize=imagesize/GlobleBubbleNumber;

    //5.3 GrayMean
    if (opencvimage_gray.isContinuous())
    {
        nc=nr*nc;
        nr=1;
    }
    for (int j=0;j<nr;j++)
        {
            uchar* data=opencvimage_gray.ptr<uchar>(j);
            for (int i=0;i<nc;i++)
            {
                sumgrayvalue=sumgrayvalue+data[i];
            }
        }
    GlobleGrayMean=sumgrayvalue/imagesize;


    //6. set value and send singnals
    setBubbleNumber(QString::number(GlobleBubbleNumber));
    setBubbleSize(QString::number(GlobleBubbleSize));
    setGrayMean(QString::number(GlobleGrayMean));
}
