// imagestorage.cpp
#include "imagestorage.h"
#include <QDebug>

ImageStorage::ImageStorage(QObject *parent)
    : QObject{parent}
{}

void ImageStorage::loadImagesbyPath(const QStringList &imagePath)
{
    clearImages();

    for(const QString &urlPath: imagePath){
        QString filePath = urlPath;


        if (filePath.startsWith("file:///")) {
            filePath = filePath.mid(8);
#ifdef Q_OS_WIN

            if (!filePath.contains(':')) {
                filePath = filePath.mid(1);
            }
#endif
        }

        qDebug() << "Loading image from:" << filePath;

        cv::Mat image = cv::imread(filePath.toStdString());

        if(!image.empty()){
            originalImages.append(image);
            int imageIndex = originalImages.size() - 1;
            imageSettings[imageIndex] = QMap<QString, int>();

            qDebug() << "Image loaded successfully. Total images:" << originalImages.size();
        } else {
            qDebug() << "Failed to load image:" << filePath;
        }
    }
}

cv::Mat ImageStorage::getOriginalImage(int index)
{
    if(index >= 0 && index < originalImages.size()){
        return originalImages[index];
    }
    qDebug() << "Invalid image index:" << index << "Total images:" << originalImages.size();
    return cv::Mat();
}

void ImageStorage::saveImageSettings(int index, QString &toolName, int value)
{
    if (index >= 0 && index < originalImages.size()) {
        imageSettings[index][toolName] = value;
        qDebug() << "Saved setting for image" << index << ":" << toolName << "=" << value;
    }
}

int ImageStorage::getImageSettings(int index, QString &toolName)
{
    if (index >= 0 && index < originalImages.size()) {
        if (imageSettings[index].contains(toolName)) {
            return imageSettings[index][toolName];
        }
    }
    return 0;
}

void ImageStorage::clearImages()
{
    originalImages.clear();
    imageSettings.clear();
    qDebug() << "All images cleared from storage";
}
