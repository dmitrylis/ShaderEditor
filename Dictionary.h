#ifndef DICTIONARY_H
#define DICTIONARY_H

#include <QString>
#include <QSet>

class Dictionary
{
public:
    Dictionary();

    static QSet<QString> &conditionals();
    static QSet<QString> &statements();
    static QSet<QString> &repeats();
    static QSet<QString> &types();
    static QSet<QString> &starageClasses();
    static QSet<QString> &functions();
    static QSet<QString> &states();
    static QSet<QString> &uniforms();
};

#endif // DICTIONARY_H
