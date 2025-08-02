#ifndef IMAGEMANAGER_H
#define IMAGEMANAGER_H
#include <QObject>
#include <QStringList>
#include <QUrl>
#include <QQmlEngine>
class ImageManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList imageUrls READ imageUrls NOTIFY imageUrlsChanged)
    Q_PROPERTY(int currentIndex READ currentIndex WRITE setCurrentIndex NOTIFY currentIndexChanged FINAL)
    Q_PROPERTY(int totalImages READ totalImages NOTIFY totalImagesChanged FINAL)
public:
    explicit ImageManager(QObject *parent = nullptr);
    QStringList imageUrls() const { return m_imageUrls; }
    int currentIndex() const {return m_currentIndex;}
    int totalImages() const {return m_imageUrls.size();}
public slots:
    void processImagePaths(const QStringList &filepaths);
    void clearImages();
    void setCurrentIndex(int index);
    void nextImage();
    void previousImage();
signals:
    void imageUrlsChanged();
    void currentIndexChanged();
    void totalImagesChanged();
private:
    QStringList m_imageUrls;
    int m_currentIndex;
};
#endif // IMAGEMANAGER_H
