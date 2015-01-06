window.Foo = function() {
    this.setText = function() {
        document.querySelector('body h1.test').innerHTML = 'It Works!';
    };
};