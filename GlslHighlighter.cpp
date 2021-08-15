#include "GlslHighlighter.h"

#include "Dictionary.h"

GlslHighlighter::GlslHighlighter(QTextDocument *parent) : QSyntaxHighlighter(parent)
{
    HighlightingRule rule;

    ///////////////
    /// FORMATS ///
    ///////////////

    statementFormat.setForeground(QColor(249, 38, 106));

    commentFormat.setForeground(QColor(117, 113, 79));

    preprocessorFormat.setForeground(QColor(117, 113, 79));

    numberFormat.setForeground(QColor(174, 129, 227));

    typesFormat.setForeground(QColor(88, 217, 239));

    keywordFormat.setForeground(QColor(249, 38, 106));

    uniformsFormat.setForeground(QColor(174, 129, 227));

    swizzleFormat.setForeground(QColor(249, 38, 106));

    /////////////
    /// RULES ///
    /////////////

    addPatternFromSet(Dictionary::conditionals(), statementFormat);

    addPatternFromSet(Dictionary::statements(), statementFormat);

    addPatternFromSet(Dictionary::repeats(), statementFormat);

    /* Numbers */
    rule.pattern = QRegExp("\\b\\d+(u{,1}l{0,2}|ll{,1}u)\\b");
    rule.format = numberFormat;
    highlightingRules.append(rule);
    rule.pattern = QRegExp("\\b0x\\x+(u{,1}l{0,2}|ll{,1}u)\\b");
    rule.format = numberFormat;
    highlightingRules.append(rule);
    rule.pattern = QRegExp("\\b\\d+f\\b");
    rule.format = numberFormat;
    highlightingRules.append(rule);
    rule.pattern = QRegExp("\\b\\d+\\.\\d*(e[-+]{,1}\\d+){,1}[fl]{,1}\\b");
    rule.format = numberFormat;
    highlightingRules.append(rule);
    rule.pattern = QRegExp("\\b\\.\\d+(e[-+]{,1}\\d+){,1}[fl]{,1}\\b");
    rule.format = numberFormat;
    highlightingRules.append(rule);
    rule.pattern = QRegExp("\\b\\d+e[-+]{,1}\\d+[fl]{,1}\\b");
    rule.format = numberFormat;
    highlightingRules.append(rule);
    rule.pattern = QRegExp("\\b0\\o*[89]\\d*\\b");
    rule.format = numberFormat;
    highlightingRules.append(rule);

    /* Swizzles */
    rule.pattern = QRegExp("\\.[xyzw]{1,4}\\b");
    rule.format = swizzleFormat;
    highlightingRules.append(rule);
    rule.pattern = QRegExp("\\.[rgba]{1,4}\\b");
    rule.format = swizzleFormat;
    highlightingRules.append(rule);
    rule.pattern = QRegExp("\\.[stpq]{1,4}\\b");
    rule.format = swizzleFormat;
    highlightingRules.append(rule);

    /* Types */
    addPatternFromSet(Dictionary::types(), typesFormat);

    /* Storage class */
    addPatternFromSet(Dictionary::starageClasses(), keywordFormat);

    /* Functions */
    addPatternFromSet(Dictionary::functions(), statementFormat);

    /* States */
    addPatternFromSet(Dictionary::states(), uniformsFormat);

    /* Uniforms */
    addPatternFromSet(Dictionary::uniforms(), uniformsFormat);

    /* preprocessor */
    rule.pattern = QRegExp("#.*");
    rule.format = preprocessorFormat;
    highlightingRules.append(rule);

    /* single line comments */
    rule.pattern = QRegExp("//.*");
    rule.format = commentFormat;
    highlightingRules.append(rule);

    /* multi line comments */
    commentStartExpression = QRegExp("/\\*");
    commentEndExpression = QRegExp("\\*/");
}

QQuickTextDocument *GlslHighlighter::quickTextDocument() const
{
    return m_quickTextDocument;
}

void GlslHighlighter::setQuickTextDocument(QQuickTextDocument *quickTextDocument)
{
    if (m_quickTextDocument != quickTextDocument)
    {
        m_quickTextDocument = quickTextDocument;
        QSyntaxHighlighter::setDocument(quickTextDocument->textDocument());

        quickTextDocumentChanged(quickTextDocument);
    }

}

void GlslHighlighter::addPatternFromSet(QSet<QString> &set, QTextCharFormat &format)
{
    HighlightingRule rule;

    QSet<QString>::iterator it;
    for (it = set.begin(); it != set.end(); ++it)
    {
        rule.pattern = QRegExp(QString("\\b") + (*it) + QString("\\b"));
        rule.format = format;
        highlightingRules.append(rule);
    }
}

void GlslHighlighter::highlightBlock(const QString &text)
{
    foreach (HighlightingRule rule, highlightingRules)
    {
        QRegExp &expression = rule.pattern;
        int index = rule.pattern.indexIn(text);
        while (index >= 0)
        {
            int length = expression.matchedLength();
            if (length <= 0)
            {
                fprintf(stderr,
                        "length==0 for " "%s" " mathcing in " "%s" " at %d\n",
                        expression.pattern().toLatin1().data(),
                        text.toLatin1().data(), index);
            }
            setFormat(index, length, rule.format);
            index = expression.indexIn(text, index + length);
        }
    }
    setCurrentBlockState(0);

    int startIndex = 0;
    if (previousBlockState() != 1)
    {
        startIndex = commentStartExpression.indexIn(text);
    }

    while (startIndex >= 0)
    {
        int endIndex = commentEndExpression.indexIn(text, startIndex);
        int commentLength;
        if (endIndex == -1)
        {
            setCurrentBlockState(1);
            commentLength = text.length() - startIndex;
        }
        else
        {
            commentLength = endIndex - startIndex + commentEndExpression.matchedLength();
        }
        setFormat(startIndex, commentLength, commentFormat);
        startIndex = commentStartExpression.indexIn(text, startIndex + commentLength);
    }
}
