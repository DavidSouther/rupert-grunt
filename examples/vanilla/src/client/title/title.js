window.TitleManager = TitleManager;

function TitleManager(title){
  this.title = title || 'Vanilla Rupert';
  this.listeners = [];
}

TitleManager.prototype.addEventListener = function(listener){
  this.listeners.push(listener);
};

TitleManager.prototype.emitEvent = function(data){
  this.listeners.forEach(function(listener){
    listener(data);
  });
};

TitleManager.prototype.loadTitle = function(){
  var r = new XMLHttpRequest();
  r.open('GET', '/api/title/random', true);
  r.onreadystatechange = function () {
    if (r.readyState !== 4 || r.status !== 200) return;
    this.title = r.requestBody;
    this.emitEvent(this.title);
  }.bind(this);
  r.send();
};
