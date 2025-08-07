#ifndef IMAGESTORAGE_H
#define IMAGESTORAGE_H

#include <QObject>
#include <QStringList>
#include <QPixmap>
#include <opencv2/opencv.hpp>
#include <QMap>

class ImageStorage : public QObject
{
    Q_OBJECT
public:
    explicit ImageStorage(QObject *parent = nullptr);

public slots:
    void getImagesbyPath(const QStringList &imagePath);
    cv::Mat getOriginalImage(int index);
    void saveImageSettings(int index, QString &toolName, int value);
    int getImageSettings(int index, QString &toolName);
    void clearImages();
signals:
private:
    QList<cv::Mat> originalImages;
    QMap<int, QMap<QString,int>> imageSettings;
};

#endif // IMAGESTORAGE_H
