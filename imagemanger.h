#ifndef IMAGEMANGER_H
#define IMAGEMANGER_H

#include <QObject>

class ImageManger : public QObject
{
    Q_OBJECT
public:
    explicit ImageManger(QObject *parent = nullptr);

signals:
};

#endif // IMAGEMANGER_H
