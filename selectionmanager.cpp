#include "selectionmanager.h"

SelectionManager::SelectionManager(QObject *parent)
    : QObject{parent}
{}

QString SelectionManager::selectedOption() const
{
    return m_selectedOption;
}

void SelectionManager::setSelectedOption(QString &option)
{
    if (m_selectedOption != option) {
        m_selectedOption = option;
        emit selectedOptionChanged();
    }
}
