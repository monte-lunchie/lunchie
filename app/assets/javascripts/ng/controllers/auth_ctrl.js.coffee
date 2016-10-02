angular
  .module 'lunchie'
  .controller 'AuthCtrl', ($scope, $auth) ->
    $scope.user = {}

    # sign up
    $scope.signUp = ->
      $auth.submitRegistration $scope.user

    # sign in
    $scope.signIn = ->
      $auth.submitLogin $scope.user

    return
