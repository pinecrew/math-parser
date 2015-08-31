import std.regex, std.regex.internal.backtracking;

enum tokenType {
    ERROR,
    NUMBER,
    OPERATOR,
    ID
};

struct token {
    tokenType t;
    string value;
};

struct tokenRange {
    auto scanner = ctRegex!(`(\s+)|(\d+)|([-*+/^])|([A-Za-z_][A-Za-z0-9_]*)|(.)`);
    
    // что за фигня с этими типами?
    RegexMatch!(string, BacktrackingMatcher!(true)) matchRange;

    this(string expression) {
        matchRange = matchAll(expression, scanner);
    }

    @property token front() {
        auto m = matchRange.front();
        auto tokType = tokenType.ERROR;

        // говнокооооооддддд))))
        if (m[1].length) {
            matchRange.popFront();
            m = matchRange.front();
        }
        
        if (m[2].length)
            tokType = tokenType.NUMBER;

        if (m[3].length)
            tokType = tokenType.OPERATOR;
        
        if (m[4].length)
            tokType = tokenType.ID;
        
        return token(tokType, m[0]);
    }

    void popFront () {
        matchRange.popFront();
    }

    @property bool empty() {
        return matchRange.empty;
    }
}