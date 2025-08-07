#ifndef COLORTOOLPROCESSOR_H
#define COLORTOOLPROCESSOR_H

#include <QObject>
#include <QPixmap>
#include <opencv2/opencv.hpp>
#include "imagestorage.h"
#include <QDateTime>

class ColorToolProcessor : public QObject
{
    Q_OBJECT

public:
    explicit ColorToolProcessor(QObject *parent = nullptr);
public slots:
     void applyGrayscale(double intensity, double contrast);
     void loadImage(const QString &imagePath);
     void setCurrentImage(int imageIndex);
     void setImageStorage(ImageStorage *storage);
     void setCurrentImageIndex(int index);
signals:
   void previewReady(const QString &imagePath);
private:
   QPixmap matToQPixmap(const cv::Mat &mat);
   cv::Mat currentOriginalImage;
   int currentImageIndex = 0;
   ImageStorage *m_imageStorage;
   int m_currentImageIndex;
};

#endif // COLORTOOLPROCESSOR_H
