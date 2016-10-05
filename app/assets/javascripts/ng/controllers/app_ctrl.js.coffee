angular
  .module 'lunchie'
  .controller 'AppCtrl', ($scope, $rootScope, $state, $auth, $timeout, $mdToast) ->
    $rootScope.$on '$stateChangeSuccess', (event, toState) ->
      $rootScope.stateName = toState.name

    $scope.showToastMessage = (message) ->
      toast = $mdToast.simple()
        .textContent message
        .position 'bottom right'
        .hideDelay 5000
      $mdToast.show toast

    # sign up
    $scope.$on 'auth:registration-email-success', (event, response) ->
      $state.go 'profile'
        .then ->
          $scope.showToastMessage 'Welcome aboard ' + response.nickname + '!'

    $scope.$on 'auth:registration-email-error', (event, response) ->
      $scope.showToastMessage 'Something went wrong :('


    # sign in
    $scope.$on 'auth:login-success', (event, response) ->
      $state.go 'profile'
        .then ->
          $scope.showToastMessage 'Welcome back ' + response.nickname + '!'

    $scope.$on 'auth:login-error', (event, response) ->
      $scope.showToastMessage 'Something went wrong :('


    # token auth
    $scope.$on 'auth:validation-success', (event, response) ->
      $state.go 'profile'
        .then ->
          $scope.showToastMessage 'Welcome back ' + response.nickname + '!'

    $scope.$on 'auth:validation-error', (event, response) ->
      $state.go 'sign-in'

    # sign out
    $scope.signOut = ->
      $auth.signOut()

    $scope.$on 'auth:logout-success', (event, response) ->
      $state.go 'sign-in'
        .then ->
          $scope.showToastMessage 'See you soon ' + response.nickname + '!'

    $scope.$on 'auth:logout-error', (event, response) ->
      $scope.showToastMessage 'Something went wrong :('

    return
