// colortoolprocessor.cpp
#include "colortoolprocessor.h"
#include <QDebug>
#include <QStandardPaths>
#include <QDir>

ColorToolProcessor::ColorToolProcessor(QObject *parent)
    : QObject{parent}, m_imageStorage(nullptr), m_currentImageIndex(0)
{}


void ColorToolProcessor::setImageStorage(ImageStorage *storage) {
    m_imageStorage = storage;
}

void ColorToolProcessor::setCurrentImageIndex(int index) {
    m_currentImageIndex = index;
}


void ColorToolProcessor::loadImage(const QString &imagePath) {
    currentOriginalImage = cv::imread(imagePath.toStdString());
    if (!currentOriginalImage.empty()) {
        qDebug() << "Image loaded successfully:" << imagePath;
    } else {
        qDebug() << "Failed to load image:" << imagePath;
    }
}

void ColorToolProcessor::setCurrentImage(int imageIndex) {
    currentImageIndex = imageIndex;
    if (m_imageStorage) {
        currentOriginalImage = m_imageStorage->getOriginalImage(imageIndex);
        qDebug() << "Current image set to index:" << imageIndex;
    }
}

void ColorToolProcessor::applyGrayscale(double intensity, double contrast)
{
    if (!m_imageStorage) {
        qDebug() << "ImageStorage not connected";
        return;
    }

    // Get the original image from ImageStorage
    cv::Mat originalImage = m_imageStorage->getOriginalImage(m_currentImageIndex);
    if (originalImage.empty()) {
        qDebug() << "No image loaded at index:" << m_currentImageIndex;
        return;
    }


    cv::Mat grayImage;
    cv::cvtColor(originalImage, grayImage, cv::COLOR_BGR2GRAY);
    cv::Mat grayRGB;
    cv::cvtColor(grayImage, grayRGB, cv::COLOR_GRAY2RGB);
    cv::Mat result;
    grayRGB.convertTo(result, -1, intensity/100.0, contrast);
    QString tempDir = QStandardPaths::writableLocation(QStandardPaths::TempLocation);
    QString tempPath = tempDir + "/preview_" + QString::number(QDateTime::currentMSecsSinceEpoch()) + ".png";

    // Save the processed image
    bool saved = cv::imwrite(tempPath.toStdString(), result);

    if (saved) {
        emit previewReady("file:///" + tempPath);
        qDebug() << "Preview saved to:" << tempPath;
    } else {
        qDebug() << "Failed to save preview image";
    }

    qDebug() << "Grayscale applied with intensity:" << intensity << "contrast:" << contrast;
}

QPixmap ColorToolProcessor::matToQPixmap(const cv::Mat &mat)
{
    cv::Mat rgbMat;
    if (mat.channels() == 3) {
        cv::cvtColor(mat, rgbMat, cv::COLOR_BGR2RGB);
    } else {
        rgbMat = mat.clone();
    }

    QImage qImage(rgbMat.data, rgbMat.cols, rgbMat.rows, rgbMat.step, QImage::Format_RGB888);
    return QPixmap::fromImage(qImage);
}
