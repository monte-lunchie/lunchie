angular
  .module 'lunchie'
  .controller 'AppCtrl', ($scope, $state, $mdToast) ->
    $scope.showToastMessage = (message) ->
      toast = $mdToast.simple()
        .textContent message
        .position 'bottom right'
        .hideDelay 5000
      $mdToast.show toast

    $scope.$on 'auth:registration-email-success', (event, response) ->
      $state.go 'home'
        .then ->
          $scope.showToastMessage 'Welcome aboard ' + response.nickname + '!'


    $scope.$on 'auth:registration-email-error', (event, response) ->
      console.log 'error'

    $scope.$on 'auth:login-success', (event, response) ->
      $state.go 'home'
        .then ->
          $scope.showToastMessage 'Welcome back ' + response.nickname + '!'

    $scope.$on 'auth:login-error', (event, response) ->
      console.log 'error'

    $scope.$on 'auth:validation-success', (event, response) ->
      $state.go 'home'
        .then ->
          $scope.showToastMessage 'Welcome back ' + response.nickname + '!'

    $scope.$on 'auth:validation-error', (event, response) ->
      console.log 'error'


    return
