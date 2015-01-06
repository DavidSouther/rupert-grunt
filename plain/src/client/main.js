window.onload = function() {
    //simple routing mechanism
    switch(window.location.pathname) {
        case '/':
            var bar = new window.Foo();
            bar.setText();
            break;
    }
};