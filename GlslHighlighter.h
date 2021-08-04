#ifndef GLSL_HIGHLIGHTER
#define GLSL_HIGHLIGHTER

#include <QSyntaxHighlighter>
#include <QTextCharFormat>
#include <QQuickTextDocument>

class GlslHighlighter: public QSyntaxHighlighter
{
    Q_OBJECT
    Q_PROPERTY(QQuickTextDocument* quickTextDocument READ quickTextDocument WRITE setQuickTextDocument NOTIFY quickTextDocumentChanged)

public:
    GlslHighlighter(QTextDocument *parent = nullptr);

    QQuickTextDocument *quickTextDocument() const;
    void setQuickTextDocument(QQuickTextDocument *quickTextDocument);

signals:
    void quickTextDocumentChanged(QQuickTextDocument* quickTextDocument);

protected:
    void highlightBlock(const QString &text);

private:
    void addPatternFromList(QStringList &list, QTextCharFormat &format);

    struct HighlightingRule
    {
        QRegExp pattern;
        QTextCharFormat format;
    };

    QVector<HighlightingRule> highlightingRules;

    QRegExp commentStartExpression;
    QRegExp commentEndExpression;

    QTextCharFormat statementFormat;
    QTextCharFormat commentFormat;
    QTextCharFormat preprocessorFormat;
    QTextCharFormat numberFormat;
    QTextCharFormat typesFormat;
    QTextCharFormat keywordFormat;
    QTextCharFormat uniformsFormat;
    QTextCharFormat swizzleFormat;

    QQuickTextDocument* m_quickTextDocument;
};

#endif // GLSL_HIGHLIGHTER
