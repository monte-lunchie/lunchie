angular
  .module 'lunchie.app_ctrl', ['ngMaterial']
  .controller 'AppCtrl', ($scope, $timeout, $mdSidenav) ->
    buildToggler = (componentId) ->
      ->
        $mdSidenav(componentId).toggle()
        return

    $scope.toggleLeft = buildToggler 'left'
    $scope.toggleRight = buildToggler 'right'
    return
