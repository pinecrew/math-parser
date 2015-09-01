struct Element(T) {
    T data;
    Element * next;
}

struct Stack(T) {
    Element!T * topElement;

    @property bool empty () {
        return (topElement == null);
    }

    @property T top () {
        return topElement.data;
    }

    void pop () {
        topElement = topElement.next;
    }

    void push (T a) {
        topElement = new Element!T(a, topElement);
    }
}

struct Queue(T) {
    Element!T * frontElement;
    Element!T * backElement;

    @property bool empty () {
        return (backElement == null || frontElement == null);
    }

    @property T front () {
        return frontElement.data;
    }

    void pop () {
        frontElement = frontElement.next;
        if (empty)
            backElement = null;
    }

    void push (T a) {
        auto tmp = new Element!T(a, null);
        if (!empty)
            backElement.next = tmp;

        backElement = tmp;
        
        if (empty)
            frontElement = backElement;
    }
}