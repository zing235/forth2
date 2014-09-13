#ifndef IMAGEVALUE_H
#define IMAGEVALUE_H
#include <QObject>

class ImageValue : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString BubbleNumber READ getBubbleNumber WRITE setBubbleNumber NOTIFY BubbleNumberChanged)
    Q_PROPERTY(QString BubbleSize READ getBubbleSize WRITE setBubbleSize NOTIFY BubbleSizeChanged)
    Q_PROPERTY(QString GrayMean READ getGrayMean WRITE setGrayMean NOTIFY GrayMeanChanged)
public:
    explicit ImageValue(QObject *parent=0);

    QString getBubbleNumber(void) const;
    void setBubbleNumber(const QString BubbleNumber);

    QString getBubbleSize(void) const;
    void setBubbleSize(const QString BubbleSize);

    QString getGrayMean(void) const;
    void setGrayMean(const QString GrayMean);

//    Q_INVOKABLE void getImageValue(QUrl url);
    Q_INVOKABLE void getImageValue(void);

signals:
    void BubbleNumberChanged(void);
    void BubbleSizeChanged(void);
    void GrayMeanChanged(void);

private:
    QString m_BubbleNumber;
    QString m_BubbleSize;
    QString m_GrayMean;
};
#endif // IMAGEVALUE_H
