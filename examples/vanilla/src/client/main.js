window.onload = function(){
  var titleManager = new window.TitleManager();
  setTitle(titleManager.title);
  titleManager.addEventListener(function(title){
    setTitle(title);
  });
};

function setTitle(newTitle){
  function set(element){
    element.innerText = newTitle;
  }
  Array.prototype.forEach.call(document.getElementsByTagName('title'), set);
  Array.prototype.forEach.call(document.getElementsByClassName('title'), set);
}
