#ifndef SELECTIONMANAGER_H
#define SELECTIONMANAGER_H

#include <QObject>
#include <QString>

class SelectionManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString selectedOption READ selectedOption WRITE setSelectedOption NOTIFY selectedOptionChanged FINAL)
public:
    explicit SelectionManager(QObject *parent = nullptr);

    QString selectedOption() const;
    void setSelectedOption(QString &option);
signals:
    void selectedOptionChanged();

private:
    QString m_selectedOption;
};

#endif // SELECTIONMANAGER_H
