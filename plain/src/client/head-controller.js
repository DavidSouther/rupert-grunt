angular.module('rupert-app.head-controller', [
    'rupert-app.title-service'
]).controller('HeadCtrl', function($scope, TitleSvc){
    $scope.title = TitleSvc.title;
});
