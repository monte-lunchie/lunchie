@lunchie = angular.module 'lunchie', [
  'ui.router',
  'templates',
  'ngMaterial'
]

@lunchie.config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->
  signInState =
    name: 'sign-in'
    url: '/sign_in'
    templateUrl: 'auth/sign_in.html'
    controller: 'AuthCtrl'

  homeState =
    name: 'home'
    url: ''
    templateUrl: 'home.html'
    controller: 'AppCtrl'

  $stateProvider.state signInState
  $stateProvider.state homeState

  $urlRouterProvider.otherwise '/sign_in'
  return
]
