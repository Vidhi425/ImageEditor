#include "imagemanager.h"
#include <QFileInfo>
#include <QDir>
#include <QDebug>
#include <QStandardPaths>


ImageManager::ImageManager(QObject *parent)
    : QObject{parent}, m_currentIndex(0),m_imageStorage(nullptr)
{}

void ImageManager::setImageStorage(ImageStorage *storage)
{
    m_imageStorage = storage;
}


void ImageManager::processImagePaths(const QStringList &filepaths)
{
    qDebug() << "Processing" << filepaths.size() << "files";
    if (filepaths.empty()) {
        qDebug() << "No files provided";
        return;
    }
    m_imageUrls.clear();
    int processedCount = 0;
    for (int i = 0; i < filepaths.size(); ++i)
    {
        QString path = filepaths[i];
        qDebug() << "Original path:" << path;
        if (path.startsWith("file://")) {
            path = path.mid(7);
#ifdef Q_OS_WIN
            if (path.startsWith("/")) {
                path = path.mid(1);
            }
#endif
        }
        QFileInfo fileInfo(path);
        if (fileInfo.exists()) {
            QString suffix = fileInfo.suffix().toLower();
            if (suffix == "jpg" || suffix == "jpeg" || suffix == "png" ||
                suffix == "bmp" || suffix == "gif" || suffix == "tiff") {
                m_imageUrls.append("file:///" + path);
                processedCount++;
            }
        }
    }
    if(m_imageStorage){
        m_imageStorage->loadImagesbyPath(m_imageUrls);
    }
    qDebug() << "Processed" << processedCount << "valid image files";
    m_currentIndex = 0;
    emit imageUrlsChanged();
    emit totalImagesChanged();
    emit currentIndexChanged();
}

void ImageManager::setCurrentIndex(int index) {
    if (index >= 0 && index < m_imageUrls.size() && index != m_currentIndex) {
        m_currentIndex = index;
        emit currentIndexChanged();
        emit currentImageIndexChanged(m_currentIndex);
    }

}

void ImageManager::nextImage() {
    if (m_currentIndex < m_imageUrls.size() - 1) {
        setCurrentIndex(m_currentIndex + 1);
    }
}

void ImageManager::previousImage() {
    if (m_currentIndex > 0) {
        setCurrentIndex(m_currentIndex - 1);
    }
}

void ImageManager::clearImages()
{
    m_imageUrls.clear();
    m_currentIndex = 0;
    emit imageUrlsChanged();
    emit totalImagesChanged();
    emit currentIndexChanged();
    if(m_imageStorage){
        m_imageStorage->clearImages();
    }
}
